NB. functions to do with validating & registering users
require 'data/sqlite'

coclass 'pselectdb'

NB. ConStr=: jpath '~.CGI/code/select_small.sqlite'
ConStr=:  'd:/web/selectj/code/select_small.sqlite'

NB. =========================================================
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

NB. =========================================================


NB. getPhrasesBySec=: verb sdefine
NB.     r=. (boxopen y) query__db sqlPhrasesBySec
NB. )

NB.*getUserInfo v gets user info from database
NB. y is values to look up in database
NB. x is string specifying name of sqlquery to run
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

NB. insertDBTable=: 4 : 0
NB.   if. (L. = 0:) x do.
NB.     sql=. ". 'sqlins_',x
NB.   else. NB. insert blobs
NB.     'x blb'=. x
NB.     sql=. (". 'sqlins_',x);blb
NB.   end.
NB.   y apply__db sql
NB. )
