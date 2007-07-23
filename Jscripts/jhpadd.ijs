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