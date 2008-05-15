NB. functions to do with validating & registering users

NB.*createSession v creates a new user session
NB. returns ticket to write to cookie
NB. y is userID
createSession=: 3 : 0
 if. isdefseed_rgspasswd_'' do. randomize'' end.
 sid=. >:?<:-:2^32 NB. random session id
 sh=. salthash ":sid 
 'newsession' insertInfo  sid;y;sh
 tk=. writeTicket sid;{:sh
)

NB.*expireSession v changes status of session to inactive
NB. maybe better to delete expired sessions?
expireSession=: 3 : 0
  if.0=#y do. y=. qcookie 'SessionTicket' end.
  sid=.0{:: readTicket y
  'expiresession' updateInfo ".sid
)

NB.*isActive v checks if username is inactive (needs to be reinitalised)
isActive=: 3 : 0
  s=. 'userstatus' getInfo y
)

NB.*readTicket v reads ticket string
NB. returns 2-item boxed list of sessionid;hash
readTicket=: 3 : 0
  kVTable=. qsparse y  NB. qsparse from JHP
  sid=.'ssid' keyval kVTable
  shash=. 'hash' keyval kVTable
  sid;shash
)

NB.*registerUser v creates a new user, if successful returns userid
NB. y is boxed list of strings from registration form
NB. result is numeric -ve if not successful, string userid if successful
registerUser=: 3 : 0
  'action uname fname lname refnum email passwd'=.y
  if. action-:'guest' do. uname=. randPassword 16  end.
  if. *#u=.'userlogin' getInfo uname  do. NB. check usrname not already in use
    if. NB. check if same person
      m1=. email-:'pp_email' keyval |:'userrec' getInfo uid=.0{::u 
      m2=. action-:'importuser'
     do. 
      uid return. NB. return existing user id 
     else.
      _2  return.
    end.
  end. 
  if. 0=# pid=. 'idfromemail' getInfo email  do. NB. if email address not already used in people table
    pid=. 'newperson' insertInfo fname;lname;email NB. insert person in people table
  end.
  sph=. salthash passwd NB. create salt and passhash
  uid=.'newuser' insertInfo pid;uname;refnum;|.sph NB. insert user into database
)

