NB. verbs for zipping and extracting directory trees using arc/zip addon

require 'dir arc/zip/zfiles'
require 'strings files'  NB. would get loaded by other scripts anyway
NB. needs addPS, dircreate, direxist verbs from dir_add.ijs script
NB. part of http://www.jsoftware.com/jwiki/Scripts/DirectoryTrees
require '~Projects/utils/dir_add.ijs'

coclass 'ptrees'

NB.*unziptree v unzip zipfile y to directory tree x
NB. eg. todir unziptree fromzip
NB. returns 2-item list 0{ number of directories created
NB.                     1{ number of files successfully extracted
NB. any existing files of the same name will be written over
unziptree=: 4 : 0
  'todir fromzip'=. x;y
  if. -.fexist fromzip do. 0 0 return. end. NB. exit if fromzip not found
  todir=. addPS todir
  fromall=. /:~{."1 zdir fromzip
  dirmsk=. '/'={:@> fromall
  fromfiles=. (-.dirmsk)#fromall
  repps=. (<'/',PATHSEP_j_) charsub&.> ] NB. replaces '/' with PATHSEP_j_
  aprf=. ] ,&.>~ [: < [   NB. catenates x to start of each y
  tofiles=. repps fromfiles
  tofiles=. todir aprf tofiles
  fromfiles=. fromfiles,.<fromzip
  todirs=. repps dirmsk#fromall
  todirs=. todir aprf todirs
  todirs=. (}.,each/\ <;.2 todir), todirs
  resdir=. dircreate todirs
  resfile=. 0&<@>tofiles zextract"0 1 fromfiles
  (+/resdir),+/resfile
)

NB.*ziptree v zip directory tree y to zipfile x
NB. eg. tozip ziptree fromdir
NB. returns 2-item list 0{ number of directories written to zipfile
NB.                     1{ number of files written to zipfile
ziptree=: 4 : 0
  'tozip fromdir'=. x;y
  if. -.direxist fromdir do. 0 0 return. end. NB. exit if fromzip not found
  repps=. (<PATHSEP_j_,'/') charsub&.> ] NB. replaces PATHSEP_j_ with '/'
  dprf=. ] }.&.>~ [: # [  NB. drops #x chars from beginning of each y
  fromdir=. addPS fromdir
  fromdirs=. addPS each }.dirpath fromdir
  todirs=. repps fromdir dprf fromdirs
  todirs=. todirs,.<tozip
  fromfiles=. {."1 dirtree fromdir
  tofiles=. repps fromdir dprf fromfiles
  tofiles=. tofiles,.<tozip
  zipdir=. tozip {.~>: tozip i: PATHSEP_j_
  resdir=. dircreate }.,each/\ <;.2  zipdir NB. create dirs in tozip path if necessary
  resdir=. resdir, 0= (((#todirs),0)$'') zwrite"1 todirs NB. create dirs in tozip
  resfile=. 0&<@>tofiles zcompress"1 0 fromfiles
  (+/resdir),+/resfile
)

NB.*ztypes v get file types for contents of zip file
NB. vector of numeric types, file (1) dir (2)
NB. eg. ztypes jpath '~addons/arc/zip/test.zip'
ztypes=: [: >: '/' = [: {:@> [: {."1 zdir

zextract=: 4 : 0
  dat=. zread y
  dat fwrite x
)

zcompress=: 4 : 0
  dat=. fread y
  dat zwrite x
)

unziptree_z_=: unziptree_ptrees_
ziptree_z_=: ziptree_ptrees_
ztypes_z_=: ztypes_ptrees_