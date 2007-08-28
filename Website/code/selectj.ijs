NB. built from project: ~Projects/selectj/selectj

IFJIJX_j_=: 1
script_z_ '~system\main\convert.ijs'
script_z_ '~system\main\dir.ijs'
script_z_ '~system\main\dll.ijs'
script_z_ '~system\main\files.ijs'
script_z_ '~system\packages\stats\random.ijs'
script_z_ '~system\main\strings.ijs'
script_z_ '~system\packages\misc\task.ijs'
script_z_ '~system\packages\winapi\winapi.ijs'

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
loc_z_=: 3 : '> (4!:4 <''y'') { 4!:3 $0'
require 'random convert/misc/md5'
createSalt=: ([: _2&ic a. {~ [: ? 256 $~ ])&4
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
 'session' insertDBTable_psqliteq_  sid;y;sh
 tk=. writeTicket sid;{:sh
)
expireSession=: 3 : 0
  if.0=#y do. y=. qcookie 'SessionTicket' end.
  sid=.0{:: readTicket y
  'sessionexpire' updateDBTable_psqliteq_ ".sid
)

GUESTID=:5
isActive=: 3 : 0
  s=. {:'status' getTable_psqliteq_ y
)
readTicket=: 3 : 0
  kVTable=. qsparse y  
  sid=.'ssid' keyval kVTable
  shash=. 'hash' keyval kVTable
  sid;shash
)

registerUser=: 3 : 0
  'uname fname lname refnum email passwd'=.y
  
  
  uinfo =. {:'login' getTable_psqliteq_ uname  
  if. -.uinfo-:'' do. _2 return. end. 
  pinfo =. {:'email' getTable_psqliteq_  email
  if. -.pinfo-:''  do. 
    pid=. 0{::pinfo    
  else.
    pid=. 'newperson' insertDBTable_psqliteq_ fname;lname;email 
  end.
  sph=. salthash passwd 
  uid=.'newuser' insertDBTable_psqliteq_ pid;uname;refnum;|.sph 
  
)
updateSession=: 3 : 0
  if.0=#y do. y=. qcookie 'SessionTicket' end.
  sid=.0{:: readTicket y
  'session' updateDBTable_psqliteq_ ".sid
)
validCase=: 3 : 0
  if. 0-: uofid=.validEnrolment'' do. 0 return. end.
  uofid validCase y
:
  if. 0=#y do. y=.0 qcookie 'CaseID' end.
  vldcs=.'validcase' getTable_psqliteq_ x,<y
  if. #vldcs do. x,<y else. 0 end.
)
validEnrolment=: 3 : 0
  if. 0-: uid=.validSession'' do. 0 return. end.
  uid validEnrolment y
:
  if. 0=#y do. y=. 0 qcookie 'OfferingID' end.
  enrld=.'enrolled' getTable_psqliteq_ x;y
  if. #enrld do. x;y else. 0 end.
)
validLogin=: 3 : 0
 'usrnme passwd'=. y
  if. usrnme -: '' do. _1 return. end. 
  uinfo =. {:'login' getTable_psqliteq_ usrnme  
  if. ''-: uinfo   do. _2 return. end.   
  'duid dunme dhash dsalt' =. 4{.uinfo
  if. -. dhash-: _1{::dsalt salthash passwd do. _3 return. end. 
  duid
)
validSession=: 3 : 0
  if. 0=#y do. y=. qcookie 'SessionTicket' end.
  'sid shash'=. readTicket y
  sinfo=.'session' getTable_psqliteq_ ".sid
  if. 0=#sinfo do. 0 return. end. 
  'hdr dat'=. split sinfo         
  (hdr)=. |:dat                   
  
  if. -. shash -: 1{::ss_salt salthash sid do. 0 return. end.
  if. timeleft<0 do. 
    'sessionexpire' updateDBTable_psqliteq_ ".sid
    0
  else.
    'session' updateDBTable_psqliteq_ ".sid
    ss_urid
  end.
)
writeTicket=: 3 : 0
  'tsid thash'=.y
  ('ssid=',":tsid),'&hash=',thash
)

resetUsers=: 3 : 0
  if. *#y do.
    'resetusers' updateDBTable_psqliteq_ y
    
    ''
  end.
)
setUsers=: 3 : 0
  if. *#y do.
    'setusers' updateDBTable_psqliteq_ y
    
    ''
  end.
)
deleteUsers=: 3 : 0
  if. *#y do.
    'deleteusers' updateDBTable_psqliteq_ y
    
    ''
  end.
)

pathdelim=: 4 : '}.;([:x&,,)each y'  
getFnme=: 4 : 0
  sep=. PATHSEP_j_
  basefldr=. IFCONSOLE{:: 'd:/web/selectj/';'~.CGI/'
  
  select. x
    case. 'animini' do.  
      fdir=. 'caseinstfolder' getFnme y
      fnme=. 'animini' getDBItem_psqliteq_ y
      fnme=. fdir,fnme
    case. 'caseinstfolder' do.  
      
      pathinfo=. 'caseinstfolder' getTableStr_psqliteq_ y
      'hdr dat'=. split pathinfo
      (hdr)=. |:dat
      of_code=. '_' pathdelim cr_code;of_year;sm_code;dm_code
      fnme=. sep pathdelim ur_uname;of_code;sd_code;ci_id
      fnme=. basefldr,'userpop',sep,fnme,sep
    case. 'scendef' do.  
      
      cde=. 'scendef' getDBItem_psqliteq_ y
      fnme=. basefldr,'scendefs',sep,cde,'.zip'
    case. 'TrtInfo' do.  
      fdir=. 'caseinstfolder' getFnme y
      fnme=. 'TrtInfo.xls'
      fnme=. fdir,fnme
    case. do.
  end.
  fnme=. jpath fnme
)

Note 'list filenames in tree'
,. ,>"1 (,/"0) 1 dir each (dirpath jpath 'd:/web/selectj/scendefs/popsz')#~ a:=(<'.svn') ss each dirpath jpath 'd:/web/selectj/scendefs/popsz'
)
createCaseInstance=: 3 : 0
  ciid=. 'caseinstance' insertDBTable_psqliteq_ y
  uz=. createCaseInstFolder ciid
  ciid
)
createCaseInstFolder=: 3 : 0
  zippath=. 'scendef' getFnme y
  newpath=. 'caseinstfolder' getFnme y
  uz=. unzip zippath;newpath  
)
getCaseInstance=: 3 : 0
  if. 0=#y do.
    if. 0-: uofcsid=. validCase'' do. 0 return. end.
  else.
    uofcsid=. y
  end.
  ciid=. >@{:'caseinstance' getTable_psqliteq_ uofcsid
  if. #ciid do.
    ciid
  else. 
    ciid=. createCaseInstance uofcsid
  end.
)
expireCaseInstance=: 3 : 0
  'expirecaseinst' updateDBTable_psqliteq_ y
  deleteCaseInstFolder y
)
deleteCaseInstFolder=: 3 : 0
  delpath=. 'caseinstfolder' getFnme y
  res=.deltree delpath
  if. 1=*./res do. 1 else. 0 end.
)
getScenarioInfo=: 3 : 0
  'animini' getScenarioInfo y
  :
  infotyp=. boxopen x
  select. infotyp
    case. <'animini' do.
      fnme=. 'animini' getFnme y
      res=. getPPAllSections fnme
    case. <'alltrtinfo' do.
      xlfnme=. 'TrtInfo' getFnme y
      'tDefn' readexcel xlfnme
  end.
)
getParamState=: 3 : 0
 '' getParamState y
:
  seld=. vals=. nmes=. a:  
  select. y
    case. 'hrdsizes'    do.
      vals=. makeVals 'flksizes' keyval ANIMINI
      if. 1 do. 
        seld=. boxopen vals
        vals=. <"0 (100,200*>:i.5), 1500 2000 4000
      end.
    case. 'selnmeth'    do.
      'seld vals nmes'=. getParamState 'coltypes'
      tmp=. makeVals 'selectlistcols' keyval ANIMINI
      tmp=. (({.@> tmp) e. 'pg')#tmp 
      tmp=. {:>{:tmp  
      seld=. ('ed' i. tmp){ |.vals 
    case. 'summtype'    do.
      'seld vals nmes'=. getParamState 'coltypes'
      tmp=. makeVals 'respons2outpt' keyval ANIMINI
      tmp=. (({.@> tmp) e. 'pg')#tmp 
      tmp=. ~.{:@>tmp   
      tmp=. (0<+/-.tmp e. 'de'),'de'e.tmp  
      seld=. tmp#vals   
    case. 'coltypes' do.
      seld=. <'phen'
      vals=. ;:'phen genD genDe'
      nmes=. 'Phenotypes';'Genotypes';'Estimated Breeding Values'
    case. 'trts2select';'trts2summ' do.
      vals=. makeVals 'trtsavail' keyval ANIMINI
      getTrtInfo=. TRTINFO {~[:<(({."1 TRTINFO) i.]);({.TRTINFO) i.[:<[
      nmes=. 'TrtCaption' getTrtInfo vals
      nmes=. ('(',each vals ,each <') '),each nmes
      tmp=. (('trts2select';'trts2summ')i. boxopen y) { 'selectlistcols';'respons2outpt'
      tmp=. makeVals tmp keyval ANIMINI
      tmp=. (({.@> tmp) e. 'pg')#tmp 
      tmp=. tmp -. each <'pdge' 
      seld=. ~. tmp 
    case. 'objectvrevs' do.
      nmes=. makeVals 'trtsavail' keyval ANIMINI
      vals=. (#nmes)#a:
      tmpv=. <"0 makeVals y keyval ANIMINI
      tmpn=. 0{:: getParamState 'trts2select'
      vals=. tmpv (nmes i. tmpn)}vals
    case. 'trtsrecorded' do.
      vals=. makeVals 'trtsavail' keyval ANIMINI
      getTrtInfo=. TRTINFO {~[:<(({."1 TRTINFO) i.]);({.TRTINFO) i.[:<[
      msk=. 9999&~:@>'AOM' getTrtInfo vals 
      vals=. msk#vals
      nmes=. 'TrtCaption' getTrtInfo vals
      seld=. makeVals y keyval ANIMINI

    
    
    case. 'dams2hrdsire' do.
      'seld vals nmes' =. getParamState 'flkdams2sire'
    case. 'usesiresxhrd' do. 
      'seld vals nmes' =. getParamState 'usesiresxflk'
    case. 'samplehrdeffects' do. 
      'seld vals nmes' =. getParamState 'sampleflkeffects'
    case. 'hrdspecfnme' do. 
      'seld vals nmes' =. getParamState 'flkspecfnme'
    case. 'currcycle' do. 
      'seld vals nmes' =. getParamState 'curryear'
    case. do. 
      
      
      vals=. makeVals y keyval ANIMINI
      if. isnum vals do. vals=. <"0 vals end.
      vals=. boxopen vals  
  end.
  seld;vals;<nmes
)
Note 'design for getParamState'
read whole of ini at once and store in memory (at start of buildform?)
Individual params read from memory store.
makeVals key keyval }."1 animini
also need to read total possible traits from traitinfo
probably select case for params that can handle inidividual
should numeric lists be individually boxed?
TRTINFO {~[:<col1 i.];row1 i.[:<[

)
Note 'design for updateParamState'
read whole of ini at once and store in memory (at start of updateform?)
writes params to memory store and then write whole
memory store to file.
)


require 'data/sqlite'
coclass 'psqliteq'
3 : 0 ''
  if. 0=4!:0 <'CONNECTSTR_base_' do.
    ConStr=:  CONNECTSTR_base_  
  else.
    
    ConStr=:  'd:/web/selectj/code/select_cmplx.sqlite'
  end.
)
lasterr=: [: deb LF -.~ }.@(13!:12)
sqldberr_z_=: (assert 0=#) f.

sBegin=: 0 : 0
  r=. 0 0$''
  msg=. ''
  try.
    db=. ConStr conew 'psqlite'
)
sEnd=: 0 : 0
  catch. msg=. lasterr'' end.
  if. 0=nc<'db' do. destroy__db '' end.
  sqldberr msg
  r
)
sdefine=: 1 : 'm : (sBegin , (0 : 0) , sEnd)'
getDBItem=: 3 : 0
 '' getDBItem y
:
 r=. x getTable y
 r=.>{.{:r
)
getDBItemStr=: 3 : 0
 '' getDBItemStr y
:
 r=. x getTableStr y
 r=.>{.{:r
)
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

execSQL=: dyad sdefine
  r=. exec__db y
)

coclass 'psqliteq'
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
  FROM  `cases` cs INNER JOIN `caseinstances` ci ON ( `cs`.`cs_id` = `ci`.`ci_csid` ) 
        INNER JOIN `scendefs` sd ON ( `sd`.`sd_id` = `cs`.`cs_sdid` ) 
  WHERE (ci.ci_id =?);
)

sqlupd_expirecaseinst=: 0 : 0
  UPDATE caseinstances
  SET ci_status=0
  WHERE ci_id=?;
)
sqlsel_animini=: 0 : 0
  SELECT sd.sd_filen sd_filen 
  FROM  `cases` cases INNER JOIN `caseinstances` ci ON ( `cases`.`cs_id` = `ci`.`ci_csid` ) 
        INNER JOIN `scendefs` sd ON ( `sd`.`sd_id` = `cases`.`cs_sdid` ) 
  WHERE (ci.ci_id =?);
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

coclass 'psqliteq'
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

sqlsel_param=: 0 : 0
  SELECT pr.pr_class pr_class ,
         pr.pr_name pr_name ,
         fp.fp_label fp_label ,
         pr.pr_note pr_note ,
         fp.fp_note fp_note ,
         pr.pr_ctype pr_ctype ,
         pr.pr_code pr_code 
  FROM `params` pr INNER JOIN `fieldsetparams` fp ON ( `pr`.`pr_id` = `fp`.`fp_prid` ) 
  WHERE (fp.fp_fsid=? AND fp.fp_prid =?);
)

sqlsel_fieldset=: 0 : 0
  SELECT fs.fs_name fs_name ,
         fp.fp_fsid fs_id ,
         fp.fp_prid pr_id 
  FROM  `fieldsets` fs INNER JOIN `fieldsetparams` fp ON ( `fs`.`fs_id` = `fp`.`fp_fsid` ) 
  WHERE (fs.fs_id =?);
)


sqlsel_paramform=: 0 : 0
  SELECT cf.cf_fsid fs_id ,
         cf.cf_value cf_value 
  FROM  `cases` cs INNER JOIN `caseinstances` ci ON ( `cs`.`cs_id` = `ci`.`ci_csid` ) 
        INNER JOIN `casefieldsets` cf ON ( `cs`.`cs_id` = `cf`.`cf_csid` ) 
  WHERE (ci.ci_id =?);
)

coclass 'pwebforms'
vals_trts2select=: ;:'NLB LW8 FW12 FD FAT LEAN'
nmes=. '(FAT) Carcass Fat content';'(LEAN) Carcass Lean content '
nmes=. '(FW12) Fleece weight at 12-mon';'(FD) Ultrasound backfat depth';nmes
nmes_trts2select=: '(NLB) No. of Lambs Born';'(LW8) Live weight at 8-mon';nmes
seld_trts2select=:  'NLB';'FAT'

vals_popsizes=: <&>(100,200*>:i.5), 1500 2000 4000
seld_popsizes=:  200

vals_ncycles=: <10
vals_currcycle=: <3

vals_dams2sire=: <50
vals_cullage=: <&> 7 8
vals_mateage=: <&> 1 2
vals_allelefreq=: <&> 0.1 0.9
vals_objectvrevs=:<&> 1 3 _4 5 3 0.5
nmes_objectvrevs=: ;:'NLB LW8 FW12 FD FAT LEAN'
vals_selnmeth=: ;:'phen genD genDe'
nmes_selnmeth=: 'Phenotypes';'Genotypes';'Estimated Breeding Values'
seld_selnmeth=: 'genD'
vals_summtype=: vals_selnmeth
nmes_summtype=: nmes_selnmeth
seld_summtype=: ;:'phen genDe'
vals_trts2summ=: vals_trts2select
nmes_trts2summ=: nmes_trts2select
seld_trts2summ=: ;:'NLB FAT LEAN LW8'
vals_trtsrecorded=: ;:'NLB LW8 FW12 FD'
nmes=. '(FW12) Fleece weight at 12-mon';'(FD) Ultrasound backfat depth'
nmes_trtsrecorded=:'(NLB) No. of Lambs Born';'(LW8) Live weight at 8-mon';nmes
ctrlprops_allelefreq=: 0 : 0
 type 'text' size '5'
)

ctrlprops_cullage=: ctrlprops_allelefreq

ctrlprops_currcycle=: 0 : 0
 type 'text' maxlength '3' size '4'
)

ctrlprops_dams2sire=: ctrlprops_allelefreq

ctrlprops_mateage=: ctrlprops_allelefreq

ctrlprops_ncycles=: ctrlprops_currcycle

ctrlprops_objectvrevs=: ctrlprops_allelefreq

ctrlprops_popsizes=: ''

ctrlprops_revs=: 0 : 0
 type 'text' size '7'
)

ctrlprops_selnmeth=: 0 : 0
 type 'radio'
)

ctrlprops_summtype=: 0 : 0
 type 'checkbox'
)

ctrlprops_trts2select=: 0 : 0
 onchange 'REVStatus' multiple 'multiple' size '6'
)

ctrlprops_trts2summ=:  0 : 0
 multiple 'multiple' size '6'
)

ctrlprops_trtsrecorded=: ctrlprops_trts2summ

coclass 'pwebforms'
buildButtons=: 3 : 0
  bt=. INPUT class 'button' type 'submit' onclick 'formsubmit()' value 'Save Changes' ''
  bt=. bt,LF, INPUT class 'button' type 'reset' value 'Discard Changes' ''
  DIV class 'buttonrow' bt
)
buildForm=: 3 : 0
  ANIMINI_z_=: }."1 'animini' getScenarioInfo y
  ANIMINI_z_=: (tolower each {."1 ANIMINI) (0)}"0 1 ANIMINI
  TRTINFO_z_=: 'alltrtinfo' getScenarioInfo y
  info=. 'paramform' getTable_psqliteq_ y  
  'hdr dat'=. split info
  (hdr)=. |:dat                   
  lgd=. P class 'legend' 'This is the legend for my form'
  fsts=. cf_value buildFieldset each fs_id
  frm=. LF join lgd;fsts, boxopen buildButtons ''
  frm=. FORM id 'params' name 'params' enctype 'multipart/form-data' method 'post' action 'case.jhp?action=chgparams' frm
  DIV class 'form-container' frm
)
buildFieldset=: 3 : 0
  1 buildFieldset y
:
  info=. 'fieldset' getTable_psqliteq_ y 
  'hdr dat'=. split info
  (hdr)=. |:dat                   
  lgd=. LEGEND {.fs_name        
  pdvs=. buildParamDiv each boxitemidx <"0 each fs_id;pr_id
  fst=. FIELDSET LF join lgd;pdvs
  dsabld=. (x<1)#'disabled="disabled"'
  fst=. ('disabled';dsabld) stringreplace fst
)
buildParamDiv=: 3 : 0
  info=. 'param' getTable_psqliteq_ y  
  'hdr dat'=. split info
  (hdr)=. ,dat                   
  if. #fp_label do. pr_name=. fp_label end. 
  if. #fp_note  do. pr_note=. fp_note  end. 
  info=. getParamState pr_code 
  'seld vals nms'=. 3{. info
  ctrlprops=. <LF-.~".'ctrlprops_',pr_code 
  ctrlprops=. (#vals)#ctrlprops
  idx=. makeidx (<:^:(=1:)) #vals 
  if. 'select'-: pr_ctype do. idx=.a: end. 
  if. pr_class-:'controlset' do.
    lbl=. LABEL class 'controlset' pr_name
    ctrls=.seld buildControlset  ctrlprops;vals;nms;<idx
    ctrls=.boxopen DIV ctrls
    nte=. buildNote pr_note
    pdv=. DIV class 'controlset' LF join lbl;ctrls,<nte
  else.
    lbl=. 'pr_code' buildLabel pr_name;{.idx
    select. pr_ctype  
      case. 'select' do.
        if. -.a:-:nms do. vals=.boxitemidx vals;<nms end.
        ctrls=.boxopen seld buildSelect (0{::ctrlprops);<vals
      case. 'textarea' do.
        ctrls=. buildTextarea ctrlprops;<vals
      case. 'input' do.
        ctrls=. seld&buildInput each boxitemidx ctrlprops;vals;<idx
    end.
    nte=. buildNote pr_note
    pdv=. DIV LF join lbl;ctrls,<nte
  end.
  pdv=. ('pr_code';pr_code) stringreplace pdv
)
buildControlset=: 3 : 0
  '' buildControlset y
:
  'cprops vals nms idx'=. 4{.y
  ctrls=. x&buildInput each boxitemidx cprops;vals;<idx
  lbls=.  buildLabel each boxitemidx nms;<idx
  LF join ,ctrls,.lbls,.<BR ''
)
buildInput=: 3 : 0
 '' buildInput y
:
  'Ctrlprops Val Idx'=. 3{.y
  Val=. ,8!:2 Val
  x=. 8!:0 x
  Pcode=.'pr_code'
  Chk=. 'checked="checked"'
  ". '((x e.~ <Val)#Chk) INPUT id (Pcode,Idx) value Val name Pcode disabled ',Ctrlprops,' '''''
)
buildLabel=: 3 : 0
  'pr_code' buildLabel y
:
  'nme idx'=. 2{. boxopen y
  Pcode=. x 
  LABEL for (Pcode,idx) nme
)
buildNote=: 3 : 0
  if. #y do.
    P class 'note' y
  else. y end.
)
buildOption=: 3 : 0
  '' buildOption y
:
  'Val Descr'=. 2$y
  sel=. 'selected="selected"'
  ((x e.~ <Val)#sel) OPTION value Val Descr
)
buildSelect=: 3 : 0
  '' buildSelect y
:
  'Ctrlprops opts'=. 2{. y
  opts=. ,each (<"0^:(L.=1:)) opts 
  opts=. 8!:0 each opts
  x=. boxopen 8!:0 x
  Pcode=.'pr_code'
  opts=. x&buildOption each opts
  opts=. LF join opts
  ". 'SELECT id Pcode name Pcode disabled ',Ctrlprops,' opts'
)
getParamStateX=: 3 : 0
  seld=. boxopen ".'seld_',y
  vals=. boxopen ".'vals_',y
  nms=.  boxopen ".'nmes_',y
seld;vals;<nms
)
dict=: 3 : 0
)
unquote=: 3 : 0
  y-.'"'
)
unquot=: 3 : 0
'" ' charsub y
)
join=: ' '&$. : (4 : '(;@(#^:_1!.(<x))~  1 0$~_1 2 p.#) y')  
makeidx=:[: 8!:0 i.

boxitemidx=:<"1@:|:@:>
Note 'useful code'
('pr_code';'nCycles';'disabled';tst1) stringreplace INPUT id 'pr_code' name 'pr_code' type 'text' disabled ''
('checked="checked" ') INPUT value (y) name 'pr_code' id 'pr_code' ''
LABEL for 'pr_code' 'pr_name'
each control has its own verb that creates the control
verb that calls the control verb for each value or value, name pair

Once the controls are created for the param, do the string replace for
pr_code

Once the fieldset is created do a stringreplace for disabled that will
sort out all the controls in the fieldset
)
Note 'tests'
tst=: ('Dollar';'$')
rarg=:('Dollar';'$');(<'Kroner';'DKK')
larg=:''
selectoptions rarg
larg selectoptions rarg
rarg=: ('VISA';'MasterCard')
larg=: 'MasterCard'
larg selectoptions rarg
rarg=: dict 'Basic="$20"';'Plus="$40"'
larg=:'$40'
larg selectoptions rarg
rarg=:  'VISA';'MasterCard';'Discover'
larg=:  'VISA';'Discover'
larg selectoptions rarg
rarg=:  ('No. of Lambs Born';'NLB');('Live weight at 8-mon';'LW8');('Fleece weight at 12-mon';'FW12');(<'Ultrasound backfat depth';'FD')
larg=:  'NLB';'FD'
larg selectoptions rarg
)

buildForm_z_=: buildForm_pwebforms_
addpath_z_=: adverb def '(copath~ ~.@(x&;)@copath)@(coname^:(0:=#)) :. ((copath~ copath -. (<x)"_)@(coname^:(0:=#)))'
webdefs_z_=: 'jweb' addpath
webdefs ''         
cocurrent 'jweb'   
tag=: adverb def 'verb def ((''''''<'',x,''>'''',y,''''</'',x,''>'''''');'':'';(''''''<'',x,'' '''',x,''''>'''',y,''''</'',x,''>''''''))'
maketag=: verb def 'empty ".y,''=: '''''',(tolower y),'''''' tag'''
maketag@> ;:noun define-.LF
   HTML HEAD TITLE BODY LINK
   P PRE BLOCKQUOTE BASE
   STYLE SPAN DIV ADDRESS
   A OBJECT APPLET AREA
   H1 H2 H3 H4 H5 H6 DEL INS
   FONT BASEFONT TT B I BIG SMALL STRIKE U
   XMP CODE SAMP EM STRONG Q CITE
   KBD VAR ABBR ACRONYM DFN SUB SUP
   UL OL LI DIR MENU DL DT DD
   TABLE CAPTION THEAD TFOOT TBODY
   COLGROUP COL TH TR TD
   FRAMESET NOFRAMES IFRAME
   FORM BUTTON SELECT FIELDSET LEGEND
   OPTGROUP OPTION TEXTAREA LABEL
   SCRIPT NOSCRIPT
)
parm=: adverb def 'conjunction def ((''('''''',x,''='''' glue v) u y'');'':'';(''(('''''',x,''='''' glue v),'''' '''',x) u y''))'
makeparm=: verb def 'empty ".y,''=: '''''',y,'''''' parm'''
makeparm@> ;:noun define-.LF
   size width height align href face bgcolor
   text alink vlink border color src alt
   longdesc span hspace vspace usemap clear
   classid codebase codetype archive standby
   start value summary rowspan colspan rows cols
   char charoff headers scope abbr axis
   frame rules cellspacing cellpadding
   name content rel type id class title
   lang dir style datetime onload onunload
   onclick ondblclick onmousedown onmouseup
   onmouseover onmousemove onmouseout
   onkeypress onkeydown onkeyup cite data
   link rel rev charset hreflang accesskey
   tabindex onfocus onblur shape coords media
   valuetype object scrolling frameborder
   marginwidth marginheight target for
   action method enctype onsubmit accept
   maxlength onselect onchange prompt
   language onreset checked readonly multiple
   selected
)

