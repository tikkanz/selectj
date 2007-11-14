NB. =========================================================
NB. Data virtualisation layer
NB. virtualises interaction with data so that data requests/changes in rest of code
NB. are independent of actual location and form of data
NB.! put in own locale and create pointers for main verbs in rgsselectj locale
NB. Main verbs are:
NB.  * getInfo
NB.  * insertInfo
NB.  * updateInfo


NB. =========================================================
NB. Available Database SELECT query names in their classes
NB. y is mostly case instance id
QRYci=: ;:'animinipath caseinstpath casedetails caseinstname caseinststatus casestage paramform scendefpath'
UPDci=: ;:'casestage delstoredcaseinst expirecaseinst storecaseinst'
INSci=: ;:'newcaseinstance'

NB. y is mostly user id
QRYur=: ;:'caseinst2expire expiredguests usergreeting usercourses userstatus userlist username userrec'
QRYcomb=: ;:'caseinstanceid enrolled validcase'
QRYother=: ;:'idfromemail userlogin'
UPDur=: ;:'deleteusers resetusers setusers'
INSur=: ;:'newuser newperson'

NB. y is mostly offering id
QRYof=: ;:'coursecases coursedetails coursename coursesumrys'
UPDof=: ;:''
INSof=: ;:''

NB. y is mostly session id
QRYss=: ;:'sessioninfo'
UPDss=: ;:'expiresession extendsession'
INSss=: ;:'newsession'

NB. DBQRYall n Boxed list of all SELECT query names.
DBQRY=: QRYci,QRYof,QRYur,QRYss,QRYcomb,QRYother
NB. DBUPDall n Boxed list of all UPDATE query names.
DBUPD=: UPDci,UPDur,UPDof,UPDss
NB. DBINSall n Boxed list of all INSERT query names.
DBINS=: INSci,INSur,INSof,INSss

NB. =========================================================
NB. Classify database query names according to result type required
NB. (table, tablestr, row, column, item etc)
  DBtable   =:          ;:'casedetails caseinstname paramform'
  DBtable   =: DBtable, ;:'userlist userrec usergreeting usercourses expiredguests validcase enrolled'
  DBtable   =: DBtable, ;:'coursecases coursedetails coursename coursesumrys'
DBtable   =: DBtable, ;:'sessioninfo'
DBtablestr=: ;:'caseinstpath'
DBrow     =: ;:'casestage userlogin caseinststatus'
DBcol     =: ;:'caseinst2expire username'
DBitem    =: ;:'animinipath scendefpath caseinstanceid userstatus idfromemail'

NB. =========================================================
NB. Valid query names where info not sourced from database (probably file)

FLQRY=: ;:'animini trtinfoall caseprogress'
FLQRY=: FLQRY, ;:'animsumry animsumrycnt ansumrycsv animsumryhdr '
FLQRY=: FLQRY, ;:'selnlistfem selnlistmale '

NB.*getInfo v get info for a case instance
NB. y is case instance id(s)
NB. x is literal name of information request
NB.! cover verb for readStoredCaseInst and getScenarioInfo verbs
NB.! check status of ciid (current,stage,stored) to work out where to get info
NB.! Hand over to appropriate handling verb getScenarioInfo/readCaseInst
getInfo=: 4 : 0
  NB. QRYall contains boxed list of names of info queries that are available
  NB.   via a DB call
  if. (boxopen x) e. DBQRY do.
    x getInfoDB y
  else. NB. caseinstance info stored somewhere other than the Database
    (x,':query undefined') assert (boxopen x) e. FLQRY
    sts=. 'caseinststatus' getInfoDB y NB.! check status/location of caseinst
    select. <sts
      case. <0;0  do. NB. no longer valid and not stored
        '' NB. assert error, data not available
      case. <(0;1) do.  NB. valid not stored
        x getCIInfoCurr y  NB.getCIInfoCurr
      case. (1;0);<(1;1) do.  NB. stored
        x getCIInfoStored y
    end.
  end.
)

NB.*updateInfo v
updateInfo=: 4 : 0
  (x,':query undefined') assert (boxopen x) e. DBUPD
  x updateDBTable y
)

NB.*insertInfo v
insertInfo=: 4 : 0
  (x,':query undefined') assert (boxopen x) e. DBINS
  x insertDBTable y
)

getInfoDB=: 4 : 0
  select. x
    case. DBtable do.
      res=. x getDBTable y
    case. DBtablestr do.
      res=. x getDBTableStr y
    case. DBrow do.
      res=. {: x getDBTable y
    case. DBcol do.
      res=. x getDBField y
    case. DBitem do.
      res=. x getDBItem y
    case. do. 
      (x,':querytype undefined') assert 0
  end.
  res
)

