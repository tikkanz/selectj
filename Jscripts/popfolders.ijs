NB. functions to do with copying/deleting/changing
NB.  users' flocks/popluation folders


pathdelim=: 4 : '}.;([:x&,,)each y'

NB.*getFnme v get filename of specified filetype for user,offering,case
NB. result is string of filename, or numeric _1 if file doesn't exist
getFnme=: 4 : 0
  sep=. PATHSEP_j_
  basefldr=. 'd:\web\selectj\'
  select. x
    case. 'caseinstfolder' do.
    NB. userpop/uname/coursecode_year_sem_dm/scendefcode/caseinstanceid/
      pathinfo=. 'caseinstfolder' getTableStr_pselectdb_ y
      'hdr dat'=. split pathinfo
      (hdr)=. |:dat
      of_code=. '_' pathdelim cr_code;of_year;sm_code;dm_code
      fnme=. sep pathdelim ur_uname;of_code;sd_code;ci_id
      fnme=. 'userpop',sep,fnme,sep
    case. 'scendef' do.
    NB. scendefs/scendefcode.zip
      pathinfo=. 'scendef' getTableStr_pselectdb_ y
      'hdr dat'=. split pathinfo
      (hdr)=. |:dat
      fnme=. 'scendefs',sep,(,sd_code),'.zip'
    case. do.
  end.
  fnme=. basefldr,fnme
)

Note 'list filenames in tree'
NB. require 'dir'
,. ,>"1 (,/"0) 1 dir each (dirpath jpath 'd:/web/selectj/scendefs/popsz')#~ a:=(<'.svn') ss each dirpath jpath 'd:/web/selectj/scendefs/popsz'
)

NB.*copyScenDef v copies Scenario Definition folder to caseinstance folder

NB.*createCaseInstance v creates new CaseInstance
NB. return new caseinstance id, copy Case to user folder
NB. y is optional 3-item boxed list of userid;offeringid;caseid
NB. if y is '' then reads cookies and updates sessionticket
createCaseInstance=: 3 : 0
  'uid ofid csid'=. y
  ciid=. 'caseinstance' insertDBTable_pselectdb_ uid;ofid;csid
  zippath=. tolower 'scendef' getFnme csid
  newpath=. tolower 'caseinstfolder' getFnme ciid
  t=.zippath unzip newpath
  ciid
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
  ciid=. >@{:'caseinstance' getTable_pselectdb_ uofcsid
  if. #ciid do.
    ciid
  else. NB. create new caseinstance
    createCaseInstance uofcsid
  end.
)

NB.*updateCaseStage
NB.*summryCaseInstance
NB.*expireCaseInstance
NB.*deleteCaseInstanceFolder
