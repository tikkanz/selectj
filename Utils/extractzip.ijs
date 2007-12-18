NB. literate program from http://www.jsoftware.com/jwiki/Scripts/UnZip#extractzip.ijs

NB. =========================================================
NB. Extracts Zip archive to desired sub-directory

coclass 'rgsunzip'

3 : 0 ''
  if. -.IFUNIX do. require 'task' end.
)

UNZIP=: '"',(jpath '~tools/zip/unzip.exe'),'" -o -C '
dquote=: '"'&, @ (,&'"')
hostcmd=: [: 2!:0 '(' , ] , ' || true)'"_

NB. =========================================================
shellcmd=: 3 : 0
  if. IFUNIX do.
    hostcmd y
  else.
    spawn y
  end.
)
NB. =========================================================
NB.*unzip v unzips file into given subdirectory
NB. returns 'Ok' if successful or 'Unexpected error' if not
NB. y is 2-item list of boxed strings
NB.  0{::y filename zip file to extract
NB.  1{::y name of directory to extract zip file to
NB. can't extract to non-existing multilevel path.
unzip=: 3 : 0
  'file dir'=.dquote each y
  e=. 'Unexpected error'
  if. IFUNIX do.
    e=. shellcmd 'tar -xzf ',file,' -C ',dir
  else.
    dir=. (_2&}. , PATHSEP_j_ -.~ _2&{.) dir
    e=. shellcmd UNZIP,' ',file,' -d ',dir
    NB. if. 'Ok'-: _2{.e -. CRLF do. e=. 'Ok' end.
  end.
  e
)

unzip_z_=: unzip_rgsunzip_