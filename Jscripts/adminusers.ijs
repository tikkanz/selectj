NB. functions to do with administering users


NB.*importUsers v imports list of users and enrols them in offering
NB.*getOfferingUsers v gets a list of users enrolled in offering
NB.*deleteEnrolment v deletes user enrolment

NB.*resetUsers v resets user account and folder
NB. y is list of user ids
NB. no result?
resetUsers=: 3 : 0
  if. *#y do.
    'resetusers' updateDBTable_psqliteq_ y
    NB. do stuff to reset user scenario data
    ''
  end.
)

NB.*resetUsers v resets user account and folder
NB. y is list of user ids
NB. no result?
setUsers=: 3 : 0
  if. *#y do.
    'setusers' updateDBTable_psqliteq_ y
    NB. do stuff to create user scenario data
    ''
  end.
)

NB.*deleteUsers v resets user account and folder
NB. y is list of user ids
NB. no result?
deleteUsers=: 3 : 0
  if. *#y do.
    'deleteusers' updateDBTable_psqliteq_ y
    NB. do stuff to delete user scenario data
    ''
  end.
)