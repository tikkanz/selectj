NB. verbs for zipping and extracting directory trees using arc/zip addon

require 'dir arc/zip/zfiles'
require 'strings files'  NB. would get loaded by other scripts anyway
NB. needs addPS, dircreate verbs from dir_add.ijs script
NB. part of http://www.jsoftware.com/jwiki/Scripts/DirectoryTrees
3 : 0 ''
  if. -.IFCONSOLE do. NB. need to make sure it is included in project for console
    require 'dir_add' NB. mapped to ~user/projects/utils/dir_add.ijs in startup.ijs
  end.
)

coclass 'rgsztrees'

NB.*unziptree v unzip zipfile y to directory tree x
NB. eg. todir unziptree fromzip
NB. returns 2-item list 0{ number of directories created
NB.                     1{ number of files successfully extracted
NB. any existing files of the same name will be written over
unziptree=: 4 : 0
  'todir fromzip'=. x;y
  if. -.fexist fromzip do. 0 0 return. end. NB. exit if fromzip not found
  fromall=. /:~{."1 zdir fromzip
  dirmsk=. '/'={:@> fromall
  fromfiles=. (-.dirmsk)#fromall
  repps=. (<'/',PATHSEP_j_) charsub&.> ] NB. replaces '/' with PATHSEP_j_
  aprf=. ] ,&.>~ [: < [   NB. catenates x to start of each y
  tofiles=. repps fromfiles
  tofiles=. todir aprf tofiles
  fromfiles=. fromfiles,.<fromzip
  todirs=. repps dirmsk#fromall
  todirs=. ~.;(,each /\)@(<;.2) each todirs NB. add names of any missing subdirectories
  todirs=. todir aprf todirs
  resdir=. pathcreate todir NB. create dirs in todir path if necessary
  resdir=. resdir, dircreate todirs  NB. create dirs from zip
  resfile=. 0&<@>tofiles zextract"0 1 fromfiles NB. write files
  (+/resdir),+/resfile
)

NB.*ziptree v zip directory tree y to zipfile x
NB. eg. tozip ziptree fromdir
NB. returns 2-item list 0{ number of directories written to zipfile
NB.                     1{ number of files written to zipfile
ziptree=: 4 : 0
  'tozip fromdir'=. x;y
  if. -.direxist fromdir do. 0 0 return. end. NB. exit if fromdir not found
  repps=. (<PATHSEP_j_,'/') charsub&.> ] NB. replaces PATHSEP_j_ with '/'
  dprf=. ] }.&.>~ [: # [  NB. drops #x chars from beginning of each y
  fromdir=. addPS fromdir
  fromdirs=. addPS each }.dirpath fromdir
  todirs=. repps fromdir dprf fromdirs
  todirs=. todirs,.<tozip
  fromfiles=. {."1 dirtree fromdir
  tofiles=. repps fromdir dprf fromfiles
  tofiles=. tofiles,.<tozip
  zipdir=. PATHSEP_j_ dropto&.|. tozip
  resdir=. pathcreate zipdir NB. create dirs in tozip path if necessary
  resdir=. resdir, 0= (((#todirs),0)$'') zwrite"1 todirs NB. create dirs in tozip
  resfile=. 0&<@>tofiles zcompress"1 0 fromfiles
  (+/resdir),+/resfile
)

NB.*zipfiles v Add/Append one or more files to a zip file.
NB. returns 2-item numeric list 
NB.               0{ number of directories written to zipfile
NB.               1{ number of files written to zipfile
NB. y is 1 or more-item boxed list of file names to zip
NB. x is 1 or 2-item boxed list.
NB.         0{ is name of zip file
NB.         1{ is optional info on what directory info to include in zip.
NB.            0. don't include any directories
NB.            1. (default) Base directory is highest directory common to all files.
NB.           ''. (i.e. empty) include full paths
NB.    <basedir>. explicitly specify base directory 
NB. eg. (tozip;0) zipfiles fname1;fname2;fname3
zipfiles=: 4 : 0
  fromfiles=. boxopen y
  'tozip dirinf'=. 2{.!.(<1) boxopen x
  if. *./-.fexist @> fromfiles do. 0 return. end. NB. stop if no fromfiles found
  repps=. (<PATHSEP_j_,'/') charsub&.> ] NB. replaces PATHSEP_j_ with '/'
  dprf=. ] }.&.>~ [: # [  NB. drops #x chars from beginning of each y
  if. (0-:dirinf) +. (1-:dirinf) *. 1=#fromfiles do.
    tofiles=. '/' taketo&.|. each repps fromfiles
    tofiles=. tofiles,.<tozip
    todirs=. ''
  else.
    if. 1-:dirinf do.
      basedir=. (0 i. ~ *./ 2=/\>fromfiles){."1 >{.fromfiles NB. find base directory of files
      basedir=. PATHSEP_j_ dropto&.|. basedir
    else.
      basedir=. (, ('/' -. {:))^:(*@#) > repps <dirinf NB. ensure trailing / if not empty
    end.
    tofiles=. repps basedir dprf fromfiles NB. drop length of base directory from each fromfile
    todirs=. '/' dropto&.|. each tofiles NB. dirs in tofiles
    todirs=. todirs #~ (a:~:todirs) *. ~: tolower each todirs NB. unique not empty dirs
    todirs=. todirs,.<tozip
    tofiles=. tofiles,.<tozip
  end.
  zipdir=. PATHSEP_j_ dropto&.|. tozip
  resdir=. pathcreate zipdir NB. create dirs in tozip path if necessary
  resdir=. resdir, 0= (((#todirs),0)$'') zwrite"1 todirs NB. create dirs in tozip
  resfile=. 0&<@>tofiles zcompress"1 0 fromfiles
  (+/resdir),+/resfile
)

NB.*ztypes v get file types for contents of zip file
NB. vector of numeric types, file (1) dir (2)
NB. eg. ztypes jpath '~addons/arc/zip/test.zip'
ztypes=: [: >: '/' = [: {:@> [: {."1 zdir

zextract=: fwrite~ zread
zcompress=: zwrite~ fread

unziptree_z_=: unziptree_rgsztrees_
zipfiles_z_=: zipfiles_rgsztrees_
ziptree_z_=: ziptree_rgsztrees_
ztypes_z_=: ztypes_rgsztrees_