
const loginRouter = (app,mysql,bcrypt,passport,flash,session,methodOverride,checkNotAuthenticated,checkAuthenticated) => {

const getDbConPw = async () => { 
        return await mysql.createConnection({
        host: 'localhost',
        user: 'emp-node',
        password: 'emp-532!',
        database: 'ems',
        multipleStatements: true
    })
}

var users = [];
var usersold = [];
function setusers(user){
   users = user;
}
const confuserquery = async (cb) => { 
   const con = await getDbConPw()
   await con.query("select * from users", function(error, results, fields){
	   var resultArray = Object.values(JSON.parse(JSON.stringify(results)))
     cb(resultArray);
   })
   await con.end()
   //console.log(myloop)
 }
 confuserquery(setusers)

bcrypt.hash('rightsDog1234!', 10, function(err, hash) {
  // Store hash in database
	usersold.push({
      id: "2",
      manager_id: "2",
      eval_employee_id: "0",
      name: "jim",
      email: "jim.brinson@imaginecommunications.com",
      password: hash
    })
    console.log(usersold);
});

const initializePassport = require('./passport-config')
initializePassport(
  passport,
  email => users.find(user => user.email === email),
  id => users.find(user => user.id === id)
)

app.post('/login', checkNotAuthenticated, passport.authenticate(
	'local', 
	{
  		successRedirect: '/',
  		failureRedirect: '/login',
  		failureFlash: true
	},

))

};

module.exports = loginRouter;
