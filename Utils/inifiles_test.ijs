NB. Tests for inifiles
   load '~user/projects/utils/inifiles.ijs'
   INIPATH=: jpath '~temp/example.ini'
   NB. copy example.ini to temp folder
   INIPATH fwrites~ freads jpath '~users/projects/utils/inifiles_example.ini'
   freads INIPATH

NB. Test1: test that parseIni and makeIni are inverse of each other
   ini1=. parseIni_rgsini_ freads INIPATH
   ini2=: parseIni_rgsini_ makeIni_rgsini_ ini1
   'inis do not match. Test1' assert ini1-:ini2

NB. Test2: test different forms of ini input
   ]ini1=: getIniAllSections INIPATH
   ini2=: (freads INIPATH) getIniAllSections ''
   ini3=: (getIniAllSections INIPATH) getIniAllSections ''
   'inis do not match. Test2' assert *./ ini1&-: every ini2;<ini3

NB. Test3: test different forms of ini input
   ]res1=: getIniString 'BrkAtModule';'Control';INIPATH
   res2=: (freads INIPATH) getIniString 'BrkAtModule';'Control'
   res3=: ini1 getIniString 'brkatmodule';'control' NB. names are not case sensitive
   res4=: ini1 getIniString 'BrkAtModule' NB. section not required if keynames unique
   res5=: ini1 getIniValue 'BrkAtModule' NB. getIniValue is same as getIniString for literal value
   'results do not match. Test3' assert *./ res1&-: every res5;res4;res2;<res3

NB. Test4: Difference between getIniString and getIniValue
   ]res1=: ini1 getIniString 'Colors'
   ]res2=: ini1 getIniValue 'Colors'
   ]res3=: ini1 getIniValue 'Border'
   res4=: getIniValue 'Border';'formats';INIPATH
   ]res5=: 4+ini1 getIniValue 'Border'
   'results do not match. Test4a' assert res1 -: ' ' join_rgsini_ res2
   'results do not match. Test4b' assert res3&-: each res4;<_4+res5

NB. Test5: updateIniString and get it again
   newval=: 'Fatal Attraction'
   res1=: updateIniStrings newval;'FavMovie';'User';INIPATH
   res2=: res1 getIniString 'FavMovie'
   'results do not match. Test5a' assert newval-:res2
   newval=: 155 155 155
   res1=: res1 updateIniStrings newval;'Border';'Formats'
   res2=: res1 getIniValue 'Border'
   'results do not match. Test5b' assert newval-:res2

NB. Test6: writeIniString and get it again
   newval=: 'Finding Nemo'
   res1=: writeIniStrings newval;'FavMovie';'User';INIPATH
   res2=: getIniString 'FavMovie';'User';INIPATH
   'results do not match. Test6a' assert newval-:res2
   newval=: 'Black';'White';'RedAllOver'
   res1=: writeIniStrings newval;'colors';'Formats';INIPATH
   res2=: getIniValue 'Colors';'Formats';INIPATH
   'results do not match. Test6b' assert newval-:res2

NB. Test7: update/writeIniString for new key and get it again
   res1=: getIniString 'FavSong';'User';INIPATH
   'results should match. Test7a' assert ''-: res1
   newval=: 'Make the Devil Mad'
   res2=: updateIniStrings newval;'FavSong';'User';INIPATH
   res3=: res2 getIniString 'FavSong';'User'
   'results should match. Test7b' assert newval-:res3
   newval=: 'Not empty now!'
   res2=: writeIniStrings newval;'Here';'EmptySection';INIPATH
   res3=: getIniString 'Here';'EmptySection';INIPATH
   'results should match. Test7c' assert newval-:res3

NB. Test8: write change to new INI file
   INIPATH2=: jpath '~temp/example2.ini'
   (INIPATH2,' already exists. Test6c') assert -.fexist INIPATH2
   ini1=: getIniAllSections INIPATH
   newval=: 'Pink Blue Yellow'
   res1=: ini1 writeIniStrings newval;'colors';'Formats';INIPATH2
   res2=: getIniString 'Colors';'Formats';INIPATH2
   res3=: getIniString 'Colors';'Formats';INIPATH
   'results should match. Test8a' assert newval-:res2
   'results should not match. Test8b' assert -.newval-:res3

NB. look up multiple keynames at once
   ]keys2get=. ('brkatmodule';'control'),('ColoRs';'Formats'),:'Birthdate';'User'
   ini1 getIniStrings keys2get
   ini1 <@getIniString"_ 1 keys2get
   ini1 <@getIniValue"_ 1 keys2get

NB. if keyname is unique across all sections then
NB. can safely lookup just on keyname
   ini1 getIniStrings ,.{."1 keys2get
   ini1 <@getIniString"_ 0 {."1 keys2get
   ini1 <@getIniValue"_ 0 {."1 keys2get

NB. update multiple keynames at once
   updateIniStrings ('Mod2';'Pink Blue';2006 3 3),.keys2get,.<INIPATH
   ini1 updateIniStrings ('Mod2';'Pink Blue';2006 3 3),.keys2get
   
   