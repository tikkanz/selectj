NB. literate program from http://www.jsoftware.com/jwiki/Scripts/UnZip#extractzip.ijs

NB. =========================================================
NB. Extracts Zip archive to desired sub-directory

coclass 'rgsunzip'

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

NB. =========================================================
NB. exequote
NB. ensure exe is wrapped in double quotes for Windows
exequote=: 3 : 0
  f=. deb y
  if. '"' = {. f do. f return. end.
  ndx=. 4 + 1 i.~ '.exe' E. f
  if. ndx >: #f do. f return. end.
  '"',(ndx{.f),'"',ndx }. f
)
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
unzip=: 3 : 0
  'file dir'=.y
  e=. 'Unexpected error'
  if. IFUNIX do.
    e=. shellcmd 'tar -xzf ',(dquote file),' -C ',dquote dir
  else.
    z=. exequote UNZIP
    if. +./'7z' E. UNZIP do. 
      dirsw=.' -o'
    else.  NB. assume using Info-Zip unzip
      dirsw=.' -d'
    end.
    r=. z,' ',(dquote file),dirsw,dquote dir
    e=. shellcmd r
    NB. if. 'Ok'-: _2{.e -. CRLF do. e=. 'Ok' end.
  end.
  e
)

unzip_z_=: unzip_rgsunzip_
