NB. functions to do with copying/deleting/changing 
NB.  users' flocks/popluation folders

NB.*getFnme v get filename of specified filetype for user,offering,case
NB. result is string of filename, or numeric _1 if file doesn't exist
getFnme=: 4 : 0
  
)

NB.*createCaseInstance v creates new CaseInstance
NB. return new caseinstance id, copy Case to user folder
NB. y is optional 3-item boxed list of userid;offeringid;caseid
NB. if y is '' then reads cookies and updates sessionticket
createCaseInstance=: 3 : 0
  'caseinstance' insertDBTable_pselectdb_ uid;ofid;csid
)

NB.*getCaseInstance v get CaseInstance info for uid,ofid,csid
NB. return 0 if no valid/current CaseInstance, otherwise caseinstance info
NB. y is optional 3-item boxed list of userid;offeringid;caseid
NB. if y is '' then reads cookies and updates sessionticket
getCaseInstance=: 3 : 0
  if. 0=#y do.
    if. 0-: uofcsid=. validCase'' do. 0 return. end.
  else.
    if. 0-: uofcsid=. (2{.y) validCase 2}.y do. 0 return. end.
  end.
  cinst=.'caseinstance' getTable_pselectdb_ uofcsid
  if. 0=#cinst do. 0 return. end.
  cinst
)

NB.*expireCaseInstance
NB.*summryCaseInstance