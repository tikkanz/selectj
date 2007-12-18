NB. verbs for extending the dir.ijs system library

require 'files'

coclass 'rgsdiradd'

addPS=: , PATHSEP_j_ -. {:          NB. ensure trailing path separator
dropPS=: }:^:(PATHSEP_j_={:)  NB. drop trailing path separator

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

NB. direxist v check directory exists
direxist=: 2 = ftype&>@: boxopen
 NB. direxist=: 'd' e."1 [: > [: , [: ({:"1) 1!:0@(fboxname&>)@(dropPS&.>)@boxopen
 NB.   'd' e."1 >@:,@:({:"1@:(1!:0@(fboxname&>)@:(dropPS&.>)@:boxopen))
 NB.   'd'=[:{."1[: 4&}."1[: > [: , [: ({:"1) 1!:0@(fboxname&>)@(dropPS&.>)@boxopen



dircreate_z_=: dircreate_rgsdiradd_
NB. direxist_z_=: direxist_rgsdiradd_
addPS_z_=: addPS_rgsdiradd_
dropPS_z_=: dropPS_rgsdiradd_