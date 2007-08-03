NB. built from project: ~Projects/selectj/selectj

IFJIJX_j_=: 1
script_z_ '~system\main\convert.ijs'
script_z_ '~system\main\dir.ijs'
script_z_ '~system\main\dll.ijs'
script_z_ '~system\main\files.ijs'
script_z_ '~system\packages\stats\random.ijs'
script_z_ '~system\main\strings.ijs'
script_z_ '~system\packages\misc\task.ijs'

coclass 'pselect'

require 'files'
coclass 'z'

fext=:'.'&(>:@i:~}.]) 
isJHP=: (;:'jhp asp') e.~ [:<fext

transfer=: 3 : 0
  fnme=.y
  
  if. isJHP fnme do.
    ContentType'text/html'[ Expires 0 
    markup fnme
  else.
    ContentType'text/html'[ Expires 0  
    stdout fread jpath fnme
  end.
)

redirect=: 3 : 0
  uri=.y
  
  println 'Location: ',uri
  ContentType'text/html'
)

refresh=: 3 : 0
  uri=.y
  
  println 'Refresh: 0; url=',uri
  ContentType'text/html'
)

boxitem=: ,`(<"_1) @. (0=L.)

setcolnames=: 3 : 0
  if. y-:i.0 0 do. return. end.
  'hdr dat'=. split y
  (hdr)=: |:dat
  ''
)
coercetxt=: 3 : 0
  isboxed=.0<L. y
  y=. boxopen y
  msk=. -.isnum @> y
  newnums=. 0&coerce each msk#y
  y=.[newnums (I.msk)}y 
  if. -.isboxed do. >y end. 
)
listatom=: 1&#
createSalt=: ([: _2&(3!:4) a. {~ [: ? 256 $~ ])&4
randpwd=: 3 : 0
'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789' randpwd y
:
if. -.4=3!:0 y do. len=.8 else. len=.y end.
len (]{~ [:?[$ [:#]) x
)
isdefseed=: 3 : '+./({.2{::9!:44'''')=16807 1215910514'
salthash=: 3 : 0
  '' salthash y 
  :
  if. 0<#x do. s=.x
    if. 2=3!:0 s do. s=.".s end. 
  else. 
    if. isdefseed'' do. randomize'' end.
    s=. createSalt '' 
  end.
  h=. md5 y,2&ic s
  s;h  
)
createSession=: 3 : 0
 if. isdefseed'' do. randomize'' end.
 sid=. >:?<:-:2^32 
 sh=. salthash ":sid 
 'session' insertDBTable_pselectdb_  sid;y;sh
 tk=. writeTicket sid;{:sh
)
expireSession=: 3 : 0
  if.0=#y do. y=. qcookie 'SessionTicket' end.
  sid=.0{:: readTicket y
  'sessionexpire' updateDBTable_pselectdb_ ".sid
)

GUESTID=:5
isActive=: 3 : 0
  s=. {:'status' getTable_pselectdb_ y
)
readTicket=: 3 : 0
  kVTable=. qsparse y  
  sid=.'ssid' keyval kVTable
  shash=. 'hash' keyval kVTable
  sid;shash
)

registerUser=: 3 : 0
  'uname fname lname refnum email passwd'=.y
  
  
  uinfo =. {:'login' getTable_pselectdb_ uname  
  if. -.uinfo-:'' do. _2 return. end. 
  pinfo =. {:'email' getTable_pselectdb_  email
  if. -.pinfo-:''  do. 
    pid=. 0{::pinfo    
  else.
    pid=. 'newperson' insertDBTable_pselectdb_ fname;lname;email 
  end.
  sph=. salthash passwd 
  uid=.'newuser' insertDBTable_pselectdb_ pid;uname;refnum;|.sph 
  
)
updateSession=: 3 : 0
  if.0=#y do. y=. qcookie 'SessionTicket' end.
  sid=.0{:: readTicket y
  'session' updateDBTable_pselectdb_ ".sid
)
validCase=: 3 : 0
  if. 0-: uofid=.validEnrolment'' do. 0 return. end.
  uofid validCase y
:
  if. 0=#y do. y=.0 qcookie 'CaseID' end.
  vldcs=.'validcase' getTable_pselectdb_ x,<y
  if. #vldcs do. x,<y else. 0 end.
)
validEnrolment=: 3 : 0
  if. 0-: uid=.validSession'' do. 0 return. end.
  uid validEnrolment y
:
  if. 0=#y do. y=. 0 qcookie 'OfferingID' end.
  enrld=.'enrolled' getTable_pselectdb_ x;y
  if. #enrld do. x;y else. 0 end.
)
validLogin=: 3 : 0
 'usrnme passwd'=. y
  if. usrnme -: '' do. _1 return. end. 
  uinfo =. {:'login' getTable_pselectdb_ usrnme  
  if. ''-: uinfo   do. _2 return. end.   
  'duid dunme dhash dsalt' =. 4{.uinfo
  if. -. dhash-: _1{::dsalt salthash passwd do. _3 return. end. 
  duid
)
validSession=: 3 : 0
  if. 0=#y do. y=. qcookie 'SessionTicket' end.
  'sid shash'=. readTicket y
  sinfo=.'session' getTable_pselectdb_ ".sid
  if. 0=#sinfo do. 0 return. end. 
  'hdr dat'=. split sinfo         
  (hdr)=. |:dat                   
  
  if. -. shash -: 1{::ss_salt salthash sid do. 0 return. end.
  if. timeleft<0 do. 
    'sessionexpire' updateDBTable_pselectdb_ ".sid
    0
  else.
    'session' updateDBTable_pselectdb_ ".sid
    ss_urid
  end.
)
writeTicket=: 3 : 0
  'tsid thash'=.y
  ('ssid=',":tsid),'&hash=',thash
)

resetUsers=: 3 : 0
  if. *#y do.
    'resetusers' updateDBTable_pselectdb_ y
    
    ''
  end.
)
setUsers=: 3 : 0
  if. *#y do.
    'setusers' updateDBTable_pselectdb_ y
    
    ''
  end.
)
deleteUsers=: 3 : 0
  if. *#y do.
    'deleteusers' updateDBTable_pselectdb_ y
    
    ''
  end.
)

pathdelim=: 4 : '}.;([:x&,,)each y'

deleteDirTree=: 3 : 0
  try.
    res=. 1!:55 {."1 dirtree y
    res=. res,1!:55 |.dirpath y
  catch.
    
    
    
    13!:11 ''
  end.
)

getFnme=: 4 : 0
  sep=. PATHSEP_j_
  basefldr=. jpath '~.CGI/' 
  select. x
    case. 'caseinstfolder' do.
    
      pathinfo=. 'caseinstfolder' getTableStr_pselectdb_ y
      'hdr dat'=. split pathinfo
      (hdr)=. |:dat
      of_code=. '_' pathdelim cr_code;of_year;sm_code;dm_code
      fnme=. sep pathdelim ur_uname;of_code;sd_code;ci_id
      fnme=. 'userpop',sep,fnme,sep
    case. 'scendef' do.
    
      pathinfo=. 'scendef' getTableStr_pselectdb_ y
      'hdr dat'=. split pathinfo
      (hdr)=. |:dat
      fnme=. 'scendefs',sep,(,sd_code),'.zip'
    case. do.
  end.
  fnme=. basefldr,fnme
)

Note 'list filenames in tree'
,. ,>"1 (,/"0) 1 dir each (dirpath jpath 'd:/web/selectj/scendefs/popsz')#~ a:=(<'.svn') ss each dirpath jpath 'd:/web/selectj/scendefs/popsz'
)
createCaseInstance=: 3 : 0
  'uid ofid csid'=. y
  ciid=. 'caseinstance' insertDBTable_pselectdb_ uid;ofid;csid
  uz=. createCaseInstFolder csid;ciid
  ciid
)
createCaseInstFolder=: 3 : 0
  'csid ciid'=.y
  zippath=. 'scendef' getFnme csid
  newpath=. 'caseinstfolder' getFnme ciid
  uz=. unzip zippath;newpath  
)
getCaseInstance=: 3 : 0
  if. 0=#y do.
    if. 0-: uofcsid=. validCase'' do. 0 return. end.
  else.
    uofcsid=. y
  end.
  ciid=. >@{:'caseinstance' getTable_pselectdb_ uofcsid
  if. #ciid do.
    ciid
  else. 
    ciid=. createCaseInstance uofcsid
  end.
)
expireCaseInstance=: 3 : 0
  'expirecaseinst' updateDBTable_pselectdb_ y
  deleteCaseInstFolder y
)
deleteCaseInstFolder=: 3 : 0
  delpath=. 'caseinstfolder' getFnme y
  res=.deleteDirTree delpath
  if. 1=*./res do. 1 else. 0 end.
)
getAllTrtNames=: 3 : 0
  'uid ofid'=. qcookie"0 ;:'UserId CaseID'
  (uid;ofid) getAllTrtNames y
:
  if. 0=#y do. y=. 0 qcookie 'CaseID' end.
  xlfnme=. 'TrtInfo' getFnme x,<y
  1{."1 'tDefn' readexcel xlfnme
)
getScenarioInfo=: 3 : 0
  'default' getScenarioInfo y
  :
  keys=. boxopen x
  uid=. ":y 
  inifile=. '~.CGI/flocks/',uid,'/animalsim.ini'
  
)
require 'data/sqlite'

coclass 'pselectdb'
ConStr=:  'd:/web/selectj/code/select_cmplx.sqlite'
lasterr=: [: deb LF -.~ }.@(13!:12)
usrdberr_z_=: (assert 0=#) f.

sBegin=: 0 : 0
  r=. 0 0$''
  msg=. ''
  try.
    db=. ConStr conew 'psqlite'
)
sEnd=: 0 : 0
  catch. msg=. lasterr'' end.
  if. 0=nc<'db' do. destroy__db '' end.
  usrdberr msg
  r
)
sdefine=: 1 : 'm : (sBegin , (0 : 0) , sEnd)'
getTable=: dyad sdefine
  r=.(boxopen y) query__db ".'sqlsel_',x
)
getTableStr=: dyad sdefine
  r=.(boxopen y) strquery__db ".'sqlsel_',x
)

insertDBTable=: dyad sdefine
  sql=. ". 'sqlins_',x
  r=. (boxopen y) apply__db sql
)

updateDBTable=: dyad sdefine
  r=. (boxopen y) apply__db ". 'sqlupd_',x
)

coclass 'pselectdb'
sqlsel_login=: 0 : 0
  SELECT users.ur_id ur_id, 
         users.ur_uname ur_uname,
         users.ur_passhash ur_passhash,
         users.ur_salt ur_salt
  FROM users
  WHERE users.ur_uname=?;
)

sqlsel_status=: 0 : 0
  SELECT users.ur_status ur_status
  FROM users
  WHERE users.ur_id=?;
)

sqlsel_email=: 0 : 0
  SELECT pp.pp_id pp_id ,
         pp.pp_fname pp_fname ,
         pp.pp_lname pp_lname
  FROM `people` pp
  WHERE pp.pp_email=?;
)

sqlins_newperson=: 0 : 0
  INSERT INTO people (pp_fname,pp_lname,pp_email)
  VALUES(?,?,?);
)

sqlins_newuser=: 0 : 0
  INSERT INTO users (ur_ppid,ur_uname,ur_refnum,ur_passhash,ur_salt)
  VALUES(?,?,?,?,?);
)

sqlins_session=: 0 : 0
  INSERT INTO sessions (ss_id,ss_urid,ss_salt,ss_hash,ss_expire)
  VALUES(?,?,?,?,julianday('now','20 minutes'));
)

sqlsel_session=: 0 : 0
  SELECT ss.ss_urid ss_urid ,
         ss.ss_salt ss_salt ,
         (ss.ss_expire-julianday('now')) timeleft 
  FROM  `sessions`  ss 
  WHERE (ss.ss_id =?) AND (ss.ss_status >0);
)

sqlupd_session=: 0 : 0
  UPDATE sessions
  SET ss_expire=julianday('now','20 minutes')
  WHERE ss_id=?
)
sqlupd_sessionexpire=: 0 : 0
  UPDATE sessions
  SET ss_status=0
  WHERE ss_id=?
)

sqlsel_enrolled=: 0 : 0
  SELECT en.en_urid en_urid ,
         en.en_ofid en_ofid 
  FROM   `enrolments` en
  WHERE (en.en_urid =?) AND (en.en_ofid =?);
)

sqlsel_validcase=: 0 : 0
  SELECT en.en_urid ur_id ,
         en.en_ofid of_id ,
         oc.oc_csid cs_id 
  FROM  `enrolments` en INNER JOIN `offeringcases` oc ON ( `en`.`en_ofid` = `oc`.`oc_ofid` ) 
  WHERE (en.en_urid =?) AND (en.en_ofid =?) AND (oc.oc_csid =?);
)

sqlins_caseinstance=: 0 : 0
  INSERT INTO caseinstances (ci_urid,ci_ofid,ci_csid)
  VALUES(?,?,?);
)

sqlsel_caseinstance=: 0 : 0
  SELECT ci.ci_id ci_id 
  FROM  `caseinstances`  ci 
  WHERE (ci.ci_urid =?) AND (ci.ci_ofid =?) AND (ci.ci_csid =?) AND (ci.ci_status >0);
)

sqlsel_caseinstfolder=: 0 : 0
  SELECT ur.ur_uname ur_uname ,
         off_info.cr_code cr_code ,
         off_info.of_year of_year ,
      	 off_info.sm_code sm_code ,
         off_info.dm_code dm_code ,
         sd.sd_code sd_code ,
         ci.ci_id ci_id 
  FROM  `users` ur INNER JOIN `caseinstances` ci ON ( `ur`.`ur_id` = `ci`.`ci_urid` ) 
        INNER JOIN `cases` cases ON ( `cases`.`cs_id` = `ci`.`ci_csid` ) 
        INNER JOIN `offering_info` off_info ON ( `off_info`.`of_id` = `ci`.`ci_ofid` ) 
        INNER JOIN `scendefs` sd ON ( `sd`.`sd_id` = `cases`.`cs_sdid` ) 
  WHERE (ci.ci_id =?);
)

sqlsel_scendef=: 0 : 0
  SELECT sd.sd_code sd_code 
  FROM  `scendefs` sd INNER JOIN `cases` cs ON ( `sd`.`sd_id` = `cs`.`cs_sdid` ) 
  WHERE (cs.cs_id =?);
)

sqlupd_expirecaseinst=: 0 : 0
  UPDATE caseinstances
  SET ci_status=0
  WHERE ci_id=?;
)
sqlsel_userlist=: 0 : 0
  SELECT ur.ur_id ur_id ,
         ur.ur_status ur_status ,
         pp.pp_fname pp_fname ,
         pp.pp_lname pp_lname
  FROM `users` ur INNER JOIN `people` pp ON ur.ur_ppid=pp.pp_id;
)


sqlsel_userrec=: 0 : 0
  SELECT ur.ur_id ur_id ,
         pp.pp_fname pp_fname ,
         pp.pp_lname pp_lname ,
         ur.ur_uname ur_uname ,
         ur.ur_refnum ur_refnum ,
         pp.pp_email pp_email ,
         ur.ur_status ur_status ,
         ur.ur_salt ur_salt ,
         ur.ur_passhash ur_passhash
  FROM `users` ur INNER JOIN `people` pp ON ur.ur_ppid=pp.pp_id
  WHERE ur.ur_id=?;
)

sqlupd_resetusers=: 0 : 0
  UPDATE users
  SET ur_status=0
  WHERE ur_id=?
)

sqlupd_setusers=: 0 : 0
  UPDATE users
  SET ur_status=1
  WHERE ur_id=?
)

sqlupd_deleteusers=: 0 : 0
  DELETE FROM users
  WHERE ur_id=?
)

coclass 'pselectdb'
sqlsel_greeting=: 0 : 0
  SELECT pp.pp_fname pp_fname,
         pp.pp_lname pp_lname
  FROM `users` ur INNER JOIN `people` pp ON ur.ur_ppid=pp.pp_id
  WHERE ur.ur_id=?;
)

sqlsel_mycourses=: 0 : 0
  SELECT off_info.of_id of_id ,
         off_info.cr_name cr_name ,
         off_info.cr_code cr_code ,
         off_info.of_year of_year ,
         off_info.sm_code sm_code ,
         off_info.dm_code dm_code ,
         off_info.pp_adminfname pp_adminfname ,
         off_info.pp_adminlname pp_adminlname ,
         rl.rl_name rl_name 
  FROM  `offering_info` off_info INNER JOIN `enrolments` en ON ( `off_info`.`of_id` = `en`.`en_ofid` ) 
        INNER JOIN `roles` rl ON ( `en`.`en_rlid` = `rl`.`rl_id` ) 
  WHERE (en.en_urid =?) AND (off_info.of_status >0)
  ORDER BY off_info.cr_code  Asc, off_info.of_year  Asc;
)

sqlsel_course=: 0 : 0
  SELECT off_info.of_id of_id ,
        off_info.cr_name cr_name ,
        off_info.cr_code cr_code ,
        off_info.of_year of_year ,
        off_info.sm_code sm_code ,
        off_info.dm_code dm_code ,
        off_info.pp_adminfname pp_adminfname ,
        off_info.pp_adminlname pp_adminlname ,
        ox.ox_intro ox_intro 
  FROM `offering_info` off_info INNER JOIN `offeringstext` ox 
        ON ( `off_info`.`of_id` = `ox`.`ox_id` ) 
  WHERE (off_info.of_id =?);
)

sqlsel_coursename=: 0 : 0
  SELECT off_info.cr_name cr_name ,
         off_info.cr_code cr_code 
  FROM `offering_info` off_info
  WHERE (off_info.of_id =?);
)

sqlsel_coursecases=: 0 : 0
  SELECT sd.sd_name sd_name ,
        sd.sd_descr sd_descr ,
        sd.sd_id sd_id ,
        sd.sd_code sd_code ,
        oc.oc_csid cs_id 
  FROM  `scendefs` sd INNER JOIN `cases` cs ON ( `sd`.`sd_id` = `cs`.`cs_sdid` ) 
        INNER JOIN `offeringcases` oc ON ( `cs`.`cs_id` = `oc`.`oc_csid` ) 
  WHERE (oc.oc_ofid =?);
)

sqlsel_casestage=: 0 : 0
  SELECT ci.ci_stage ci_stage ,
         ci.ci_sumry ci_sumry
  FROM  `caseinstances`  ci 
  WHERE (ci.ci_id =?);
)

sqlsel_case=: 0 : 0
  SELECT sd.sd_name sd_name ,
         sd.sd_code sd_code ,
         sd.sd_descr sd_descr ,
         xn.xn_name xn_name ,
         cx.cx_text cx_text 
FROM  `scendefs` sd INNER JOIN `cases` cs ON ( `sd`.`sd_id` = `cs`.`cs_sdid` ) 
      INNER JOIN `casestext` cx ON ( `cs`.`cs_id` = `cx`.`cx_csid` ) 
      INNER JOIN `textblocks` xn ON ( `xn`.`xn_id` = `cx`.`cx_xnid` ) 
WHERE (cs.cs_id =?) AND (xn.xn_id =?);
)

coclass 'punzip'

3 : 0 ''
if. -.IFUNIX do. require 'task' end.
if. IFCONSOLE do.
  UNZIP=: '"c:\program files\7-zip\7z.exe" x -y'
else.
  UNZIP=: UNZIP_j_
end.
)


dquote=: '"'&, @ (,&'"')
hostcmd=: [: 2!:0 '(' , ] , ' || true)'"_
exequote=: 3 : 0
  f=. deb y
  if. '"' = {. f do. f return. end.
  ndx=. 4 + 1 i.~ '.exe' E. f
  if. ndx >: #f do. f return. end.
  '"',(ndx{.f),'"',ndx }. f
)
shellcmd=: 3 : 0
  if. IFUNIX do.
    hostcmd y
  else.
    spawn y
  end.
)
unzip=: 3 : 0
  'file dir'=.y
  e=. 'Unexpected error'
  if. IFUNIX do.
    e=. shellcmd 'tar -xzf ',(dquote file),' -C ',dquote dir
  else.
    z=. exequote UNZIP
    if. +./'7z' E. UNZIP do. 
      dirsw=.' -o'
    else.  
      dirsw=.' -d'
    end.
    r=. z,' ',(dquote file),dirsw,dquote dir
    e=. shellcmd r
    
  end.
  e
)

unzip_z_=: unzip_punzip_

require 'files'
require '~addons/data/sqlite/def.ijs'

coclass 'psqlite'

MAXROWS=: 1000
COMMITROWS=: 1000

trc=: [ smoutput  

chrr=: _1&$: : ([: memr ] , 0 , [)
intr=: 1&$: : ([: memr ] , 0 , JINT ,~ [)
create=: 3 : 0
  limit''
  ignore''   
  blobsize'' 
  r=. sqlite_open y;c1=. ,_1
  con=: {.c1
  check r
)

destroy=: 3 : 0
  check sqlite_close con
  codestroy''
)
strtbl=: 3 : 0
  'rp rn cn ep'=. (,_1);(,_1);(,_1);(,_1)
  if. sqlite_get_table con;y;rp;rn;cn;ep do.
    es=. chrr {.ep
    sqlite_free {.ep
    sqlite_free_table {.rp
    sqlerr es
    return.
  end.
  tbl=. ((1+rn),cn)$ chrr@intr &.> ({.rp)+4*i.(1+rn)*cn
  sqlite_free_table {.rp
  tbl
)
exec=: 3 : 0
  if. rc=. sqlite_exec con;y;0;0;ep=. ,_1 do.
    es=. chrr {.ep
    sqlite_free {.ep
    sqlerr es
    return.
  end.
  affected''
)

affected=: 3 : '(sqlite_changes , sqlite_total_changes) con'
extran=: 3 : 0
  trans=. 1
  try. exec 'begin transaction;'
  catch. trans=. 0 end.
  try.
    r=. exec y
  catch.
    smoutput 13!:12''
    if. trans do. exec 'rollback;' end.
    sqlerr 'exec failed'
  end.
  if. trans do. exec 'commit;' end.
  r
)
apply=: 4 : 0
  trans=. 1
  try. exec 'begin;'
  catch. trans=. 0 end.
  'sql pt'=. 2{.(boxopen y),<0
  trans prepare sql
  nrows=. #x=. trans normalize x
  tbl=. ''
  for_r. i.1>.nrows do.
    if. nrows do. pt bind r { x end.
    select. rc=. step''
    case. SQLITE_DONE do.
      tbl=. tbl,sqlite_last_insert_rowid con
    case. SQLITE_ERROR do.
      err=. -sqlite_reset st
      if. (0~:ignerr)+.err=0 do.
        tbl=. tbl,err
      else.
        msg=. errmsg''
        finalize''
        exec 'rollback;'
        sqlerr msg
      end.
    case. do.
      tbl=. tbl,SQLITE_E_RESULT
      if. 0=ignerr do. break. end.
    end.
    if. trans*.(r>0)*.0=COMMITROWS|r do.
      trc 'autocommit ', ":r
      exec 'commit;'
      exec 'begin;'
    end.
    sqlite_reset st
  end.
  finalize''
  if. trans do. exec 'commit;' end.
  ignore''
  tbl
)
limit=: 3 : 0  
  maxrows=: {:MAXROWS,y
  skip=: _2{0 0,y
)

ignore=: 3 : 0
  ignerr=: {.y,0
)

blobsize=: 3 : 0
  BLOBSIZE=: {.y,0
)

queryloop=: 1 : 0
  :
  prepare y
  nrows=. #x=. normalize x
  i=. 0
  for_r. i.1>.nrows do.
    if. nrows do. bind r { x end.
    done=. 0
    while. -.done do.
      rc=. step''
      select. rc
      case. SQLITE_ERROR do.
        finalize''
        check rc
        break.
      case. SQLITE_ROW do.
        done=. u i=. i + 1
      case. SQLITE_DONE do.
        done=. 1
      case. do.
        break.
      end.
    end.
    sqlite_reset st
  end.
  finalize''
  limit''
)

query_aux=: 3 : 0
  if. y<:skip do. 0 return. end.
  if. 0=#tbl do. tbl=: tbl,head'' end.
  maxrows < #tbl=: tbl,vrow''
)
query=: ''&$: : (4 : 0)
  tbl=: empty''
  x query_aux queryloop y
  tbl
)

strquery_aux=: 3 : 0
  if. y<:skip do. 0 return. end.
  if. 0=#tbl do. tbl=: tbl,head'' end.
  maxrows < #tbl=: tbl,srow''
)
strquery=: ''&$: : (4 : 0)
  tbl=: empty''
  x strquery_aux queryloop y
  tbl
)
colquery=: ''&$: : (4 : 0)
  if. 0=# r=. x strquery y do. r return. end.
  ({. ,: <@:>"1@|:@}.) r
)

prepare=: 0&$: : (4 : 0)
  'st tail'=: (,_1);(,_1)
  r=. sqlite_prepare con;y;(#y);st;tail
  tail=: {.tail
  st=: {.st
  if. r do.
    msg=. errmsg''
    if. x do. exec 'rollback;' end.
    sqlerr msg
  end.
)

finalize=: 3 : 'check sqlite_finalize st'

step=: 3 : '>{. sqlite_step st'

normalize=: 0&$: : (4 : 0)
  sharg=. $y
  try.
    select. npar=. sqlite3_bind_parameter_count st
    case. 0 do.
    case. 1 do.
      assert -.0 e. sharg
      ,y return.
    case. do.
      assert -.0 e. sharg
      assert 2 >: #sharg
      select. #sharg
      case. 0 do.
        (1,npar) $ y return.
      case. 1 do.
        assert npar = {.sharg
        (1,npar) $ y return.
      case. 2 do.
        assert npar = {:sharg
        y return.
      end.
    end.
  catch.
    smoutput 13!:12''
    finalize ''
    if. x do. exec 'rollback;' end.
    sqlerr 'argument error'
  end.
  ''
)

JB01INT=: JB01;JINT
bind=: 0&$: : (4 : 0)
  x=. x $~ #y
  for_c. 1+i.#y do.
    v=. >(c-1){y
    select. 3!:0 v
    case. JCHAR do.
      v=. ,v
      if. 0<#v do.
        f=. sqlite_bind_text`sqlite_bind_blob@.(*(c-1){x)
        rc=. f st;c;v;(#v);SQLITE_TRANSIENT
      else.
        rc=. sqlite_bind_null st;c
      end.
    case. JB01INT do.
      rc=. sqlite_bind_int st;c;{.v
    case. JFL do.
      rc=. sqlite_bind_double st;c;{.v
    case. do.  
      v=. ''
    end.
    check rc
  end.
)

srow=: 3 : 0
  row=. ''
  cn=. sqlite_column_count st
  for_c. i.cn do.
    len=. sqlite_column_bytes st;c
    row=. row,<len chrr sqlite_column_text st;c
  end.
  row
)

vrow=: 3 : 0
  row=. ''
  cn=. sqlite_column_count st
  for_c. i.cn do.
    select. sqlite_column_type st;c
    case. SQLITE_INTEGER do.
      v=. sqlite_column_int st;c
    case. SQLITE_FLOAT do.
      v=. sqlite_column_double st;c
    case. SQLITE_TEXT do.
      len=. sqlite_column_bytes st;c
      v=. len chrr sqlite_column_text st;c
    case. SQLITE_BLOB do.
      len=. sqlite_column_bytes st;c
      if. BLOBSIZE do. v=. len else.
        v=. len chrr sqlite_column_blob st;c end.
    case. do.  
      v=. ''
    end.
    row=. row,<v
  end.
  row
)

head=: 3 : 0
  row=. ''
  cn=. >{.sqlite_column_count st
  for_c. i.cn do.
    row=. row,<chrr sqlite_column_name st;c
  end.
  row
)

sqlerr=: (13!:8)&101
errmsg=: 3 : 'chrr sqlite_errmsg con'
check=: sqlerr@errmsg^:(*@])

