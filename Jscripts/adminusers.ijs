NB. functions to do with administering users


NB.*importUsers v imports list of users and enrols them in offering
NB.*getOfferingUsers v gets a list of users enrolled in offering
NB.*deleteEnrolment v deletes user enrolment

NB.*cleanGuests v reset guest users with expired sessions
NB. looks for guest sessions that have timed out and expires them
NB. resets guest users.
cleanGuests=: 3 : 0
  ginfo=. 'expiredguests' getDBTable ''
  if. 0=#ginfo do. 0 return. end. NB. no expired guests
  'hdr dat'=. split ginfo
  (hdr)=. |:dat                   NB. assign hdrnames
  if. *#ss_id do.
    'sessionexpire' updateDBTable boxopenatoms ss_id
  end.
  resetUsers ur_id
  ''
)

NB.*resetUsers v resets user account and folder
NB. y is boxed list of user ids
NB. no result?
resetUsers=: 3 : 0
  if. *#y do.
    urids=. boxopenatoms y
    cids=. 'caseinst2expire' getDBField urids
    if. #cids do. 
      'expirecaseinst' updateDBTable boxopenatoms cids
    end.
    deleteUserFolders y NB. delete users' folders
    'resetusers' updateDBTable urids
    ''
  end.
)

NB.*setUsers v sets user account
NB. y is list of user ids
NB. no result?
setUsers=: 3 : 0
  if. *#y do.
    'setusers' updateDBTable y
    ''
  end.
)

NB.*deleteUsers v resets user account and folder
NB. y is list of user ids
NB. no result?
deleteUsers=: 3 : 0
  if. *#y do.
    deleteUserFolders y NB. do stuff to delete user folder
    'deleteusers' updateDBTable boxopenatoms y
    ''
  end.
)