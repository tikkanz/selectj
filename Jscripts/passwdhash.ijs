NB. functions to do with creating and hashing passwords

NB.*createSalt v generates salt as 4-byte integer
NB. e.g. createSalt '' 
createSalt=: ([: _2&(3!:4) a. {~ [: ? 256 $~ ])&4

NB.*randpwd v generates y character alphanumeric password
NB. y is integer of number characters for password
randpwd=: 3 : 0
'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789' randpwd y
:
if. -.4=3!:0 y do. len=.8 else. len=.y end.
len (]{~ [:?[$ [:#]) x
)

NB.*isdefseed v check if random seed has been reset from J6.01 default
isdefseed=: 3 : '+./({.2{::9!:44'''')=16807 1215910514'

NB.*salthash v generates hash
NB. y is password string
NB. x if present is the salt to use
salthash=: 3 : 0
  '' salthash y NB. default create new salt
  :
  if. 0<#x do. s=.x
    if. 2=3!:0 s do. s=.".s end. NB. handle string
  else. 
    if. isdefseed'' do. randomize'' end.
    s=. createSalt '' 
  end.
  h=. md5 y,2&ic s
  s;h  NB. 4 byte salt conver
)