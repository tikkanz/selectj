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
QRYci=: ;:'animinipath caseinstpath casedetails caseinststatus casestage paramform scendefpath'
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
  DBtable   =:          ;:'casedetails paramform'
  DBtable   =: DBtable, ;:'userlist userrec usergreeting usercourses expiredguests validcase enrolled'
  DBtable   =: DBtable, ;:'coursecases coursedetails coursename coursesumrys'
DBtable   =: DBtable, ;:'sessioninfo'
DBtablestr=: ;:'caseinstpath'
DBrow     =: ;:'casestage userlogin caseinststatus'
DBcol     =: ;:'caseinst2expire username'
DBitem    =: ;:'animinipath scendefpath caseinstanceid userstatus idfromemail'

NB. =========================================================
NB. Valid query names where info not sourced from database (probably file)

FLQRY=: ;:'animini alltrtinfo caseprogress'
FLQRY=: FLQRY, ;:'animsumry animsumryhdr animsumrycnt'
FLQRY=: FLQRY, ;:'summaryINI summaryCSV'

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
      case. (0;1);<(1;1) do.  NB. valid not stored
        x getScenarioInfo y  NB.getCIInfoCurr
      case. <1;0 do.  NB. stored
        x readStoredCaseInst y  NB.getCIInfoStored 
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


NB. readStoredCaseInst v reads files from a CaseInstance stored in a zip file
NB. result depends on file requested.
NB.     if .csv then 2-item boxed list. 1{boxed list of header names. 2{csv contents as inverted table
NB.     if .ini then boxed list of parsed ini file
NB. y is ciid of case instance to read
NB. x is datatype to read
readStoredCaseInst=: 4 : 0
  fnme=. <"1&dtb"1 x getFnme y NB.2-item boxed list 0{ file to extract. 1{ pathname of zip
  kfnme=. 'ijf',~_3}. 1{:: fnme
  ftyp=. _3{. 0{:: fnme
  ns=. (<'csvhdr');(;:'csvhdr csvcnt');<<'ini'
  ns=. ((;:'hdr csv ini') i. <ftyp){:: ns NB. required nouns for ftyp
  if. -.fexist kfnme do. keycreate kfnme end.
  if. _4-: res=. keyread kfnme;<ns do.
  NB. read from zip and create key
    select. ftyp
      case. 'hdr';'csv' do.
        res=. split fixcsv toJ zread fnme
        res=. (ifa each 1{res) 1}res
      case. 'ini' do.
        res=. <(toJ zread fnme) getIniAllSections ''
    end.
    s=. res keywrite kfnme;<ns
    if. ftyp-:'hdr' do. res=. 0{res end.
  end.
  res
)

NB. getScenarioInfo v gets Scenario info from caseinstance folder
NB. y is numeric caseinstance id
NB. x is optional strings specifying info to get
NB.   [default is 'animini']
NB. other options will let us read
getScenarioInfo=: 4 : 0
  infotyp=. boxopen x
  select. infotyp
    case. <'animini' do.
      fnme=. 'animinipath' getFnme y
      res=. getIniAllSections fnme
    case. <'alltrtinfo' do.  NB. reads tDefn sheet from TrtInfo.xls
      xlfnme=. 'trtinfo' getFnme y
      'tDefn' readexcel xlfnme
    case. <'caseprogress' do. NB. returns currcycle;ncycles from animalsim.ini
      fnme=. 'animinipath' getFnme y
      ini=. getIniAllSections fnme
      crcyc=. ini getIniValue 1&transName 'curryear'
      ncyc=.  ini getIniValue 'ncycles'
      crcyc;ncyc
  end.
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