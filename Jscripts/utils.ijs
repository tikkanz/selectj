NB. =========================================================
NB. Utility verbs

NB.*listatom v Makes y a 1-item list if y is atom (rank 0)
NB. suggested by Chris Burke JForum June 2007
NB. (listatom 5) -: ,5
NB. (listatom i.4 3) -: i.4 3
listatom=: 1&#

NB.*mfv1 v Make a 1-row matrix from a vector
mfv1=: ,:^:(#&$ = 1:)
NB. use mfv in convert.ijs instead

NB.*idxfnd v Returns only indexes of items of y that are found in x.
idxfnd=: i. #~ i. < [: # [

NB. loc returns the full path of the script calling it.
NB. could be useful for relative calling?
NB. from the forums
NB. http://www.jsoftware.com/pipermail/general/2003-May/015265.html
loc_z_=: 3 : '> (4!:4 <''y'') { 4!:3 $0'

NB.*join v unbox and delimit a list of boxed items y with x
NB. from forum post
NB. http://www.jsoftware.com/pipermail/programming/2007-June/007077.html
NB. eg. '","' join 'item1';'item2'
NB. eg. LF join 'item1';'item2'
NB. eg. 99 join <&> i.8
join=: ' '&$. : (4 : '(;@(#^:_1!.(<x))~  1 0$~_1 2 p.#) y')  NB. ignore $.

NB.*dquote v Enclose string in double quotes
dquote=: '"'&, @ (,&'"')

NB.*vfms v convert a matrix to a space-delimited vector.
vfms=: [: }. [: , ' ' ,. ] NB. matrix to space-delimited vector


NB.*makeTable v makes a 2-column table from a multi-space and LF delimited noun
NB. eg. makeTable MimeMap
NB. makeTable=:[: > [: <;._1 each TAB,each [: <;._2 ] , LF -. {:
makeTable=: [: > [: <;._1 each ' ',each [: <;._2 (deb@:toJ ]) , LF -. {:

NB.*boxitem v Boxes the items in y
boxitem=: ,`(<"_1) @. (0=L.)

NB.*setcolnames v Labels in first row of table assigned as noun containing respective column
setcolnames=: 3 : 0
  if. y-:i.0 0 do. return. end.
  'hdr dat'=. split y
  (hdr)=: |:dat
  ''
)

NB.*coercetxt v Converts any boxed txt to numeric, leave boxed numeric alone
coercetxt=: 3 : 0
  isboxed=.0<L. y
  y=. boxopen y
  msk=. -.isnum @> y
  newnums=. 0&coerce each msk#y
  y=.[newnums (I.msk)}y NB. works?
  if. -.isboxed do. >y end. NB. unboxed if was at start
)


NB.*keyval v Returns value of key (x) in boxed 2-column table (y)
NB. returns value of key
NB. y is 2-column boxed table 0{"1 are keys 0{"2 keyvalues
NB. x is character list of key to return value for
NB. e.g. val=. 'key' keyval keyValTable
NB. from JHP addon
keyval=: ''&$: : (4 : 0)     NB. val=. 'key' keyval keyValTable
  if. (#y) > i=. ({."1 y) i. <,>x do.
    (<i,1) {:: y else. '' end.
)