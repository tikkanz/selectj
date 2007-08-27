NB. functions to do with copying/deleting/changing
NB.  users' flocks/popluation folders


pathdelim=: 4 : '}.;([:x&,,)each y'  NB.!Use join instead??

NB.*getFnme v get filename of specified filetype for user,offering,case
NB. result is string of filename, or numeric _1 if file doesn't exist
getFnme=: 4 : 0
  sep=. PATHSEP_j_
  basefldr=. IFCONSOLE{:: 'd:/web/selectj/';'~.CGI/'
  NB. basefldr=. '~.CGI/' NB. 'd:\web\selectj\'
  select. x
    case. 'animini' do.  NB. y is ciid
      fdir=. 'caseinstfolder' getFnme y
      fnme=. 'animini' getDBItem_psqliteq_ y
      fnme=. fdir,fnme
    case. 'caseinstfolder' do.  NB. y is ciid
      NB. userpop/uname/coursecode_year_sem_dm/scendefcode/caseinstanceid/
      pathinfo=. 'caseinstfolder' getTableStr_psqliteq_ y
      'hdr dat'=. split pathinfo
      (hdr)=. |:dat
      of_code=. '_' pathdelim cr_code;of_year;sm_code;dm_code
      fnme=. sep pathdelim ur_uname;of_code;sd_code;ci_id
      fnme=. basefldr,'userpop',sep,fnme,sep
    case. 'scendef' do.  NB. y is ciid
      NB. scendefs/scendefcode.zip
      cde=. 'scendef' getDBItem_psqliteq_ y
      fnme=. basefldr,'scendefs',sep,cde,'.zip'
    case. 'TrtInfo' do.  NB. y is ciid
      fdir=. 'caseinstfolder' getFnme y
      fnme=. 'TrtInfo.xls'
      fnme=. fdir,fnme
    case. do.
  end.
  fnme=. jpath fnme
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
  ciid=. 'caseinstance' insertDBTable_psqliteq_ y
  uz=. createCaseInstFolder ciid
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
  ciid=. >@{:'caseinstance' getTable_psqliteq_ uofcsid
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
  'expirecaseinst' updateDBTable_psqliteq_ y
  deleteCaseInstFolder y
)

NB.*deleteCaseInstFolder v deletes user's case instance
NB. ys is caseinstance id
deleteCaseInstFolder=: 3 : 0
  delpath=. 'caseinstfolder' getFnme y
  res=.deltree delpath
  if. 1=*./res do. 1 else. 0 end.
)