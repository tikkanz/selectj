NB. functions to do with administering users


NB.*importUsers v imports list of users and enrols them in offering
NB.*getOfferingUsers v gets a list of users enrolled in offering
NB.*deleteEnrolment v deletes user enrolment

NB.*cleanGuests v reset guest users with expired sessions
NB. looks for guest sessions that have timed out and expires them
NB. resets guest users.
cleanGuests=: 3 : 0
  ginfo=. 'expiredguests' getInfo ''
  if. 0=#ginfo do. 0 return. end. NB. no expired guests
  'hdr dat'=. split ginfo
  (hdr)=. |:dat                   NB. assign hdrnames
  if. *#ss_id do.
    'expiresession' updateInfo boxopenatoms ss_id
  end.
  resetUsers ur_id
  ''
)

NB.*resetUsers v resets user status to 0 and deletes folder
NB. y is boxed list of user ids
NB. no result?
resetUsers=: 3 : 0
  if. *#y do.
    urids=. boxopenatoms y
    cids=. 'caseinst2expire' getInfo urids
    resetCaseInsts cids
    deleteUserFolders y NB. delete users' folders
    'resetusers' updateInfo urids
    ''
  end.
)

NB.*resetCaseInsts
NB. y is boxed list of case instance ids
NB.! doesn't delete stored caseinstance zips
NB.! that's OK if called by resetUsers because whole user folder is deleted
resetCaseInsts=: 3 : 0
  if. *#y do.
    ciids=. boxopenatoms y
    'expirecaseinst' updateInfo ciids
    'delstoredcaseinst' updateInfo ciids
    ''
  end.
)


NB.*setUsers v sets user account
NB. y is list of user ids
NB. no result?
setUsers=: 3 : 0
  if. *#y do.
    'setusers' updateInfo y
    ''
  end.
)

NB.*deleteUsers v resets user account and folder
NB. y is list of user ids
NB. no result?
deleteUsers=: 3 : 0
  if. *#y do.
    deleteUserFolders y NB. do stuff to delete user folder
    'deleteusers' updateInfo boxopenatoms y
    ''
  end.
)