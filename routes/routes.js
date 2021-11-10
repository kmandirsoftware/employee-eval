
const appRouter = (app, mysql, fs, checkAuthenticated, checkNotAuthenticated, authRole) => {

const getDbConnection = async () => { 
        return await mysql.createConnection({
        host: 'localhost',
        user: 'emp-node',
        password: 'emp-532!',
        database: 'ems',
        multipleStatements: true
    })
}
const DbCon = mysql.createConnection({
        host: 'localhost',
        user: 'emp-node',
        password: 'emp-532!',
        database: 'ems',
        multipleStatements: true
})

const DbConUpdate = mysql.createConnection({
        host: 'localhost',
        user: 'emp-node',
        password: 'emp-532!',
        database: 'evals',
        multipleStatements: true
})

var getmyloop=0;
function setloopcount(cnt){
   getmyloop = cnt.mycount;
   console.log(getmyloop);
}

const confquery = async (cb) => { 
   const con = await getDbConnection()
   await con.query("select count(*) as mycount from catagory", function(error, results, fields){
     cb(results[0]);
   })
   await con.end()
   //console.log(myloop)
 }
 confquery(setloopcount)

 
   /* GET home page. */
   app.get('/', checkAuthenticated, (req, res) => {
     res.render('index', {page:'Home', menuId:'home', name: req.user.name});
   });   
   /* GET login page. 
    */
   app.get('/login', checkNotAuthenticated, (req, res) => {
     res.render('login', {page:'Login', menuId:'login'});
   });   

   app.delete('/logout', (req, res) => {
       req.session.destroy((err) => {
           if(err){
               return console.log(err)
           }
         req.logOut()
         res.redirect('/login')
      })
   })

   app.post('/submit_form', function(req, res){
      console.log(req.body);
      res.send("recieved your request!");
   });

   app.post('/submit_eval1_form/:id', function(req, res){
      console.log("body");
      console.log(req.body);
      var mySelection=[];
      var toSearchR = "radio";
      var toSearchN = "note";
      var myNotes = [];
      var myCatagoryId = req.params.id;
      var myResult = req.body;
      var myEmployeeId = myResult.employee_id;
      delete myResult["employee_id"];
      var mylength = Object.keys(myResult).length;
      console.log("length: " + mylength); 
      var myDate = new Date();
      
      for (const property in myResult){
         var mylastchar = property.substr(-1);
         if(property.indexOf(toSearchR)!=-1) {
             mySelection.push(myResult[property]);
             //console.log(`${property}: ${myResult[property]}`);
	 }
         if(property.indexOf(toSearchN)!=-1) {
             myNotes.push(myResult[property]);
	 }
      }
	   console.log(mySelection);
	   console.log(myNotes);
      var records = [];
      // -- formulate insert into table with the restults
      for (let i=0; i<mySelection.length; i++){
	      records.push([myEmployeeId,0,myDate,i,myCatagoryId,mySelection[i],myNotes[i]]);
      }
	   console.log(records);
      var myInsertQuery = "insert into review (employee_id, cycle_id,date_of_review,eval_form1_id,catagory_id,rating,comments) VALUES ? ";
	   myInsertQuery += "ON DUPLICATE KEY UPDATE rating=VALUES(rating),comments=VALUES(comments)";
      sessionData = req.session;
      sessionData.user = {};
      sessionData.user.eval_employee_id = myEmployeeId;
      console.log("session");
      console.log(req.session);
      var nextpage = parseInt(req.params.id) + 1;
      DbConUpdate.query(myInsertQuery, [records], function(error, results, fields){
	      console.log(results);
	      console.log(error);
            if(nextpage > getmyloop){
               res.redirect('/');
   	         console.log("Finished Form!");
            } else{
               res.redirect('/eval/'+ nextpage);
            }
      });
   });

// Add in Update capability
   app.post('/submit_edit_eval1_form/:id', function(req, res){
      console.log("body");
      console.log(req.body);
      var mySelection=[];
      var toSearchR = "radio";
      var toSearchN = "note";
      var myNotes = [];
      var myCatagoryId = req.params.id;
      var myResult = req.body;
      var myEmployeeId = myResult.employee_id;
      delete myResult["employee_id"];
      var mylength = Object.keys(myResult).length;
      console.log("length: " + mylength); 
      var myDate = new Date();
      
      for (const property in myResult){
         var mylastchar = property.substr(-1);
         if(property.indexOf(toSearchR)!=-1) {
             mySelection.push(myResult[property]);
             //console.log(`${property}: ${myResult[property]}`);
	 }
         if(property.indexOf(toSearchN)!=-1) {
             myNotes.push(myResult[property]);
	 }
      }
	   console.log(mySelection);
	   console.log(myNotes);
      var records = [];
      // -- formulate insert into table with the restults
      for (let i=0; i<mySelection.length; i++){
	      records.push([myEmployeeId,0,myDate,i,myCatagoryId,mySelection[i],myNotes[i]]);
      }
	   console.log(records);
      var myInsertQuery = "insert into review (employee_id, cycle_id,date_of_review,eval_form1_id,catagory_id,rating,comments) VALUES ? ";
	   myInsertQuery += "ON DUPLICATE KEY UPDATE rating=VALUES(rating),comments=VALUES(comments)";
      sessionData = req.session;
      sessionData.user = {};
      sessionData.user.eval_employee_id = myEmployeeId;
      console.log("session");
      console.log(req.session);
      var nextpage = parseInt(req.params.id) + 1;
      DbConUpdate.query(myInsertQuery, [records], function(error, results, fields){
	      console.log(results);
	      console.log(error);
            if(nextpage > getmyloop){
               res.redirect('/');
   	         console.log("Finished Form!");
            } else{
               res.redirect('/edit-eval/'+ nextpage);
            }
      });
   });
   // Display Employees based on login user
   app.get("/edit",checkAuthenticated, function(req,res,next) {
       var lsqlstmt = "select * from employees,personal_details where employees.personal_details_id = personal_details.id and employees.manager_id =?"
	   console.log(lsqlstmt);
       DbCon.query(lsqlstmt, req.user.manager_id, function(error, results, fields){
            res.render('update-employee-lst', {page:'Employee Selection', menuId:'List', data: results, name: req.user.name});
            //console.log("Query results(inside): " + JSON.stringify(results));             
        });
   })
   app.post('/edit_submit_employee', function(req, res){
	   console.log("got here!");
       console.log(req.body)
       console.log(req.user)
	   var sessionUser = req.session;
	   sessionUser.user = {};
	   sessionUser.user.eval_employee_id = req.body.employee_id;
	   console.log(req.session)
         res.redirect('/edit-eval/1');
   })
   app.get('/edit-eval/:id',checkAuthenticated, function(req, res, next) {
     console.log(req.session.user.eval_employee_id);
     var nextpage = parseInt(req.params.id)+1;
     var submitbuttonmessage = "NEXT";
	   var reviews = [0,0,0];
     if(nextpage > getmyloop) submitbuttonmessage = "SUBMIT";
     var sqlstmt2 = "SELECT name from eval_form1 where catagory_id="+req.params.id+"; select name from catagory where id="+req.params.id;
     sqlstmt2 += " ; select * from employees,personal_details where employees.personal_details_id = personal_details.id and employees.manager_id =? ";
     sqlstmt2 += " ; select rating from evals.review where employee_id="+req.session.user.eval_employee_id+" and cycle_id=0 and catagory_id="+req.params.id;
     sqlstmt2 += " ; select comments from evals.review where employee_id="+req.session.user.eval_employee_id+" and cycle_id=0 and catagory_id="+req.params.id;
	   console.log(sqlstmt2);
       DbCon.query(sqlstmt2, req.user.manager_id, function(error, results, fields){
        res.render('update-employee-eval', {page:'Employee Eval'+req.params.id, evalpage: req.params.id, data: results[0], catdata: results[1], edata: results[2], selected_employee: parseInt(req.session.user.eval_employee_id), bsubmit: submitbuttonmessage, menuId:'eval1', name: req.user.name, reviewed: results[3], notes: results[4]});
        console.log("Query results(inside): " + JSON.stringify(results[4]));             
      });
   });


// Edit capability
   app.post('/submit_employee', function(req, res){
	   console.log("got here!");
       console.log(req.body)
       console.log(req.user)
	   var sessionUser = req.session;
	   sessionUser.user = {};
	   sessionUser.user.eval_employee_id = req.body.employee_id;
	   console.log(req.session)
         res.redirect('/eval/1');
   })

   // Display Employees based on login user
   app.get("/list",checkAuthenticated, function(req,res,next) {
       var lsqlstmt = "select * from employees,personal_details where employees.personal_details_id = personal_details.id and employees.manager_id =?"
       DbCon.query(lsqlstmt, req.user.manager_id, function(error, results, fields){
            res.render('employee-lst', {page:'Employee Selection', menuId:'List', data: results, name: req.user.name});
            console.log("Query results(inside): " + JSON.stringify(results));             
        });
   })
   // Handle web pages
   app.get('/employemgt',checkAuthenticated, function(req, res, next) {
     var sqlstmt = "SELECT managers.id,last_name FROM managers,personal_details where personal_details.id = managers.personal_details_id;select id,name from projects;";
     sqlstmt += " select id,name from titles; ";      
      DbCon.query(sqlstmt, function(error, results, fields){
            res.render('employee-mgt', {page:'Employee', menuId:'Add', data: results[0], pdata: results[1], tdata: results[2], name: req.user.name});
            console.log("Query results(inside): " + JSON.stringify(results));             
        });
     
   });   

   app.get('/eval/:id',checkAuthenticated, function(req, res, next) {
     console.log(req.session.user.eval_employee_id);
     var nextpage = parseInt(req.params.id)+1;
     var submitbuttonmessage = "NEXT";
     if(nextpage > getmyloop) submitbuttonmessage = "SUBMIT";
     var sqlstmt2 = "SELECT name from eval_form1 where catagory_id="+req.params.id+"; select name from catagory where id="+req.params.id;
     sqlstmt2 += " ; select * from employees,personal_details where employees.personal_details_id = personal_details.id and employees.manager_id =? ";
       DbCon.query(sqlstmt2, req.user.manager_id, function(error, results, fields){
        res.render('employee-eval1', {page:'Employee Eval'+req.params.id, evalpage: req.params.id, data: results[0], catdata: results[1], edata: results[2], selected_employee: parseInt(req.session.user.eval_employee_id), bsubmit: submitbuttonmessage, menuId:'eval1', name: req.user.name});
        console.log("Query results(inside): " + JSON.stringify(results[1]));             
      });
   });
}
module.exports = appRouter;
