NB. functions to do with validating & registering users

NB.*createSession v creates a new user session
NB. returns ticket to write to cookie
NB. y is userID
createSession=: 3 : 0
 if. isdefseed_rgspasswd_'' do. randomize'' end.
 sid=. >:?<:-:2^32 NB. random session id
 sh=. salthash ":sid 
 'session' insertDBTable  sid;y;sh
 tk=. writeTicket sid;{:sh
)

NB.*expireSession v changes status of session to inactive
NB. maybe better to delete expired sessions?
expireSession=: 3 : 0
  if.0=#y do. y=. qcookie 'SessionTicket' end.
  sid=.0{:: readTicket y
  'sessionexpire' updateDBTable ".sid
)

NB.*isActive v checks if username is inactive (needs to be reinitalised)
isActive=: 3 : 0
  s=. {:'status' getDBTable y
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
  uinfo =. {:'login' getDBTable uname  NB. retrieve data for username
  if. -.uinfo-:'' do. _2 return. end. NB. check usrname not already in use
  pinfo =. {:'email' getDBTable  email
  if. -.pinfo-:''  do. NB. if email address already used in people table
    pid=. 0{::pinfo    NB. get pid of person with that email address
  else.
    pid=. 'newperson' insertDBTable fname;lname;email NB. insert person in people table
  end.
  sph=. salthash passwd NB. create salt and passhash
  uid=.'newuser' insertDBTable pid;uname;refnum;|.sph NB. insert user into database
  NB. uid=.'newuser' insertDBTable (}:y),|.sph NB. insert user into database
)

NB.*updateSession v updates expiry of session
updateSession=: 3 : 0
  if.0=#y do. y=. qcookie 'SessionTicket' end.
  sid=.0{:: readTicket y
  'session' updateDBTable ".sid
)

NB.*validCase v Checks if case id is valid for user offering
NB. returns 0 if not, otherwise returns 3-item boxed list of userID;offeringID;caseID
NB. y is optional numeric offering id (of_id), otherwise reads cookie
NB. x is optional 2-item boxed list of user id;offering id, otherwise gets via enrolledIn
NB. calling with no left argument will update session expiry if valid
validCase=: 3 : 0
  if. 0-: uofid=.validEnrolment'' do. 0 return. end.
  uofid validCase y
:
  if. 0=#y do. y=.0 qcookie 'CaseID' end.
  vldcs=.'validcase' getDBTable x,<y
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
  enrld=.'enrolled' getDBTable x;y
  if. #enrld do. x;y else. 0 end.
)

NB.*validLogin v checks if login is valid returns userid
NB.  y is boxed list of two strings 'username';'password'
NB.  result is numeric _1 if not valid, string userid if valid
validLogin=: 3 : 0
 'usrnme passwd'=. y
  if. usrnme -: '' do. _1 return. end. NB. check for empty usrname
  uinfo =. {:'login' getDBTable usrnme  NB. retrieve data for username
  if. ''-: uinfo   do. _2 return. end.   NB. check username exists
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
  sinfo=.'session' getDBTable ".sid
  if. 0=#sinfo do. 0 return. end. NB. no (active) session
  'hdr dat'=. split sinfo         
  (hdr)=. |:dat                   NB. assign hdrnames
  if. -. shash -: 1{::ss_salt salthash sid do. 0 return. end.
  if. timeleft<0 do. 
    'sessionexpire' updateDBTable ".sid
    0
  else.
    'session' updateDBTable ".sid
    ss_urid
  end.
)

NB.*writeTicket v makes ticket string for cookie
NB. returns string to write to cookie
writeTicket=: 3 : 0
  'tsid thash'=.y
  ('ssid=',":tsid),'&hash=',thash
)
