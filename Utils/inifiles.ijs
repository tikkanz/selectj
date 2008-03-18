NB. verbs for reading from & writing to INI files
NB. writing to INI files currently requires winapi

require 'files regex strings'
coclass 'rgsini'

Note 'get Ini string'
inistr=. freads 'animinipath' getFnme 2  NB. use for file on disk
inistr=. toJ zread <"1&dtb"1 'animinipathSTORED' getFnme y NB. use for file in zip
)

boxtolower=: 13 : '($y) $ <;._2 tolower ; y ,each {:a.'

NB.*getIniAllSections v Gets all the keynames and values in an INI file
NB. returns 5-column boxed table,
NB.      0{"1 lowercase sectionnames, 1{"1 lowercase keynames,  
NB.      2{"1 sectionnames, 3{"1 keynames, 4{"1 keyvalues and comments
NB. y is literal filename of Ini file to read. (Empty if x is given)
NB. x is optional. Either string contents of Ini file, 
NB.      or 5-column boxed table result of parseIni
getIniAllSections=: 3 :0
  '' getIniAllSections y
  :
  fln=. 0{:: ,boxopen y
  ini=. x
  if. -.*#ini do. NB. read Ini from file
    if. -.fexist fln do. '' return. end. NB. file not found or given
    ini=. freads fln
  end.
  if. *(L.=0:) ini do. NB. parse string contents of Ini file
    ini=. parseIni ini
  else. NB. x was already parsed
    ini
  end.
)

NB.*getIniSectionNames v Gets section names from INI file 
NB. returns list of boxed section names from the INI string
NB. y is literal filename of Ini file to read. Empty if x given.
NB. x is optional. String contents of Ini file (LF delimited) 
getIniSectionNames=: 3 : 0
  '' getIniSectionNames y
  :
  fln=. 0{:: ,boxopen y
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
NB. y is literal, or 1,2 or 3-item boxed list.
NB.      literal or 0{:: y is key name to look up
NB.      1{:: y is optional section name of Ini to look for key in
NB.      2{:: is optional file name of Ini file to read.
NB. x is optional. Either string contents of Ini file, 
NB.      or 5-column table result of parsing Ini file using parseIni
NB. keyname lookup is case-insensitive
getIniIndex=: 3 :0
  '' getIniIndex y
  :
  'keyn secn fln'=. 3{. boxopen y
  ini=. x
  ini=. ini getIniAllSections fln
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
NB.      or 5-column table result of parsing Ini file using parseIni
NB. keyname lookup is case-insensitive
getIniString=: 3 : 0
  '' getIniString y
  :
  'i ini'=. 2{.!.a: x getIniIndex y
  delim=. 3{:: 4{. boxopen y
  if. -.*#delim do. delim=. '#' end. NB. default column delimiter is #  
  if. -.*#ini do. ini=.x end. NB. x was parsed Ini
  if. ''-:i do. i
  else. dtb@(delim&taketo) (<i,4) {:: ini end.
)

NB.*getIniValue v returns INI key value(s) from an INI array
NB. returns INI key string as values (numeric list or boxed list of literals)
NB. y is literal, or 1,2,3 or 4-item boxed list.
NB.      literal or 0{:: y is key name to look up
NB.      1{:: y is optional section name of Ini to look for key in
NB.      2{:: is optional file name of Ini file to read.
NB.      3{:: is optional comment delimiter (defaults to '#')
NB. x is optional. Either string contents of Ini file, 
NB.      or 5-column table result of parsing Ini file using parseIni
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

NB.*writeIniString v Writes key and key value to an INI file
NB. returns Boolean, 1 if wrote OK, otherwise 0.
NB. y is 2,3,4 or 5-item boxed list.
NB.      0{:: y is key value to write
NB.      1{:: y is key name to write
NB.      2{:: y is optional section name of Ini to look for key in
NB.      3{:: is optional file name of Ini file to write to.
NB.      4{:: is optional comment delimiter (defaults to '#')
NB. x is optional. Either string contents of Ini file, 
NB.      or 5-column table result of parsing Ini file using parseIni
NB. keyname lookup is case-insensitive
writeIniString=: 3 : 0
  '' writeIniString y
  :
  'i ini'=. 2{.!.a: x getIniIndex }.y
  if. -.*#ini do. ini=.x end. NB. x was parsed Ini
  ini=. 2}."1 ini NB. drop lowercase columns
  if. ''-:i do. NB. append key name
    ini=. ini,|. 3{.y  
  else. 
    ini=. ({.y) (<i,2) } ini  NB. amend key value
  end.
  NB.! write 5-column table to file and report success.
)

Note 'verbs required for writing inifile'
writeIniString NB. accepts parsed ini or reads ini, updates value, writes boxed table to ini file
updateIniString NB. amends parsed Ini or reads ini, returns amended boxed table
writeAllIniSections NB. writes parsed Ini to file in INI format.

To update multiple keys at once, need a verb to amend
values of boxed table without writing.
So to do that, ReadIniAllSections, updateIniString for each key, writeAllIniSections.
)

NB.*makeIni v Create string with INI format from 5-column boxed table
NB. returns literal in format of INI file.
NB. y is 5-column boxed table (result of parseIni)
makeIni=: 3 : 0
  ini=. 2}."1 y NB. drop lowercase columns
  'snmes keys'=. split |: ini
  secs=. snmes </. |: keys
  ini=. (~.snmes) makeIniSection each secs
  (],LF -. {:) LF join ini NB. join with LFs and ensure trailing LF
)

NB.*makeIniSection v 
makeIniSection=: 4 : 0
  'snme sec'=. x;<y
  snme =. '[',snme,']'
  msk=. -.*#&>{."1 sec NB. where no keyname
  sec=. <@('='&join)"1 sec
  sec=. msk }.&.> sec  NB. drop first ('=') where no keyname
  LF join snme;sec  NB. join lines with LFs
)

NB.*parseIni v Parse string contents of an INI file
NB. returns 5-column boxed table 
NB. (lc section name;lc key name;section name;key name;key string & comments)
NB. y is string contents of an Ini file
parseIni=: 3 :0
  ini=. }.(patsection&rxmatches rxcut ]) y NB. cut on section names & drop first
  'snmes secs'=. <"1 |: (] $~ 2 ,~ -:@#) ini NB. reshape to 2-column table
  snmes=. (<'[]')-.~each snmes
  secs=. parseIniSection each secs
  nkys=. 1 >. #&> secs
  ini=. (nkys#snmes),. ;secs
  (([: boxtolower 2&{."1) ,. ]) ini
)

NB.*parseIniSection v parse content of INI file section
parseIniSection=: 3 : 0
  keys=. }.<;._2 (],LF -. {:) y NB. box each line (using LF) and drop first
  NB. keys=. (dtb@(x&taketo)) each keys NB. drop comment & trailing whitespace
  msk=. 0< #@> keys NB. lines of non-zero length
  keys=. msk#keys
  NB. >(<;._1@('='&,)) &.> keys
  |."1 > |.@(<;._1@('='&,)) &.> keys NB. box on '='
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
