NB. script for late open/early closing of sqlite database connection
NB. adapted from JHP phrases database example.

NB. set filename of the sqlite database to noun "CONNECTSTR" located in
NB.   the base or z locales

require 'data/sqlite'
coclass 'rgssqliteq'

NB.! look at using as a class, or coinserting in sqlite class?
NB. script_z_ '~addons/data/sqlite/sqlite.ijs'
NB. coclass 'rgssqliteq'
NB. coinsert 'psqlite'

NB. get path to database file
3 : 0 ''
  if. 0=4!:0 <'CONNECTSTR_base_' do.
    ConStr=:  CONNECTSTR_base_  NB. constant set in base or z locales
  else.
    NB. ConStr=: jpath '~.CGI/code/select_small.sqlite'
    ConStr=:  'd:/web/selectj/code/select_cmplx.sqlite'
  end.
)

NB. rgsselectq methods
NB. =========================================================
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

NB. =========================================================

NB. getPhrasesBySec=: verb sdefine
NB.     r=. (boxopen y) query__db sqlPhrasesBySec
NB. )

NB.*getDBItem v gets single field from a record in database
NB. returns single field
getDBItem=: 3 : 0
 '' getDBItem y
:
 r=. x getDBTable y
 r=.>{.{:r
)

NB.*getDBItemStr v gets single field from a record in database
NB. returns single field
getDBItemStr=: 3 : 0
 '' getDBItemStr y
:
 r=. x getDBTableStr y
 r=.>{.{:r
)

NB.*getDBTable v gets info from database
NB. returns boxed list of query result. {.is list of boxed field names.
NB. y is values to look up in database
NB. x is string specifying name of noun containing sql to run
getDBTable=: dyad sdefine
  r=.(boxopen y) query__db ".'sqlsel_',x
)

NB.*getDBTableStr v gets info from database as strings
NB. returns boxed list of query result. {.is list of boxed field names.
NB. y is values to look up in database
NB. x is string specifying name of noun containing sql to run
getDBTableStr=: dyad sdefine
  r=.(boxopen y) strquery__db ".'sqlsel_',x
)

NB.*insertDBTable v inserts record into database
NB. returns row ids of inserted record(s)
NB. y is boxed list of values to insert
NB. x is string specifying name of noun containing sql to run
insertDBTable=: dyad sdefine
  sql=. ". 'sqlins_',x
  r=. (boxopen y) apply__db sql
)

NB.*updateDBTable v updates record(s) in database
NB. returns ??
NB. y is boxed list of values to update
NB. x is string specifying name of noun containing sql to run
updateDBTable=: dyad sdefine
  r=. (boxopen y) apply__db ". 'sqlupd_',x
)

execSQL=: dyad sdefine
  r=. exec__db y
)

getDBItem_z_=: getDBItem_rgssqliteq_
getDBItemStr_z_=: getDBItemStr_rgssqliteq_
getDBTable_z_=: getDBTable_rgssqliteq_
getDBTableStr_z_=: getDBTableStr_rgssqliteq_
insertDBTable_z_=: insertDBTable_rgssqliteq_
updateDBTable_z_=: updateDBTable_rgssqliteq_