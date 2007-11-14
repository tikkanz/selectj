NB. functions to do with copying/deleting/changing
NB.  users' flock/popluation folders

NB.*createCaseInstance v creates new CaseInstance
NB. return new caseinstance id, extract scendef to user folder
NB. y is optional 3-item boxed list of userid;offeringid;caseid
NB. if y is '' then reads cookies and updates sessionticket
createCaseInstance=: 3 : 0
  ciid=. 'newcaseinstance' insertInfo y
  uz=. createCaseInstFolder ciid
  ciid
)

NB.*createCaseInstFolder v extracts Scenario Definition zip to CaseInstance
NB. returns result of unzip
NB. y is caseinstanceid
createCaseInstFolder=: 3 : 0
  zippath=. 'scendefpath' getFnme y
  newpath=. 'caseinstpath' getFnme y
  uz=. unzip zippath;newpath NB. newpath unziptree zippath 
)

NB.*getCaseInstance v get CaseInstance info for uid,ofid,csid
NB. returns caseinstance id, creates new one first if necessary
NB. returns zero if case not valid for user offering
NB. y is optional 3-item boxed list of userid;offeringid;caseid
NB. if y is '' then reads cookies and updates sessionticket
getCaseInstance=: 3 : 0
  if. 0=#y do.
    if. 0-: uofcsid=. validCase'' do. 0 return. end.
  else.
    uofcsid=. y
  end.
  ciid=. 'caseinstanceid' getInfo uofcsid
  if. #ciid do.
    ciid
  else. NB. create new caseinstance
    ciid=. createCaseInstance uofcsid
  end.
)

NB.*updateCaseStage v Update stage/status of case instance.
NB. y is list of boxed new case stage;ci_id
updateCaseStage=: 3 : 0
  'casestage' updateInfo y
)

NB.*storeCaseInstance v stores summary info from completed case instance in summary zip
storeCaseInstance=: 3 :0
  nms=. <"1&dtb"1 'sumryfiles' getFnme y NB. get names of Files to store
  zipnm=. 'sumryzippath' getFnme y  NB. get name of zip file to store in
  dirinf=. 'caseinstpath' getFnme y
  z=. (zipnm;dirinf) zipfiles nms
  if. (#nms)={:z do. NB. update only if all files successfully zipped
    'storecaseinst' updateInfo y  NB. Update ci_stored in caseinstances table
  end.
)

NB.*deleteStoredCaseInst v deletes zip file containing summary info for case instance
NB. y is ciid(s)
deleteStoredCaseInst=: 3 :0
  if. *#y do.
    zipnm=. 'sumryzippath' getFnme y
    kfnm=. 'ijf',~_3}. zipnm
    ferase zipnm;kfnm
    if. -. fexist zipnm do.
      'delstoredcaseinst' updateInfo y  NB. update ci_stored in caseinstances table.
    end.
    ''
  end.
)

NB.*cleanStoredKeyFiles v Deletes key files older than 4 days.
cleanStoredKeyFiles=: 3 :0
  pth=. getpath_j_ ,'userfolderpath' getFnme 1 NB. should be at least 1 user?
  kfls=. 2{."1 dirtree pth,'*.ijf'
  if. #kfls do.
    oldmsk=. (4%365)<,(3{. 6!:0 '')&tsdiff&(3&{.) every 1{"1 kfls
    kfls=. oldmsk# {."1 kfls
    ferase kfls
  end.
)


NB.*expireCaseInstance v updates caseinstance status to 0 and deletes folder
NB. y is caseinstanceid
expireCaseInstance=: 3 : 0
  'expirecaseinst' updateInfo y
  deleteCaseInstFolder y
)

NB.*deleteCaseInstFolder v deletes user's case instance
NB. ys is caseinstance id
deleteCaseInstFolder=: 3 : 0
  delpath=. 'caseinstpath' getFnme y
  res=.deltree delpath
  if. 1=*./res do. 1 else. 0 end.
)
NB.*deleteUserFolders v deletes users' folders
NB. ys is boxed list of user ids
deleteUserFolders=: 3 : 0
  delpath=. ,each 'userfolderpath'&getFnme each y
  res=.deltree every delpath
  if. 1=*./res do. 1 else. 0 end.
)