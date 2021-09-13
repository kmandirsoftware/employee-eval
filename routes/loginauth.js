
const loginRouter = (app,mysql,bcrypt,passport,flash,session,methodOverride,checkNotAuthenticated,checkAuthenticated) => {

const users = [];

bcrypt.hash('dataDog1234!', 10, function(err, hash) {
  // Store hash in database
	users.push({
      id: "2",
      manager_id: "2",
      eval_employee_id: "0",
      name: "jim",
      email: "jim.brinson@imaginecommunications.com",
      password: hash
    })
    console.log(users);
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