NB. I think this will be about working out what templates are available
NB. Presenting those options to user

NB.*getScenarioInfo v gets Scenario info from caseinstance folder
NB. y is numeric caseinstance id
NB. x is optional strings specifying info to get
NB.   [default is 'animini']
NB. other options will let us read
getScenarioInfo=: 3 : 0
  'animini' getScenarioInfo y
  :
  infotyp=. boxopen x
  select. infotyp
    case. <'animini' do.
      fnme=. 'animini' getFnme y
      res=. getPPAllSections fnme
    case. <'alltrtinfo' do.  NB. reads tDefn sheet from TrtInfo.xls
      xlfnme=. 'TrtInfo' getFnme y
      'tDefn' readexcel xlfnme
    case. <'status' do. NB. returns curryear;ncycles from animalsim.ini
      fnme=. 'animini' getFnme y
      cryr=. getPPVals fnme;'GenCycle';'CurrYear' 
      ncyc=. getPPVals fnme;'Control';'nCycles'
      cryr;ncyc
  end.
)

updateScenarioInfo=: 3 : 0
  'animini' updateScenarioInfo y
  :
  infotyp=. boxopen x
  select. infotyp
    case. <'animini' do.
      fnme=. <'animini' getFnme y
      res=. writePPString"1 fnme,.ANIMINI
  end.
)

NB.*runAnimalSim v calls AnimalSim for caseinstance
NB. returns 0 if error, 1 if successful
NB. y is caseinstance id
runAnimalSim=: 3 : 0
  inipath=. 'animini' getFnme y
  if. -.fexist inipath do. 0 return. end.
  cryr=. getPPVals key=. inipath;'GenCycle';'CurrYear'
  _1 fork 'c:\program files\animalsim\animalsim ',inipath
  if. fexist  'errorlog.txt',~ cifldr=. 'caseinstfolder' getFnme y do. NB.AnimalSim error
    if. cryr< getPPVals key do.
      writePPString key,<cryr  NB. reset CurrYear
    end.
    0
  else.
    1
  end.
)

NB.*checkCycle v Determines 0th, last or other cycle.
NB. returns -1, 0, 1 for initial cycle, inbetween, last cycle respectively
NB. y is caseinstance id
checkCycle=: 3 : 0
  'cryr ncyc'=. 'status' getScenarioInfo y
  cifldr=. 'caseinstfolder' getFnme y
  issm=. fexist cifldr,'output',PATHSEP_j_,'animsummary.csv'
  res=. (issm *. cryr = ncyc)-cryr=0
)

NB.*validInput v Checks that files required (if any) are valid.
NB. returns 1 for "all good", ??error messages for not??
NB. 
validInput=: 3 : 0
NB. if. stage 21 (Manual selection) then files required
  NB. if. files are present and files are valid (right number of females & males)
  NB. then return 1
  NB. else. return error message.
  NB. end.
NB. else. then no files required, return 1
NB. end.
1
)

