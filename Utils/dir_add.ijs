NB. verbs for extending the dir.ijs system library

require 'files'

coclass 'rgsdiradd'

NB.*addPS v ensures trailing path separator
addPS=: , PATHSEP_j_ -. {:
NB.*dropPS v drops trailing path separator
dropPS=: }:^:(PATHSEP_j_={:)

NB.*dircreate v Create directory(s)
NB. y is one or more (boxed) directories to create
NB. parent-directories must be created before their children
NB. if user account calling createdir doesn't have 
NB. read permission for already existing parent directories.
NB. looks like they don't exist and interface error when try to create
dircreate=: 3 : 0
  y=. boxxopen y
  msk=. -.direxist y
  if. ''-:$msk do. msk=.(#y)#msk end.
  res=.1!:5 msk#y
  msk expand ,res
)

NB.*direxist v check directory exists
direxist=: 2 = ftype&>@: boxopen

NB.*pathcreate v Create non-existing directories in a path
NB. returns numeric list of 1s for each directory created.
NB. y is literal directory path to create (no filename at end).
pathcreate=: 3 : 0
  todir=. addPS jhostpath y
  todirs=. }. ,each /\ <;.2 todir NB. base dirs
  msk=. -.direxist todirs NB. 1 for each non-existing dir
  NB. zero any 1s before last 0 because the dir must 
  NB. exist so user probably just has no read permissions
  NB. for root dirs.
  msk=. 0 (i. msk i: 0)}msk
  dircreate msk#todirs NB. create non-existing base dirs
)

dircreate_z_=: dircreate_rgsdiradd_
direxist_z_=: direxist_rgsdiradd_
pathcreate_z_=: pathcreate_rgsdiradd_
addPS_z_=: addPS_rgsdiradd_
dropPS_z_=: dropPS_rgsdiradd_