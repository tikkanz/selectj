NB. functions to do with copying/deleting/changing
NB.  users' flock/popluation folders


pathdelim=: 4 : '}.;([:x&,,)each y'  NB.!Use join instead??

NB.*getFnme v get filename of specified filetype for user,offering,case
NB. result is string of filename, or numeric _1 if file doesn't exist
NB. y is ciid
NB. x is string describing file to get
getFnme=: 4 : 0
  basefldr=. IFCONSOLE{:: 'd:/web/selectj/';'~.CGI/'
  NB. basefldr=. '~.CGI/' NB. 'd:\web\selectj\'
  select. x
    case. 'animini' do.
      fdir=. 'caseinstfolder' getFnme y
      fnme=. 'animini' getDBItem y
      fnme=. fdir,fnme
    case. 'caseinstfolder' do.
      NB. userpop/uname/coursecode_year_sem_dm/scendefcode/caseinstanceid/
      pathinfo=. 'caseinstfolder' getDBTableStr y
      'hdr dat'=. split pathinfo
      (hdr)=. |:dat
      of_code=. '_' pathdelim cr_code;of_year;sm_code;dm_code
      fnme=. '/' pathdelim ur_uname;of_code;sd_code;ci_id
      fnme=. basefldr,'userpop/',fnme,'/'
    case. 'scendef' do.
      NB. scendefs/scendefcode.zip
      cde=. 'scendef' getDBItem y
      fnme=. basefldr,'scendefs/',cde,'.zip'
    case. keys=. ;:'selnlist pedigree matealloc animsumry' do.
      fdir=. 'caseinstfolder' getFnme y
      inipath=. 'animini' getFnme y
      fkey=. 1 transName x
      fnme=. getIniString fkey;'FileNames';inipath
      if. *#fnme do. NB. use default names
        fnme=. (keys i.<x){:: ('output/selectlstfem.csv';'output/selectlstmale.csv'); cut'output/pedigree.csv matealloc.csv output/animsummary.csv'
      end.
      fnme=.fdir&, @> boxopen fnme
    case. 'summaryCSV' do.
      NB. 'output/animsummary.csv';'d:\web\...\ciid.zip'
      NB. lenfldr=.# 'caseinstfolder' getFnme y
      NB.! fnme=. lenfldr}. 'animsumry' getFnme y NB. doesn't work cause animalsim.ini gone
      fnme=. 'output/animsummary.csv'
      zipnme=. 'sumryzip' getFnme y
      fnme=. >fnme;zipnme
    case. 'summaryINI' do.
      NB. 'animalsim.ini';'d:\web\...\ciid.zip'
      fnme=. 'animini' getDBItem y
      zipnme=. 'sumryzip' getFnme y
      fnme=. >fnme;zipnme
    case. 'sumryfiles' do. NB. fnames of files to include in zip
      fnme=. >('animini';'animsumry') getFnme each y
    case. 'sumryzip' do.
      NB. userpop/uname/coursecode_year_sem_dm/summaries/ciid.zip
      fdir=. 'sumryfolder' getFnme y
      fnme=. ":y
      fnme=. fdir,fnme,'.zip'
    case. 'sumryfolder' do.
      NB. userpop/uname/coursecode_year_sem_dm/summaries/
      pathinfo=. 'caseinstfolder' getDBTableStr y
      'hdr dat'=. split pathinfo
      (hdr)=. |:dat
      of_code=. '_' pathdelim cr_code;of_year;sm_code;dm_code
      fnme=. '/' pathdelim ur_uname;of_code;'summaries'
      fnme=. basefldr,'userpop/',fnme,'/'
    case. 'trtinfo' do.
      fdir=. 'caseinstfolder' getFnme y
      inipath=. 'animini' getFnme y
      fkey=. 1 transName x
      fnme=. getIniString fkey;'QuantTrts';inipath
      if. *#fnme do. fnme=. 'TrtInfo.xls' end.
      fnme=. fdir,fnme
    case. 'userfolder' do. NB. y is ur_id
      uns=.'username' getDBField y
      fnme=. (basefldr,'userpop/'),"1 uns
    case. do.
  end.
  fnme=. jpath"1 fnme
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
  ciid=. >@{:'caseinstance' getDBTable uofcsid
  if. #ciid do.
    ciid
  else. NB. create new caseinstance
    ciid=. createCaseInstance uofcsid
  end.
)

NB.*updateCaseStage v Update stage/status of case instance.
NB. y is list of boxed new case stage;ci_id
updateCaseStage=: 3 : 0
  'casestage' updateDBTable y
)

NB.*summryCaseInstance v copies summary info to summary folder 
summryCaseInstance=: 3 :0
  nms=. <"1&dtb"1 'sumryfiles' getFnme y NB. get names of Files to store
  zipnm=. 'sumryzip' getFnme y  NB. get name of zip file to store in
  dirinf=. 'caseinstfolder' getFnme y
  z=. (zipnm;dirinf) zipfiles nms
  if. (#nms)={:z do. NB. update only if all files successfully zipped
    'sumrycaseinst' updateDBTable y  NB. Update ci_sumry in caseinstances table
  end.
)

Note 'summryCaseInstance'
Can see which case instances have summaries by looking up ci_sumry 
in caseinstances table.
)

NB.*deleteCaseInstSummary v deletes zip file containing summary info for case instance
NB. y is ciid(s)
deleteCaseInstSummary=: 3 :0
  zipnm=. 'sumryzip' getFnme y
  ferase zipnm
  if. -. fexist zipnm do.
    'delsumrycaseinst' updateDBTable y  NB. update ci_sumry in caseinstances table.
  end.
)

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
NB.*deleteUserFolder v deletes user's folder
NB. ys is user id
deleteUserFolders=: 3 : 0
  delpath=. 'userfolder' getFnme y
  res=.deltree"1 delpath
  if. 1=*./res do. 1 else. 0 end.
)