NB.*updateSelnDetails v updates INI file configuration based on submitted Selection Details form
NB. y is caseinstance id
updateSelnDetails=: 3 : 0
  translateNewNames '' NB. required until SelectJ and AnimalSim parameter names match
  ANIMINI_z_=: 'animini' getScenarioInfo y
  TRTINFO_z_=: 'alltrtinfo' getScenarioInfo y
  NB. Names of ini keys that need to be updated by processing form info
  keyscalc=. ;:'Trts2Sim Phens2Sim EBVs2Sim GetEBVs SelectListCols Respons2Outpt'
  keyscalc=. keyscalc,;:'ObjectvTrts ObjectvREVs'
  keysform=. ~. qparamKeys'' NB. keys submitted from form
  keysini=. tolower each 1{"1 ANIMINI  NB. keys that occur in INI file
  keys2upd8=. ~.(tolower each keyscalc),(keysform e. keysini)#keysform NB. unique list of keys from union of keyscalc and (keysform that also occur in keysini)
  keysform updateKeyState"1 0 keys2upd8
  ANIMINI_z_=: (; keys2upd8 getIniIdx each <ANIMINI){ANIMINI NB. keep only keys2upd8
  'animini' updateScenarioInfo y NB. write ANIMINI to caseinstance directory
)

NB. replace any new SelectJ parameter names that occur in CGIKEYS with old AnimalSim names
translateNewNames=: 3 : 0
  new=. ;:'hrdsizes dams2hrdsire usesiresxhrd samplehrdeffects hrdspecfnme currcycle'
  old=. ;:'flksizes flkdams2sire usesiresxflk sampleflkeffects flkspecfnme curryear'
  msk=. (#CGIKEYS)>idx=. CGIKEYS i. new
  CGIKEYS=: (msk#old) (msk#idx)}CGIKEYS
)

NB.*getIniVals v returns INI key value(s) from an INI array
NB. returns INI key string as values
NB. y is INI key name to get key value for
NB. x is 3-column array. 0{"1 INI section names, 1{"1 INI key names, 2{"1 INI key values
NB. getIniVals=: 3 : 'makeVals y keyval }."1 ANIMINI'
getIniVals=: [: makeVals getIniStr

NB. e.g. getTrtBase getTrtsOnly 'SelectListCols' getIniVals ANIMINI

NB.*getIniStr v returns INI key value string from INI array
NB. returns INI key value as string
NB. y is 3-column array. 0{"1 INI section names, 1{"1 INI key names, 2{"1 INI key values
NB. x is INI key name to get key value for
getIniStr=: 4 : 0
  i=. x getIniIdx y
  if. ''-:i do.
    i else.  (<i,2) {:: y end.
)

NB.*getIniIdx v returns row index of INI key in INI array
NB. returns numeric row index of INI key in INI array
NB. y is 3-column array. 0{"1 INI section names, 1{"1 INI key names, 2{"1 INI key values
NB. x is INI key name to get key value for
NB. lookup is case insensitive
getIniIdx=: ''&$: : (4 : 0)
  if. (#y) > i=. (tolower each 1{"1 y) i. <,>tolower x do.
    i else. '' end.
)

NB. http://www.jsoftware.com/pipermail/programming/2007-August/007999.html
NB. e.g. (<'g';'de') prefsuf 'NLB';'LW8';'FW12'
NB.      <==> 'gNLBde';'gLW8de';'gFW12de'
NB. e.g. (('p';'');(<'g';'de')) prefsuf 'NLB';'LW8';'FW12'
NB.      <==>  'pNLB';'pLW8';'pFW12';'gNLBde';'gLW8de';'gFW12de'
NB. prefsuf=: ([: {. [ ,&.> ] ,&.> [: {: [)"1 0
NB. prefsuf=: [: ; [: ; [: ([: {. [ ,&.> ] ,&.> [: {: [)"1 0&.>/&.> [: <"1 [ ,/"0 [: < ]
NB. prefsuf=: [:,(>@{.@[,],>@{:@[)&.>"0 _

NB. e.g. (('p';''),:('g';'de')) prefsuf 'NLB';'LW8';'FW12'
NB.      <==>  'pNLB';'pLW8';'pFW12';'gNLBde';'gLW8de';'gFW12de'
prefsuf=: [:,<@;@(1&C.)@,"1 0/

NB.*getTrtBase v removes lowercase suffixes and prefixes from Traits names
NB. returns list of boxed base names for traits
NB. y is a list of boxed trait field names e.g. ;:'gLW8d pNLB gFW12de'
getTrtBase=: ((<'pgde') -.&.>~ ])

NB.*getTrtsOnly v returns only trait field names
NB. returns list of boxed trait field names (looks for starting 'p' or 'g')
NB. y is a list of boxed names e.g. ;:'Tag Flk BR gLW8d pNLB gFW12de'
getTrtsOnly=: ] #~ 'pg' e.~ {.@>

NB.*getTrtsNot v returns only field names that aren't trait field names
NB. returns list of boxed field names (looks for not starting with 'p' or 'g')
NB. y is a list of boxed field names e.g. ;:'Tag Flk BR gLW8d pNLB gFW12de'
getTrtsNot=:  ] #~ [: -. 'pg' e.~ {.@>

NB.*getTrtInfo v looks up column of tDefn sheet for each trait
NB. returns list of boxed column info for each trait in y
NB. y is list of boxed base trait names
NB. x is list of boxed column names to look up
NB. getTrtInfo=: TRTINFO {~[:<(({."1 TRTINFO) i.]);({.TRTINFO) i.[:<[
NB. e.g. 'AOM' getTrtInfo 'LW8';'NLB'
getTrtInfo=: 3 : 0
'TrtCaption' getTrtInfo y
:
  if. (#{.TRTINFO)=cidx=. ({.TRTINFO) i. boxopen x do. '' return. end.
  msk=. (#TRTINFO)>ridx=. ({."1 TRTINFO) i. boxopen y
  ridx=. msk#ridx
  (<ridx;cidx){TRTINFO
)

NB.*getTrtsPhn v Returns base trait names for which phenotypes can be recorded.
NB. returns list of boxed base names for traits that can be recorded
NB. y is a list of boxed base names for traits
NB.! length error if trt name in y not found in TRTINFO
getTrtsPhn=: 3 : 0
      msk=. 9999&~:@>'AOM' getTrtInfo y NB. recordable traits
      res=. msk#y
)

NB.*getParamState v retrieves parameter state from caseinstance
NB. returns 3- item boxed list of selectedvalues;values;valuenames
NB. y is pr_code (code for parameter eg. 'ncycles')
NB.! x is caseinstance id  or maybe just get cookie for params where ciid reqd.
NB. if selected not relevant result is: '';value
getParamState=: 3 : 0
  '' getParamState y
  :
  seld=. vals=. nmes=. a:  NB. initialize outputs
  select. y
    case. 'coltypes' do.
      seld=. <'phen'
      vals=. ;:'phen genD genDe'
      nmes=. 'Phenotypes';'Genotypes';'Estimated Breeding Values'
    case. 'cullage' do.
      vals=. <"0 y getIniVals ANIMINI
      nmes=. 'Female';'Male'
    case. 'hrdsizes'    do.
      vals=. 'flksizes' getIniVals ANIMINI
      if. 1 do. NB. 'select'-:pr_ctype NB. if select control
        seld=. boxopen vals
        vals=. <"0 (100,200*>:i.5), 1500 2000 4000
      end.
    case. 'mateage' do.
      vals=. <"0 y getIniVals ANIMINI
      nmes=. 'Female';'Male'
    case. 'objectvrevs' do.
      nmes=. 'trtsavail' getIniVals ANIMINI
      vals=. (#nmes)#a:
      tmpv=. <"0 y getIniVals ANIMINI
      tmpn=. 0{:: getParamState 'trts2select'
      vals=. tmpv (nmes i. tmpn)}vals
    case. 'selnmeth'    do.
      'seld vals nmes'=. getParamState 'coltypes'
      tmp=. 'selectlistcols' getIniVals ANIMINI
      tmp=. getTrtsOnly tmp NB. only Traits
      tmp=. {:>{:tmp  NB. just need to check one (all same type)
      seld=. ('ed' i. tmp){ |.vals NB. dependent on order of vals
    case. 'summtype'    do.
      'seld vals nmes'=. getParamState 'coltypes'
      tmp=. 'respons2outpt' getIniVals ANIMINI
      tmp=. getTrtsOnly tmp NB. only Traits
      tmp=. ~.{:@>tmp   NB. unique last chars
      tmp=. (0<+/-.tmp e. 'de'),'de'e.tmp  NB. last chars present
      seld=. tmp#vals   NB. dependent on order of vals
    case. 'trtsrecorded' do.
      vals=. 'trtsavail' getIniVals ANIMINI
      vals=. getTrtsPhn vals
      nmes=. 'TrtCaption' getTrtInfo vals
      seld=. y getIniVals ANIMINI
    case. 'trts2select';'trts2summ' do.
      vals=. 'trtsavail' getIniVals ANIMINI
      nmes=. 'TrtCaption' getTrtInfo vals
      nmes=. ('(',each vals ,each <') '),each nmes
      tmp=. (('trts2select';'trts2summ')i. boxopen y) { 'selectlistcols';'respons2outpt'
      tmp=. tmp getIniVals ANIMINI
      tmp=. getTrtsOnly tmp  NB. only Traits
      tmp=. tmp -. each <'pdge' NB. dropout all of 'pdge'
      seld=. ~. tmp NB. unique traits
      
    NB. Next cases just use different names than AnimalSim
    NB. Once AnimalSim updated to use 'hrd' names, can remove these cases.
    case. 'currcycle' do.
      'seld vals nmes'=. getParamState 'curryear'
    case. 'dams2hrdsire' do.
      'seld vals nmes'=. getParamState 'flkdams2sire'
    case. 'hrdspecfnme' do.
      'seld vals nmes'=. getParamState 'flkspecfnme'
    case. 'samplehrdeffects' do.
      'seld vals nmes'=. getParamState 'sampleflkeffects'
    case. 'usesiresxhrd' do.
      'seld vals nmes'=. getParamState 'usesiresxflk'
    case. do. NB. no special handling required - just look up ANIMINI
    NB. 'curryear';'ncycles';'dams2sire';'cullage';'mateage';
    NB. 'allelefreq';'trtsavail'
      vals=. y getIniVals ANIMINI
      if. isnum vals do. vals=. <"0 vals end.
      vals=. boxopen vals  NB. box any open string
  end.
  seld;vals;<nmes
)

NB.* updateKeyState v updates INI file configuration based on submitted Selection Details form
NB. y is boxed key to update
NB. x is list of boxed keys set by form
updateKeyState=: 4 : 0
  key2upd8=. >y
  select. key2upd8
    case. 'ebvs2sim'  do.
    NB. unique traits from (trts2select if selnmeth is genDe) and (trts2summ if summtype includes genDe)
      msk=. (<'genDe') e."0 1> qparamList each 'selnmeth';'summtype'
      frmtrts=. msk#'trts2select';'trts2summ'
    NB. substitute not set keysform above with keysini SelectListCols,Respons2Outpt
      notset=. -.frmtrts e. x
      initrts=. notset# msk#'selectlistcols';'respons2outpt'
      initrts=. getTrtBase getTrtsOnly ;initrts getIniVals each <ANIMINI
      frmtrts=. ;qparamList each frmtrts
      kval=. ~.frmtrts,initrts
    case. 'getebvs'   do.
    NB. 1 if 'genDe' is a member of selnmeth or summtype else 0
      kval=. qparamList key2upd8
      if. ''-:kval do. NB. if not set directly in form
        frmflds=. 'selnmeth';'summtype'
        notset=. -.frmflds e. x
        iniflds=. notset# 'selectlistcols';'respons2outpt'
        isebv=. 'e' e. {:@>getTrtsOnly ;iniflds getIniVals each <ANIMINI
        kval=. +./isebv,(<'genDe') e."0 1> qparamList each frmflds
        key2upd8=. (*./notset){:: key2upd8;'' NB. leave key if no frmflds set in form
      end.
    case. 'objectvrevs'    do.
      if. (<'objectvrevs') e. x do.
        kval=. qparamList key2upd8
      else.
        if. (<'trts2select') e. x do. NB. if trts2select set by form then
          kval=. (# qparamList 'trts2select')#1 NB. use 1 for each objectvtrts
        else. key2upd8=. '' end. NB. don't update key
      end.
    case. 'objectvtrts'    do.
      if. (<'trts2select') e. x do. NB. only calculate if trts2select is set in form
        trts=. qparamList 'trts2select'
        if. (<'selnmeth') e. x do.
          sm=. qparamList 'selnmeth'
        else. sm=. <'phen' end. NB. default to phenotype if selnmeth not set
        ps=. ('phen';'genD';'genDe') e. sm
        ps=. ps# ('p';''),('g';'d'),:('g';'de')
        kval=. ps prefsuf trts NB. prefix/suffix trts2select traits based on selnmeth
        kval=. (<'BR') (kval ((([: # [) > [ i. [: < ]) # [ i. [: < ]) 'pNLB')} kval NB. use birth rank for pNLB
      else. key2upd8=. '' end. NB. don't update key
    case. 'phens2sim' do.
    NB. unique traits from trtsrecorded (and trts2select if selnmeth is phen) (and trts2summ if summtype includes phen)
      frmtyps=. 'selnmeth';'summtype'
      notset=. -.frmtyps e. x
      msk=. (<'phen') e."0 1> qparamList each 'selnmeth';'summtype'
      msk=. notset +. msk
      frmtrts=. (<'trtsrecorded'),msk#'trts2select';'trts2summ'
    NB. substitute not set keysform above with keysini TrtsRecorded,SelectListCols,Respons2Outpt
      notset=. -.frmtrts e. x
      initrts=. notset# (<'trtsrecorded'),msk#'selectlistcols';'respons2outpt'
      initrts=. getTrtBase getTrtsOnly ;initrts getIniVals each <ANIMINI
      frmtrts=. ;qparamList each frmtrts
      kval=. getTrtsPhn ~.(<'NLB'),frmtrts,initrts  NB. make sure NLB (or LSZ) is included
    case. 'respons2outpt'  do.
      if. (<'trts2summ') e. x do. NB. only calculate if trts2summ is set in form
        trts=. qparamList 'trts2summ'
        if. (<'summtype') e. x do.
          st=. qparamList 'summtype'
        else. st=. 'phen';'genD' end. NB. default to phenotype & genotype if summtype not set
        ps=. ('phen';'genD';'genDe') e. st
        ps=. ps# ('p';''),('g';'d'),:('g';'de')
        kval=. ps prefsuf trts NB. prefix/suffix trts2summ traits based on summtype
      else. key2upd8=. '' end.
    case. 'selectlistcols' do.
      if. (<'trts2select') e. x do. NB. only calculate if trts2select is set in form
        trts=. qparamList 'trts2select'
        if. (<'selnmeth') e. x do.
          sm=. qparamList 'selnmeth'
        else. sm=. <'phen' end. NB. default to phenotype if selnmeth not set
        ps=. ('phen';'genD';'genDe') e. sm
        ps=. ps# ('p';''),('g';'d'),:('g';'de')
        trtflds=. ps prefsuf trts NB. prefix/suffix trts2select traits based on selnmeth
        nttrt=. getTrtsNot key2upd8 getIniVals ANIMINI NB.non-trait fields already in SelectListCols
        kval=. nttrt,trtflds
      else. key2upd8=. '' end.
    case. 'trts2sim' do.
    NB. unique traits from trtsrecorded,trts2select,trts2summ
      frmtrts=. ;:'trtsrecorded trts2select trts2summ'
    NB. substitute not set keysform above with keysini TrtsRecorded,SelectListCols,Respons2Outpt
      notset=. -. frmtrts e. x
      initrts=. notset# ;:'trtsrecorded selectlistcols respons2outpt'
      initrts=. getTrtBase getTrtsOnly ;initrts getIniVals each <ANIMINI
      frmtrts=. ;qparamList each frmtrts
      kval=. ~.frmtrts,initrts
    case. do. NB. default case
      kval=. qparamList key2upd8
  end.
  kidx=. key2upd8 getIniIdx ANIMINI
  if. -.''-:kidx do.
    ANIMINI=: (<kval) (<kidx,2) } ANIMINI
  end.
  ''
)
