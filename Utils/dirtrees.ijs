NB. verbs for copying and deleting directory trees

require 'dir files'
NB. needs addPS, dropPS, dircreate, direxist verbs from dir_add.ijs script
NB. part of http://www.jsoftware.com/jwiki/Scripts/DirectoryTrees
3 : 0 ''
if. -.IFCONSOLE do. NB. need to make sure it is included in project for console
  require 'dir_add' NB. mapped to ~Projects/utils/dir_add.ijs in startup.ijs
end.
)
coclass 'rgstrees'

addPS=: , PATHSEP_j_ -. {:          NB. ensure trailing path separator
dropPS=: }:^:(PATHSEP_j_={:)  NB. drop trailing path separator

NB.*copytree v copies directory tree from directory y to directory x
NB. eg. todir copytree fromdir
NB. returns 2-item list 0{ number of directories created
NB.                     1{ number of files successfully copied
NB. any existing files of the same name will be written over
copytree=: 4 : 0
  'todir fromdir'=. addPS each x;y
  if. -.direxist fromdir do. 0 0 return. end. NB. exit if fromdir not found
  dprf=. ] }.&.>~ [: # [  NB. drops #x chars from beginning of each y
  aprf=. ] ,&.>~ [: < [    NB. catenates x to start of each y
  fromdirs=. dirpath fromdir
  todirs=. todir aprf fromdir dprf fromdirs
  todirs=. (}:}.,each/\ <;.2 todir), todirs
  fromfiles=. {."1 dirtree fromdir
  tofiles=. todir aprf fromdir dprf fromfiles
  resdir=. dircreate todirs
  resfile=. 0&< @>tofiles fcopy fromfiles
  (+/resdir),+/resfile
)

NB.*deltree v delete directory tree
NB. returns 1 if all files and folders in tree are deleted
NB.         0 on error or if some cannot be deleted
NB. y is filename of directory to delete
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

copytree_z_=: copytree_rgstrees_
deltree_z_=: deltree_rgstrees_