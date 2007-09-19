NB.cover functions for winapi functions for reading from & writing to INI files
require 'winapi strings'
coclass 'rgsini'

NB.*getPPAllKeys v Gets all the keynames and values in an INI file
NB. returns 3 column matrix,
NB.       0{"1 sectionnames, 1{"1 keynames, 2{"1 keyvalues
NB. y is the full filename of INI file
getPPAllSections=: 3 : 0
  snmes=. getPPSectionNames y
  keys=. getPPSection each <"1 (boxopen y),.snmes
  nkys=. #@> keys       NB. number of keys in each section
  keys=. ;(nkys>0)#keys NB. compress out empty sections
  (nkys#snmes),.keys
)

NB.*getPPSection v Gets all the keys and values for a section of an INI file
NB. returns 2 column matrix
NB.           0{"1 keynames, 1{"1 keyvalues
getPPSection=: 3 : 0
  'fnme snme'=. y
  len=. #str=. 4096$' '  NB. max ??32767
  'len val'=. 0 2{'GetPrivateProfileSectionA'win32api snme;str;len;fnme
  val=. ({.a.),len{.val  NB. line delimiter is {.a. (null)
  val=. <;._1 val
  val=. dtb each '#' taketo each val
  msk=. 0< #@> val NB. lines of non-zero length
  val=. msk#val
  ><;._1 each '=',each val
)

NB.*getPPSectionNames v Gets section names from an INI file
NB. returns list of boxed section names from the INI file
NB. y is full path to INI file
getPPSectionNames=: 3 : 0
  fnme=. y
  len=. #str=. 512$' '  NB. max ??32767
  'len val'=. 0 1{'GetPrivateProfileSectionNamesA'win32api str;len;fnme
  <;._2 val=. len{.val
)

NB.*getPPString v Gets the value of a key from an INI file
NB. returns string of value of specified key
NB. y is 3-item list of boxed strings
NB.         0{ The full path to the INI file
NB.         1{ Section Name
NB.         2{ Key Name
NB. e.g. getPPString 'c:\myini.ini';'Install';'InstallPath'
getPPString=: 3 : 0
  'fnme snme knme'=. y
  len=. #str=. 256$' '  NB. max ??32767
  'len val'=. 0 4{'GetPrivateProfileStringA'win32api snme;knme;'';str;len;fnme
  val=. len{.val
)

NB.*getPPValue v Gets a key value from an INI file without comments
NB. returns key value without comments
NB. y is 3-item list of boxed strings
NB.           0{ filename of ini file,
NB.           1{ name of Section
NB.           2{ name of Key
NB. x is optional character used to delineate start of comments for line
NB. e.g. getPPValue 'c:\myini.ini';'Install';'InstallPath'
getPPValue=: 3 : 0
  '#' getPPValue y  NB. default comment delimiter is #
  :
  rval=. getPPString y   NB. get raw value of Key
  rval=. dtb x taketo rval  NB. get cleaned Key value (x is the comment delimiter)
)

NB.*getPPVals v Gets and interprets a key value from an INI file
NB. if can be interpreted as numeric, returns numeric list
NB. if string contains spaces, returns list of boxed literals
NB. else returns string of key value
NB. y is 3-item list of boxed strings
NB.           0{ filename of ini file,
NB.           1{ name of Section
NB.           2{ name of Key
NB. x is optional character used to delineate start of comments for line
NB. e.g. getPPVals 'c:\myini.ini' 'Install' 'InstallPath'
getPPVals=: 3 : 0
  '#' getPPVals y  NB. default comment delimiter is #
  :
  'delim err'=. 2{.!.(<_999999) boxopen x
  val=. delim getPPValue y   NB. get cleaned value of Key
  err makeVals val
)

NB.*join v Unbox and delimit a list of boxed items y with x
NB. from forum post 
NB. http://www.jsoftware.com/pipermail/programming/2007-June/007077.html
NB. eg. '","' join 'item1';'item2'
NB. eg. LF join 'item1';'item2'
NB. eg. 99 join <&> i.8
join=: ' '&$. : (4 : '(;@(#^:_1!.(<x))~  1 0$~_1 2 p.#) y')  NB. ignore $.

NB.*makeString v Creates space-delimited string from numeric list, list of boxed literals or numbers
NB. returns space-delimited string or unchanged y, if y is literal
NB. y is string, numeric list, list of boxed literals and/or numbers
makeString=:[: ' '&join 8!:0

NB.*makeVals v Interprets a string as numeric or list of boxed literals
NB. if y can be interpreted as all numeric, returns numeric list
NB. elseif y contains spaces or commas, returns list of boxed literals
NB. else returns original string
NB. y is a string
NB. x is optional numeric value used to signify non-numeric. 
NB.   Choose value for x that will not be valid numeric in your data.
makeVals=: 3 : 0
  _999999 makeVals y
  :
  err=. x
  if. L.y do. y return. end. NB. already boxed
  val=. ', ' charsub y  NB. values delimited by commas and/or spaces
  if. -.+./err= nums=. err&". val do. val=. nums end.
  if. ' ' e. val do. val=. <;._1 ' ',deb val end.
  val
)

NB.*writePPString v Writes key and key value to an INI file
NB. returns Boolean, 1 if wrote OK, otherwise 0.
NB. y is 4-item list of boxed info on key value to write
NB.         0{ The full path to the INI file
NB.         1{ Section Name
NB.         2{ Key Name
NB.         3{ The values to write  (string, numeric list or 
NB.                         list of boxed literals and/or numbers)
writePPString=: 3 : 0
  'fnme snme knme val'=. y
  val=. makeString val
  res=. 'WritePrivateProfileStringA'win32api snme;knme;val;fnme
  0{:: res
)

NB.*writePPSection v Writes list of key;keyvalue lists to an INI file
NB. returns Boolean, 1 if wrote OK, otherwise 0.
NB. y is 4-item list of boxed info on key values to write
NB.         0{ The full path to the INI file
NB.         1{ Section Name
NB.         2{ list of 2-item boxed lists
NB.                  0{"1 keynames
NB.                  1{"1 keyvalues (string, numeric list or 
NB.                         list of boxed literals and/or numbers)
writePPSection=: 3 : 0
  'fnme snme keys'=. y
  null={.a.
  keys=. (makeString each 1{"1 keys) (1)}"0 1 keys NB. make keyvalues all strings
  keys=. '=' join each <"1 keys  NB. join each key and keyvalue with '='
  keys=. null,~ null join keys NB. join key,keyvalue pairs with null. Terminate with null
  NB. max length for keys is 65,535 bytes
  res=. 'WritePrivateProfileSectionA'win32api snme;keys;fnme
  0{:: res
)


getPPAllSections_z_=: getPPAllSections_rgsini_
getPPString_z_=: getPPString_rgsini_
getPPVals_z_=: getPPVals_rgsini_
writePPString_z_=: writePPString_rgsini_
makeVals_z_=: makeVals_rgsini_