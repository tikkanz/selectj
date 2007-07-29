NB. functions to do with validating & registering users

NB.*loggedIn v Checks if a user is currently authenticated
loggedIn=: 3 : 0
  uid=. qcookie 'UserID'
  0<#uid
  NB. could also check uid is valid
)

NB.*enrolledIn v Checks if authenticated user is enrolled in offering
NB. y is numeric offering id (of_id)
enrolledIn=: 3 : 0
  if. -.loggedIn'' do. 0 return. end.
  uid=. 0 qcookie 'UserID'
  uid enrolledIn y
:
  x=. coercetxt x
  y=. coercetxt y
  enrld=.'enrolled' getTable_pselectdb_ y;x
  0<#enrld
)

NB.*validCase v Checks if case id is valid for user offering
validCase=: 3 : 0
  ofid=. 0 qcookie 'OfferingID'
  if. -.enrolledIn ofid do. 0 return. end.
  uid=. 0 qcookie 'UserID'
  (uid;ofid) validCase y
:
  x=. coercetxt x
  y=. coercetxt y
  vldcs=.'validcase' getTable_pselectdb_ x,<y
  0<#vldcs
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

NB.*isdefseed v check if random seed has been reset from J6.01 default
isdefseed=: 3 : '+./({.2{::9!:44'''')=16807 1215910514'

NB.*salthash v generates hash
NB. y is password string
NB. x if present is the salt to use
salthash=: 3 : 0
  '' salthash y NB. default create new salt
  :
  if. 0<#x do. s=.x
    if. 2=3!:0 s do. s=.".s end. NB. handle string
  else. 
    if. isdefseed'' do. randomize'' end.
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
  uinfo =. {:'login' getTable_pselectdb_ usrnme  NB. retrieve data for username
  if. ''-: uinfo   do. _2 return. end.   NB. check username exists
  'duid dunme dhash dsalt' =. 4{.uinfo
  if. -. dhash-: _1{::dsalt salthash passwd do. _3 return. end. NB. check password is valid
  duid
)

NB.*isActive checks if username is inactive (needs to be reinitalised)
isActive=: 3 : 0
  s=. {:'status' getTable_pselectdb_ y
)

NB.*registerUser v creates a new user, if successful returns userid
NB. y is boxed list of strings from registration form
NB. result is numeric -ve if not successful, string userid if successful
registerUser=: 3 : 0
  'uname fname lname refnum email passwd'=.y
  NB.passwd=._1{::y
  NB.uname=.0{::y
  uinfo =. {:'login' getTable_pselectdb_ uname  NB. retrieve data for username
  if. -.uinfo-:'' do. _2 return. end. NB. check usrname not already in use
  pinfo =. {:'email' getTable_pselectdb_  email
  if. -.pinfo-:''  do. NB. if email address already used in people table
    pid=. 0{::pinfo    NB. get pid of person with that email address
  else.
    pid=. 'newperson' insertDBTable_pselectdb_ fname;lname;email NB. insert person in people table
  end.
  sph=. salthash passwd NB. create salt and passhash
  uid=.'newuser' insertDBTable_pselectdb_ pid;uname;refnum;|.sph NB. insert user into database
  NB. uid=.'newuser' insertDBTable_pselectdb_ (}:y),|.sph NB. insert user into database
)

NB.*writeTicket v makes ticket string for cookie
writeTicket=: 3 : 0
  'tsid thash'=.y
  ('ssid=',":tsid),'&hash=',thash
)
NB.*readTicket v reads ticket string
readTicket=: 3 : 0
  {:"1 qsparse y NB. qsparse from JHP
)

NB.*createSession v creates a new user session
NB. returns ticket to write to cookie
NB. y is userID
createSession=: 3 : 0
 if. isdefseed'' do. randomize'' end.
 sid=. ?<:-:2^32 NB. random session id
 sh=. salthash ":sid 
 'session' insertDBTable_pselectdb_  sid;y;sh
 tk=. writeTicket sid;{:sh
)

NB.*validSession v validates session ticket
NB. if session ticket cookie not valid, returns 0
NB. if expired, update ss_status to 0 and returns 0
NB. if valid, updates expiry and returns ss_urid
NB. y is content (session ticket) of sessionID cookie
validSession=: 3 : 0
  'sid shash'=. readTicket y
  sinfo=.'session' getTable_pselectdb_ ".sid
  if. 0=#sinfo do. 0 return. end. NB. no (active) session
  'hdr dat'=. split sinfo         
  (hdr)=: |:dat                   NB. assign hdrnames
  NB. if. -. shash -: ss_hash do. 0 return. end. NB.
  if. -. shash -: 1{::ss_salt salthash sid do. 0 return. end.
  if. timeleft<0 do. 
    'sessionexpire' updateDBTable_pselectdb_ ".sid
    0
  else.
    'session' updateDBTable_pselectdb_ ".sid
    ss_urid
  end.
)

NB.*updateSession v updates expiry of session
updateSession=: 3 : 0
  sid=.0{:: readTicket y
  'session' updateDBTable_pselectdb_ ".sid
)

NB.*expireSession v changes status of session to inactive
NB. maybe better to delete expired sessions?
expireSession=: 3 : 0
  sid=.0{:: readTicket y
  'sessionexpire' updateDBTable_pselectdb_ ".sid
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