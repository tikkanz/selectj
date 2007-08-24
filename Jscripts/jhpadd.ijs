require 'files'
NB. require 'web/jhp/jhp'

coclass 'z'

fext=:'.'&(>:@i:~}.]) NB. get file extension
isJHP=: (;:'jhp asp') e.~ [:<fext

transfer=: 3 : 0
  fnme=.y
  NB. map to physical path
  if. isJHP fnme do.
    ContentType'text/html'[ Expires 0 
    markup fnme
  else.
    ContentType'text/html'[ Expires 0  NB. determine Content-Type here
    stdout fread jpath fnme
  end.
)

redirect=: 3 : 0
  uri=.y
  NB. if relative URL, convert to absolute
  println 'Location: ',uri
  ContentType'text/html'
)

refresh=: 3 : 0
  uri=.y
  NB. if relative URL, convert to absolute
  println 'Refresh: 0; url=',uri
  ContentType'text/html'
)

boxitem=: ,`(<"_1) @. (0=L.)

setcolnames=: 3 : 0
  if. y-:i.0 0 do. return. end.
  'hdr dat'=. split y
  (hdr)=: |:dat
  ''
)

NB.*coercetxt v converts any boxed txt to numeric, leave boxed numeric alone
coercetxt=: 3 : 0
  isboxed=.0<L. y
  y=. boxopen y
  msk=. -.isnum @> y
  newnums=. 0&coerce each msk#y
  y=.[newnums (I.msk)}y NB. works?
  if. -.isboxed do. >y end. NB. unboxed if was at start
)

NB. ---------------------------------------------------------
NB.*listatom v makes y a 1-item list if y is atom (rank 0)
NB. suggested by Chris Burke JForum June 2007
NB. (listatom 5) -: ,5
NB. (listatom i.4 3) -: i.4 3
listatom=: 1&#

NB. loc returns the full path of the script calling it.
NB. could be useful for relative calling?
NB. from the forums
NB. http://www.jsoftware.com/pipermail/general/2003-May/015265.html
loc_z_=: 3 : '> (4!:4 <''y'') { 4!:3 $0'