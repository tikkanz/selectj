NB. functions to do with copying/deleting/changing
NB.  users' flocks/popluation folders


pathdelim=: 4 : '}.;([:x&,,)each y'  NB.!Use join instead??

NB. deleteDirTree=: 3 : 0
NB.   try.
NB.     res=. 1!:55 {."1 dirtree y
NB.     res=. res,1!:55 |.dirpath y
NB.   catch.
NB.     NB. error number 7 is interface error (probably open file)
NB.     NB. error number 25 is file name error (dir/file doesn't exist)
NB.     NB. res=. 'Some files and/or directory could not be deleted.'
NB.     13!:11 ''
NB.   end.
NB. )


NB.*getFnme v get filename of specified filetype for user,offering,case
NB. result is string of filename, or numeric _1 if file doesn't exist
getFnme=: 4 : 0
  sep=. PATHSEP_j_
  basefldr=. jpath '~.CGI/' NB. 'd:\web\selectj\public\'
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

NB.*createCaseInstance v creates new CaseInstance
NB. return new caseinstance id, extract scendef to user folder
NB. y is optional 3-item boxed list of userid;offeringid;caseid
NB. if y is '' then reads cookies and updates sessionticket
createCaseInstance=: 3 : 0
  'uid ofid csid'=. y
  ciid=. 'caseinstance' insertDBTable_pselectdb_ uid;ofid;csid
  uz=. createCaseInstFolder csid;ciid
  ciid
)

NB.*createCaseInstFolder v extracts Scenario Definition zip to CaseInstance
NB. returns result of unzip
NB. y is 2-item list of boxed caseid;caseinstanceid
createCaseInstFolder=: 3 : 0
  'csid ciid'=.y
  zippath=. 'scendef' getFnme csid
  newpath=. 'caseinstfolder' getFnme ciid
  uz=. unzip zippath;newpath  NB. ,.uz;zippath;newpath
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
    ciid=. createCaseInstance uofcsid
  end.
)

NB.*updateCaseStage
NB.*summryCaseInstance

NB.*expireCaseInstance v updates caseinstance status to 0 and deletes folder
NB. y is caseinstanceid
expireCaseInstance=: 3 : 0
  'expirecaseinst' updateDBTable_pselectdb_ y
  deleteCaseInstFolder y
)

NB.*deleteCaseInstFolder v deletes user's case instance
NB. ys is caseinstance id
deleteCaseInstFolder=: 3 : 0
  delpath=. 'caseinstfolder' getFnme y
  res=.deltree delpath
  if. 1=*./res do. 1 else. 0 end.
)