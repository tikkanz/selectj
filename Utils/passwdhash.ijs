NB. functions to do with creating and hashing passwords
require 'stats/base/random convert/misc/md5'

coclass 'rgspasswd'

ic=: 3!:4 NB. conversion to (_x) and from (x) J integers

NB.*createSalt v Generates salt as 4-byte integer.
NB. eg: createSalt '' 
createSalt=: ([: _2&ic a. {~ [: ? 256 $~ ])&4

NB.*randPassword v Generates alphanumeric password.
NB. y is optional integer denoting desired password length
NB. x is optional list of literals valid for use in the password
randPassword=: 3 : 0
  defx=.'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789' 
  defx randPassword y
:
  if. isdefseed'' do. randomize'' end.
  len=. (*#y){ 8,y  NB. default length is 8
  len ((?@$ #) { ]) x
)

NB.*isdefseed v Checks if random seed has been reset from J6.01 default.
isdefseed=: 3 : '+./ 16807 1215910514 = {.2{::9!:44'''' '

NB.*salthash v Generates salted hash of password.
NB. form: [salt] salthash password
NB. returns: 2-item list of boxed 4-byte integer salt and salted md5 hash of y
NB. y is: password string
NB. x is: optional salt to use. Defaults to generates new salt
salthash=: 3 : 0
  '' salthash y NB. default create new salt
  :
  if. *#x do. s=.x
    if. 2=3!:0 s do. s=.".s end. NB. handle string
  else. 
    if. isdefseed'' do. randomize'' end.
    s=. createSalt '' 
  end.
  h=. md5 y,2&ic s NB. convert from 4-byte salt 
  s;h
)

salthash_z_=: salthash_rgspasswd_
randPassword_z_=: randPassword_rgspasswd_