NB. functions to do with copying/deleting/changing
NB.  users' flock/popluation folders


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
      fnme=. 'animini' getDBItem y
      fnme=. fdir,fnme
    case. 'caseinstfolder' do.  NB. y is ciid
      NB. userpop/uname/coursecode_year_sem_dm/scendefcode/caseinstanceid/
      pathinfo=. 'caseinstfolder' getDBTableStr y
      'hdr dat'=. split pathinfo
      (hdr)=. |:dat
      of_code=. '_' pathdelim cr_code;of_year;sm_code;dm_code
      fnme=. sep pathdelim ur_uname;of_code;sd_code;ci_id
      fnme=. basefldr,'userpop',sep,fnme,sep
    case. 'matealloc' do. NB. y is ciid
      fdir=. 'caseinstfolder' getFnme y
      fnme=. fdir,'MateAlloc.csv'
    case. 'scendef' do.  NB. y is ciid
      NB. scendefs/scendefcode.zip
      cde=. 'scendef' getDBItem y
      fnme=. basefldr,'scendefs',sep,cde,'.zip'
    case. 'TrtInfo' do.  NB. y is ciid
      fdir=. 'caseinstfolder' getFnme y
      fnme=. 'TrtInfo.xls'
      fnme=. fdir,fnme
    case. do.
  end.
  fnme=. jpath fnme
)

NB.*createCaseInstance v creates new CaseInstance
NB. return new caseinstance id, extract scendef to user folder
NB. y is optional 3-item boxed list of userid;offeringid;caseid
NB. if y is '' then reads cookies and updates sessionticket
createCaseInstance=: 3 : 0
  ciid=. 'caseinstance' insertDBTable y
  uz=. createCaseInstFolder ciid
  ciid
)

NB.*createCaseInstFolder v extracts Scenario Definition zip to CaseInstance
NB. returns result of unzip
NB. y is caseinstanceid
createCaseInstFolder=: 3 : 0
  zippath=. 'scendef' getFnme y
  newpath=. 'caseinstfolder' getFnme y
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
  ciid=. >@{:'caseinstance' getDBTable uofcsid
  if. #ciid do.
    ciid
  else. NB. create new caseinstance
    ciid=. createCaseInstance uofcsid
  end.
)

NB.*updateCaseStage
NB. y is list of boxed new case stage;ci_id
updateCaseStage=: 3 : 0
  'casestage' updateDBTable y
)
NB.*summryCaseInstance

NB.*expireCaseInstance v updates caseinstance status to 0 and deletes folder
NB. y is caseinstanceid
expireCaseInstance=: 3 : 0
  'expirecaseinst' updateDBTable y
  deleteCaseInstFolder y
)

NB.*deleteCaseInstFolder v deletes user's case instance
NB. ys is caseinstance id
deleteCaseInstFolder=: 3 : 0
  delpath=. 'caseinstfolder' getFnme y
  res=.deltree delpath
  if. 1=*./res do. 1 else. 0 end.
)