NB.*enrolUsers v enrols user(s) in offering(s)
NB. result is numeric list of new row numbers in enrolments table if successful
NB. y is 1 or 2-element boxed list
NB.     0{::y is numeric list of user ids to enrol
NB.     1{::y is optional numeric offering id(s) to enrol every user id in (default 1)
NB. x is optional role id for enrolment [default is 1 (student)]
enrolUsers=: 3 : 0
  1 enrolUsers y
:
  'uids ofids'=. 2{.!.(<1) boxopen y NB. fill 1 is default offering
  rlids=. (#uids)$x
  enrl=.(>,{uids;ofids),.(#ofids)#rlids
  if. 0=#enrl do. '' return. end.
  'newenrolment' insertInfo <"0 enrl
)

NB.*createUsers v registers user(s) and enrols them as students in offering(s)
NB. result is user ids if successful
NB. y is table of boxed lists. Row for each user
NB.     column for each parameter required by registerUser
NB.        ('action uname fname lname refnum email passwd')
NB. x is optional numeric list of offering id(s) to enrol every user in
createUsers=: 3 : 0
  1 createUsers y NB. enrol in Expt with AnSim course by default
:
 uids=. ,registerUser"1 y
 rowids=. 1 enrolUsers ((0&< # ])uids);x NB. enrol non-negative uids
 uids
)

NB.*importUsers v extract info required for user registration from external source
NB. result is table of boxed lists. Row for each user
NB.     column for each parameter required by registerUser
NB.        ('action uname fname lname refnum email passwd')
NB. y is literal filename of file containing user info
NB. x is optional literal label describing type of external source
NB. EG. 'MasseyRPS' importUsers 'c:\temp\classlist200801.csv'
importUsers=: 3 : 0
  'MasseyRPScsv' importUsers y
:
  select. x
   case. 'MasseyRPScsv' do.
     NB. map  user info to csv column headers
     'uname fname lname refnum email'=. ;:'stud_code forename surname stud_code email_address'
     NB. require 'csv'
     'hdr dat'=. split 13}. readcsv y
     idx=. hdr i. uname;fname;lname;refnum;email
     usrs=. idx{"1 dat
     usrs=. usrs,. (hdr i.<lname){"1 dat NB. passwd=. lname
     usrs=. (<'importuser'),.usrs      NB. action=.<'importuser'
   case. do.
     'unknown data source' assert 0
  end. 
)

NB.*updateSession v updates expiry of session
updateSession=: 3 : 0
  if.0=#y do. y=. qcookie 'SessionTicket' end.
  sid=.0{:: readTicket y
  'extendsession' updateInfo ".sid
)

NB.*validCase v Checks if case id is valid for user offering
NB. returns 0 if not, otherwise returns 3-item boxed list of userID;offeringID;caseID
NB. y is optional numeric offering id (cs_id), otherwise reads cookie
NB. x is optional 2-item boxed list of user id;offering id, otherwise gets via enrolledIn
NB. calling with no left argument will update session expiry if valid
validCase=: 3 : 0
  if. 0-: uofid=.validEnrolment'' do. 0 return. end.
  uofid validCase y
:
  if. 0=#y do. y=.0 qcookie 'CaseID' end.
  vldcs=.'validcase' getInfo x,<y
  if. #vldcs do. x,<y else. 0 end.
)

NB.*validEnrolment v Checks if authenticated user is enrolled in offering
NB. returns 0 if not, otherwise returns 2-item boxed list of user id;offering id
NB. y is optional numeric offering id (of_id), otherwise reads cookie
NB. x is optional numeric user id, otherwise gets via sessionticket cookie
NB. calling with no left argument will update session expiry if valid
validEnrolment=: 3 : 0
  if. 0-: uid=.validSession'' do. 0 return. end.
  uid validEnrolment y
:
  if. 0=#y do. y=. 0 qcookie 'OfferingID' end.
  enrld=.'enrolled' getInfo x;y
  if. #enrld do. x;y else. 0 end.
)

NB.*validLogin v checks if login is valid returns userid
NB.  y is boxed list of two strings 'username';'password'
NB.  result is numeric _1 if not valid, string userid if valid
validLogin=: 3 : 0
 'usrnme passwd'=. y
  if. 0=# usrnme do. _1 return. end. NB. check for empty usrname
  uinfo =. 'userlogin' getInfo usrnme  NB. retrieve data for username
  if. 0=# uinfo   do. _2 return. end.   NB. check username exists
  'duid dunme dhash dsalt' =. 4{.uinfo
  if. -. dhash-: _1{::dsalt salthash passwd do. _3 return. end. NB. check password is valid
  duid
)

NB.*validSession v validates session ticket
NB. if session ticket cookie not valid, returns 0
NB. if expired, update ss_status to 0 and returns 0
NB. if valid, updates expiry and returns ss_urid
NB. y is content (session ticket) of sessionID cookie
validSession=: 3 : 0
  if. 0=#y do. y=. qcookie 'SessionTicket' end.
  'sid shash'=. readTicket y
  sinfo=.'sessioninfo' getInfo sid NB. returns ss_urid, ss_salt, timeleft
  if. 0=#sinfo do. 0 return. end. NB. no (active) session
  'hdr dat'=. split sinfo         
  (hdr)=. |:dat                   NB. assign hdrnames
  if. -. shash -: 1{::ss_salt salthash sid do. 0 return. end.
  if. timeleft<0 do. 
    'expiresession' updateInfo sid
    0
  else.
    'extendsession' updateInfo sid
    ss_urid
  end.
)

NB.*writeTicket v makes ticket string for cookie
NB. returns string to write to cookie
writeTicket=: 3 : 0
  'tsid thash'=.y
  ('ssid=',":tsid),'&hash=',thash
)
