NB. verbs for extending the dir.ijs system library

require 'dir files'

coclass 'pdiradd'

addPS=: , PATHSEP_j_ -. {:          NB. ensure trailing path separator
dropPS=: }:^:(PATHSEP_j_={:)  NB. drop trailing path separator

NB.*createdir v Create directory(s)
NB. y is one or more (boxed) directories to create
NB. parent-directories must be created before their children
dircreate=: 3 : 0
  y=. boxopen y
  msk=. -.direxist y
  if. ''-:$msk do. msk=.(#y)#msk end.
  res=.1!:5 msk#y
  msk expand ,res
)

NB.*direxist v check directory exists
direxist=: 'd' e."1 [: > [: , [: ({:"1) 1!:0@(fboxname&>)@(dropPS&.>)@boxopen
 NB.   'd' e."1 >@:,@:({:"1@:(1!:0@(fboxname&>)@:(dropPS&.>)@:boxopen))
 NB.   'd'=[:{."1[: 4&}."1[: > [: , [: ({:"1) 1!:0@(fboxname&>)@(dropPS&.>)@boxopen

dircreate_z_=: dircreate_pdiradd_
direxist_z_=: direxist_pdiradd_
addPS_z_=: addPS_pdiradd_
dropPS_z_=: dropPS_pdiradd_