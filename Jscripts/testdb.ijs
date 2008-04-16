require 'data/sqlite'
NB. FBASE=: '~home/documents/web/'
FBASE=: '~home/Documents/web/'
FDIR=: jpath FBASE,'selectj/code/'
'FDB FDDL FDATA'=: cut 'select_cmplx.sqlite select_cmplx_ddl.sql select_cmplx_data.sql '
ferase FDIR,FDB NB. deletes database file

]db=: 'psqlite'conew~ FDIR,FDB  NB. creates new connection (and database file if required)

NB. Set up the table structure in the database
exec__db fread FDIR,FDDL
exec__db fread FDIR,FDATA
destroy__db ''

NB.! Offer to deltree all subfolders of userpop except for '.svn'