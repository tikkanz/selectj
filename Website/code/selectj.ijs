NB. built from project: ~Projects/selectj/selectj

IFJIJX_j_=: 1
script_z_ '~system\main\convert.ijs'
script_z_ '~system\main\dll.ijs'
script_z_ '~system\main\files.ijs'
script_z_ '~system\packages\misc\guid.ijs'
script_z_ '~system\main\strings.ijs'

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
loggedIn=: 3 : 0
  uid=. qcookie 'UserID'
  0<#uid
  
)
getScenarioInfo=: 3 : 0
  'default' getScenarioInfo y
  :
  keys=. boxopen x
  uid=. ":y 
  inifile=. '~.CGI/flocks/',uid,'/animalsim.ini'
  
)
createSalt=: ([: _2&(3!:4) a. {~ [: ? 256 $~ ])&4
randpwd=: 3 : 0
'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789' randpwd y
:
if. -.4=3!:0 y do. len=.8 else. len=.y end.
len (]{~ [:?[$ [:#]) x
)
salthash=: 3 : 0
  '' salthash y 
  :
  if. 0<#x do. s=.x
    if. 2=3!:0 s do. s=.".s end. 
  else. 
    if. +./(1{::9!:44'')=624,>:i.3 do. 
        9!:1 (_2) 3!:4 , guids 1 end.
    s=. createSalt '' 
  end.
  h=. md5 y,2&ic s
  s;h  
)

validLogin=: 3 : 0
 'usrnme passwd'=. y
  if. usrnme -: '' do. _1 return. end. 
  uinfo =. {:'login' getUserInfo_pselectdb_ usrnme  
  if. ''-: uinfo   do. _2 return. end.   
  'duid dunme dhash dsalt' =. 4{.uinfo
  if. -. dhash-: _1{::dsalt salthash passwd do. _3 return. end. 
  duid
)
isActive=: 3 : 0
  s=. {:'status' getUserInfo_pselectdb_ y
)
registerUser=: 3 : 0
  
  passwd=._1{::y
  uname=.0{::y
  uinfo =. {:'login' getUserInfo_pselectdb_ uname  
  if. -.uinfo-:'' do. _2 return. end. 
  sph=. salthash passwd 
  uid=.'newuser' insertDBTable_pselectdb_ (}:y),|.sph 
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
require 'data/sqlite'

coclass 'pselectdb'
ConStr=:  'd:/web/selectj/code/select_small.sqlite'
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
getUserInfo=: dyad sdefine
  r=.(boxopen y) query__db ".'sqlsel_',x
)

insertDBTable=: dyad sdefine
  sql=. ". 'sqlins_',x
  r=. (boxopen y) apply__db sql
)

updateDBTable=: dyad sdefine
  r=. (boxopen y) apply__db ". 'sqlupd_',x
)

coclass 'pselectdb'

sqlsel_userid=: 0 : 0
  SELECT ur_id
  FROM users
  WHERE ur_uname=?;
)
sqlsel_login=: 0 : 0
  SELECT ur_id, ur_uname, ur_passhash, ur_salt
  FROM users
  WHERE ur_uname=?;
)
sqlsel_status=: 0 : 0
  SELECT ur_status
  FROM users
  WHERE ur_id=?;
)

sqlsel_greeting=: 0 : 0
  SELECT ur_fname, ur_lname
  FROM users
  WHERE ur_id=?;
)

sqlsel_userlist=: 0 : 0
  SELECT ur_id,ur_status,ur_fname,ur_lname
  FROM users
)
sqlsel_userrec=: 0 : 0
  SELECT ur_id,ur_fname,ur_lname,ur_uname,ur_studentid,ur_email,ur_status,ur_salt,ur_passhash
  FROM users
  WHERE ur_id=?;
)

sqlins_newuser=: 0 : 0
  INSERT INTO users (ur_uname,ur_fname,ur_lname,ur_studentid,ur_email,ur_passhash,ur_salt)
  VALUES(?,?,?,?,?,?,?);
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