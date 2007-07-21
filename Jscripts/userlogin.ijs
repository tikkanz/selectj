NB. functions to do with validating & registering users
NB.*loggedIn v Checks if a user is currently authenticated
loggedIn=: 3 : 0
  uid=. qcookie 'UserID'
  0<#uid
  NB. could also check uid is valid
)

NB.*getScenarioInfo v gets Scenario info from ini file
NB. y is numeric user id
NB. x is optional vector of boxed strings specifying info to get
NB.   [default is 'login']
getScenarioInfo=: 3 : 0
  'default' getScenarioInfo y
  :
  keys=. boxopen x
  uid=. ":y NB. handle y if numeric
  inifile=. '~.CGI/flocks/',uid,'/animalsim.ini'
  NB. readkeys from ini file
)

NB.*createSalt v generates salt as 4-byte integer
NB. e.g. createSalt '' 
createSalt=: ([: _2&(3!:4) a. {~ [: ? 256 $~ ])&4

NB.*randpwd v generates y character alphanumeric password
NB. y is integer of number characters for password
randpwd=: 3 : 0
'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789' randpwd y
:
if. -.4=3!:0 y do. len=.8 else. len=.y end.
len (]{~ [:?[$ [:#]) x
)

NB.*salthash v generates hash
NB. y is password string
NB. x if present is the salt to use
salthash=: 3 : 0
  '' salthash y NB. default create new salt
  :
  if. 0<#x do. s=.x
    if. 2=3!:0 s do. s=.".s end. NB. handle string
  else. 
    if. +./(1{::9!:44'')=624,>:i.3 do. NB.reset random seed if state incremented less than 3 times
        9!:1 (_2) 3!:4 , guids 1 end.
    s=. createSalt '' 
  end.
  h=. md5 y,2&ic s
  s;h  NB. 4 byte salt conver
)


NB.*validLogin v checks if login is valid returns userid
NB.  y is boxed list of two strings 'username';'password'
NB.  result is numeric _1 if not valid, string userid if valid
validLogin=: 3 : 0
 'usrnme passwd'=. y
  if. usrnme -: '' do. _1 return. end. NB. check for empty usrname
  uinfo =. {:'login' getUserInfo_pselectdb_ usrnme  NB. retrieve data for username
  if. ''-: uinfo   do. _2 return. end.   NB. check username exists
  'duid dunme dhash dsalt' =. 4{.uinfo
  if. -. dhash-: _1{::dsalt salthash passwd do. _3 return. end. NB. check password is valid
  duid
)

NB.*isActive checks if username is inactive (needs to be reinitalised)
isActive=: 3 : 0
  s=. {:'status' getUserInfo_pselectdb_ y
)

NB.*registerUsers v creates a new user, if successful returns userid
NB. y is boxed list of strings from registration form
NB. result is numeric -ve if not successful, string userid if successful
registerUser=: 3 : 0
  'uname fname lname refnum email passwd'=.y
  NB.passwd=._1{::y
  NB.uname=.0{::y
  uinfo =. {:'login' getUserInfo_pselectdb_ uname  NB. retrieve data for username
  if. -.uinfo-:'' do. _2 return. end. NB. check usrname not already in use
  pinfo =. {:'email' getUserInfo_pselectdb_  email
  if. -.pinfo-:''  do. NB. if email address already used in people table
    pid=. 0{::pinfo    NB. get pid of person with that email address
  else.
    pid=. 'newperson' insertDBTable_pselectdb_ fname;lname;email NB. insert person in people table
  end.
  sph=. salthash passwd NB. create salt and passhash
  uid=.'newuser' insertDBTable_pselectdb_ pid;uname;refnum;|.sph NB. insert user into database
  NB. uid=.'newuser' insertDBTable_pselectdb_ (}:y),|.sph NB. insert user into database
)

NB.*resetUsers v resets user account and folder
NB. y is list of user ids
NB. no result?
resetUsers=: 3 : 0
  if. *#y do.
    'resetusers' updateDBTable_pselectdb_ y
    NB. do stuff to reset user scenario data
    ''
  end.
)

NB.*resetUsers v resets user account and folder
NB. y is list of user ids
NB. no result?
setUsers=: 3 : 0
  if. *#y do.
    'setusers' updateDBTable_pselectdb_ y
    NB. do stuff to create user scenario data
    ''
  end.
)

NB.*deleteUsers v resets user account and folder
NB. y is list of user ids
NB. no result?
deleteUsers=: 3 : 0
  if. *#y do.
    'deleteusers' updateDBTable_pselectdb_ y
    NB. do stuff to delete user scenario data
    ''
  end.
)