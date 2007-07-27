NB. I think this will be about working out what templates are available
NB. Presenting those options to user

NB.*getAllTrtNames v gets names of all defined traits for scenario
NB. result is column of boxed strings, 0{. is <'TrtName'
NB. y is optional numeric caseid
NB. x is optional boxed 2-item list of numeric userid;offeringid
NB. arguments not given are retrieved from cookies
NB. eg. setcolnames getTrtNames ''
NB. eg. 1 2 getTrtNames 1
getAllTrtNames=: 3 : 0
  'uid ofid'=. qcookie"0 ;:'UserId CaseID'
  (uid;ofid) getAllTrtNames y
:
  if. 0=#y do. y=. 0 qcookie 'CaseID' end.
  xlfnme=. 'TrtInfo' getFnme x,<y
NB.  xlfnme=. 'd:\web\selectj\scendefs\popsz\trtinfo.xls'
  1{."1 'tDefn' readexcel xlfnme
)

NB.*getFnme v get filename of specified filetype for user,offering,case
NB. result is string of filename, or numeric _1 if file doesn't exist
getFnme=: 4 : 0
  
)