enquote=: ('"'&,)@(,&'"')^:('"'&~:@{.@(1&{.))
glue=: , enquote@":
parm0=: adverb def 'adverb def (('''''''',x,'''''' u y'');'':'';(''('''''',x,'' '''',x) u y''))'
makeparm0=: verb def 'empty ".y,''=: '''''',y,'''''' parm0'''
makeparm0@> ;:noun define-.LF
   ismap compact nowrap declare nohref noshade
   noresize disabled
)
point=: adverb def 'verb def ((''''''<'',x,'' />'''''');'':'';(''''''<'',x,'' '''',x,'''' />''''''))'
makepoint=: verb def 'empty ".y,''=: '''''',(tolower y),'''''' point'''
makepoint@> ;:noun define-.LF
  IMG BR HR PARAM MAP ISINDEX META INPUT
)
makecolor=: verb def 'empty ".y,''=: '''''',y,'''''''''
makecolor@> ;:noun define-.LF
   Black  Silver Gray   White
   Maroon Red    Purple Fuchsia
   Green  Lime   Olive  Yellow
   Navy   Blue   Teal   Aqua
)

splice=: 2 : '; @ (<@u ;. n)'

decorate=: adverb define
:
c=. <;._1 y [ d=. {.y            
g=. (+: 0: , }:) mt=. (0: = #@>) c  
c=. g <@; ;. 1 c,&.>mt<@#"0 d      
(1#~#c) (u{~x i. {.@>c)@> splice 1 }.&.>c
)
ftext=: verb def '''_*%~@'' (]`B`I`CODE`link) decorate y'
fdecor=: adverb def (':';'(''_*%~@'',x) (]`B`I`CODE`LINE`U) decorate y')
link=: verb define
i=. y i. PATHSEP_j_
A href (i{.y) (}.i}.y)
)

image=: verb def ('IMG src y 0';':';'x IMG src y 0')
jsite=: link@('http://www.jsoftware.com/'&,)
spread=: ;@({.&.>&1)   
upon=: 2 : '(u@:v) : (u v)'
by=: ,&LF : (, LF&,)
onbox=: ;@:(by&.>) :.<

table=: TABLE upon (onbox@:(TR&.onbox"1)@:(TD@by&.>))
all=: 2 : '; @ (((by@x)&.>) @ y)'
boxes=: ]
lines=: <;._2
paras=: (_1&|.&((2#LF)&E.) <;._2 ])@by
words=: (#~ *@#@>) @ (<;._1) @ (' '&,)
'ents plain'=: <"0 |: (({. ; }.@}.)~ i.&' ');._2 noun define
lt <
gt >
amp &
quot "
)

pfe=. ;@(((entcvt@{. , }.@}.)~ i.&';')&.>@(<;._1)) &. ('&amp;'&, :. }.)
entcvt=. (ents"_ i. <) >@{ plain"_ , <
entcvt=. (entcvt f.) :. ((plain"_ i. <@,) >@{ (('&'&,@(,&';')&.>ents)"_ , <))
efp=. ; @: (entcvt^:_1&.>)
entities=: pfe :. efp f.
asciibox=: (,(179 180 191 192 193 194 195 196 197 217 218{a.),.'|++++++-+++')&charsub
pdecorate=: adverb def (':';'u@}.@.(x"_ i. {.) all paras y')
fparas=: '>]"''-'&(ftitle`fraw`(P@ftext)`fpre`(P@flist) pdecorate)
fpdecor=: adverb def (':';'(''>]"''''-'',x) (ftitle`fraw`(p@ftext)`fpre`(p@flist)`u) pdecorate y')
fpre=: PRE@(LF&,)
ftitle=: verb def '(''H'',{.y)tag }.}:y'
fraw=: ]
flist=: UL@(LI all lines)

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

require 'dir files'

coclass 'pdiradd'

addPS=: , PATHSEP_j_ -. {:          
dropPS=: }:^:(PATHSEP_j_={:)  
dircreate=: 3 : 0
  y=. boxopen y
  msk=. -.direxist y
  if. ''-:$msk do. msk=.(#y)#msk end.
  res=.1!:5 msk#y
  msk expand ,res
)
direxist=: 'd' e."1 [: > [: , [: ({:"1) 1!:0@(fboxname&>)@(dropPS&.>)@boxopen
 
 

dircreate_z_=: dircreate_pdiradd_
direxist_z_=: direxist_pdiradd_
addPS_z_=: addPS_pdiradd_
dropPS_z_=: dropPS_pdiradd_
require 'dir files'
3 : 0 ''
if. -.IFCONSOLE do.
require 'd:\jprg\user\projects\utils\dir_add.ijs'
end.
)
coclass 'ptrees'

addPS=: , PATHSEP_j_ -. {:          
dropPS=: }:^:(PATHSEP_j_={:)  
copytree=: 4 : 0
  'todir fromdir'=. addPS each x;y
  if. -.direxist fromdir do. 0 0 return. end. 
  dprf=. ] }.&.>~ [: # [  
  aprf=. ] ,&.>~ [: < [    
  fromdirs=. dirpath fromdir
  todirs=. todir aprf fromdir dprf fromdirs
  todirs=. (}:}.,each/\ <;.2 todir), todirs
  fromfiles=. {."1 dirtree fromdir
  tofiles=. todir aprf fromdir dprf fromfiles
  resdir=. dircreate todirs
  resfile=. 0&< @>tofiles fcopy fromfiles
  (+/resdir),+/resfile
)
deltree=: 3 : 0
  try.
    res=.0< ferase {."1 dirtree y
    *./ res,0<ferase |.dirpath y
  catch. 0 end.
)

fcopy=: 4 : 0
  dat=. fread each boxopen y
  dat fwrite each boxopen x
)