strjoin=: ":&.>@] ;@}:@,@,. boxopen@[
strquot=: ([:''''&, ,&'''')^:(2=3!:0)
bulkins=: 4 : 0
  x=. 'insert into ',x,' values('
  ; <@(x , ');',~ [:; ','strjoin ":@strquot&.>)"1 y
)

require 'dll strings'

coclass 'psqlite'

ADDONDIR=: jpath '~addons/data/sqlite/'
d=. (<jhostpath ADDONDIR,'lib/') ,&.> cut 'sqlite-3.3.17.so sqlite3.dll '
d=. ({.d),('/usr/lib/libsqlite3.dylib');{:d
LIBSQLITE=: '"','" ',~ (#.IFWIN32,'Darwin'-:UNAME){::d
cdsq=: 1 : '(deb LIBSQLITE,m)&cd'

sqlite_errmsg=:        'sqlite3_errmsg  >+ i  i' cdsq
sqlite_errcode=:       'sqlite3_errcode >+ i  i' cdsq
sqlite_open=:          'sqlite3_open    >+ i  *c *i' cdsq
sqlite_close=:         'sqlite3_close   >+ i  i' cdsq

sqlite_exec=:          'sqlite3_exec          >+ i  i *c  i i  *i' cdsq
sqlite_get_table=:     'sqlite3_get_table     >+ i  i *c *i  *i *i  *i' cdsq
sqlite_free_table=:    'sqlite3_free_table    >+ i  i' cdsq
sqlite_free=:          'sqlite3_free          >+ i  i' cdsq
sqlite_changes=:       'sqlite3_changes       >+ i  i' cdsq
sqlite_total_changes=: 'sqlite3_total_changes >+ i  i' cdsq

sqlite_prepare=:       'sqlite3_prepare  >+ i  i *c i *i *i' cdsq
sqlite_step=:          'sqlite3_step     >+ i  i' cdsq
sqlite_reset=:         'sqlite3_reset    >+ i  i' cdsq
sqlite_finalize=:      'sqlite3_finalize >+ i  i' cdsq

sqlite_column_count=:  'sqlite3_column_count  >+ i  i' cdsq
sqlite_column_type=:   'sqlite3_column_type   >+ i  i i' cdsq
sqlite_column_name=:   'sqlite3_column_name   >+ i  i i' cdsq
sqlite_column_bytes=:  'sqlite3_column_bytes  >+ i  i i' cdsq
sqlite_column_text=:   'sqlite3_column_text   >+ i  i i' cdsq
sqlite_column_blob=:   'sqlite3_column_blob   >+ i  i i' cdsq
sqlite_column_int=:    'sqlite3_column_int    >+ i  i i' cdsq
sqlite_column_double=: 'sqlite3_column_double >+ d  i i' cdsq

sqlite_last_insert_rowid=:     'sqlite3_last_insert_rowid    >+ i  i' cdsq
sqlite3_bind_parameter_count=: 'sqlite3_bind_parameter_count >+ i  i' cdsq

sqlite_bind_blob=:     'sqlite3_bind_blob   >+ i  i i *c i i' cdsq
sqlite_bind_int=:      'sqlite3_bind_int    >+ i  i i i' cdsq
sqlite_bind_double=:   'sqlite3_bind_double >+ i  i i d' cdsq
sqlite_bind_text=:     'sqlite3_bind_text   >+ i  i i *c i i' cdsq
sqlite_bind_null=:     'sqlite3_bind_null   >+ i  i i' cdsq


s=.  'SQLITE_OK SQLITE_ERROR SQLITE_INTERNAL SQLITE_PERM SQLITE_ABORT SQLITE_BUSY '
s=.s,'SQLITE_LOCKED SQLITE_NOMEM SQLITE_READONLY SQLITE_INTERRUPT SQLITE_IOERR '
s=.s,'SQLITE_CORRUPT SQLITE_NOTFOUND SQLITE_FULL SQLITE_CANTOPEN SQLITE_PROTOCOL '
s=.s,'SQLITE_EMPTY SQLITE_SCHEMA SQLITE_TOOBIG SQLITE_CONSTRAINT SQLITE_MISMATCH '
s=.s,'SQLITE_MISUSE SQLITE_NOLFS SQLITE_AUTH SQLITE_FORMAT SQLITE_RANGE SQLITE_NOTADB'
(s)=: i.#;:s
'SQLITE_ROW SQLITE_DONE'=: 100 101

s=. 'SQLITE_INTEGER SQLITE_FLOAT SQLITE_TEXT SQLITE_BLOB SQLITE_NULL'
(s)=: 1+i.#;:s

'SQLITE_STATIC SQLITE_TRANSIENT'=: 0 _1

SQLITE_E_RESULT=: _999  

require 'convert'
coclass 'pcrypt'
'`lt gt ge xor'=: (20 b.)`(18 b.)`(27 b.)`(22 b.)
'`and or rot sh'=: (17 b.)`(23 b.)`(32 b.)`(33 b.)
add=: (+&(_16&sh) (16&sh@(+ _16&sh) or and&65535@]) +&(and&65535))"0
hexlist=: tolower@:,@:hfd@:,@:(|."1)@(256 256 256 256&#:)

cmn=: 4 : 0
'x s t'=. x [ 'q a b'=. y
b add s rot (a add q) add (x add t)
)

ff=: cmn (((1&{ and 2&{) or 1&{ lt 3&{) , 2&{.)
gg=: cmn (((1&{ and 3&{) or 2&{ gt 3&{) , 2&{.)
hh=: cmn (((1&{ xor 2&{)xor 3&{       ) , 2&{.)
ii=: cmn (( 2&{ xor 1&{  ge 3&{       ) , 2&{.)
op=: ff`gg`hh`ii

I=: ".;._2(0 : 0)
0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
1 6 11 0 5 10 15 4 9 14 3 8 13 2 7 12
5 8 11 14 1 4 7 10 13 0 3 6 9 12 15 2
0 7 14 5 12 3 10 1 8 15 6 13 4 11 2 9
)
S=: 4 4$7 12 17 22 5 9 14 20 4 11 16 23 6 10 15 21

T=: |:".;._2(0 : 0)
 _680876936  _165796510     _378558  _198630844
 _389564586 _1069501632 _2022574463  1126891415
  606105819   643717713  1839030562 _1416354905
_1044525330  _373897302   _35309556   _57434055
 _176418897  _701558691 _1530992060  1700485571
 1200080426    38016083  1272893353 _1894986606
_1473231341  _660478335  _155497632    _1051523
  _45705983  _405537848 _1094730640 _2054922799
 1770035416   568446438   681279174  1873313359
_1958414417 _1019803690  _358537222   _30611744
     _42063  _187363961  _722521979 _1560198380
_1990404162  1163531501    76029189  1309151649
 1804603682 _1444681467  _640364487  _145523070
  _40341101   _51403784  _421815835 _1120210379
_1502002290  1735328473   530742520   718787259
 1236535329 _1926607734  _995338651  _343485551
)

norm=: 3 : 0
n=. 16 * 1 + _6 sh 8 + #y
b=. n#0  [  y=. a.i.y
for_i. i. #y do.
  b=. ((j { b) or (8*4|i) sh i{y) (j=. _2 sh i) } b
end.
b=. ((j { b) or (8*4|i) sh 128) (j=._2 sh i=.#y) } b
_16]\ (8 * #y) (n-2) } b
)
md5=: 3 : 0
X=. norm y
q=. r=. 1732584193 _271733879 _1732584194 271733878
for_x. X do.
  for_j. i.4 do.
    l=. ((j{I){x) ,. (16$j{S) ,. j{T
    for_i. i.16 do.
      r=. _1|.((i{l) (op@.j) r),}.r
    end.
  end.
  q=. r=. r add q
end.
hexlist r
)

md5_z_=: md5_pcrypt_

Note 'tests suite'
   (>,. '='"_,. md5&>@]) '';'a';'abc';'message digest'
              =d41d8cd98f00b204e9800998ecf8427e
a             =0cc175b9c0f1b6a831c399e269772661
abc           =900150983cd24fb0d6963f7d28e17f72
message digest=f96b697d7cb7938d525a2f31aaf161d0

   (,: md5) (i.26)&+&.(a.&i.)'a'
abcdefghijklmnopqrstuvwxyz
c3fcd3d76192e4007dfb496cca67e13b

   (,: md5) a.{~(a.i.'Aa0');@:(<@(+i.)"0) 26 26 10
ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789
d174ab98d277d9f5a5611c2c9f419d9f

   (,: md5) 80$'1234567890'
12345678901234567890123456789012345678901234567890123456789012345678901234567890
57edf4a22be3c955ac49da2e2107b67a
)
