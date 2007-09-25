NB. functions to do with creating and hashing passwords
require 'random convert/misc/md5'

coclass 'rgspasswd'
NB.*createSalt v Generates salt as 4-byte integer.
NB. e.g. createSalt '' 
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
  len (]{~ [:?[$ [:#]) x
)

NB.*isdefseed v Checks if random seed has been reset from J6.01 default.
isdefseed=: 3 : '+./({.2{::9!:44'''')=16807 1215910514'

NB.*salthash v Generates salted hash of password.
NB. returns 2-item boxed list of 4-byte integer salt;salted md5 hash of y
NB. y is password string
NB. x if present is the salt to use
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