copytree_z_=: copytree_ptrees_
deltree_z_=: deltree_ptrees_
require 'winapi strings'
coclass 'pini'
getPPAllSections=: 3 : 0
  snmes=. getPPSectionNames y
  keys=. getPPSection each <"1 (boxopen y),.snmes
  nkys=. #@> keys       
  keys=. ;(nkys>0)#keys 
  (nkys#snmes),.keys
)
getPPSection=: 3 : 0
  'fnme snme'=. y
  len=. #str=. 32767$' '
  'len val'=. 0 2{'GetPrivateProfileSectionA'win32api snme;str;len;fnme
  val=. ({.a.),len{.val  
  val=. <;._1 val
  val=. dtb each '#' taketo each val
  msk=. 0< #@> val 
  val=. msk#val
  ><;._1 each '=',each val
)
getPPSectionNames=: 3 : 0
  fnme=. y
  len=. #str=. 32767$' '
  'len val'=. 0 1{'GetPrivateProfileSectionNamesA'win32api str;len;fnme
  <;._2 val=. len{.val
)
getPPString=: 3 : 0
  'fnme snme knme'=. y
  len=. #str=. 32767$' '
  'len val'=. 0 4{'GetPrivateProfileStringA'win32api snme;knme;'';str;len;fnme
  val=. len{.val
)
getPPValue=: 3 : 0
  '#' getPPValue y  
  :
  rval=. getPPString y   
  rval=. dtb x taketo rval  
)
getPPVals=: 3 : 0
  '#' getPPVals y  
  :
  'delim err'=. 2{.!.(<_999999) boxopen x
  val=. delim getPPValue y   
  err makeVals val
)
join=: ' '&$. : (4 : '(;@(#^:_1!.(<x))~  1 0$~_1 2 p.#) y')  
makeString=:[: ' '&join 8!:0
makeVals=: 3 : 0
  _999999 makeVals y
  :
  err=. x
  if. L.y do. y return. end. 
  val=. ', ' charsub y  
  if. -.+./err= nums=. err&". val do. val=. nums end.
  if. ' ' e. val do. val=. <;._1 ' ',deb val end.
  val
)
writePPString=: 3 : 0
  'fnme snme knme val'=. y
  val=. makeString val
  res=. 'WritePrivateProfileStringA'win32api snme;knme;val;fnme
  0{:: res
)
writePPSection=: 3 : 0
  'fnme snme keys'=. y
  null={.a.
  keys=. (makeString each 1{"1 keys) (1)}"0 1 keys 
  keys=. '=' join each <"1 keys  
  keys=. null,~ null join keys 
  
  res=. 'WritePrivateProfileSectionA'win32api snme;keys;fnme
  0{:: res
)


getPPAllSections_z_=: getPPAllSections_pini_
getPPString_z_=: getPPString_pini_
getPPVals_z_=: getPPVals_pini_
writePPString_z_=: writePPString_pini_
makeVals_z_=: makeVals_pini_
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
d=. (<jhostpath ADDONDIR,'lib/') ,&.> cut 'sqlite-3.4.2.so sqlite3.dll '
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

cocurrent 'oleutlfcn'
oledate2local=: 3 : 0
86400000* _72682+86400%~10000000%~(8#256)#. a.i.y
)
localdate2ole=: 3 : 0
a.{~(8#256)#: 10000000*x:86400*(y%86400000)+72682
)
bitand=: 17 b.
bitxor=: 22 b.
bitor=: 23 b.
bitrot=: 32 b.
bitshl=: 33 b.
bitsha=: 34 b.
ltrim=: }.~ +/@(*./\)@(' '&=)
rtrim=: }.~ -@(+/)@(*./\.)@(' '&=)
trim=: ltrim@:rtrim f.
bigendian=: ({.a.)={. 1&(3!:4) 1  
toBYTE=: {&a.@(256&|)
fromBYTE=: a.&i.
toWORDm=: 1&(3!:4)@:<.
toDWORDm=: 2&(3!:4)@:<.
toucodem=: ''&,@(1&(3!:4))@(3&u:)@u:
toDoublem=: 2&(3!:5)
fromWORDm=: _1&(3!:4)
fromDWORDm=: _2&(3!:4)
fromucodem=: 6&u:
fromDoublem=: _2&(3!:5)
toWORDr=: ,@:(|."1)@(_2: ]\ 1&(3!:4)@:<.)
toDWORDr=: ,@:(|."1)@(_4: ]\ 2&(3!:4)@:<.)
toucoder=: ''&,@:,@:(|."1@(_2: ]\ 1&(3!:4)))@(3&u:)@u:
toDoubler=: ,@:(|."1)@(_8: ]\ 2&(3!:5))
fromWORDr=: _1&(3!:4)@:,@:(|."1)@(_2&(]\))
fromDWORDr=: _2&(3!:4)@:,@:(|."1)@(_4&(]\))
fromucoder=: 6&u:@:,@:(|."1)@(_2&(]\))
fromDoubler=: _2&(3!:5)@:,@:(|."1)@(_8&(]\))
toWORD0=: toWORDm`toWORDr@.bigendian f.
toDWORD0=: toDWORDm`toDWORDr@.bigendian f.
toucode0=: toucodem`toucoder@.bigendian f.
toDouble0=: toDoublem`toDoubler@.bigendian f.
fromWORD0=: fromWORDm`fromWORDr@.bigendian f.
fromDWORD0=: fromDWORDm`fromDWORDr@.bigendian f.
fromucode0=: fromucodem`fromucoder@.bigendian f.
fromDouble0=: fromDoublem`fromDoubler@.bigendian f.
toWORD1=: toWORDm`toWORDr@.(-.bigendian) f.
toDWORD1=: toDWORDm`toDWORDr@.(-.bigendian) f.
toucode1=: toucodem`toucoder@.(-.bigendian) f.
toDouble1=: toDoublem`toDoubler@.(-.bigendian) f.
fromWORD1=: fromWORDm`fromWORDr@.(-.bigendian) f.
fromDWORD1=: fromDWORDm`fromDWORDr@.(-.bigendian) f.
fromucode1=: fromucodem`fromucoder@.(-.bigendian) f.
fromDouble1=: fromDoublem`fromDoubler@.(-.bigendian) f.
dfhs=: 3 : 0
z=. 0
for_bit. , {&(#: i.16) @ ('0123456789abcdef'&i.) y do.
  z=. bit (23 b.) 1 (33 b.) z
end.
z
)
RGB=: 3 : 0"1
(0{y) (23 b.) 8 (33 b.) (1{y) (23 b.) 8 (33 b.) (2{y)
)

RGBtuple=: 3 : 0"0
(16bff (17 b.) y), (_8 (33 b.) 16bff00 (17 b.) y), (_16 (33 b.) 16bff0000 (17 b.) y)
)

fboxname=: ([: < 8 u: >) :: ]
toupperw=: u:@(7&u:)@toupper@(8&u: ::])

fread=: (1!:1 :: _1:) @ fboxname
fdir=: 1!:0@fboxname
freadx=: (1!:11 :: _1:)@(fboxname@{., }.)`(1!:11)@.(0: = L.)
fwritex=: ([ (1!:12) (fboxname@{., }.)@])`(1!:12)@.((0: = L.)@])
fopen=: (1!:21 :: _1:) @ (fboxname &>) @ boxopen
fclose=: (1!:22 :: _1:) @ (fboxname &>) @ boxopen
fwrite=: [ (1!:2) fboxname@]
fappend=: [ (1!:3) fboxname@]
fexist=: (1:@(1!:4) :: 0:) @ (fboxname &>) @ boxopen
ferase=: (1!:55 :: _1:) @ (fboxname &>) @ boxopen
maxpp=: 15 [ 16   
coclass 'oleheaderinfo'
coinsert 'olepps'
create=: 3 : 0
smallsize=: 16b1000
ppssize=: 16b80
bigblocksize=: 16b200
smallblocksize=: 16b0040
bdbcount=: 0
rootstart=: 0
sbdstart=: 0
sbdcount=: 0
extrabbdstart=: 0
extrabbdcount=: 0
bbdinfo=: 0 2$''
sbstart=: 0
sbsize=: 0
data=: ''
fileh=: ''
ppsfile=: ''
)

destroy=: codestroy

coclass 'olestorage'
coinsert 'oleutlfcn'
ppstyperoot=: 5
ppstypedir=: 1
ppstypefile=: 2
datasizesmall=: 16b1000
longintsize=: 4
ppssize=: 16b80
create=: 3 : 0
sfile=: y
openfilenum=: ''
headerinfo=: ''
)

destroy=: 3 : 0
if. -. ''-:openfilenum do. fclose"0 openfilenum end.
if. #headerinfo do. destroy__headerinfo '' end.
codestroy ''
)
getppstree=: 3 : 0
bdata=. y
rhinfo=. initparse sfile
if. ''-:rhinfo do. '' return. end.
(0&{ :: (''"_)) >@{: ugetppstree 0 ; rhinfo ; <bdata
)
getppssearch=: 3 : 0
'raname bdata icase'=. y
rhinfo=. initparse sfile
if. ''-:rhinfo do. '' return. end.
(0&{ :: (''"_)) >@{: ugetppssearch 0 ; rhinfo ; raname ; bdata ; <icase
)
getnthpps=: 3 : 0
'ino bdata'=. y
rhinfo=. initparse sfile
if. ''-:rhinfo do. '' return. end.
ugetnthpps ino ; rhinfo ; <bdata
)
initparse=: 3 : 0
if. #headerinfo do. headerinfo return. end.
if. 1 4 e.~ 3!:0 y do.
  oio=. y
else.
  openfilenum=: ~. openfilenum, oio=. fopen <y   
end.
if. '' -.@-: p=. getheaderinfo oio do. headerinfo=: p end.
p
)
ugetppstree=: 3 : 0
'ino rhinfo bdata radone'=. 4{.y
if. '' -.@-: radone do.
  if. ino e. radone do. radone ; <'' return. end.
end.
radone=. radone, ino
irootblock=. rootstart__rhinfo
opps=. ugetnthpps ino ; rhinfo ; <bdata
if. dirpps__opps ~: _1 do.
  radone=. >@{. ra=. ugetppstree dirpps__opps ; rhinfo ; bdata ; <radone
  achildl=. >@{: ra
  child__opps=: child__opps, achildl
else.
  child__opps=: ''
end.
alist=. ''
if. prevpps__opps ~: _1 do.
  radone=. >@{. ra=. ugetppstree prevpps__opps ; rhinfo ; bdata ; <radone
  alist=. >@{: ra
end.
alist=. alist, opps
if. nextpps__opps ~: _1 do.
  radone=. >@{. ra=. ugetppstree nextpps__opps ; rhinfo ; bdata ; <radone
  alist=. alist, >@{: ra
end.
radone ; <alist
)
ugetppssearch=: 3 : 0
'ino rhinfo raname bdata icase radone'=. 6{.y
irootblock=. rootstart__rhinfo
if. '' -.@-: radone do.
  if. ino e. radone do. radone ; <'' return. end.
end.
radone=. radone, ino
opps=. ugetnthpps ino ; rhinfo ; <0
found=. 0
if. ((icase *. name__opps -:&toupperw raname) +. name__opps-:raname) do.
  found=. 1
end.
if. found do.
  if. 1=bdata do.
    opps=. ugetnthpps ino ; rhinfo ; <bdata
  end.
  ares=. opps
else.
  ares=. ''
end.
if. dirpps__opps ~: _1 do.
  radone=. >@{. ra=. ugetppssearch dirpps__opps ; rhinfo ; raname ; bdata ; icase ; <radone
  ares=. ares, >@{: ra
end.
if. prevpps__opps ~: _1 do.
  radone=. >@{. ra=. ugetppssearch prevpps__opps ; rhinfo ; raname ; bdata ; icase ; <radone
  ares=. ares, >@{: ra
end.
if. nextpps__opps ~: _1 do.
  radone=. >@{. ra=. ugetppssearch nextpps__opps ; rhinfo ; raname ; bdata ; icase ; <radone
  ares=. ares, >@{: ra
end.
radone ; <ares
)
getheaderinfo=: 3 : 0
fp=. 0
if. -. (freadx y, fp, 8)-:16bd0 16bcf 16b11 16be0 16ba1 16bb1 16b1a 16be1{a. do. '' return. end.
rhinfo=. '' conew 'oleheaderinfo'
fileh__rhinfo=: y
if. ''-:iwk=. getinfofromfile fileh__rhinfo ; 16b1e ; 2 do. '' [ destroy__rhinfo '' return. end.
bigblocksize__rhinfo=: <. 2&^ iwk
if. ''-:iwk=. getinfofromfile fileh__rhinfo ; 16b20 ; 2 do. '' [ destroy__rhinfo '' return. end.
smallblocksize__rhinfo=: <. 2&^ iwk
if. ''-:iwk=. getinfofromfile fileh__rhinfo ; 16b2c ; 4 do. '' [ destroy__rhinfo '' return. end.
bdbcount__rhinfo=: iwk
if. ''-:iwk=. getinfofromfile fileh__rhinfo ; 16b30 ; 4 do. '' [ destroy__rhinfo '' return. end.
rootstart__rhinfo=: iwk
if. ''-:iwk=. getinfofromfile fileh__rhinfo ; 16b3c ; 4 do. '' [ destroy__rhinfo '' return. end.
sbdstart__rhinfo=: iwk
if. ''-:iwk=. getinfofromfile fileh__rhinfo ; 16b40 ; 4 do. '' [ destroy__rhinfo '' return. end.
sbdcount__rhinfo=: iwk
if. ''-:iwk=. getinfofromfile fileh__rhinfo ; 16b44 ; 4 do. '' [ destroy__rhinfo '' return. end.
extrabbdstart__rhinfo=: iwk
if. ''-:iwk=. getinfofromfile fileh__rhinfo ; 16b48 ; 4 do. '' [ destroy__rhinfo '' return. end.
extrabbdcount__rhinfo=: iwk
bbdinfo__rhinfo=: getbbdinfo rhinfo
oroot=. ugetnthpps 0 ; rhinfo ; <0
sbstart__rhinfo=: startblock__oroot
sbsize__rhinfo=: size__oroot
rhinfo
)
getinfofromfile=: 3 : 0
'file ipos ilen'=. y
if. ''-:file do. '' return. end.
if. 2=ilen do.
  fromWORD0 freadx file, ipos, ilen
else.
  fromDWORD0 freadx file, ipos, ilen
end.
)
getbbdinfo=: 3 : 0
rhinfo=. y
abdlist=. ''
ibdbcnt=. bdbcount__rhinfo
i1stcnt=. <.(bigblocksize__rhinfo - 16b4c) % longintsize
ibdlcnt=. (<.bigblocksize__rhinfo % longintsize) - 1
fp=. 16b4c
igetcnt=. ibdbcnt <. i1stcnt
abdlist=. abdlist, fromDWORD0 freadx fileh__rhinfo, fp, longintsize*igetcnt
ibdbcnt=. ibdbcnt - igetcnt
iblock=. extrabbdstart__rhinfo
while. ((ibdbcnt> 0) *. isnormalblock iblock) do.
  fp=. setfilepos iblock ; 0 ; <rhinfo
  igetcnt=. ibdbcnt <. ibdlcnt
  abdlist=. abdlist, fromDWORD0 freadx fileh__rhinfo, fp, longintsize*igetcnt
  ibdbcnt=. ibdbcnt - igetcnt
  iblock=. fromDWORD0 freadx fileh__rhinfo, (fp=. fp+longintsize*igetcnt), longintsize
end.
iblkno=. 0
ibdcnt=. <.bigblocksize__rhinfo % longintsize
hbd=. 0 2$''
for_ibdl. abdlist do.
  fp=. setfilepos ibdl ; 0 ; <rhinfo
  awk=. fromDWORD0 freadx fileh__rhinfo, fp, bigblocksize__rhinfo
  for_i. i.ibdcnt do.
    if. ((i{awk) ~: iblkno+1) do.
      hbd=. hbd, iblkno, i{awk
    end.
    iblkno=. >:iblkno
  end.
end.
hbd
)
ugetnthpps=: 3 : 0
'ipos rhinfo bdata'=. y
ippsstart=. rootstart__rhinfo
ibasecnt=. <.bigblocksize__rhinfo % ppssize
ippsblock=. <.ipos % ibasecnt
ippspos=. ipos |~ ibasecnt
iblock=. getnthblockno ippsstart ; ippsblock ; <rhinfo
if. ''-:iblock do. '' return. end.
fp=. setfilepos iblock ; (ppssize*ippspos) ; <rhinfo
inmsize=. fromWORD0 (16b40+i.2){swk=. freadx fileh__rhinfo, fp, ppssize
inmsize=. 0 >. inmsize - 2
snm=. inmsize{.swk
sname=. fromucode0 (i.inmsize){swk
itype=. 256|fromWORD0 (16b42+i.2){swk
'lppsprev lppsnext ldirpps'=. fromDWORD0 (16b44+i.12){swk
ratime1st=: ((itype = ppstyperoot) +. (itype = ppstypedir)) { 0, oledate2local (16b64+i.8){swk
ratime2nd=: ((itype = ppstyperoot) +. (itype = ppstypedir)) { 0, oledate2local (16b6c+i.8){swk
'istart isize'=. fromDWORD0 (16b74+i.8){swk
if. 1=bdata do.
  sdata=. getdata itype ; istart ; isize ; <rhinfo
  pps=. createpps ipos ; sname ; itype ; lppsprev ; lppsnext ; ldirpps ; ratime1st ; ratime2nd ; istart ; isize ; sdata
else.
  pps=. createpps ipos ; sname ; itype ; lppsprev ; lppsnext ; ldirpps ; ratime1st ; ratime2nd ; istart ; isize
end.
pps
)
setfilepos=: 3 : 0
'iblock ipos rhinfo'=. y
ipos + (iblock+1)*bigblocksize__rhinfo
)
getnthblockno=: 3 : 0
'istblock inth rhinfo'=. y
inext=. istblock
for_i. i.inth do.
  isv=. inext
  inext=. getnextblockno isv ; <rhinfo
  if. 0= isnormalblock inext do. '' return. end.
end.
inext
)
getdata=: 3 : 0
'itype iblock isize rhinfo'=. y
if. itype = ppstypefile do.
  if. isize < datasizesmall do.
    getsmalldata iblock ; isize ; <rhinfo
  else.
    getbigdata iblock ; isize ; <rhinfo
  end.
elseif. itype = ppstyperoot do.  
  getbigdata iblock ; isize ; <rhinfo
elseif. itype = ppstypedir do.  
  0
end.
)
getbigdata=: 3 : 0
'iblock isize rhinfo'=. y
if. 0= isnormalblock iblock do. '' return. end.
irest=. isize
sres=. ''
akeys=. /:~ {."1 bbdinfo__rhinfo
while. irest > 0 do.
  ares=. (akeys>:iblock)#akeys
  inkey=. {.ares
  i=. inkey - iblock
  inext=. ({:"1 bbdinfo__rhinfo){~({."1 bbdinfo__rhinfo)i.inkey
  fp=. setfilepos iblock ; 0 ; <rhinfo
  igetsize=. irest <. bigblocksize__rhinfo * (i+1)
  sres=. sres, freadx fileh__rhinfo, fp, igetsize
  irest=. irest-igetsize
  iblock=. inext
end.
sres
)
getnextblockno=: 3 : 0
'iblockno rhinfo'=. y
if. iblockno e. {."1 bbdinfo__rhinfo do.
  ({:"1 bbdinfo__rhinfo){~({."1 bbdinfo__rhinfo)i.iblockno
else.
  iblockno+1
end.
)
isnormalblock=: 3 : 0
y -.@e. _4 _3 _2 _1
)
getsmalldata=: 3 : 0
'ismblock isize rhinfo'=. y
irest=. isize
sres=. ''
while. irest > 0 do.
  fp=. setfilepossmall ismblock ; <rhinfo
  sres=. sres, freadx fileh__rhinfo, fp, irest <. smallblocksize__rhinfo
  irest=. irest - smallblocksize__rhinfo
  ismblock=. getnextsmallblockno ismblock ; <rhinfo
end.
sres
)
setfilepossmall=: 3 : 0
'ismblock rhinfo'=. y
ismstart=. sbstart__rhinfo
ibasecnt=. <.bigblocksize__rhinfo % smallblocksize__rhinfo
inth=. <.ismblock%ibasecnt
ipos=. ismblock |~ ibasecnt
iblk=. getnthblockno ismstart ; inth ; <rhinfo
setfilepos iblk ; (ipos * smallblocksize__rhinfo) ; <rhinfo
)
getnextsmallblockno=: 3 : 0
'ismblock rhinfo'=. y
ibasecnt=. <.bigblocksize__rhinfo % longintsize
inth=. <.ismblock%ibasecnt
ipos=. ismblock |~ ibasecnt
iblk=. getnthblockno sbdstart__rhinfo ; inth ; <rhinfo
fp=. setfilepos iblk ; (ipos * longintsize) ; <rhinfo
fromDWORD0 freadx fileh__rhinfo, fp, longintsize
)

createpps=: 3 : 0
'ipos sname itype lppsprev lppsnext ldirpps ratime1st ratime2nd istart isize sdata'=. 11{.y
select. {.itype
case. ppstyperoot do.
  p=. conew 'oleppsroot'
  create__p ratime1st ; ratime2nd ; ''
case. ppstypedir do.
  p=. conew 'oleppsdir'
  create__p sname ; ratime1st ; ratime2nd ; ''
case. ppstypefile do.
  p=. conew 'oleppsfile'
  create__p sname ; sdata ; ''
case. do.
  assert. 0
end.
no__p=: ipos
name__p=: u: sname
type__p=: {.itype
prevpps__p=: lppsprev
nextpps__p=: lppsnext
dirpps__p=: ldirpps
time1st__p=: ratime1st
time2nd__p=: ratime2nd
startblock__p=: istart
size__p=: isize
data__p=: sdata
p
)

cocurrent 'olepps'
coinsert 'oleutlfcn'
ppstyperoot=: 5
ppstypedir=: 1
ppstypefile=: 2
datasizesmall=: 16b1000
longintsize=: 4
ppssize=: 16b80
fputs=: 3 : 0
if. fileh-:'' do. data=: data, y else. fileh fappend~ y end.
)
datalen=: 3 : 0
if. '' -.@-: ppsfile do. fsize ppsfile return. end.
#data
)
makesmalldata=: 3 : 0
'alist rhinfo'=. y
sres=. ''
ismblk=. 0
for_opps. alist do.
  if. type__opps=ppstypefile do.
    if. size__opps <: 0 do. continue. end.
    if. size__opps < smallsize__rhinfo do.
      ismbcnt=. >. size__opps % smallblocksize__rhinfo
      for_i. i.ismbcnt-1 do.
        fputs__rhinfo toDWORD0 i+ismblk+1
      end.
      fputs__rhinfo toDWORD0 _2
      if. '' -.@-: ppsfile__opps do.
        sres=. sres, ]`(''"_)@.(_1&-:)@:fread ppsfile__opps
      else.
        sres=. sres, data__opps
      end.
      if. size__opps |~ smallblocksize__rhinfo do.
        sres=. sres, ({.a.) #~ smallblocksize__rhinfo ([ - |) size__opps
      end.
      startblock__opps=: ismblk
      ismblk=. ismblk + ismbcnt
    end.
  end.
end.
isbcnt=. <. bigblocksize__rhinfo % longintsize
if. ismblk |~ isbcnt do.
  fputs__rhinfo, (,:toDWORD0 _1) #~ isbcnt ([ - |) ismblk
end.
sres
)
saveppswk=: 3 : 0
rhinfo=. y
z=. toucode0 name
z=. z, ({.a.)#~ 64-2*#name                         
z=. z, toWORD0 2*1+#name                     
z=. z, toBYTE type                                 
z=. z, toBYTE 16b00 
z=. z, toDWORD0 prevpps 
z=. z, toDWORD0 nextpps 
z=. z, toDWORD0 dirpps  
z=. z, 0 9 2 0{a.                                  
z=. z, 0 0 0 0{a.                                  
z=. z, 16bc0 0 0 0{a.                              
z=. z, 0 0 0 16b46{a.                              
z=. z, 0 0 0 0{a.                                  
z=. z, localdate2ole time1st                       
z=. z, localdate2ole time2nd                       
z=. z, toDWORD0 startblock                   
z=. z, toDWORD0 size                         
z=. z, toDWORD0 0                            
fputs__rhinfo z
z
)

coclass 'oleppsdir'
coinsert 'oleutlfcn'
coinsert 'olepps'
create=: 3 : 0
'sname ratime1st ratime2nd rachild'=. y
no=: 0
name=: u: sname
type=: ppstypedir
prevpps=: 0
nextpps=: 0
dirpps=: 0
time1st=: ratime1st
time2nd=: ratime2nd
startblock=: 0
size=: 0
data=: ''
child=: rachild
fileh=: ''
ppsfile=: ''
)

destroy=: codestroy

coclass 'oleppsfile'
coinsert 'oleutlfcn'
coinsert 'olepps'
create=: 3 : 0
'snm sdata sfile'=. y
no=: 0
name=: u: snm
type=: ppstypefile
prevpps=: 0
nextpps=: 0
dirpps=: 0
time1st=: 0
time2nd=: 0
startblock=: 0
size=: 0
data=: >(''-:sfile) { sdata ; ''
child=: ''
ppsfile=: ''
fileh=: ''
ppsfile=: ''
if. '' -.@-: sfile do.
  if. 1 4 e.~ 3!:0 sfile do.
    ppsfile=: sfile
  elseif. do.
    fname=. sfile
    ferase <fname
    ppsfile=: fopen <fname
  end.
  if. #sdata do.
    ppsfile fappend~ sdata
  end.
end.
)

append=: 3 : 0
if. '' -.@-: ppsfile do.
  ppsfile fappend~ y
else.
  data=: data, y
end.
)

destroy=: codestroy

coclass 'oleppsroot'
coinsert 'oleutlfcn'
coinsert 'olepps'
create=: 3 : 0
'ratime1st ratime2nd rachild'=. y
no=: 0
name=: u: 'Root Entry'
type=: ppstyperoot
prevpps=: 0
nextpps=: 0
dirpps=: 0
time1st=: ratime1st
time2nd=: ratime2nd
startblock=: 0
size=: 0
data=: ''
child=: rachild
fileh=: ''
ppsfile=: ''
)

destroy=: codestroy
save=: 3 : 0
'sfile bnoas rhinfo'=. y
if. ''-:rhinfo do.
  rhinfo=. '' conew 'oleheaderinfo'
end.
bigblocksize__rhinfo=: <. 2&^ (0= bigblocksize__rhinfo) { (adjust2 bigblocksize__rhinfo), 9
smallblocksize__rhinfo=: <. 2&^ (0= smallblocksize__rhinfo) { (adjust2 smallblocksize__rhinfo), 6
smallsize__rhinfo=: 16b1000
ppssize__rhinfo=: 16b80
if. ''-:sfile do.
  fileh__rhinfo=: ''
elseif. 1 4 e.~ 3!:0 sfile do.
  fileh__rhinfo=: sfile
elseif. do.
  ferase <sfile
  fileh__rhinfo=: fopen <sfile
end.
iblk=. 0
alist=. ''
list=. 18!:5 ''
if. bnoas do.
  alist=. >@{. saveppssetpnt2 list ; alist ; <rhinfo
else.
  alist=. >@{. saveppssetpnt list ; alist ; <rhinfo
end.
'isbdcnt ibbcnt ippscnt'=. calcsize alist ; <rhinfo
saveheader rhinfo ; isbdcnt ; ibbcnt ; <ippscnt
ssmwk=. makesmalldata alist ; <rhinfo
data=: ssmwk  
ibblk=. isbdcnt
ibblk=. savebigdata ibblk ; alist ; <rhinfo
savepps alist ; <rhinfo
savebbd isbdcnt ; ibbcnt ; ippscnt ; <rhinfo
if. (''-.@-:sfile) *. -. 1 4 e.~ 3!:0 sfile do.
  fclose fileh__rhinfo
end.
if. ''-:sfile do.
  rc=. data__rhinfo
else.
  rc=. ''
end.
destroy__rhinfo ''
rc
)
calcsize=: 3 : 0
'ralist rhinfo'=. y
isbdcnt=. 0
ibbcnt=. 0
ippscnt=. 0
ismalllen=. 0
isbcnt=. 0
for_opps. ralist do.
  if. type__opps=ppstypefile do.
    size__opps=: datalen__opps''  
    if. size__opps < smallsize__rhinfo do.
      isbcnt=. isbcnt + >.size__opps % smallblocksize__rhinfo
    else.
      ibbcnt=. ibbcnt + >.size__opps % bigblocksize__rhinfo
    end.
  end.
end.
ismalllen=. isbcnt * smallblocksize__rhinfo
islcnt=. <. bigblocksize__rhinfo % longintsize
isbdcnt=. >.isbcnt % islcnt
ibbcnt=. ibbcnt + >.ismalllen % bigblocksize__rhinfo
icnt=. #ralist
ibdcnt=. <.bigblocksize__rhinfo % ppssize
ippscnt=. >.icnt % ibdcnt
isbdcnt ; ibbcnt ; <ippscnt
)
adjust2=: 3 : 0
>. 2^.y
)
saveheader=: 3 : 0
'rhinfo isbdcnt ibbcnt ippscnt'=. y
iblcnt=. <.bigblocksize__rhinfo % longintsize
i1stbdl=. <.(bigblocksize__rhinfo - 16b4c) % longintsize
ibdexl=. 0
iall=. ibbcnt + ippscnt + isbdcnt
iallw=. iall
ibdcntw=. >.iallw % iblcnt
ibdcnt=. >.(iall + ibdcntw) % iblcnt
if. ibdcnt > i1stbdl do.
  whilst. ibdcnt > i1stbdl + ibdexl*iblcnt do.
    ibdexl=. >:ibdexl
    iallw=. >:iallw
    ibdcntw=. >.iallw % iblcnt
    ibdcnt=. >.(iallw + ibdcntw) % iblcnt
  end.
end.
z=. 16bd0 16bcf 16b11 16be0 16ba1 16bb1 16b1a 16be1{a.
z=. z, 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0{a.
z=. z, toWORD0 16b3b
z=. z, toWORD0 16b03
z=. z, toWORD0 _2
z=. z, toWORD0 9
z=. z, toWORD0 6
z=. z, toWORD0 0
z=. z, 0 0 0 0 0 0 0 0 {a.
z=. z, toDWORD0 ibdcnt
z=. z, toDWORD0 ibbcnt+isbdcnt 
z=. z, toDWORD0 0
z=. z, toDWORD0 16b1000
z=. z, toDWORD0 0                   
z=. z, toDWORD0 1
if. ibdcnt < i1stbdl do.
  z=. z, toDWORD0 _2       
  z=. z, toDWORD0 0        
else.
  z=. z, toDWORD0 iall+ibdcnt
  z=. z, toDWORD0 ibdexl
end.
fputs__rhinfo z
i=. 0
while. (i<i1stbdl) *. (i < ibdcnt) do.
  fputs__rhinfo toDWORD0 iall+i
  i=. >:i
end.
if. i<i1stbdl do.
  fputs__rhinfo, (,:toDWORD0 _1) #~ i1stbdl-i
end.
)
savebigdata=: 3 : 0
'istblk ralist rhinfo'=. y
ires=. 0
for_opps. ralist do.
  if. type__opps ~: ppstypedir do.
    size__opps=: datalen__opps''   
    if. ((size__opps >: smallsize__rhinfo) +. ((type__opps = ppstyperoot) *. 0~:#data__opps)) do.
      if. '' -.@-: ppsfile__opps do.
        ilen=. #sbuff=. ]`(''"_)@.(_1&-:)@:fread ppsfile__opps
        fputs__rhinfo sbuff
      else.
        fputs__rhinfo data__opps
      end.
      if. size__opps |~ bigblocksize__rhinfo do.
        fputs__rhinfo ({.a.) #~ bigblocksize__rhinfo ([ - |) size__opps
      end.
      startblock__opps=: istblk
      istblk=. istblk + >.size__opps % bigblocksize__rhinfo
    end.
  end.
end.
istblk
)
savepps=: 3 : 0
'ralist rhinfo'=. y
for_oitem. ralist do.
  saveppswk__oitem rhinfo
end.
icnt=. #ralist
ibcnt=. <.bigblocksize__rhinfo % ppssize__rhinfo
if. (icnt |~ ibcnt) do.
  fputs__rhinfo ({.a.) #~ (ibcnt ([ - |) icnt) * ppssize__rhinfo
end.
>.icnt % ibcnt
)
saveppssetpnt2=: 3 : 0
'athis ralist rhinfo'=. y
if. ''-:athis do. ralist ; _1 return.
elseif. 1=#athis do.
  ralist=. ralist, l=. 0{athis
  no__l=: (#ralist) -1
  prevpps__l=: _1
  nextpps__l=: _1
  ralist=. >@{. ra=. saveppssetpnt2 child__l ; ralist ; <rhinfo
  dirpps__l=: >@{: ra
  ralist ; no__l return.
elseif. do.
  icnt=. #athis
  ipos=. 0 
  awk=. athis
  if. (#athis) > 2 do.
    aprev=. 1{awk
    anext=. 2}.awk
  else.
    aprev=. ''
    anext=. }.awk
  end.
  l=. ipos{athis
  ralist=. >@{. ra=. saveppssetpnt2 aprev ; ralist ; <rhinfo
  prevpps__l=: >@{: ra
  ralist= ralist, l
  no__l=: (#ralist) -1
  ralist=. >@{. ra=. saveppssetpnt2 anext ; ralist ; <rhinfo
  nextpps__l=: >@{: ra
  ralist=. >@{. ra=. saveppssetpnt2 child__l ; ralist ; <rhinfo
  dirpps__l=: >@{: ra
  ralist ; no__l return.
end.
)
saveppssetpnt2s=: 3 : 0
'athis ralist rhinfo'=. y
if. (0:=#) athis do. ralist ; _1 return.
elseif. (#athis) =1 do.
  ralist=. ralist, l=. 0{athis
  no__l=: (#ralist) -1
  prevpps__l=: _1
  nextpps__l=: _1
  ralist=. >@{. ra=. saveppssetpnt2 child__l ; ralist ; <rhinfo
  dirpps__l=: >@{: ra
  ralist ; no__l return.
elseif. do.
  icnt=. #athis
  ipos=. 0 
  ralist=. ralist, l=. ipos{athis
  no__l=: (#ralist) -1
  awk=. athis
  aprev=. ipos{.awk
  anext=. (1+ipos)}.awk
  ralist=. >@{. ra=. saveppssetpnt2 aprev ; ralist ; <rhinfo
  prevpps__l=: >@{: ra
  ralist=. >@{. ra=. saveppssetpnt2 anext ; ralist ; <rhinfo
  nextpps__l=: >@{: ra
  ralist=. >@{. ra=. saveppssetpnt2 child__l ; ralist ; <rhinfo
  dirpps__l=: >@{: ra
  ralist ; no__l return.
end.
)
saveppssetpnt=: 3 : 0
'athis ralist rhinfo'=. y
if. (0:=#) athis do. ralist ; _1 return.
elseif. (#athis) =1 do.
  ralist=. ralist, l=. 0{athis
  no__l=: (#ralist) -1
  prevpps__l=: _1
  nextpps__l=: _1
  ralist=. >@{. ra=. saveppssetpnt child__l ; ralist ; <rhinfo
  dirpps__l=: >@{: ra
  ralist ; no__l return.
elseif. do.
  icnt=. #athis
  ipos=. <.icnt % 2
  ralist=. ralist, l=. ipos{athis
  no__l=: (#ralist) -1
  awk=. athis
  aprev=. ipos{.awk
  anext=. (1+ipos)}.awk
  ralist=. >@{. ra=. saveppssetpnt aprev ; ralist ; <rhinfo
  prevpps__l=: >@{: ra
  ralist=. >@{. ra=. saveppssetpnt anext ; ralist ; <rhinfo
  nextpps__l=: >@{: ra
  ralist=. >@{. ra=. saveppssetpnt child__l ; ralist ; <rhinfo
  dirpps__l=: >@{: ra
  ralist ; no__l return.
end.
)
saveppssetpnt1=: 3 : 0
'athis ralist rhinfo'=. y
if. (0:=#) athis do. ralist ; _1 return.
elseif. (#athis) =1 do.
  ralist=. ralist, l=. 0{athis
  no__l=: (#ralist) -1
  prevpps__l=: _1
  nextpps__l=: _1
  ralist=. >@{. ra=. saveppssetpnt child__l ; ralist ; <rhinfo
  dirpps__l=: >@{: ra
  ralist ; no__l return.
elseif. do.
  icnt=. #athis
  ipos=. <.icnt % 2
  ralist=. ralist, l=. ipos{athis
  no__l=: (#ralist) -1
  awk=. athis
  aprev=. ipos{.awk
  anext=. (1+ipos)}.awk
  ralist=. >@{. ra=. saveppssetpnt aprev ; ralist ; <rhinfo
  prevpps__l=: >@{: ra
  ralist=. >@{. ra=. saveppssetpnt anext ; ralist ; <rhinfo
  nextpps__l=: >@{: ra
  ralist=. >@{. ra=. saveppssetpnt child__l ; ralist ; <rhinfo
  dirpps__l=: >@{: ra
  ralist ; no__l return.
end.
)
savebbd=: 3 : 0
'isbdsize ibsize ippscnt rhinfo'=. y
ibbcnt=. <.bigblocksize__rhinfo % longintsize
i1stbdl=. <.(bigblocksize__rhinfo - 16b4c) % longintsize
ibdexl=. 0
iall=. ibsize + ippscnt + isbdsize
iallw=. iall
ibdcntw=. >.iallw % ibbcnt
ibdcnt=. >.(iall + ibdcntw) % ibbcnt
if. ibdcnt >i1stbdl do.
  whilst. ibdcnt > i1stbdl+ibdexl*ibbcnt do.
    ibdexl=. >:ibdexl
    iallw=. >:iallw
    ibdcntw=. >.iallw % ibbcnt
    ibdcnt=. >.(iallw + ibdcntw) % ibbcnt
  end.
end.
if. isbdsize > 0 do.
  for_i. i.(isbdsize-1) do.
    fputs__rhinfo toDWORD0 i+1
  end.
  fputs__rhinfo toDWORD0 _2
end.
for_i. i.(ibsize-1) do.
  fputs__rhinfo toDWORD0 i+isbdsize+1
end.
fputs__rhinfo toDWORD0 _2
for_i. i.(ippscnt-1) do.
  fputs__rhinfo toDWORD0 i+isbdsize+ibsize+1
end.
fputs__rhinfo toDWORD0 _2
for_i. i.ibdcnt do.
  fputs__rhinfo toDWORD0 _3
end.
for_i. i.ibdexl do.
  fputs__rhinfo toDWORD0 _4
end.
if. ((iallw + ibdcnt) |~ ibbcnt) do.
  fputs__rhinfo, (,:toDWORD0 _1) #~ ibbcnt ([ - |) (iallw + ibdcnt)
end.
if. (ibdcnt > i1stbdl) do.
  in=. 0
  inb=. 0
  i=. i1stbdl
  while. i<ibdcnt do.
    if. (in>: (ibbcnt-1)) do.
      in=. 0
      inb=. >:inb
      fputs__rhinfo toDWORD0 iall+ibdcnt+inb
    end.
    fputs__rhinfo toDWORD0 ibsize+isbdsize+ippscnt+i
    i=. >:i
    in=. >:in
  end.
  if. ((ibdcnt-i1stbdl) |~ (ibbcnt-1)) do.
    fputs__rhinfo, (,:toDWORD0 _1) #~ (ibbcnt-1) ([ - |) (ibdcnt-i1stbdl)
  end.
  fputs__rhinfo toDWORD0 _2
end.
)
cocurrent 'biff'
RECORDLEN=: 8224   
format0n=: 164  
colorset0n=: 8   
colorborder=: 16b40
colorpattern=: 16b41
colorfont=: 16b7fff
A1toRC=: 3 : 0
assert. y e. '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'
(26 #. (0 _1)+ _2&{. ' ABCDEFGHIJKLMNOPQRSTUVWXYZ'&i. c),~ <: 1&". y -. c=. y -. '0123456789'
)

toHeader=: toWORD0
UString=: 3 : 0
toucode0 u: y
)

SString=: 3 : 0
(1&u: ::]) y
)

toString=: 3 : 0
if. 131072= 3!:0 y do.
  toucode0 y
else.
  y
end.
)

toUString8=: 3 : 0
if. 131072= 3!:0 y do.
  (a.{~#y), (1{a.), toucode0 y
else.
  (a.{~#y), (0{a.), y
end.
)

toUString16=: 3 : 0
if. 131072= 3!:0 y do.
  (toWORD0 #y), (1{a.), toucode0 y
else.
  (toWORD0 #y), (0{a.), y
end.
)

toUString=: 3 : 0
if. 131072= 3!:0 y do.
  (1{a.), toucode0 y
else.
  (0{a.), y
end.
)

toStream=: 4 : 0
x fappend~ y
)

sulen8=: 3 : 0
if. 131072= 3!:0 y do.
  2+2*#y
else.
  2+#y
end.
)

sulen16=: 3 : 0
if. 131072= 3!:0 y do.
  3+2*#y
else.
  3+#y
end.
)
cellborder_no_line=: 0
cellborder_thin=: 1
cellborder_medium=: 2
cellborder_dashed=: 3
cellborder_dotted=: 4
cellborder_thick=: 5
cellborder_double=: 6
cellborder_hair=: 7
cellborder_medium_dashed=: 8
cellborder_thin_dash_dotted=: 9
cellborder_medium_dash_dotted=: 10
cellborder_thin_dash_dot_dotted=: 11
cellborder_medium_dash_dot_dotted=: 12
cellborder_slanted_medium_dash_dotted=: 13
biff_array=: 3 : 0
'range recalc parsedexpr'=. y
'firstrow lastrow firstcol lastcol'=. range
recordtype=. 16b0221
z=. ''
z=. z, toWORD0 firstrow
z=. z, toWORD0 lastrow
z=. z, toBYTE firstcol
z=. z, toBYTE lastcol
z=. z, toWORD0 recalc
z=. z, toDWORD0 0
z=. z, toWORD0 #parsedexpr
z=. z, SString parsedexpr
z=. (,~ toHeader@:(recordtype , #)) z
)
biff_backup=: 3 : 0
recordtype=. 16b0040
z=. ''
z=. z, toWORD0 0~:y
z=. (,~ toHeader@:(recordtype , #)) z
)
biff_blank=: 4 : 0
recordtype=. 16b0201
y=. >y
assert. 2=#y
z=. ''
z=. z, toWORD0 y
z=. z, toWORD0 x
z=. (,~ toHeader@:(recordtype , #)) z
)
biff_bof=: 3 : 0
'version docn'=. y
recordtype=. 16b809
z=. ''
z=. z, toWORD0 version
z=. z, toWORD0 docn
z=. z, toWORD0 8111   
z=. z, toWORD0 1997   
z=. z, toDWORD0 16b40c1
z=. z, toDWORD0 16b106
z=. (,~ toHeader@:(recordtype , #)) z
)

biff_bookbool=: 3 : 0
recordtype=. 16b00da
z=. ''
z=. z, toWORD0 0~:y
z=. (,~ toHeader@:(recordtype , #)) z
)
biff_boolerr=: 4 : 0
'rowcol boolerrvalue boolORerr'=. y
recordtype=. 16b0205
z=. ''
z=. z, toWORD0 rowcol
z=. z, toWORD0 x
z=. z, toBYTE boolerrvalue
z=. z, toBYTE boolORerr
z=. (,~ toHeader@:(recordtype , #)) z
)
biff_bottommargin=: 3 : 0
recordtype=. 16b0029
z=. ''
z=. z, toDouble0 y
z=. (,~ toHeader@:(recordtype , #)) z
)

biff_boundsheet=: 3 : 0
'offset visible type sheetname'=. y
recordtype=. 16b85
z=. ''
z=. z, toDWORD0 offset
z=. z, toBYTE visible
z=. z, toBYTE type
z=. z, toUString8 sheetname
z=. (,~ toHeader@:(recordtype , #)) z
)
biff_calccount=: 3 : 0
recordtype=. 16b000c
z=. ''
z=. z, toWORD0 y
z=. (,~ toHeader@:(recordtype , #)) z
)
biff_calcmode=: 3 : 0
recordtype=. 13
z=. ''
z=. z, toWORD0 y
z=. (,~ toHeader@:(recordtype , #)) z
)

biff_codepage=: 3 : 0
recordtype=. 16b0042
z=. ''
z=. z, toWORD0 y
z=. (,~ toHeader@:(recordtype , #)) z
)

biff_colinfo=: 4 : 0
'col1 col2 width hide level collapse'=. y
recordtype=. 16b007d
z=. ''
z=. z, toWORD0 col1, col2, width, x
z=. z, toWORD0 hide bitor 8 bitshl level bitor 4 bitshl collapse
z=. z, toWORD0 0
z=. (,~ toHeader@:(recordtype , #)) z
)
biff_columndefault=: 3 : 0
recordtype=. 16b0020
z=. ''
z=. z, toWORD0 y
z=. (,~ toHeader@:(recordtype , #)) z
)
biff_continue=: 3 : 0
recordtype=. 16b003c
z=. ''
z=. z, toString y
z=. (,~ toHeader@:(recordtype , #)) z
)

biff_country=: 3 : 0
recordtype=. 16b008c
z=. ''
z=. z, toWORD0 y
z=. (,~ toHeader@:(recordtype , #)) z
)

biff_crn=: 3 : 0
recordtype=. 16b005a
z=. ''
z=. z, SString y
z=. (,~ toHeader@:(recordtype , #)) z
)
biff_date1904=: 3 : 0
recordtype=. 16b0022
z=. ''
z=. z, toWORD0 0~:y
z=. (,~ toHeader@:(recordtype , #)) z
)
biff_defaultcolwidth=: 3 : 0
recordtype=. 16b0055
z=. ''
z=. z, toWORD0 y
z=. (,~ toHeader@:(recordtype , #)) z
)
biff_defaultrowheight=: 3 : 0
'notmatch hidden spaceabove spacebelow height'=. y
recordtype=. 16b0225
z=. ''
z=. z, toWORD0 bitor (0~:notmatch) bitor 1 bitshl (0~:hidden) bitor 1 bitshl (0~:spaceabove) bitor 1 bitshl (0~:spacebelow)
z=. z, toWORD0 height
z=. (,~ toHeader@:(recordtype , #)) z
)
biff_delta=: 3 : 0
recordtype=. 16b0010
z=. ''
z=. z, toDouble0 y
z=. (,~ toHeader@:(recordtype , #)) z
)
biff_dimensions=: 3 : 0
recordtype=. 16b0200
z=. ''
z=. z, toDWORD0 0 1+0 1{y
z=. z, toWORD0 0 1+2 3{y
z=. z, toWORD0 0
z=. (,~ toHeader@:(recordtype , #)) z
)
biff_eof=: 3 : 0
recordtype=. 16b000a
z=. ''
z=. (,~ toHeader@:(recordtype , #)) z
)

biff_externname=: 4 : 0
recordtype=. 16b0023
z=. ''
if. 'external'-:x do.
  'builtin sheetidx name formula'
  z=. z, toWORD0 0~:builtin
  z=. z, toWORD0 >:sheetidx
  z=. z, toWORD0 0
  z=. z, toUString8 name
  z=. z, SString formula
elseif. 'internal'-:x do.
  'unhandled exception' 13!:8 (3)
elseif. 'addin'-:x do.
  z=. z, toWORD0 0
  z=. z, toDWORD0 0
  z=. z, toUString8 y
  z=. z, SString a.{~2 0 16b1c 16b17
elseif. 'dde'-:x do.
  'automatic stddoc clip item'=. y
  if. 0~:stddoc do. clip=. 16bfff end.
  z=. z, toWORD0 1 bitshl (0~:automatic) bitand 1 bitshl (0~:stddoc) bitand 2 bitshl clip
  z=. z, toDWORD0 0
  z=. z, toUString8 item
elseif. 'ole'-:x do.
  'automatic storage'=. y
  z=. z, toWORD0 1 bitshl (0~:automatic)
  z=. z, toDWORD0 storage
  z=. z, SString a.{~1 0 16b27
elseif. do.
  'unhandled exception' 13!:8 (3)
end.
z=. (,~ toHeader@:(recordtype , #)) z
)

biff_externsheet=: 3 : 0
recordtype=. 16b0017
z=. ''
z=. z, toWORD0 #y
for_yi. y do.
  z=. z, toWORD0 yi
end.
z=. (,~ toHeader@:(recordtype , #)) z
)
biff_font=: 3 : 0
recordtype=. 16b0031
z=. ''
'height italic strikeout color weight script underline family charset fontname'=. y
z=. z, toWORD0 height
z=. z, toWORD0 (1 bitshl 0~:italic) bitor (3 bitshl 0~:strikeout)
z=. z, toWORD0 color
z=. z, toWORD0 weight
z=. z, toWORD0 script
z=. z, toBYTE underline
z=. z, toBYTE family
z=. z, toBYTE charset
z=. z, toBYTE 0
z=. z, toUString8 fontname
z=. (,~ toHeader@:(recordtype , #)) z
)
biff_footer=: 3 : 0
recordtype=. 16b0015
z=. ''
if. #y do.
  z=. z, toUString16 y
end.
z=. (,~ toHeader@:(recordtype , #)) z
)
biff_format=: 3 : 0
'num str'=. y
recordtype=. 16b041e
z=. ''
z=. z, toWORD0 num
z=. z, toUString16 str
z=. (,~ toHeader@:(recordtype , #)) z
)
biff_formula=: 4 : 0
'rowcol value recalc calcopen shared parsedexpr'=. y
recordtype=. 16b0006
z=. ''
z=. z, toWORD0 rowcol
z=. z, toWORD0 x
z=. z, SString 8{.value
z=. z, toWORD0 (0~:recalc) bitor 1 bitshl 1 (0~:calcopen) bitor 1 bitshl 1 (0~:shared)
z=. z, toDWORD0 0
z=. z, toWORD0 #parsedexpr
z=. z, SString parsedexpr
z=. (,~ toHeader@:(recordtype , #)) z
)

biff_gridset=: 3 : 0
recordtype=. 16b0082
z=. ''
z=. z, toWORD0 0~:y
z=. (,~ toHeader@:(recordtype , #)) z
)

biff_guts=: 3 : 0
recordtype=. 16b0080
z=. ''
z=. z, toWORD0 y
z=. (,~ toHeader@:(recordtype , #)) z
)

biff_hcenter=: 3 : 0
recordtype=. 16b008d
z=. ''
z=. z, toWORD0 0~:y
z=. (,~ toHeader@:(recordtype , #)) z
)
biff_header=: 3 : 0
recordtype=. 16b0014
z=. ''
if. #y do.
  z=. z, toUString16 y
end.
z=. (,~ toHeader@:(recordtype , #)) z
)

biff_hideobj=: 3 : 0
recordtype=. 16b008d
z=. ''
z=. z, toWORD0 y
z=. (,~ toHeader@:(recordtype , #)) z
)

biff_hlink=: 4 : 0
recordtype=. 16b01b8
z=. ''
linktype=. x
if. 'url'-:linktype do. 'rowcols link textmark target description'=. y
elseif. 'local'-:linktype do. 'rowcols link elink uplevel textmark target description'=. y
elseif. 'unc'-:linktype do. 'rowcols link textmark target description'=. y
elseif. 'worksheet'-:linktype do. 'rowcols textmark target description'=. y
elseif. do. 'unhandled exception' 13!:8 (3)
end.
bit8=. bit7=. bit6=. bit5=. bit4=. bit3=. bit2=. bit1=. bit0=. 0
if. #target do. bit7=. 1 end.
if. #description do. bit2=. bit4=. 1 end.
if. #textmark do. bit3=. 1
elseif. 'worksheet'-:linktype do.
  'unhandled exception' 13!:8 (3)
end.
if. ('worksheet'-:linktype) *. (':'e.link) do. bit1=. 1 end.
if. 'url'-:linktype do. bit0=. bit1=. 1
elseif. 'local'-:linktype do. bit0=. 1
elseif. 'unc'-:linktype do. bit0=. bit1=. bit8=. 1
elseif. 'worksheet'-:linktype do. bit3=. 1
end.
flag=. #. bit8, bit7, bit6, bit5, bit4, bit3, bit2, bit1, bit0
z=. z, toWORD0 rowcols  
z=. z, SString 16bd0 a.{~16bc9 16bea 16b79 16bf9 16bba 16bce 16b11 16b8c 16b82 16b00 16baa 16b00 16b4b 16ba9 16b0b
z=. z, toDWORD0 2
z=. z, toDWORD0 flag
if. #description do.
  z=. z, toDWORD0 1+#description
  z=. z, UString description+{.a.
end.
if. #target do.
  z=. z, toDWORD0 1+#target
  z=. z, UString target+{.a.
end.
if. 'url'-:linktype do.
  z=. z, SString a.{~16be0 16bc9 16bea 16b79 16bf9 16bba 16bce 16b11 16b8c 16b82 16b00 16baa 16b00 16b4b 16ba9 16b0b
  z=. z, toDWORD0 2*1+#link
  z=. z, UString link+{.a.
elseif. 'local'-:linktype do.
  z=. z, SString a.{~16b03 16b03 16b00 16b00 16b00 16b00 16b00 16b00 16bc0 16b00 16b00 16b00 16b00 16b00 16b00 16b46
  z=. z, toWORD0 uplevel
  z=. z, toDWORD0 1+#link
  z=. z, SString link+{.a.
  z=. z, SString a.{~16bff 16bff 16bad 16bde, 20#0
  if. #elink do.
    z=. z, toDWORD0 10+2*#elink
    z=. z, toDWORD0 2*#elink
    z=. z, SString a.{~16b03 16b00
    z=. z, UString elink
  else.
    z=. z, toDWORD0 0
  end.
elseif. 'unc'-:linktype do.
  z=. z, SString a.{~16be0 16bc9 16bea 16b79 16bf9 16bba 16bce 16b11 16b8c 16b82 16b00 16baa 16b00 16b4b 16ba9 16b0b
  z=. z, toDWORD0 1+#link
  z=. z, UString link+{.a.
elseif. 'worksheet'-:linktype do.
  ''  
end.
if. #textmark do.
  z=. z, toDWORD0 1+#textmark
  z=. z, UString textmark+{.a.
end.
z=. (,~ toHeader@:(recordtype , #)) z
)
biff_horizontalpagebreaks=: 3 : 0
recordtype=. 16b001b
z=. ''
z=. z, toWORD0 #y
for_iy. y do. z=. z, toWORD0 iy end.
z=. (,~ toHeader@:(recordtype , #)) z
)

biff_index=: 3 : 0
recordtype=. 16b020b
z=. ''
z=. z, toDWORD0 0
z=. z, toDWORD0 y
z=. (,~ toHeader@:(recordtype , #)) z
)
biff_integer=: 4 : 0
assert. 2=#y
assert. 2=#>@{.y
assert. 1 4 8 e.~ 3!:0 >1{y
recordtype=. 16b027e
z=. ''
z=. z, toWORD0 >@{.y
z=. z, toWORD0 x
z=. z, toDWORD0 2b10 bitor 2 bitshl <. >1{y
z=. (,~ toHeader@:(recordtype , #)) z
)
biff_iteration=: 3 : 0
recordtype=. 16b0011
z=. ''
z=. z, toWORD0 y
z=. (,~ toHeader@:(recordtype , #)) z
)
biff_label=: 4 : 0
assert. 2=#y
assert. 2=#>@{.y
assert. 2 131072 e.~ 3!:0 >1{y
if. ''-:, >1{y do.
  x biff_blank {.y
else.
  recordtype=. 16b00fd
  z=. ''
  z=. z, toWORD0 >@{.y
  z=. z, toWORD0 x
  z=. z, toDWORD0 add2sst ,&.> 1{y
  z=. (,~ toHeader@:(recordtype , #)) z
end.
)

biff_labelranges=: 3 : 0
'row col'=. y
if. 0=(#row)+#col do. '' return. end.
recordtype=. 16b015f
z=. ''
z=. z, toWORD0 #row
for_iy. row do. z=. z, toWORD0 iy end.
z=. z, toWORD0 #col
for_iy. col do. z=. z, toWORD0 iy end.
z=. (,~ toHeader@:(recordtype , #)) z
)
biff_leftmargin=: 3 : 0
recordtype=. 16b0026
z=. ''
z=. z, toDouble0 y
z=. (,~ toHeader@:(recordtype , #)) z
)

biff_mergedcells=: 3 : 0
if. (0:=#) y do. '' return. end.
recordtype=. 16b00e5
z=. ''
z=. z, toWORD0 #y
for_iy. y do. z=. z, toWORD0 iy end.
z=. (,~ toHeader@:(recordtype , #)) z
)

biff_name=: 3 : 0
recordtype=. 16b0018
z=. ''
'hidden function command macro complex builtin functiongroup binaryname keybd name formula sheet menu description helptopic statusbar'=. y
flag=. (0~:hidden) bitor 1 bitshl (0~:function) bitor 1 bitshl (0~:command) bitor 1 bitshl (0~:macro) bitor 1 bitshl (0~:complex) bitor 1 bitshl (0~:builtin) bitor 1 bitshl functiongroup bitor 6 bitshl binaryname
z=. z, toWORD0 flag
z=. z, toBYTE keybd
z=. z, toBYTE #name
z=. z, toWORD0 #formula
z=. z, toWORD0 0
z=. z, toWORD0 >:sheet
z=. z, toBYTE #menu
z=. z, toBYTE #description
z=. z, toBYTE #helptopic
z=. z, toBYTE #statusbar
z=. z, toUString name
z=. z, SString formula
if. #menu do. z=. z, toUString menu end.
if. #description do. z=. z, toUString description end.
if. #helptopic do. z=. z, toUString helptopic end.
if. #statusbar do. z=. z, toUString statusbar end.
z=. (,~ toHeader@:(recordtype , #)) z
)
biff_number=: 4 : 0
assert. 2=#y
assert. 2=#>@{.y
assert. 1 4 8 e.~ 3!:0 >1{y
recordtype=. 16b0203
z=. ''
z=. z, toWORD0 >@{.y
z=. z, toWORD0 x
z=. z, toDouble0 >1{y
z=. (,~ toHeader@:(recordtype , #)) z
)
biff_objectprotect=: 3 : 0
recordtype=. 16b0063
z=. ''
z=. z, toWORD0 0~:y
z=. (,~ toHeader@:(recordtype , #)) z
)

biff_palette=: 3 : 0
recordtype=. 16b0092
z=. ''
z=. z, toWORD0 #y
z=. z, toDWORD0 y
z=. (,~ toHeader@:(recordtype , #)) z
)
biff_pane=: 3 : 0
recordtype=. 16b0041
z=. ''
'split vis activepane'=. y
z=. z, toWORD0 split   
z=. z, toWORD0 vis     
for_pane. activepane do. z=. z, toWORD0 pane end.
z=. (,~ toHeader@:(recordtype , #)) z
)
biff_password=: 3 : 0
recordtype=. 16b0013
z=. ''
z=. z, toWORD0 y
z=. (,~ toHeader@:(recordtype , #)) z
)
biff_precision=: 3 : 0
recordtype=. 16b000e
z=. ''
z=. z, toWORD0 0~:y
z=. (,~ toHeader@:(recordtype , #)) z
)
biff_printgridlines=: 3 : 0
recordtype=. 16b002b
z=. ''
z=. z, toWORD0 0~:y
z=. (,~ toHeader@:(recordtype , #)) z
)
biff_printheaders=: 3 : 0
recordtype=. 16b002a
z=. ''
z=. z, toWORD0 0~:y
z=. (,~ toHeader@:(recordtype , #)) z
)
biff_protect=: 3 : 0
recordtype=. 16b0012
z=. ''
z=. z, toWORD0 0~:y
z=. (,~ toHeader@:(recordtype , #)) z
)
biff_refmode=: 3 : 0
recordtype=. 16b000f
z=. ''
z=. z, toWORD0 0~:y
z=. (,~ toHeader@:(recordtype , #)) z
)
biff_rightmargin=: 3 : 0
recordtype=. 16b0027
z=. ''
z=. z, toDouble0 y
z=. (,~ toHeader@:(recordtype , #)) z
)
biff_row=: 4 : 0
xf=. x
'rownumber firstcol lastcol usedefaultheight rowheight heightnotmatch spaceabove spacebelow hidden explicitformat outlinelevel outlinegroup'=. y
recordtype=. 16b0208
z=. ''
z=. z, toWORD0 rownumber
z=. z, toWORD0 firstcol
z=. z, toWORD0 lastcol
z=. z, toWORD0 (16b7fff bitand rowheight) bitor 15 bitshl 0~:usedefaultheight
z=. z, toWORD0 0
z=. z, toWORD0 0
z=. z, toDWORD0 (16b7 bitand outlinelevel) bitor 4 bitshl (0~:outlinegroup) bitor 1 bitshl (0~:hidden) bitor 1 bitshl (0~:heightnotmatch) bitor 1 bitshl (0~:explicitformat) bitor 1 bitshl 1 bitor 8 bitshl (16bfff bitand xf) bitor 12 bitshl (0~:spaceabove) bitor 1 bitshl 0~:spacebelow
z=. (,~ toHeader@:(recordtype , #)) z
)
biff_scenprotect=: 3 : 0
recordtype=. 16b00dd
z=. ''
z=. z, toWORD0 0~:y
z=. (,~ toHeader@:(recordtype , #)) z
)

biff_scl=: 3 : 0
recordtype=. 16b00a0
z=. ''
z=. z, toWORD0 y
z=. (,~ toHeader@:(recordtype , #)) z
)
biff_selection=: 3 : 0
recordtype=. 16b001d
z=. ''
'panenum row col refnum refs'=. y
z=. z, toBYTE panenum
z=. z, toWORD0 row
z=. z, toWORD0 col
z=. z, toWORD0 refnum
z=. z, toWORD0 #refs
for_i. i.#refs do.
  z=. z, toWORD0 2{.>i{refs
  z=. z, toBYTE 2}.>i{refs
end.
z=. (,~ toHeader@:(recordtype , #)) z
)

biff_setup=: 3 : 0
recordtype=. 16b00a1
z=. ''
'setuppapersize setupscaling setupstartpage setupfitwidth setupfitheight setuprowmajor setupportrait setupinvalid setupblackwhite setupdraft setupcellnote setuporientinvalid setupusestartpage setupnoteatend setupprinterror setupdpi setupvdpi setupheadermargin setupfootermargin setupnumcopy'=. y
z=. z, toWORD0 setuppapersize
z=. z, toWORD0 setupscaling
z=. z, toWORD0 setupstartpage
z=. z, toWORD0 setupfitwidth
z=. z, toWORD0 setupfitheight
z=. z, toWORD0 setuprowmajor bitor 1 bitshl setupportrait bitor 1 bitshl setupinvalid bitor 1 bitshl setupblackwhite bitor 1 bitshl setupdraft bitor 1 bitshl setupcellnote bitor 1 bitshl setuporientinvalid bitor 1 bitshl setupusestartpage bitor 2 bitshl setupnoteatend bitor 1 bitshl setupprinterror
z=. z, toWORD0 setupdpi
z=. z, toWORD0 setupvdpi
z=. z, toDouble0 setupheadermargin
z=. z, toDouble0 setupfootermargin
z=. z, toWORD0 setupnumcopy
z=. (,~ toHeader@:(recordtype , #)) z
)

biff_standardwidth=: 3 : 0
recordtype=. 16b0099
z=. ''
z=. z, toWORD0 y
z=. (,~ toHeader@:(recordtype , #)) z
)
biff_string=: 3 : 0
if. #y do.
  recordtype=. 16b0207
  z=. ''
  z=. z, toUString16 y
  z=. (,~ toHeader@:(recordtype , #)) z
else.
  z=. ''
end.
)

biff_style=: 4 : 0
recordtype=. 16b0293
z=. ''
'builtin id level name'=. y
if. 0=builtin do.
  z=. z, toWORD0 16bfff bitand x
  z=. z, toUString16 name
else.
  z=. z, toWORD0 16b8000 bitor 16bfff bitand x
  z=. z, toBYTE id
  z=. z, toBYTE level
end.
z=. (,~ toHeader@:(recordtype , #)) z
)

biff_supbook=: 4 : 0
recordtype=. 16b01ae
z=. ''
if. 'external'-:x do.
  z=. z, toWORD0 #>{:y
  z=. z, toUString16 >{.y
  for_yi. >{:y do.
    z=. z, toUString16 >yi
  end.
elseif. 'internal'-:x do.
  z=. z, toWORD0 y
  z=. z, SString 1 4{a.
elseif. 'addin'-:x do.
  z=. z, toWORD0 1
  z=. z, SString 1 3{a.
elseif. ('ole'-:x)+.('dde'-:x) do.
  z=. z, toWORD0 0
  z=. z, toUString16 y
elseif. do.
  'unhandled exception' 13!:8 (3)
end.
z=. (,~ toHeader@:(recordtype , #)) z
)
biff_table=: 3 : 0
recordtype=. 16b0036
z=. ''
'firstrow lastrow firstcol lastcol recalc rowinput colinput row col'=. y
z=. z, toWORD0 firstrow
z=. z, toWORD0 lastrow
z=. z, toBYTE firstcol
z=. z, toBYTE lastcol
z=. z, toWORD0 recalc
z=. z, toWORD0 rowinput
z=. z, toWORD0 colinput
z=. z, toWORD0 row
z=. z, toWORD0 col
z=. (,~ toHeader@:(recordtype , #)) z
)
biff_topmargin=: 3 : 0
recordtype=. 16b0028
z=. ''
z=. z, toDouble0 y
z=. (,~ toHeader@:(recordtype , #)) z
)

biff_vcenter=: 3 : 0
recordtype=. 16b0084
z=. ''
z=. z, toWORD0 0~:y
z=. (,~ toHeader@:(recordtype , #)) z
)
biff_verticalpagebreaks=: 3 : 0
recordtype=. 16b001a
z=. ''
z=. z, toWORD0 #y
for_iy. y do. z=. z, toWORD0 iy end.
z=. (,~ toHeader@:(recordtype , #)) z
)
biff_window1=: 3 : 0
recordtype=. 16b003d
z=. ''
'x y width height hidden'=. y
z=. z, toWORD0 x
z=. z, toWORD0 y
z=. z, toWORD0 width
z=. z, toWORD0 height
z=. z, toWORD0 hidden
z=. z, toWORD0 0
z=. z, toWORD0 0
z=. z, toWORD0 1
z=. z, toWORD0 250
z=. (,~ toHeader@:(recordtype , #)) z
)
biff_window2=: 3 : 0
recordtype=. 16b023e
z=. ''
'flag topvisiblerow leftvisiblecol RGBcolor'=. y
z=. z, toWORD0 flag
z=. z, toWORD0 topvisiblerow
z=. z, toWORD0 leftvisiblecol
z=. z, toWORD0 RGBcolor
z=. z, toWORD0 0
z=. z, toWORD0 0
z=. z, toWORD0 0
z=. z, toDWORD0 0
z=. (,~ toHeader@:(recordtype , #)) z
)
biff_windowprotect=: 3 : 0
recordtype=. 16b0019
z=. ''
z=. z, toWORD0 0~:y
z=. (,~ toHeader@:(recordtype , #)) z
)

biff_wsbool=: 3 : 0
recordtype=. 16b0081
z=. ''
z=. z, toWORD0 y
z=. (,~ toHeader@:(recordtype , #)) z
)

biff_xct=: 3 : 0
recordtype=. 16b0059
z=. ''
z=. z, toWORD0 y
z=. (,~ toHeader@:(recordtype , #)) z
)

biff_xf=: 3 : 0
recordtype=. 16b00e0
'font format typeprot align rotate indent used border linecolor color'=. y
z=. ''
z=. z, toWORD0 font
z=. z, toWORD0 format
z=. z, toWORD0 typeprot
z=. z, toBYTE align
z=. z, toBYTE rotate
z=. z, toBYTE indent
z=. z, toBYTE used
z=. z, toDWORD0 border
z=. z, toDWORD0 linecolor
z=. z, toWORD0 color
z=. (,~ toHeader@:(recordtype , #)) z
)

coclass 'biffrefname'
coinsert 'oleutlfcn'
coinsert 'biff'
create=: 3 : 0
'hidden function command macro complex builtin functiongroup binaryname keybd sheetidx'=: 0
'name formula menu description helptopic statusbar'=: 6#a:
)

destroy=: codestroy
writestream=: 3 : 0
z=. biff_name hidden ; function ; command ; macro ; complex ; builtin ; functiongroup ; binaryname ; keybd ; name ; formula ; sheetidx ; menu ; description ; helptopic ; statusbar
)

coclass 'biffsupbook'
coinsert 'oleutlfcn'
coinsert 'biff'
newextname=: 3 : 0
extname=: extname, <y
)

create=: 3 : 0
'type sheetn source sheetname'=: 4{.y
if. -. (<type) e. 'external' ; 'internal' ; 'addin' ; 'ole' ; 'dde' do.
  'unhandled exception' 13!:8 (3)
end.
extname=: ''
crn=: ''  
)

destroy=: codestroy
writestream=: 3 : 0
z=. ''
if. 'external'-:type do. z=. z, type biff_supbook source ,&< sheetname
elseif. 'internal'-:type do. z=. z, type biff_supbook y
elseif. 'addin'-:type do. z=. z, type biff_supbook ''
elseif. 'ole'-:type do. z=. z, type biff_supbook source
elseif. 'dde'-:type do. z=. z, type biff_supbook source
end.
for_ni. extname do.
  z=. z, type biff_externname >ni
end.
for_ni. crn do.
  z=. z, type biff_crn >ni
end.
z
)

coclass 'biffxf'
coinsert 'oleutlfcn'
coinsert 'biff'
getcolor=: ]
getfont=: 3 : 0
'fontheight fontitalic fontstrike fontcolor fontweight fontscript fontunderline fontfamily fontcharset fontname'=. y
y=. fontheight ; fontitalic ; fontstrike ; (getcolor fontcolor) ; fontweight ; fontscript ; fontunderline ; fontfamily ; fontcharset ; trim fontname
if. (#fontset__COCREATOR)= n=. fontset__COCREATOR i. y do.
  fontset__COCREATOR=: fontset__COCREATOR, y
end.
n
)

getformat=: 3 : 0
if. (#formatset__COCREATOR)= n=. formatset__COCREATOR i. <y=. trim y do.
  formatset__COCREATOR=: formatset__COCREATOR, <y
end.
n
)
getxfrow=: 3 : 0
font=. getfont fontheight ; fontitalic ; fontstrike ; fontcolor ; fontweight ; fontscript ; fontunderline ; fontfamily ; fontcharset ; fontname
formatn=. getformat format
if. (0=leftlinecolor) *. leftlinestyle do. leftlinecolor=. 16b40 end.
if. (0=rightlinecolor) *. rightlinestyle do. rightlinecolor=. 16b40 end.
if. (0=toplinecolor) *. toplinestyle do. toplinecolor=. 16b40 end.
if. (0=bottomlinecolor) *. bottomlinestyle do. bottomlinecolor=. 16b40 end.
if. (0=diagonalcolor) *. diagonalstyle do. diagonalcolor=. 16b40 end.
if. (0=patternbgcolor) *. pattern do. patternbgcolor=. 16b41 end.
typeprotparent=. lock bitor 1 bitshl hideformula bitor 1 bitshl type bitor 2 bitshl parentxf
align=. horzalign bitor 3 bitshl textwrap bitor 1 bitshl vertalign
indentshrink=. indent bitor 4 bitshl shrink
used=. 2 bitshl usedformat bitor 1 bitshl usedfont bitor 1 bitshl usedalign bitor 1 bitshl usedborder bitor 1 bitshl usedbackground bitor 1 bitshl usedprotect
border=. leftlinestyle bitor 4 bitshl rightlinestyle bitor 4 bitshl toplinestyle bitor 4 bitshl bottomlinestyle bitor 4 bitshl (getcolor leftlinecolor) bitor 7 bitshl (getcolor rightlinecolor) bitor 7 bitshl diagonaltopleft bitor 1 bitshl diagonalbottomleft
linecolor=. (getcolor toplinecolor) bitor 7 bitshl (getcolor bottomlinecolor) bitor 7 bitshl (getcolor diagonalcolor) bitor 7 bitshl diagonalstyle bitor 5 bitshl pattern
color=. (getcolor patterncolor) bitor 7 bitshl (getcolor patternbgcolor)
font, formatn, typeprotparent, align, rotation, indentshrink, used, border, linecolor, color
)
copyxfrow=: 3 : 0
'font formatn typeprotparent align rotate indentshrink used border linecolor color'=. y
'fontheight fontitalic fontstrike fontcolor fontweight fontscript fontunderline fontfamily fontcharset fontname'=: font{fontset__COCREATOR
format=: >formatn{formatset__COCREATOR
lock=: 1 bitand typeprotparent
hideformula=: _1 bitshl 2b10 bitand typeprotparent
type=: _2 bitshl 2b100 bitand typeprotparent
parentxf=: _4 bitshl 16bfff0 bitand typeprotparent
rotation=: rotate
horzalign=: 7 bitand align
textwrap=: _3 bitshl 8 bitand align
vertalign=: _4 bitshl 16b70 bitand align
indent=: 16bf bitand indentshrink
shrink=: _4 bitshl 16b10 bitand indentshrink
'usedformat usedfont usedalign usedborder usedbackground usedprotect'=: |. _2}. _8{. (8#0), #: used
leftlinestyle=: 16bf bitand border
rightlinestyle=: _4 bitshl 16bf0 bitand border
toplinestyle=: _8 bitshl 16bf00 bitand border
bottomlinestyle=: _12 bitshl 16bf000 bitand border
leftlinecolor=: _16 bitshl 16b7f0000 bitand border
rightlinecolor=: _23 bitshl 16b3f800000 bitand border
diagonaltopleft=: _30 bitshl 16b40000000 bitand border
diagonalbottomleft=: _31 bitshl (dfhs '80000000') bitand border
toplinecolor=: 16b7f bitand linecolor
bottomlinecolor=: _7 bitshl 16b3f80 bitand linecolor
diagonalcolor=: _14 bitshl 16b1fc000 bitand linecolor
diagonalstyle=: _21 bitshl 16b1e00000 bitand linecolor
pattern=: _26 bitshl (dfhs 'fc000000') bitand linecolor
patterncolor=: 16b7f bitand color
patternbgcolor=: _7 bitshl 16b3f80 bitand color
)
copyxfobj=: 3 : 0
l=. y
nm=. nl__l 0
for_nmi. nm do. (>nmi)=: ((>nmi), '__l')~ end.
)

create=: 3 : 0
'fontheight fontitalic fontstrike fontcolor fontweight fontscript fontunderline fontfamily fontcharset fontname'=: {.fontset_COCREATOR
format=: 'General'
lock=: 0
hideformula=: 1
type=: 0  
parentxf=: 0
horzalign=: 0  
textwrap=: 0
vertalign=: 2  
rotation=: 0
indent=: 0
shrink=: 0
usedformat=: 0
usedfont=: 0
usedalign=: 0
usedborder=: 0
usedbackground=: 0
usedprotect=: 0
leftlinestyle=: 0
rightlinestyle=: 0
toplinestyle=: 0
bottomlinestyle=: 0
leftlinecolor=: 0
rightlinecolor=: 0
diagonaltopleft=: 0
diagonalbottomleft=: 0
toplinecolor=: 0
bottomlinecolor=: 0
diagonalcolor=: 0
diagonalstyle=: 0
pattern=: 0
patterncolor=: colorborder
patternbgcolor=: colorpattern
xfindex=: _1   
if. ''-.@-:y do.
  if. (3!:0 y) e. 1 4 do.
    copyxfrow y
  elseif. (3!:0 y) e. 32 do.
    copyxfobj y
  end.
end.
)

destroy=: codestroy

coclass 'biffsheet'
coinsert 'oleutlfcn'
coinsert 'biff'
insertpicture=: 4 : 0
img=. y
'rowcol xy scalexy'=. x
if. 2 131072 e.~ 3!:0 rowcol do. rowcol=. A1toRC rowcol end.
'row col'=. rowcol
'x y'=. xy
'scalex scaley'=. scalexy
z=. processbitmap img
if. _1=>@{.z do. z return. end.
'width height size data'=. }.z
width=. width * scalex
height=. height * scaley
positionImage col ; row ; x ; y ; width ; height
record=. 16b007f
if. RECORDLEN>:8 + size do.
  length=. 8 + size
  cf=. 16b09
  env=. 16b01
  lcb=. size
  header=. toWORD0 record, length, cf, env
  header=. header, toDWORD0 lcb
  imdata=: imdata, header, data
else.
  length=. RECORDLEN
  cf=. 16b09
  env=. 16b01
  lcb=. size
  header=. toWORD0 record, length, cf, env
  header=. header, toDWORD0 lcb
  imdata=: imdata, header, (RECORDLEN-8){.data
  data=. (RECORDLEN-8)}.data
  a=. <.(#data) % RECORDLEN
  b=. RECORDLEN | #data
  if. #a do.
    imdata=: imdata,, (toHeader 16b003c, RECORDLEN), "1 (a, RECORDLEN)$(a*RECORDLEN){.data
  end.
  if. #b do.
    imdata=: imdata, (toHeader 16b003c, b), (-b){.data
  end.
end.
0 ; ''
)
positionImage=: 3 : 0
'colstart rowstart x1 y1 width height'=. y
colend=. colstart  
rowend=. rowstart  
if. x1 >: sizeCol colstart do. x1=. 0 end.
if. y1 >: sizeRow rowstart do. y1=. 0 end.
width=. width + x1 -1
height=. height + y1 -1
while. width >: sizeCol colend do.
  width=. width - sizeCol colend
  colend=. >:colend
end.
while. height >: sizeRow rowend do.
  height=. height - sizeRow rowend
  rowend=. >:rowend
end.
if. 0= sizeCol colstart do. return. end.
if. 0= sizeCol colend do. return. end.
if. 0= sizeRow rowstart do. return. end.
if. 0= sizeRow rowend do. return. end.
x1=. <. 1024 * x1 % sizeCol colstart
y1=. <. 256 * y1 % sizeRow rowstart
x2=. <. 1024 * width % sizeCol colend 
y2=. <. 256 * height % sizeRow rowend 
storeobjpicture colstart ; x1 ; rowstart ; y1 ; colend ; x2 ; rowend ; y2
)

getcolsizes=: 3 : 0
if. (#colsizes)= i=. y i.~ {."1 colsizes do.
  _1
else.
  {: i{colsizes
end.
)

getrowsizes=: 3 : 0
if. (#rowsizes)= i=. y i.~ {."1 rowsizes do.
  _1
else.
  {: i{rowsizes
end.
)
sizeCol=: 3 : 0
if. _1~: getcolsizes y do.
  if. 0= getcolsizes y do.
    0 return.
  else.
    <. 5 + 8 * 0.38 + 256%~ getcolsizes y return.
  end.
else.
  <. 5 + 8 * 0.38 + 256%~ defaultcolwidth * 256 return.
end.
)
sizeRow=: 3 : 0
if. _1~: getrowsizes y do.
  if. 0= getrowsizes y do.
    0 return.
  else.
    <. (4%3) * 20%~ getrowsizes y return.
  end.
else.
  <. (4%3) * 20%~ defaultrowheight return.
end.
)
storeobjpicture=: 3 : 0
'colL dxL rwT dyT colR dxR rwB dyB'=. y
record=. 16b005d   
length=. 16b003c   
cObj=. 16b0001   
OT=. 16b0008   
id=. 16b0001   
grbit=. 16b0614   
cbMacro=. 16b0000   
Reserved1=. 16b0000   
Reserved2=. 16b0000   
icvBack=. 16b09     
icvFore=. 16b09     
fls=. 16b00     
fAuto=. 16b00     
icv=. 16b08     
lns=. 16bff     
lnw=. 16b01     
fAutoB=. 16b00     
frs=. 16b0000   
cf=. 16b0009   
Reserved3=. 16b0000   
cbPictFmla=. 16b0000   
Reserved4=. 16b0000   
grbit2=. 16b0001   
Reserved5=. 16b0000   
header=. toWORD0 record, length
data=. toDWORD0 cObj
data=. data, toWORD0 OT
data=. data, toWORD0 id
data=. data, toWORD0 grbit
data=. data, toWORD0 colL
data=. data, toWORD0 dxL
data=. data, toWORD0 rwT
data=. data, toWORD0 dyT
data=. data, toWORD0 colR
data=. data, toWORD0 dxR
data=. data, toWORD0 rwB
data=. data, toWORD0 dyB
data=. data, toWORD0 cbMacro
data=. data, toDWORD0 Reserved1
data=. data, toWORD0 Reserved2
data=. data, toBYTE icvBack
data=. data, toBYTE icvFore
data=. data, toBYTE fls
data=. data, toBYTE fAuto
data=. data, toBYTE icv
data=. data, toBYTE lns
data=. data, toBYTE lnw
data=. data, toBYTE fAutoB
data=. data, toWORD0 frs
data=. data, toDWORD0 cf
data=. data, toWORD0 Reserved3
data=. data, toWORD0 cbPictFmla
data=. data, toWORD0 Reserved4
data=. data, toWORD0 grbit2
data=. data, toDWORD0 Reserved5
imdata=: imdata, header, data
)
processbitmap=: 3 : 0
raiseError=. ''
if. 32=3!:0 y do.
  data=. ]`(''"_)@.(_1&-:)@:fread y
else.
  data=. y
end.
if. ((#data) <: 16b36) do.
  raiseError=. 'size error'
  goto_error.
end.
identity=. 2{.data
if. (identity -.@-: 'BM') do.
  raiseError=. 'signiture error'
  goto_error.
end.
data=. 2}.data
size=. fromDWORD0 4{.data
data=. 4}.data
size=. size - 16b36 
size=. size + 16b0c 
data=. 12}.data
'width height'=. fromDWORD0 8{.data
data=. 8}.data
if. (width > 16bffff) do.
  raiseError=. 'bitmap width greater than 65535'
  goto_error.
end.
if. (height > 16bffff) do.
  raiseError=. 'bitmap height greater than 65535'
  goto_error.
end.
planesandbitcount=. fromWORD0 4{.data
data=. 4}.data
if. (24 ~: 1{planesandbitcount) do.  
  raiseError=. 'not 24 bit color'
  goto_error.
end.
if. (1 ~: 0{planesandbitcount) do.
  raiseError=. 'contain more than 1 plane'
  goto_error.
end.
compression=. fromDWORD0 4{.data
data=. 4}.data
if. (compression ~: 0) do.
  raiseError=. 'compression not supported'
  goto_error.
end.
data=. 20}.data
header=. toDWORD0 16b000c
header=. header, toWORD0 width, height, 16b01, 16b18
data=. header, data
0 ; width ; height ; size ; data
return.
label_error.
_1 ; raiseError
)

insertbackground=: 3 : 0
z=. processbitmap y
if. _1=>@{.z do. z return. end.
'width height size data'=. }.z
record=. 16b00e9
if. RECORDLEN>:8 + size do.
  length=. 8 + size
  cf=. 16b09
  env=. 16b01
  lcb=. size
  header=. toWORD0 record, length, cf, env
  header=. header, toDWORD0 lcb
  imdata=: imdata, header, data
else.
  length=. RECORDLEN
  cf=. 16b09
  env=. 16b01
  lcb=. size
  header=. toWORD0 record, length, cf, env
  header=. header, toDWORD0 lcb
  imdata=: imdata, header, (RECORDLEN-8){.data
  data=. (RECORDLEN-8)}.data
  a=. <.(#data) % RECORDLEN
  b=. RECORDLEN | #data
  if. #a do.
    imdata=: imdata,, (toHeader 16b003c, RECORDLEN), "1 (a, RECORDLEN)$(a*RECORDLEN){.data
  end.
  if. #b do.
    imdata=: imdata, (toHeader 16b003c, b), (-b){.data
  end.
end.
0 ; ''
)

adjdim=: 3 : 0
dimensions=: ((1 3{dimensions)>. y) 1 3}dimensions
)

initsheet=: 3 : 0
sheetname=: y
calccount=: 100
calcmode=: 1
refmode=: 1
delta=: 0.001000
iteration=: 0
printheaders=: 0
printgridlines=: 0
defaultrowheightnotmatch=: 1
defaultrowheighthidden=: 0
defaultrowheightspaceabove=: 0
defaultrowheightspacebelow=: 0
defaultrowheight=: 315  
wsbool=: 0
horizontalpagebreaks=: 0 3$''         
verticalpagebreaks=: 0 3$''           
header=: ''  
footer=: 'Page &P of &N'
hcenter=: 0
vcenter=: 0
leftmargin=: 0.5
rightmargin=: 0.5
topmargin=: 0.5
bottommargin=: 0.75
'setuppapersize setupscaling setupstartpage setupfitwidth setupfitheight setuprowmajor setupportrait setupinvalid setupblackwhite setupdraft setupcellnote setuporientinvalid setupusestartpage setupnoteatend setupprinterror setupdpi setupvdpi setupheadermargin setupfootermargin setupnumcopy'=: 0
setuprowmajor=: 1
setupportrait=: 1
setupinvalid=: 1
setupheadermargin=: 0.75
setupfootermargin=: 0.75
backgroundbitmap=: ''
protect=: 1
windowprotect=: 1
objectprotect=: 1
scenprotect=: 1
password=: ''
defaultcolwidth=: 8
colinfoset=: 0 7$''
dimensions=: 0 0 0 0
window2=: 16b6b6 0 0 10
sclnum=: sclden=: 1
'xsplit ysplit topvis leftvis'=: 0
activepane=: ''
mergedcell=: 0 4$''               
rowlabelrange=: collabelrange=: 0 4$''
condformatstream=: ''
selection=: 0 5$''
hlink=: ''
imdata=: ''
dvstream=: ''
colsizes=: 0 2$''
rowsizes=: 0 2$''
)

writestream=: 3 : 0
z=. biff_bof 16b600, 16
p1=. #z
z=. z, biff_index (0 1+2{.dimensions), 0
z=. z, biff_calccount calccount
z=. z, biff_calcmode calcmode
z=. z, biff_refmode refmode
z=. z, biff_delta delta
z=. z, biff_iteration iteration
z=. z, biff_printheaders printheaders
z=. z, biff_printgridlines printgridlines
z=. z, biff_defaultrowheight defaultrowheightnotmatch, defaultrowheighthidden, defaultrowheightspaceabove, defaultrowheightspacebelow, defaultrowheight
z=. z, biff_wsbool wsbool
z=. z, biff_horizontalpagebreaks horizontalpagebreaks
z=. z, biff_verticalpagebreaks verticalpagebreaks
z=. z, biff_header header
z=. z, biff_footer footer
z=. z, biff_hcenter hcenter
z=. z, biff_vcenter vcenter
z=. z, biff_leftmargin leftmargin
z=. z, biff_rightmargin rightmargin
z=. z, biff_topmargin topmargin
z=. z, biff_bottommargin bottommargin
z=. z, biff_setup setuppapersize ; setupscaling ; setupstartpage ; setupfitwidth ; setupfitheight ; setuprowmajor ; setupportrait ; setupinvalid ; setupblackwhite ; setupdraft ; setupcellnote ; setuporientinvalid ; setupusestartpage ; setupnoteatend ; setupprinterror ; setupdpi ; setupvdpi ; setupheadermargin ; setupfootermargin ; setupnumcopy
z=. z, backgroundbitmap
if. (#password) *. protect +. windowprotect +. objectprotect +. scenprotect do.
  if. protect do. z=. z, biff_protect protect end.
  if. windowprotect do. z=. z, biff_windowprotect windowprotect end.
  if. objectprotect do. z=. z, biff_objectprotect objectprotect end.
  if. scenprotect do. z=. z, biff_scenprotect scenprotect end.
  z=. z, biff_password passwordhash password
end.
p2=. #z
z=. (toDWORD0 p2+y) (p1+16+i.4)}z
z=. z, biff_defaultcolwidth defaultcolwidth
for_item. colinfoset do. z=. z, ({.item) biff_colinfo }.item end.
z=. z, biff_dimensions dimensions
z=. z, stream, imdata
z=. z, biff_window2 window2
z=. z, biff_scl sclnum, sclden
if. #activepane do. z=. z, biff_pane (xsplit, ysplit) ; (topvis, leftvis) ; activepane end.
if. #selection do. z=. z, biff_selection selection end.
if. (2:~:$$) mergedcell do. mergedcell=: _4]\, mergedcell end.
z=. z, biff_mergedcells mergedcell
z=. z, biff_labelranges rowlabelrange ; collabelrange
z=. z, condformatstream
for_item. hlink do. z=. z, (>{.item) biff_hlink }.item end.
z=. z, dvstream
z=. z, biff_eof ''
)
passwordhash=: 3 : 0
pw=. (15<.#y){.y
hash=. 0 [ i=. 0
while. i<#pw do.
  c=. 3&u: u: i{pw
  i=. >:i
  hash=. hash bitxor #. i&|. _15{.#: c
end.
hash=. 16bce4b bitxor (#pw) bitxor hash
)

create=: 3 : 0
stream=: ''
initsheet y
)

destroy=: codestroy

coclass 'biffbook'
coinsert 'oleutlfcn'
coinsert 'biff'
getxfobj=: 3 : 0
z=. _1  
if. ''-:y do.
  z=. cxf
else.
  if. (3!:0 y) e. 32 do.
    z=. y
  elseif. (3!:0 y) e. 1 4 do.
    if. 1=#y do.
      z=. addxfobj ({.y){xfset
    elseif. (}.$xfset)-:$y do.
      if. (#xfset)= n=. xfset i. y do.
        xfset=: xfset, y
      end.
      z=. addxfobj n{xfset
    end.
  end.
end.
z
)

getxfidx=: 3 : 0
rc=. 0
if. ''-:y do. y=. cxf end.
if. (3!:0 y) e. 32 do.
  l=. y
  if. (#xfset)= n=. xfset i. a=. getxfrow__l '' do.
    xfset=: xfset, a
    xfindex__l=: n
  end.
  rc=. n
elseif. (3!:0 y) e. 1 4 do.
  if. 1=#y do.
    rc=. {.y
  elseif. (}.$xfset)-:$y do.
    if. (#xfset)= n=. xfset i. y do.
      xfset=: xfset, y
    end.
    rc=. n
  end.
end.
rc
)

add2sst=: 3 : 0
sstn=: >:sstn
if. (#sst) = b=. sst i. y do. sst=: sst, y end.
b
)

WriteSST=: 3 : 0
sstbuf=: (toWORD0 16b00fc, 0), toDWORD0 sstn, #sst
wrtp=: 0 [ bufn=: RECORDLEN-8
for_ix. sst do.
  oix=. >ix
  if. 131072= 3!:0 oix do.
    if. bufn<5 do. wrtcont'' end.
    wrtn #oix
    wrtw oix
  else.
    if. bufn<4 do. wrtcont'' end.
    wrtn #oix
    wrt oix
  end.
end.
sstbuf=: (toWORD0 RECORDLEN-bufn) (wrtp+2+i.2)}sstbuf
)

wrtn=: 3 : 0
sstbuf=: sstbuf, toWORD0 y
bufn=: bufn-2
)

wrtw=: 3 : 0
while. #y do.
  if. bufn<1+2*#y do.
    sstbuf=: sstbuf, (1{a.), toucode0 (<.-:bufn-1){.y
    y=. (<.-:bufn-1)}.y
    bufn=: bufn - 1+ 2*(<.-:bufn-1)
    wrtcont''
  else.
    sstbuf=: sstbuf, (1{a.), toucode0 y
    bufn=: bufn - 1+2*#y
    y=. ''
  end.
end.
)

wrt=: 3 : 0
while. #y do.
  if. bufn<1+#y do.
    sstbuf=: sstbuf, (0{a.), (bufn-1){.y
    y=. (bufn-1)}.y
    bufn=: bufn - 1+ bufn-1
    wrtcont''
  else.
    sstbuf=: sstbuf, (0{a.), y
    bufn=: bufn - 1+#y
    y=. ''
  end.
end.
)

wrtcont=: 3 : 0
sstbuf=: (toWORD0 RECORDLEN-bufn) (wrtp+2+i.2)}sstbuf
wrtp=: #sstbuf
sstbuf=: sstbuf, toWORD0 16b003c, 0
bufn=: RECORDLEN
)

initbook=: 3 : 0
fileprotectionstream=: ''
workbookprotectionstream=: ''
codepage=: 1200
window1=: 672 192 11004 6636 16b38
backup=: 0
hideobj=: 0
date1904=: 0
precision=: 1
bookbool=: 1
fontset=: 0 10$''
fontset=: fontset, fontsize ; 0 ; 0 ; colorfont ; 400 ; 0 ; 0 ; 0 ; 0 ; fontname     
fontset=: fontset, fontsize ; 0 ; 0 ; colorfont ; 400 ; 0 ; 0 ; 0 ; 0 ; fontname     
fontset=: fontset, fontsize ; 0 ; 0 ; colorfont ; 400 ; 0 ; 0 ; 0 ; 0 ; fontname     
fontset=: fontset, fontsize ; 0 ; 0 ; colorfont ; 400 ; 0 ; 0 ; 0 ; 0 ; fontname     
fontset=: fontset, fontsize ; 0 ; 0 ; colorfont ; 400 ; 0 ; 0 ; 0 ; 0 ; fontname     
fontset=: fontset, fontsize ; 0 ; 0 ; colorfont ; 400 ; 0 ; 0 ; 0 ; 0 ; fontname     
formatset=: format0n#a:
formatset=: ('General';'0';'0.00';'#,##0';'#,##0.00';'"$"#,##0_); ("$"#,##0)';'"$"#,##0_);[Red] ("$"#,##0)';'"$"#,##0.00_); ("$"#,##0.00)';'"$"#,##0.00_);[Red] ("$"#,##0.00)';'0%';'0.00%';'0.00E+00';'# ?/?';'# ??/??';'M/D/YY';'D-MMM-YY';'D-MMM';'MMM-YY';'h:mm AM/PM';'h:mm:ss AM/PM';'h:mm';'h:mm:ss';'M/D/YY h:mm') (i.23) } formatset
formatset=: ('_(#,##0_);(#,##0)';'_(#,##0_);[Red](#,##0)';'_(#,##0.00_);(#,##0.00)';'_(#,##0.00_);[Red](#,##0.00)';'_ ("$"* #,##0_);_ ("$"* (#,##0);_ ("$"* "-"_);_(@_)';'_(* #,##0_);_(* (#,##0);_(* "-"_);_(@_)';'_ ("$"* #,##0.00_);_ ("$"* (#,##0.00);_ ("$"* "-"??_);_(@_)';'_(* #,##0.00_);_(* (#,##0.00);_(* "-"??_);_(@_)';'mm:ss';'[h]:mm:ss';'mm:ss.0';'##0.0E+0';'@') (37+i.13)}formatset
formatset=: formatset, 'd/m/yyyy';'#,##0.000';'#,##0.0000';'#,##0.000000000'
xfset=: 0 10$''
xfset=: xfset, 0 0 16bfff5 16b20 0 0 0 0 0 16b20c0 
xfset=: xfset, 1 0 16bfff5 16b20 0 0 16bf4 0 0 16b20c0 
xfset=: xfset, 1 0 16bfff5 16b20 0 0 16bf4 0 0 16b20c0
xfset=: xfset, 2 0 16bfff5 16b20 0 0 16bf4 0 0 16b20c0
xfset=: xfset, 2 0 16bfff5 16b20 0 0 16bf4 0 0 16b20c0
xfset=: xfset, 0 0 16bfff5 16b20 0 0 16bf4 0 0 16b20c0
xfset=: xfset, 0 0 16bfff5 16b20 0 0 16bf4 0 0 16b20c0
xfset=: xfset, 0 0 16bfff5 16b20 0 0 16bf4 0 0 16b20c0
xfset=: xfset, 0 0 16bfff5 16b20 0 0 16bf4 0 0 16b20c0
xfset=: xfset, 0 0 16bfff5 16b20 0 0 16bf4 0 0 16b20c0
xfset=: xfset, 0 0 16bfff5 16b20 0 0 16bf4 0 0 16b20c0
xfset=: xfset, 0 0 16bfff5 16b20 0 0 16bf4 0 0 16b20c0
xfset=: xfset, 0 0 16bfff5 16b20 0 0 16bf4 0 0 16b20c0
xfset=: xfset, 0 0 16bfff5 16b20 0 0 16bf4 0 0 16b20c0
xfset=: xfset, 0 0 16bfff5 16b20 0 0 16bf4 0 0 16b20c0
xfset=: xfset, 0 0 1 16b20 0 0 0 0 0 16b20c0 
xfset=: xfset, 1 16b2b 16bfff5 16b20 0 0 16bf8 0 0 16b20c0 
xfset=: xfset, 1 16b29 16bfff5 16b20 0 0 16bf8 0 0 16b20c0
xfset=: xfset, 1 16b2c 16bfff5 16b20 0 0 16bf8 0 0 16b20c0
xfset=: xfset, 1 16b2a 16bfff5 16b20 0 0 16bf8 0 0 16b20c0
xfset=: xfset, 1 9 16bfff5 16b20 0 0 16bf8 0 0 16b20c0
biffxfset=: ''
styleset=: 0 5$''
styleset=: styleset, 16b10 ; 1 ; 3 ; 16bff ; ''
styleset=: styleset, 16b11 ; 1 ; 6 ; 16bff ; ''
styleset=: styleset, 16b12 ; 1 ; 4 ; 16bff ; ''
styleset=: styleset, 16b13 ; 1 ; 7 ; 16bff ; ''
styleset=: styleset, 16b00 ; 1 ; 0 ; 16bff ; ''
styleset=: styleset, 16b14 ; 1 ; 5 ; 16bff ; ''
colorset=: 0 16bffffff 16bff 16bff00 16bff0000 16bffff 16bff00ff 16bffff00
colorset=: colorset, RGB 16b00 16b00 16b00  
colorset=: colorset, RGB 16bff 16bff 16bff  
colorset=: colorset, RGB 16bff 16b00 16b00  
colorset=: colorset, RGB 16b00 16bff 16b00  
colorset=: colorset, RGB 16b00 16b00 16bff  
colorset=: colorset, RGB 16bff 16bff 16b00  
colorset=: colorset, RGB 16bff 16b00 16bff  
colorset=: colorset, RGB 16b00 16bff 16bff  
colorset=: colorset, RGB 16b80 16b00 16b00  
colorset=: colorset, RGB 16b00 16b80 16b00  
colorset=: colorset, RGB 16b00 16b00 16b80  
colorset=: colorset, RGB 16b80 16b80 16b00  
colorset=: colorset, RGB 16b80 16b00 16b80  
colorset=: colorset, RGB 16b00 16b80 16b80  
colorset=: colorset, RGB 16bc0 16bc0 16bc0  
colorset=: colorset, RGB 16b80 16b80 16b80  
colorset=: colorset, RGB 16b99 16b99 16bff  
colorset=: colorset, RGB 16b99 16b33 16b66  
colorset=: colorset, RGB 16bff 16bff 16bcc  
colorset=: colorset, RGB 16bcc 16bff 16bff  
colorset=: colorset, RGB 16b66 16b00 16b66  
colorset=: colorset, RGB 16bff 16b80 16b80  
colorset=: colorset, RGB 16b00 16b66 16bcc  
colorset=: colorset, RGB 16bcc 16bcc 16bff  
colorset=: colorset, RGB 16b00 16b00 16b80  
colorset=: colorset, RGB 16bff 16b00 16bff  
colorset=: colorset, RGB 16bff 16bff 16b00  
colorset=: colorset, RGB 16b00 16bff 16bff  
colorset=: colorset, RGB 16b80 16b00 16b80  
colorset=: colorset, RGB 16b80 16b00 16b00  
colorset=: colorset, RGB 16b00 16b80 16b80  
colorset=: colorset, RGB 16b00 16b00 16bff  
colorset=: colorset, RGB 16b00 16bcc 16bff  
colorset=: colorset, RGB 16bcc 16bff 16bff  
colorset=: colorset, RGB 16bcc 16bff 16bcc  
colorset=: colorset, RGB 16bff 16bff 16b99  
colorset=: colorset, RGB 16b99 16bcc 16bff  
colorset=: colorset, RGB 16bff 16b99 16bcc  
colorset=: colorset, RGB 16bcc 16b99 16bff  
colorset=: colorset, RGB 16bff 16bcc 16b99  
colorset=: colorset, RGB 16b33 16b66 16bff  
colorset=: colorset, RGB 16b33 16bcc 16bcc  
colorset=: colorset, RGB 16b99 16bcc 16b00  
colorset=: colorset, RGB 16bff 16bcc 16b00  
colorset=: colorset, RGB 16bff 16b99 16b00  
colorset=: colorset, RGB 16bff 16b66 16b00  
colorset=: colorset, RGB 16b66 16b66 16b99  
colorset=: colorset, RGB 16b96 16b96 16b96  
colorset=: colorset, RGB 16b00 16b33 16b66  
colorset=: colorset, RGB 16b33 16b99 16b66  
colorset=: colorset, RGB 16b00 16b33 16b00  
colorset=: colorset, RGB 16b33 16b33 16b00  
colorset=: colorset, RGB 16b99 16b33 16b00  
colorset=: colorset, RGB 16b99 16b33 16b66  
colorset=: colorset, RGB 16b33 16b33 16b99  
colorset=: colorset, RGB 16b33 16b33 16b33  
country=: 1 1
supbook=: ''
externsheet=: 0 3$''
extname=: ''
refname=: ''
)

addhlink=: 3 : 0
l=. sheeti{sheet
hlink__l=: hlink__l, y
)

writefileprotection=: 3 : 0
fileprotectionstream=: y
)

writeworkbookprotection=: 3 : 0
workbookprotectionstream=: y
)

writecelltable=: 3 : 0
l=. sheeti{sheet
stream__l=: stream__l, y
)

writecondformattable=: 3 : 0
l=. sheeti{sheet
condformatstream__l=: y
)

writedvtable=: 3 : 0
l=. sheeti{sheet
dvstream__l=: y
)

celladr=: 4 : 0
'relrow relcol'=. x
'row col'=. y
z=. toWORD0 row
z=. z, toWORD0 (16bff bitand col) bitor 14 bitshl (0~:relcol) bitor 1 bitshl 0~:relrow
)

cellrangeadr=: 4 : 0
'relrow1 relrow2 relcol1 relcol2'=. x
'row1 row2 col1 col2'=. y
z=. toWORD0 row1, row2
z=. z, toWORD0 (16bff bitand col1) bitor 14 bitshl (0~:relcol1) bitor 1 bitshl 0~:relrow1
z=. z, toWORD0 (16bff bitand col2) bitor 14 bitshl (0~:relcol2) bitor 1 bitshl 0~:relrow2
)

newsupbook=: 3 : 0
supbook=: supbook, y conew 'biffsupbook'
supbooki=: <:#supbook
)

newrefname=: 3 : 0
refname=: refname, '' conew 'biffrefname'
{:refname
)

newextname=: 3 : 0
l=. supbooki{supbook
newextname__l y
)

newcrn=: 3 : 0
l=. supbooki{supbook
newcrn__l y
)

create=: 3 : 0
if. ''-:y do.
  'fontname fontsize'=: 'Courier New' ; 220
  sheetname=. 'Sheet1'
else.
  'fontname fontsize'=: 2{.y
  sheetname=. ('' -: sheetname) >@{ (sheetname=. >{.2}.y) ; 'Sheet1'
end.
sstn=: #sst=: ''
xfset=: sheet=: ''
initbook ''
addsheet sheetname  
cxf=: addxfobj 15{xfset  
)

destroy=: 3 : 0
for_l. sheet do. destroy__l '' end.
for_l. biffxfset do. destroy__l '' end.
for_l. supbook do. destroy__l '' end.
for_l. refname do. destroy__l '' end.
codestroy ''
)
rgbcolor=: 3 : 0
(i: <./) +/"1 | y -"1 RGBtuple colorset
)
addxfobj=: 3 : 0
biffxfset=: biffxfset, z=. y conew 'biffxf'
z
)
addsheet=: 3 : 0
sheet=: sheet, ((y-:'') >@{ y ; 'Sheet', ": >:#sheet) conew 'biffsheet'
sheeti=: <:#sheet
)
save=: 3 : 0
fn=. >y
z=. biff_bof 16b600, 5
z=. z, fileprotectionstream
z=. z, biff_codepage codepage
z=. z, workbookprotectionstream
z=. z, biff_window1 window1
z=. z, biff_backup backup
z=. z, biff_hideobj hideobj
z=. z, biff_date1904 date1904
z=. z, biff_precision precision
z=. z, biff_bookbool bookbool
fontset1=. (4{.fontset), 5}.fontset
for_item. fontset1 do. z=. z, biff_font item end.
if. 164<#formatset do.
  for_i. i.164-~#formatset do. z=. z, biff_format (i+164) ; (i+164){formatset end.
end.
for_item. xfset do. z=. z, biff_xf item end.
for_item. styleset do. z=. z, (>{.item) biff_style }.item end.
if. 8<#colorset do.
  z=. z, biff_palette 8}.colorset
end.
olesheet=. ''
olehead=. z
seekpoint=. #z
z=. ''
for_item. sheet do.
  z=. z, a=. biff_boundsheet 0 ; 0 ; 0 ; sheetname__item
  seekpoint=. seekpoint, #a
end.
z=. z, biff_country country
z=. z, WriteSST ''
if. #supbook do.
  for_item. supbook do.
    z=. z, writestream__item #sheet
  end.
  z=. z, biff_externsheet externsheet
  for_item. refname do.
    z=. z, writestream__item ''
  end.
end.
z=. z, biff_eof ''
olehead=. olehead, z
sheetoffset=. ({.seekpoint)+ #z
for_item. sheet do.
  z=. writestream__item {:sheetoffset
  olesheet=. olesheet, z
  sheetoffset=. sheetoffset, #z
end.
seekpoint=. }:+/\seekpoint
sheetoffset=. }:+/\sheetoffset
for_i. i.#seekpoint do.
  p1=. 4+i{seekpoint
  p2=. 0
  z=. toDWORD0 i{sheetoffset
  olehead=. z (p1+i.4)}olehead
end.
stream=. ('Workbook' ; '' ; '') conew 'oleppsfile'
append__stream olehead
append__stream olesheet
root=. (0 ; 0 ; <stream) conew 'oleppsroot'
rc=. save__root fn ; 0 ; ''
destroy__root ''
destroy__stream ''
rc
)
addcolinfo=: 3 : 0
cxf addcolinfo y
:
'col1 col2 width hide level collapse'=. 6{.y
l=. sheeti{sheet
colsizes__l=: ~. colsizes__l, (col1 + i.>:col2-col1), "0 (0~:hide){width, 0
colinfoset__l=: colinfoset__l, (getxfidx x), col1, col2, width, hide, level, collapse
''
)
addrowinfo=: 3 : 0
cxf addrowinfo y
:
'rownumber firstcol lastcols usedefaultheight rowheight'=. 5{. y=. 12{.y
l=. sheeti{sheet
if. 0=usedefaultheight do.
  rowsizes__l=: ~. rowsizes__l, rownumber, rowheight
end.
stream__l=: stream__l, (getxfidx x) biff_row y
''
)
writestring=: 3 : 0
cxf writestring y
:
assert. 2=#y
assert. 1 2 4 8 131072 e.~ 3!:0 >@{.y
assert. 2 32 131072 e.~ 3!:0 >1{y
if. 2 131072 e.~ 3!:0 rc=. >@{.y do. y=. (<A1toRC rc) 0}y end.
l=. sheeti{sheet
xf=. getxfidx x
if. (0=#@, yn) +. 2 131072 e.~ 3!:0 yn=. >1{y do.
  if. 2> $$yn do.
    adjdim__l >@{.y
    stream__l=: stream__l, xf biff_label y
  elseif. 2=$$yn do.
    'r c'=. >@{.y
    'nrow len'=. $yn
    adjdim__l >@{.y
    adjdim__l (nrow, 0)+>@{.y
    if. 0=len do.
      stream__l=: stream__l,, (toHeader 16b0201, 6), "1 (_2]\ toWORD0 r+i.nrow), "1 (_2]\ toWORD0 nrow#c), "1 (toWORD0 xf)
    else.
      yn=. <"1 yn
      sst=: sst, (~.yn) -. sst
      sstn=: sstn + #yn
      stream__l=: stream__l,, (toHeader 16b00fd, 10), "1 (_2]\ toWORD0 r+i.nrow), "1 (_2]\ toWORD0 nrow#c), "1 (toWORD0 xf), "1 (_4]\ toDWORD0 sst i. yn)
    end.
  elseif. do. 'unhandled exception' 13!:8 (3)
  end.
elseif. 32 e.~ 3!:0 yn do.
  if. (0:=#), yn do. '' return.  
  elseif. 1=#@, yn do.  
    adjdim__l >@{.y
    stream__l=: stream__l, xf biff_label ({.y), <, >yn
  elseif. 3>$$yn do.
    if. 1=$$yn do. yn=. ,:yn end.
    'r c'=. >@{.y
    adjdim__l >@{.y
    adjdim__l (s=. $yn)+>@{.y
    if. #a=. bx > ''&-:&.> yn=. , yn do.
      yn=. ((#a)#<, ' ') a}yn   
    end.
    sst=: sst, (~.yn) -. sst
    sstn=: sstn + #yn
    stream__l=: stream__l,, (toHeader 16b00fd, 10), "1 (_2]\ toWORD0 ({:s)#r+i.{.s), "1 (_2]\ toWORD0, ({.s)#,:c+i.{:s), "1 (toWORD0 xf), "1 (_4]\ toDWORD0 sst i. yn)
  elseif. do. 'unhandled exception' 13!:8 (3)
  end.
elseif. do. 'unhandled exception' 13!:8 (3)
end.
''
)
writeinteger=: 3 : 0
cxf writeinteger y
:
assert. 2=#y
assert. 1 2 4 8 131072 e.~ 3!:0 >@{.y
assert. 1 4 8 e.~ 3!:0 >1{y
if. 2 131072 e.~ 3!:0 rc=. >@{.y do. y=. (<A1toRC rc) 0}y end.
l=. sheeti{sheet
xf=. getxfidx x
if. 536870911 < >./ |, >1{y do. x writenumber y end.
if. (0:=#), yn=. 2b10 bitor 2 bitshl <. >1{y do. '' return. end.  
if. 1=#@, yn do.  
  adjdim__l >@{.y
  stream__l=: stream__l, xf biff_integer ({.y), < {., >1{y
elseif. 3>$$yn do.
  if. 1=$$yn do. yn=. ,:yn end.
  'r c'=. >@{.y
  adjdim__l >@{.y
  adjdim__l (s=. $yn)+>@{.y
  stream__l=: stream__l,, (toHeader 16b027e, 10), "1 (_2]\ toWORD0 ({:s)#r+i.{.s), "1 (_2]\ toWORD0, ({.s)#,:c+i.{:s), "1 (toWORD0 xf), "1 (_4]\ toDWORD0, yn)
elseif. do. 'unhandled exception' 13!:8 (3)
end.
''
)
writenumber=: 3 : 0
cxf writenumber y
:
assert. 2=#y
assert. 1 2 4 8 131072 e.~ 3!:0 >@{.y
assert. 1 4 8 e.~ 3!:0 >1{y
if. 2 131072 e.~ 3!:0 rc=. >@{.y do. y=. (<A1toRC rc) 0}y end.
l=. sheeti{sheet
xf=. getxfidx x
if. (0:=#), yn=. >1{y do. '' return. end.  
if. 1=#@, yn do.  
  adjdim__l >@{.y
  stream__l=: stream__l, xf biff_number ({.y), < {., yn
elseif. 3>$$yn do.
  if. 1=$$yn do. yn=. ,:yn end.
  'r c'=. >@{.y
  adjdim__l >@{.y
  adjdim__l (s=. $yn)+>@{.y
  stream__l=: stream__l,, (toHeader 16b0203, 14), "1 (_2]\ toWORD0 ({:s)#r+i.{.s), "1 (_2]\ toWORD0, ({.s)#,:c+i.{:s), "1 (toWORD0 xf), "1 (_8]\ toDouble0, yn)
elseif. do. 'unhandled exception' 13!:8 (3)
end.
''
)
writenumber2=: 3 : 0
cxf writenumber2 y
:
assert. 3=#y
assert. 1 2 4 8 131072 e.~ 3!:0 >@{.y
assert. 1 4 8 e.~ 3!:0 >1{y
assert. 2 131072 e.~ 3!:0 >2{y
if. 2 131072 e.~ 3!:0 rc=. >@{.y do. y=. (<A1toRC rc) 0}y end.
l=. getxfobj x
t=. format__l
format__l=: >{:y
if. 8= 3!:0 >1{y do.
  l writenumber 2{.y
else.
  l writeinteger 2{.y
end.
format__l=: t
''
)
writedate=: 3 : 0
cxf writedate y
:
assert. 2 3 e.~ #y
assert. 1 2 4 8 131072 e.~ 3!:0 >@{.y
assert. 1 4 8 e.~ 3!:0 >1{y
if. 2 131072 e.~ 3!:0 rc=. >@{.y do. y=. (<A1toRC rc) 0}y end.
l=. getxfobj x
t=. format__l
if. 2=#y do. y=. y, <'dd/mm/yyyy' end. 
assert. 2 131072 e.~ 3!:0 >2{y
format__l=: >2{y
l writenumber ({.y), <36522-~ >1{y
format__l=: t
''
)
insertpicture=: 4 : 0
l=. sheeti{sheet
x insertpicture__l y
)
insertbackground=: 3 : 0
l=. sheeti{sheet
insertbackground__l y
)
printarea=: 4 : 0
if. _1=x do.
  x=. newsupbook 'internal' ; #sheet
end.
externsheet=: externsheet, x, 0 0
r=. newrefname ''
builtin__r=: 1
name__r=: 16b06{a.
sheet__r=: 0
formula__r=: (a.{~16b3b 0 0), (0 0 0 0 cellrangeadr y)
x
)
rowrepeat=: 4 : 0
if. _1=x do.
  x=. newsupbook 'internal' ; #sheet
end.
externsheet=: externsheet, x, 0 0
r=. newrefname ''
builtin__r=: 1
name__r=: 16b07{a.
sheet__r=: {.y
formula__r=: (a.{~16b3b 0 0), 0 0 0 0 cellrangeadr, (}.y), 0 255
x
)
colrepeat=: 4 : 0
if. _1=x do.
  x=. newsupbook 'internal' ; #sheet
end.
externsheet=: externsheet, x, 0 0
r=. newrefname ''
builtin__r=: 1
name__r=: 16b07{a.
sheet__r=: {.y
formula__r=: (a.{~16b3b 0 0), 0 0 0 0 cellrangeadr 0 16bffff, (}.y)
x
)
rowcolrepeat=: 4 : 0
if. _1=x do.
  x=. newsupbook 'internal' ; #sheet
end.
externsheet=: externsheet, x, 0 0
r=. newrefname ''
builtin__r=: 1
name__r=: 16b07{a.
sheet__r=: {.y
formula__r=: (16b29{a.), (toWORD0@# , ]) ((a.{~16b3b 0 0), 0 0 0 0 cellrangeadr 0 16bffff, (>_2{.}.y)), ((a.{~16b3b 0 0), 0 0 0 0 cellrangeadr, (>2{.}.y), 0 255), (16b10{a.)
x
)
coclass 'biffread'
coinsert 'oleutlfcn'
create=: 4 : 0
debug=: x
stream=: y
biffver=: 0        
streamtype=: 16    
filepos=: 0
worksheets=: 0 2$''
bkrecords=: 0 3$'' [ bkbytes=: ''   
records=: 0 3$'' [ bytes=: ''       
sst=: ''
bnsst=: nsst=: 0  
sstchar=: 0
sstrtffe=: 0
insst=. 0
type=. _1
newptr=. 0
while. (type~:10)*.filepos<#stream do.
  'type ptr len'=. nextrecord ''
  if. debug do.
    bkbytes=: bkbytes, (ptr+i.len){stream
    newptr=. newptr+len [ bkrecords=: bkrecords, type, newptr, len
  end.
  if. 16b9=type do.        
    biffver=: 16b200 break.
  elseif. 16b209=type do.  
    biffver=: 16b300 break.
  elseif. 16b409=type do.  
    biffver=: 16b400 break.
  elseif. 16b809=type do.  
    if. 0=biffver do.  
      'biffver streamtype'=: fromWORD0 4{.data=. (ptr+i.len){stream
    end.
  elseif. 16b0085=type do.  
    if. 0={.fromBYTE 5{data=. (ptr+i.len){stream do.
      if. 16b500=biffver do.
        worksheets=: worksheets, (>@{. 0 decodestring8 6}.data) ; {.(fromDWORD0 4{.data)
      else.
        worksheets=: worksheets, (>@{. 0 decodeustring8 6}.data) ; {.(fromDWORD0 4{.data)
      end.
    end.
  elseif. 16b00fc=type do.  
    'bnsst nsst'=: fromDWORD0 8{.data=. (ptr+i.len){stream
    readsst 8}.data
    insst=. 1
  elseif. insst *. 16b003c=type do. 
    readsst data=. (ptr+i.len){stream
  elseif. do.
    insst=. 0
  end.
end.
if. #sst do. sst=: <;._2 sst end.
assert. nsst=#sst
assert. 0~:biffver
)

destroy=: codestroy
readsst=: 3 : 0
fp=. 0
while. fp<#y do.
  if. 0=sstchar+sstrtffe do.
    't t1'=. fp decodeustring16 y
    sst=: sst, t, {.a.
    fp=. fp + a [ 'a b c'=. t1
    sstchar=: b-#t
    sstrtffe=: c
  else.
    't t1'=. (fp, sstchar, sstrtffe) decodeustring16a y
    sst=: (}:sst), t, {.a.
    fp=. fp + a [ 'a b c'=. t1
    sstchar=: sstchar-#t
    sstrtffe=: c
  end.
end.
)
nextrecord=: 3 : 0
'type len'=. fromWORD0 (filepos+i.4){stream
filepos=: +/data=. (4+filepos), len
type, data
)
decodestring8=: 4 : 0
len=. {.fromBYTE (x+0){y
< len (([ <. #@]) {. ]) (x+1)}.y
)

decodestring16=: 4 : 0
len=. {.fromWORD0 (x+i.2){y
< len (([ <. #@]) {. ]) (x+2)}.y
)
decodeustring8=: 4 : 0
len=. {.fromBYTE (x+0){y
uc=. 0~:1 bitand op=. {.fromBYTE (x+1){y
fe=. 0~:4 bitand op
rtf=. 0~:8 bitand op
if. uc do.
  < fromucode0 (2*len) (([ <. #@]) {. ]) (x+2+(fe*4)+(rtf*2))}.y
else.
  < len (([ <. #@]) {. ]) (x+2+(fe*4)+(rtf*2))}.y
end.
)

decodeustring16=: 4 : 0
len=. {.fromWORD0 (x+i.2){y
uc=. 0~:1 bitand op=. {.fromBYTE (x+2){y  
fe=. 0~:4 bitand op                         
rtf=. 0~:8 bitand op                        
lenrtffe=. 0
if. rtf do. lenrtffe=. 4* {.fromWORD0 ((x+3)+i.2){y end.
if. fe do. lenrtffe=. lenrtffe + {.fromDWORD0 ((x+3+(rtf*2))+i.4){y end.
l=. (3+(fe*4)+(rtf*2)) + (len*uc{1 2) + lenrtffe  
if. uc do.
  z=. fromucode0 z1=. (2*len) (([ <. #@]) {. ]) (x+3+(fe*4)+(rtf*2))}.y
  z2=. (2*len)-#z1  
else.
  z=. z1=. len (([ <. #@]) {. ]) (x+3+(fe*4)+(rtf*2))}.y
  z2=. len-#z1  
end.
if. (#y)<x+l do.
  z ; (#y), len, (x+l)-z2+#y
else.
  z ; l, len, 0
end.
)
decodeustring16a=: 4 : 0
'x len lenrtffe'=. x
if. len do.
  uc=. 0~:1 bitand op=. {.fromBYTE (x+0){y
  l=. 1 + (len*uc{1 2) + lenrtffe  
  if. uc do.
    z=. fromucode0 z1=. (2*len) (([ <. #@]) {. ]) (x+1)}.y
    z2=. (2*len)-#z1    
  else.
    z=. z1=. len (([ <. #@]) {. ]) (x+1)}.y
    z2=. len-#z1  
  end.
else.
  l=. lenrtffe  
  z=. ''
  z2=. 0
end.
if. (#y)<x+l do.
  z ; (#y), len, (x+l)-z2+#y
else.
  z ; l, len, 0
end.
)
readsheet=: 0&$: : (4 : 0)
if. 16b200 16b300 16b400 e.~ biffver do.  
  filepos=: 0
  scnt=. _1
  sheetfound=. 0
else.
  filepos=: y
  sheetfound=. 1
end.
rowcolss=. rowcol=. rowcol4=. rowcol8=. rowcolc=. 0 2$''
cellvalss=. cellval=. cellval4=. cellval8=. cellvalc=. ''
null=. {.a.
type=. _1
records=: 0 3$'' [ bytes=: ''       
newptr=. 0
lookstr=. 0
while. filepos<#stream do.
  'type ptr len'=. nextrecord ''
  if. debug do.
    bytes=: bytes, (ptr+i.len){stream
    newptr=. newptr+len [ records=: records, type, newptr, len
  end.
  if. 0=sheetfound do.  
    if. 16b0009 16b0209 16b0409 e.~ type do.  
      if. 16b10= fromWORD0 (2+ptr+i.2){stream do.  
        if. y = scnt=. >:scnt do.         
          sheetfound=. 1
        end.
      end.
    end.
    continue.
  end.
  select. type
  case. 16b000a do. 
    break.
  case. 16b027e do. 
    if. 0=x do.
      if. 8=3!:0 a=. >getrk 4}.data=. (ptr+i.len){stream do.
        rowcol8=. rowcol8, fromWORD0 4{.data
        cellval8=. cellval8, a
      else.
        rowcol4=. rowcol4, fromWORD0 4{.data
        cellval4=. cellval4, a
      end.
    else.
      rowcol=. rowcol, fromWORD0 4{.data=. (ptr+i.len){stream
      cellval=. cellval, ; null&,@ (":(!.maxpp))&.> getrk 4}.data   
    end.
  case. 16b0002 do. 
    if. 0=x do.
      rowcol4=. rowcol4, fromWORD0 4{.data=. (ptr+i.len){stream
      cellval4=. cellval4, {.fromDWORD0 (2#{.a.),~ (7+i.2){data
    else.
      rowcol=. rowcol, fromWORD0 4{.data=. (ptr+i.len){stream
      cellval=. cellval, null&,@ (":(!.maxpp)) {.fromDWORD0 (2#{.a.),~ (7+i.2){data
    end.
  case. 16b0003 do. 
    if. 0=x do.
      rowcol8=. rowcol8, fromWORD0 4{.data=. (ptr+i.len){stream
      cellval8=. cellval8, {.fromDouble0 (7+i.8){data
    else.
      rowcol=. rowcol, fromWORD0 4{.data=. (ptr+i.len){stream
      cellval=. cellval, null&,@ (":(!.maxpp)) {.fromDouble0 (7+i.8){data
    end.
  case. 16b0203 do. 
    if. 0=x do.
      rowcol8=. rowcol8, fromWORD0 4{.data=. (ptr+i.len){stream
      cellval8=. cellval8, {.fromDouble0 (6+i.8){data
    else.
      rowcol=. rowcol, fromWORD0 4{.data=. (ptr+i.len){stream
      cellval=. cellval, null&,@ (":(!.maxpp)) {.fromDouble0 (6+i.8){data
    end.
  case. 16b00fd do. 
    rowcolss=. rowcolss, fromWORD0 4{.data=. (ptr+i.len){stream
    cellvalss=. cellvalss, fromDWORD0 (6+i.4){data
  case. 16b0005 do. 
    if. ({.a.)=(8+ptr){stream do. 
      if. 0=x do.
        rowcol4=. rowcol4, fromWORD0 4{.data=. (ptr+i.len){stream
        cellval4=. cellval4, ({.a.)~:7{data
      else.
        rowcol=. rowcol, fromWORD0 4{.data=. (ptr+i.len){stream
        cellval=. cellval, null&,@ (":(!.maxpp)) ({.a.)~:7{data
      end.
    end.
  case. 16b0205 do. 
    if. ({.a.)=(7+ptr){stream do. 
      if. 0=x do.
        rowcol4=. rowcol4, fromWORD0 4{.data=. (ptr+i.len){stream
        cellval4=. cellval4, ({.a.)~:6{data
      else.
        rowcol=. rowcol, fromWORD0 4{.data=. (ptr+i.len){stream
        cellval=. cellval, null&,@ (":(!.maxpp)) ({.a.)~:6{data
      end.
    end.
  case. 16b00bd do. 
    rocol=. fromWORD0 4{.data=. (ptr+i.len){stream
    lc=. fromWORD0 _2{.data
    nc=. >:lc-{:rocol
    if. 0=x do.
      v=. getrk ("1) _6]\ _2}.4}.data
      for_rcl. rocol + ("1) 0, "0 i.nc do.
        if. 8=3!:0 a=. >rcl_index{v do.
          rowcol8=. rowcol8, rcl
          cellval8=. cellval8, a
        else.
          rowcol4=. rowcol4, rcl
          cellval4=. cellval4, a
        end.
      end.
    else.
      rowcol=. rowcol, rocol + ("1) 0, "0 i.nc
      cellval=. cellval, ; null&,@ (":(!.maxpp))&.> getrk ("1) _6]\ _2}.4}.data
    end.
  case. 16b0006 do. 
    data=. (ptr+i.len){stream
    if. 16b200 = biffver do. 
      if. (255 255{a.)-:13 14{data do.
        if. (0{a.)=7{data do. 
          lookrowcol=. fromWORD0 4{.data
          lookstr=. 2
        elseif. (1{a.)=7{data do. 
          if. 0=x do.
            rowcol4=. rowcol4, fromWORD0 4{.data
            cellval4=. cellval4, ({.a.)~:9{data
          else.
            rowcol=. rowcol, fromWORD0 4{.data
            cellval=. cellval, null&,@ (":(!.maxpp)) ({.a.)~:9{data
          end.
        end.
      else.  
        if. 0=x do.
          rowcol8=. rowcol8, fromWORD0 4{.data
          cellval8=. cellval8, {.fromDouble0 (7+i.8){data
        else.
          rowcol=. rowcol, fromWORD0 4{.data
          cellval=. cellval, null&,@ (":(!.maxpp)) {.fromDouble0 (7+i.8){data
        end.
      end.
    else.
      if. (255 255{a.)-:12 13{data do.
        if. (0{a.)=6{data do. 
          lookrowcol=. fromWORD0 4{.data
          lookstr=. 2
        elseif. (1{a.)=6{data do. 
          if. 0=x do.
            rowcol4=. rowcol4, fromWORD0 4{.data
            cellval4=. cellval4, ({.a.)~:8{data
          else.
            rowcol=. rowcol, fromWORD0 4{.data
            cellval=. cellval, null&,@ (":(!.maxpp)) ({.a.)~:8{data
          end.
        end.
      else.  
        if. 0=x do.
          rowcol8=. rowcol8, fromWORD0 4{.data
          cellval8=. cellval8, {.fromDouble0 (6+i.8){data
        else.
          rowcol=. rowcol, fromWORD0 4{.data
          cellval=. cellval, null&,@ (":(!.maxpp)) {.fromDouble0 (6+i.8){data
        end.
      end.
    end.
  case. 16b0007 do. 
    if. 1=lookstr do.
      if. 0=x do.
        rowcolc=. rowcolc, lookrowcol
        cellvalc=. cellvalc, null&,@> {.0 decodestring8 data=. (ptr+i.len){stream
      else.
        rowcol=. rowcol, lookrowcol
        cellval=. cellval, null&,@> {.0 decodestring8 data=. (ptr+i.len){stream
      end.
    end.
  case. 16b0207 do.
    if. 1=lookstr do.
      if. 16b300 16b400 16b500 e.~ biffver do.  
        if. 0=x do.
          rowcolc=. rowcolc, lookrowcol
          cellvalc=. cellvalc, null&,@> {.0 decodestring16 data=. (ptr+i.len){stream
        else.
          rowcol=. rowcol, lookrowcol
          cellval=. cellval, null&,@> {.0 decodestring16 data=. (ptr+i.len){stream
        end.
      else.
        if. 0=x do.
          rowcolc=. rowcolc, lookrowcol
          cellvalc=. cellvalc, null&,@> {.0 decodeustring16 data=. (ptr+i.len){stream
        else.
          rowcol=. rowcol, lookrowcol
          cellval=. cellval, null&,@> {.0 decodeustring16 data=. (ptr+i.len){stream
        end.
      end.
    end.
  case. 16b0004 do. 
    if. 0=x do.
      rowcolc=. rowcolc, fromWORD0 4{.data=. (ptr+i.len){stream
      cellvalc=. cellvalc, null&,@> {.0 decodestring8 7}.data
    else.
      rowcol=. rowcol, fromWORD0 4{.data=. (ptr+i.len){stream
      cellval=. cellval, null&,@> {.0 decodestring8 7}.data
    end.
  case. 16b0204 do. 
    if. 16b300 16b400 16b500 e.~ biffver do.  
      if. 0=x do.
        rowcolc=. rowcolc, fromWORD0 4{.data=. (ptr+i.len){stream
        cellvalc=. cellvalc, null&,@> {.0 decodestring16 6}.data
      else.
        rowcol=. rowcol, fromWORD0 4{.data=. (ptr+i.len){stream
        cellval=. cellval, null&,@> {.0 decodestring16 6}.data
      end.
    else.
      if. 0=x do.
        rowcolc=. rowcolc, fromWORD0 4{.data=. (ptr+i.len){stream
        cellvalc=. cellvalc, null&,@> {.0 decodeustring16 6}.data
      else.
        rowcol=. rowcol, fromWORD0 4{.data=. (ptr+i.len){stream
        cellval=. cellval, null&,@> {.0 decodeustring16 6}.data
      end.
    end.
  case. 16b00d6 do. 
    if. 16b300 16b400 16b500 e.~ biffver do.  
      if. 0=x do.
        rowcolc=. rowcolc, fromWORD0 4{.data=. (ptr+i.len){stream
        cellvalc=. cellvalc, null&,@> {.0 decodestring16 6}.data
      else.
        rowcol=. rowcol, fromWORD0 4{.data=. (ptr+i.len){stream
        cellval=. cellval, null&,@> {.0 decodestring16 6}.data
      end.
    else.
      if. 0=x do.
        rowcolc=. rowcolc, fromWORD0 4{.data=. (ptr+i.len){stream
        cellvalc=. cellvalc, null&,@> {.0 decodeustring16 6}.data
      else.
        rowcol=. rowcol, fromWORD0 4{.data=. (ptr+i.len){stream
        cellval=. cellval, null&,@> {.0 decodeustring16 6}.data
      end.
    end.
  end.
  lookstr=. 0>.<:lookstr
end.
if. 0=x do.
  (rowcol4, rowcol8, rowcolc, rowcolss) ; < (<"0 cellval4), (<"0 cellval8), ( <;._1 cellvalc), sst{~cellvalss
else.
  (rowcol, rowcolss) ; < ( <;._1 cellval), sst{~cellvalss
end.
)
getrk=: 3 : 0
if. 0=2 bitand d=. fromDWORD0 2}.y do. 
  bigendian=: ({.a.)={. 1&(3!:4) 1  
  if. 0=bigendian do.
    rk=. fromDouble0 toDWORD0 0, d bitand dfhs 'fffffffc'
  else.
    rk=. fromDouble0 toDWORD0 0,~ d bitand dfhs 'fffffffc'
  end.
else.  
  rk=. _2 bitsha d bitand dfhs 'fffffffc'
end.
if. 1 bitand d do.  
  rk=. rk%100
end.
<{.rk
)
readexcel=: 0&$: : (4 : 0)
assert. fexist y
ole=. (>y) conew 'olestorage'
if. '' -: wk=: getppssearch__ole 'Workbook' ; 1 ; 0 do.              
  if. '' -: wk=: getppssearch__ole 'Book' ; 1 ; 0 do.                
    assert. 16b40009 16b60209 16b60409 e.~ fromDWORD0 freadx y;0 4  
  end.
end.
ex=. conew 'biffread'
if. ''-.@-:wk do.
  0&create__ex data__wk
  if. 2 131072 e.~ 3!:0 x do. x=. (<x) i.~ {."1 worksheets__ex end.
  assert. x<#worksheets__ex
  'name location'=. x{worksheets__ex
else.
  0&create__ex fread y
  location=. x
end.
'ix cell'=. 0&readsheet__ex location
destroy__ex ''
if. ''-.@-:wk do. destroy__wk '' end.
destroy__ole ''
rcs=. (>./ >:@- <./) ix
off=. <./ ix
m=. cell (<"1 ix-"1 off)}m=. rcs$a:
)
readexcelstring=: 0&$: : (4 : 0)
assert. fexist y
ole=. (>y) conew 'olestorage'
if. '' -: wk=: getppssearch__ole 'Workbook' ; 1 ; 0 do.              
  if. '' -: wk=: getppssearch__ole 'Book' ; 1 ; 0 do.                
    assert. 16b40009 16b60209 16b60409 e.~ fromDWORD0 freadx y;0 4  
  end.
end.
ex=. conew 'biffread'
if. ''-.@-:wk do.
  0&create__ex data__wk
  if. 2 131072 e.~ 3!:0 x do. x=. (<x) i.~ {."1 worksheets__ex end.
  assert. x<#worksheets__ex
  'name location'=. x{worksheets__ex
else.
  0&create__ex fread y
  location=. x
end.
'ix cell'=. 1&readsheet__ex location
destroy__ex ''
if. ''-.@-:wk do. destroy__wk '' end.
destroy__ole ''
rcs=. (>./ >:@- <./) ix
off=. <./ ix
m=. cell (<"1 ix-"1 off)}m=. rcs$a:
)
dumpexcel=: 0&$: : (4 : 0)
assert. fexist y
ole=. (>y) conew 'olestorage'
if. '' -: wk=: getppssearch__ole 'Workbook' ; 1 ; 0 do.              
  if. '' -: wk=: getppssearch__ole 'Book' ; 1 ; 0 do.                
    assert. 16b40009 16b60209 16b60409 e.~ fromDWORD0 freadx y;0 4  
  end.
end.
ex=. conew 'biffread'
if. ''-.@-:wk do.
  1&create__ex data__wk       
  if. 2 131072 e.~ 3!:0 x do. x=. (<x) i.~ {."1 worksheets__ex end.
  assert. x<#worksheets__ex
  'name location'=. x{worksheets__ex
else.
  1&create__ex fread y
  location=. x
end.
'ix cell'=. 0&readsheet__ex location
sst__=: sst__ex
bkrecords__=: bkrecords__ex
bkbytes__=: bkbytes__ex
records__=: records__ex
bytes__=: bytes__ex
destroy__ex ''
if. ''-.@-:wk do. destroy__wk '' end.
destroy__ole ''
''
)

cocurrent 'base'
readexcel_z_=: readexcel_biffread_
readexcelstring_z_=: readexcelstring_biffread_
dumpexcel_z_=: dumpexcel_biffread_