NB. getCIInfoStored v Reads info from a CaseInstance stored in a zip file.
NB. result depends on info requested.
NB.     if .csv then 2-item boxed list. 1{boxed list of header names. 2{csv contents as inverted table
NB.     if .ini then boxed list of parsed ini file
NB. y is ciid of case instance to read
NB. x is datatype to read
getCIInfoStored=: 4 : 0
  fnme=. <"1&dtb"1 (x,'pathSTORED') getFnme y NB.2-item boxed list 0{ file to extract. 1{ pathname of zip
  kfnme=. 'ijf',~_3}. 1{:: fnme
  ns=. (x-:'animsumry'){:: (<x);< 'animsumryhdr';'animsumrycnt'
  if. -.fexist kfnme do. keycreate kfnme end.
  if. _4-: res=. keyread kfnme;<ns do.  NB. read from zip and create key
    select. x
      case. 'ansumrycsv' do.
        res=. zread fnme return. NB. no value in writing to ijf
      case. 'animsumry';'animsumryhdr';'animsumrycnt' do.
        dat=. split fixcsv toJ zread fnme
        dat=. (ifa each 1{dat) 1}dat
        res=. ((tmp=.'animsumryhdr';'animsumrycnt')i. ns){dat
        ns=. tmp
      case. 'animini' do.
        res=. dat=. <(toJ zread fnme) getIniAllSections ''
      case. 'caseprogress' do.
        ini=. 'animini' getCIInfoStored y
        dat=. ini getIniValue 1&transName 'curryear'
        res=. dat=. <dat; ini getIniValue 'ncycles'
      case. 'trtinfoall' do.
        tmp=.  (getpath_j_ 1{::fnme),'tmp.xls' NB. temporary file name
        tmp fwrite~ zread fnme NB. read file from zip, write to temp
        res=. dat=. <'tDefn' readexcel tmp
        ferase tmp NB. delete temp file
    end.
    s=. dat keywrite kfnme;<ns
  end.
  >^:(#=1:) res NB. unbox if length=1
)

NB. getCIInfoCurr v gets Scenario info from caseinstance folder
NB. y is numeric caseinstance id
NB. x is literal list specifying info to get
getCIInfoCurr=: 4 : 0
  fnme=. (x,'path') getFnme y
  select. x
    case. 'animini' do.
      res=. getIniAllSections fnme
    case. nms=. 'animsumry';'animsumryhdr';'animsumrycnt' do.
      dat=. split fixcsv freads fnme
      dat=. (ifa each 1{dat) 1}dat
      idx=. (nms i. boxopen x){:: 0 1;0;1
      res=. >^:(#=1:) idx{dat
    case. 'ansumrycsv' do.
      res=. freads fnme
    case. 'caseprogress' do. NB. returns currcycle;ncycles from animalsim.ini
      ini=. getIniAllSections fnme
      crcyc=. ini getIniValue 1&transName 'curryear'
      ncyc=.  ini getIniValue 'ncycles'
      res=. crcyc;ncyc
    case. nms=. 'selnlistfem';'selnlistmale' do.
      fnme=. (nms i. boxopen x){ 'selnlistpath' getFnme y
      res=. freads fnme
    case. 'trtinfoall' do.  NB. reads tDefn sheet from TrtInfo.xls
      res=. 'tDefn' readexcel fnme
  end.
  res
)

updateScenarioInfo=: 3 : 0
  'animini' updateScenarioInfo y
  :
  infotyp=. boxopen x
  select. infotyp
    case. <'animini' do.
      fnme=. <'animinipath' getFnme y
      res=. writePPString"1 fnme,. 2}."1 ANIMINI
  end.
)

pathdelim=: 4 : '}.;([:x&,,)each y'  NB.!Use join instead??

NB.*getFnme v get filename of specified filetype for user,offering,case
NB. result is string of filename, or numeric _1 if file doesn't exist
NB. y is ciid
NB. x is string describing file to get
getFnme=: 4 : 0
  basefldr=. IFCONSOLE{:: 'd:/web/selectj/';'~.CGI/'
  NB. basefldr=. '~.CGI/' NB. 'd:\web\selectj\'
  select. x
    case. 'animinipath';'caseprogresspath' do.
      fdir=. 'caseinstpath' getFnme y
      fnme=. 'animinipath' getInfo y
      fnme=. fdir,fnme
    case. 'animinipathSTORED';'caseprogresspathSTORED' do.
      NB. 'animalsim.ini';'d:\web\...\ciid.zip'
      fnme=. 'animinipath' getInfo y
      zipnme=. 'sumryzippath' getFnme y
      fnme=. >fnme;zipnme
    case. 'ansumrycsvpath'; 'animsumry'&,each ('';'hdr';'cnt') ,each <'path' do.
      fkey=. 1 transName 'animsumrypath'
      fdir=. 'caseinstpath' getFnme y
      ini=. 'animini' getInfo y
      fnme=. ini getIniString fkey;'FileNames'
      if. 0=*#fnme do. fnme=. 'output/animsummary.csv' end.
      fnme=. extcsv fnme
      fnme=.fdir,fnme
    case. 'ansumrycsvpathSTORED';'animsumry'&,each ('';'hdr';'cnt') , each <'pathSTORED' do. 
      NB. 'output/animsummary.csv',:'d:\web\...\ciid.zip'
      fkey=. 1 transName 'animsumrypath'
      ini=. 'animini' getInfo y
      fnme=. ini getIniString fkey;'FileNames'
      if. 0=*#fnme do. fnme=. 'output/animsummary.csv' end.
      fnme=. extcsv '\/' charsub fnme NB. force to '/' for zread
      zipnme=. jpath 'sumryzippath' getFnme y
      fnme=. >fnme;zipnme
      return. NB. don't jpath fnme. zread must have '/'
    case. 'caseinstpath' do.
      NB. userpop/uname/coursecode_year_sem_dm/scendefcode/caseinstanceid/
      pathinfo=. 'caseinstpath' getInfo y
      'hdr dat'=. split pathinfo
      (hdr)=. |:dat
      of_code=. '_' pathdelim cr_code;of_year;sm_code;dm_code
      fnme=. '/' pathdelim ur_uname;of_code;sd_code;ci_id
      fnme=. basefldr,'userpop/',fnme,'/'
    case. 'scendefpath' do.
      NB. scendefs/scendefcode.zip
      cde=. 'scendefpath' getInfo y
      fnme=. basefldr,'scendefs/',cde,'.zip'
    case. keys=. ;:'selnlistpath pedigreepath mateallocpath' do.
      fkey=. 1 transName x
      fdir=. 'caseinstpath' getFnme y
      ini=. 'animini' getInfo y
      fnme=. ini getIniString fkey;'FileNames'
      if. 0=*#fnme do. NB. use default names
        fnme=. (keys i.<x){:: ('output/selectlstfem.csv';'output/selectlstmale.csv'); cut'output/pedigree.csv matealloc.csv'
      elseif. x-:'selnlistpath' do.
        fnme=. fnme&,each ;:'fem male'
      end.
      fnme=. extcsv each boxopen fnme
      fnme=.fdir&, @> fnme
    case. 'sumryfiles' do. NB. fnames of files to store in zip
      fnme=. >(;:'animinipath animsumrypath trtinfopath') getFnme each y
    case. 'sumryzippath' do.
      NB. userpop/uname/coursecode_year_sem_dm/summaries/ciid.zip
      fdir=. 'sumryfolderpath' getFnme y
      fnme=. ":y
      fnme=. fdir,fnme,'.zip'
    case. 'sumryfolderpath' do.
      NB. userpop/uname/coursecode_year_sem_dm/summaries/
      pathinfo=. 'caseinstpath' getInfo y
      'hdr dat'=. split pathinfo
      (hdr)=. |:dat
      of_code=. '_' pathdelim cr_code;of_year;sm_code;dm_code
      fnme=. '/' pathdelim ur_uname;of_code;'summaries'
      fnme=. basefldr,'userpop/',fnme,'/'
    case. 'trtinfopath';'trtinfoallpath' do.
      fkey=. 1 transName 'trtinfopath'
      fdir=. 'caseinstpath' getFnme y
      ini=. 'animini' getInfo y
      fnme=. ini getIniString fkey;'QuantTrts'
      if. *#fnme do. fnme=. 'TrtInfo.xls' end.
      fnme=. (, #&'.xls'@(0: = '.'"_ e. (# | i:&PATHSEP_j_) }. ])) fnme
      fnme=. fdir,fnme
    case. 'trtinfo'&,each ('';'all') , each <'pathSTORED' do.
      fkey=. 1 transName 'trtinfopath'
      ini=. 'animini' getInfo y
      fnme=. ini getIniString fkey;'FileNames'
      if. 0=*#fnme do. fnme=. 'TrtInfo.xls' end.
      fnme=. (, #&'.xls'@(0: = '.'"_ e. (# | i:&PATHSEP_j_) }. ])) fnme
      fnme=. '\/' charsub fnme NB. force to '/' for zread
      zipnme=. jpath 'sumryzippath' getFnme y
      fnme=. >fnme;zipnme
      return. NB. don't jpath fnme. zread must have '/'
    case. 'userfolderpath' do. NB. y is ur_id
      uns=.'username' getInfo y
      fnme=. (basefldr,'userpop/'),"1 uns
    case. do.
      '' return.
  end.
  fnme=. jpath"1 fnme
)