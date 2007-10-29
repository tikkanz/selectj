NB. verbs for reading from & writing to INI files
NB. writing to INI files currently requires winapi

require 'files regex strings'
coclass 'rgsini'

Note 'get Ini string'
inistr=. freads 'animini' getFnme 2  NB. use for file on disk
inistr=. toJ zread <"1&dtb"1 'summaryINI' getFnme y NB. use for file in zip
)

boxtolower=: 13 : '($y) $ <;._2 tolower ; y ,each {:a.'

NB.*getIniAllSections v Gets all the keynames and values in an INI file
NB. returns 5-column boxed table,
NB.      0{"1 sectionnames, 1{"1 keynames, 2{"1 lowercase sectionnames, 
NB.      3{"1 lowercase keynames 4{"1 keyvalues
NB. y is literal, or 1 or 2-item boxed list.
NB.      0{:: is filename of Ini file to read. (Empty if x is given)
NB.      1{:: is optional comment delimiter (defaults to '#')
NB. x is optional. Either string contents of Ini file, 
NB.      or 5-column boxed table result of parseIni
getIniAllSections=: 3 :0
  '' getIniAllSections y
  :
  'fln delim'=. 2{. boxopen y
  ini=. x
  if. -.*#ini do. NB. read Ini from file
    if. -.fexist fln do. '' return. end. NB. file not found or given
    ini=. freads fln
  end.
  if. *(L.=0:) ini do. NB. parse string contents of Ini file
    if. -.*#delim do. delim=. '#' end. NB. default column delimiter is #
    ini=. delim parseIni ini
  else. NB. x was already parsed
    ini
  end.
)

NB.*getIniSectionNames v Gets section names from INI file 
NB. returns list of boxed section names from the INI string
NB. y is literal, or 1 or 2-item boxed list.
NB.      filename of Ini file to read. Empty if x given.
NB. x is optional. String contents of Ini file (LF delimited) 
getIniSectionNames=: 3 : 0
  '' getIniSectionNames y
  :
  'fln delim'=. 2{. boxopen y
  if. -.*#delim do. delim=. '#' end. NB. default column delimiter is #
  ini=. x
  if. -.*#ini do. NB. read Ini from file
    if. -.fexist fln do. '' return. end. NB. file not found or given
    ini=. freads fln
  end.
  (<'[]')-.~each patsection rxall ini
)

NB.*getIniIndex v returns row index of INI key in parsed INI file
NB. returns 2-item boxed list
NB.     0{ contains numeric row index of INI key in parsed INI file
NB.     1{ contains parsed INI file if not given in x
NB. y is literal, or 1,2,3 or 4-item boxed list.
NB.      literal or 0{:: y is key name to look up
NB.      1{:: y is optional section name of Ini to look for key in
NB.      2{:: is optional file name of Ini file to read.
NB.      3{:: is optional comment delimiter (defaults to '#')
NB. x is optional. Either string contents of Ini file, 
NB.      or 3-column table result of parsing Ini file using parseIni
NB. keyname lookup is case-insensitive
getIniIndex=: 3 :0
  '' getIniIndex y
  :
  'keyn secn fln delim'=. 4{. boxopen y
  if. -.*#delim do. delim=. '#' end. NB. default column delimiter is #
  ini=. x
  ini=. ini getIniAllSections fln;delim
  if. -.*#ini do. '' return. end. NB. error (reading Ini from file)
  parsed=. (L.=0:) x
  NB. look up keyn in 5-column table ini
  if. -.*#secn do. NB. look up keyn ignoring section
    if. (#ini) = i=. (1{"1 ini) i. < tolower keyn do.
      i=.'' NB. keyn not found
    end.
  else. NB. look up keyn within section
    if. (#ini) = i=. (2{."1 ini) i. boxtolower secn;keyn do.
      i=.'' NB. secn;keyn not found
    end.
  end.
  i;< parsed#ini  NB. return parsed ini if not given in x
)

NB.*getIniString v returns INI key value string from INI array
NB. returns INI key value as string
NB. y is literal, or 1,2,3 or 4-item boxed list.
NB.      literal or 0{:: y is key name to look up
NB.      1{:: y is optional section name of Ini to look for key in
NB.      2{:: is optional file name of Ini file to read.
NB.      3{:: is optional comment delimiter (defaults to '#')
NB. x is optional. Either string contents of Ini file, 
NB.      or 3-column table result of parsing Ini file using parseIni
NB. keyname lookup is case-insensitive
getIniString=: 3 : 0
  '' getIniString y
  :
  'i ini'=. 2{.!.a: x getIniIndex y
  if. -.*#ini do. ini=.x end. NB. x was parsed Ini
  if. ''-:i do. i
  else. (<i,4) {:: ini end.
)

NB.*getIniValue v returns INI key value(s) from an INI array
NB. returns INI key string as values (numeric list or boxed list of literals)
NB. y is literal, or 1,2,3 or 4-item boxed list.
NB.      literal or 0{:: y is key name to look up
NB.      1{:: y is optional section name of Ini to look for key in
NB.      2{:: is optional file name of Ini file to read.
NB.      3{:: is optional comment delimiter (defaults to '#')
NB. x is optional. Either string contents of Ini file, 
NB.      or 3-column table result of parsing Ini file using parseIni
NB. keyname lookup is case-insensitive
getIniValue=: [: makeVals getIniString

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
  require 'winapi'
  'fnme snme knme val'=. y
  val=. makeString val
  res=. 'WritePrivateProfileStringA'win32api snme;knme;val;fnme
  0{:: res
)

NB.*parseIni v Parse string contents of an INI file
NB. returns 5-column boxed table 
NB. (section name;key name;lc section name;lc key name;key string)
NB. y is string contents of an Ini file
NB. x is optional character delimiter. Defaults to #.
parseIni=: 3 :0
  '#' parseIni y
  :
  ini=. }.(patsection&rxmatches rxcut ]) y NB. cut on section names & drop first
  'snmes secs'=. <"1 |: (] $~ 2 ,~ -:@#) ini NB. reshape to 2-column table
  snmes=. (<'[]')-.~each snmes
  secs=. x parseIniSection each secs
  nkys=. #&> secs
  secs=. ;(nkys>0)#secs
  ini=. (nkys#snmes),.secs
NB.  (2&{."1 ,.([: boxtolower 2&{."1) ,. {:"1) ini NB. Mixedcase cols 1st
  (([: boxtolower 2&{."1) ,. ]) ini
)

NB.*parseIniSection v parse content of INI file section
parseIniSection=: 3 : 0
  '#' parseIniSection y
  :
  keys=. }.<;._2 y NB. box each line (use LF) and drop first
  keys=. (dtb@(x&taketo)) each keys NB. drop comment & trailing whitespace
  msk=. 0< #@> keys NB. lines of non-zero length
  keys=. msk#keys
  >(<;._1@('='&,)each) keys NB. box on '='
)

patsection=: rxcomp '\[[[:alnum:]]+\]' NB. compile pattern
NB. patsection rxmatches inistr
NB. rxfree patsection  NB. frees compiled pattern resources

getIniAllSections_z_=: getIniAllSections_rgsini_
getIniString_z_=: getIniString_rgsini_
getIniValue_z_=: getIniValue_rgsini_
getIniIndex_z_=: getIniIndex_rgsini_
writePPString_z_=: writePPString_rgsini_
makeVals_z_=: makeVals_rgsini_
