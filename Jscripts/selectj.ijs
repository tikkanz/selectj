NB. built from project: ~Projects/selectj/selectj
NB. functions to do with validating & registering users

IFJIJX_j_=: 1
script_z_ '~system\main\dll.ijs'
script_z_ '~system\main\files.ijs'
script_z_ '~system\main\strings.ijs'

coclass 'pselect'

findUser=: 3 : 0
  usrinfo=. knownUser
)

chkPasswrd=: 3 : 0
  
)



getUser=: 3 : 0
  'userlogin' getUser y
  :
  y query__db ".'sqlsel_',x
)

sqlsel_userid=: 0 : 0
  SELECT ur_id
  WHERE ur_email=?;
)

sqlsel_userlogin=: 0 : 0
  SELECT ur_id, ur_email, ur_password, ur_salt
  FROM users
  WHERE ur_email=?;
)

sqlins_newuser=: 0 : 0
  INSERT INTO users (ur_fname,ur_lname,ur_studentid,ur_email,ur_password,ur_salt)
  VALUES(?,?,?,?,?,?);
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
strquot=:(([:''''&, ,&'''')@(([:>:(''''&=))#]))^:(2=3!:0) 
bulkins=: 4 : 0
  x=. 'insert into ',x,' values('
  ; <@(x , ');',~ [:; ','strjoin ":@strquot&.>)"1 y
)

require 'dll strings'

coclass 'psqlite'

ADDONDIR=: jpath '~addons/data/sqlite/'
d=. (<jhostpath ADDONDIR,'lib/') ,&.> cut 'sqlite-3.3.7.so sqlite3.dll '
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
