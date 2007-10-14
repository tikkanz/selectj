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
      res=. getIniAllSections fnme
    case. <'alltrtinfo' do.  NB. reads tDefn sheet from TrtInfo.xls
      xlfnme=. 'trtinfo' getFnme y
      'tDefn' readexcel xlfnme
    case. <'status' do. NB. returns currcycle;ncycles from animalsim.ini
      fnme=. 'animini' getFnme y
      ini=. getIniAllSections fnme
      crcyc=. ini getIniValue 1&transName 'curryear'
      ncyc=.  ini getIniValue 'ncycles'
      crcyc;ncyc
  end.
)

updateScenarioInfo=: 3 : 0
  'animini' updateScenarioInfo y
  :
  infotyp=. boxopen x
  select. infotyp
    case. <'animini' do.
      fnme=. <'animini' getFnme y
      res=. writePPString"1 fnme,. 2}."1 ANIMINI
  end.
)

NB.*updateSelnDetails v updates INI file configuration based on submitted Selection Details form
NB. y is caseinstance id
updateSelnDetails=: 3 : 0
  CGIKEYS=: 1&transName each CGIKEYS NB. required until SelectJ and AnimalSim parameter names match
  ANIMINI_z_=: 'animini' getScenarioInfo y
  TRTINFO_z_=: 'alltrtinfo' getScenarioInfo y
  NB. Names of ini keys that need to be updated by processing form info
  keyscalc=. ;:'Trts2Sim Phens2Sim EBVs2Sim GetEBVs SelectListCols Respons2Outpt'
  keyscalc=. keyscalc,;:'ObjectvTrts ObjectvREVs'
  keysform=. ~. qparamKeys'' NB. keys submitted from form
  keysini=. 1{"1 ANIMINI  NB. keys that occur in INI file
  keys2upd8=. ~.(tolower each keyscalc),(keysform e. keysini)#keysform NB. unique list of keys from union of keyscalc and (keysform that also occur in keysini)
  keysform updateKeyState"1 0 keys2upd8
  ANIMINI_z_=: (; (<ANIMINI) getIniIdx each keys2upd8){ANIMINI NB. keep only keys2upd8
  'animini' updateScenarioInfo y NB. write ANIMINI to caseinstance directory
)

NB.*TransNames n Tab-delimited mapping of old to new names.
TransNames=: makeTable 0 : 0
animsummaryfnme  animsumry
curryear         currcycle
flkdams2sire     dams2hrdsire
flksizes         hrdsizes
flkspecfnme      hrdspecfnme
mateallocfnme    matealloc
pedigreefnme     pedigree
sampleflkeffects samplehrdeffects
selnlistfnme     selnlist
traitinfofnme    trtinfo
usesiresxflk     usesiresxhrd
flocks           herds
flock            herd
flk              hrd
)

NB. transType v Reverses columns of TransNames if y is 1
transType=: TransNames |."1~]

NB.*transName v Translates between new names and old names
NB. returns new name if y is old name and x is 0
NB. returns oldname  if y is new name and x is 1
NB. returns y if y is not and old/new name
NB. y is name to translate
NB. x is 0 or 1. 0 for old to new, 1 for new to old
NB.! make caseinsensitive??
transName=: (]keyval [:transType [)^:( (TransNames{"1~[) e.~ [: boxopen ])


NB. e.g. getTrtBase getTrtsOnly 'SelectListCols' getIniVals ANIMINI

NB.*getIniVals v Cover for getIniValue that translates new names to old first
NB. returns interpreted key value of INI key in INI array
NB. y is "new" INI key name to get key value for
NB. x is 5-column parsed Ini file
NB. lookup is case insensitive
getIniVals=: 4 : 0
  x getIniValue ;1 transName y
)


NB.*getIniIdx v Cover for getIniIndex that translates new names to old first
NB. returns numeric row index of INI key in INI array
NB. y is "new" INI key name to get key value for
NB. x is 5-column parsed Ini file
NB. lookup is case insensitive
getIniIdx=: 4 : 0
 'idx ini'=. 2{.!.a: x getIniIndex ;1 transName y
  idx
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

NB.*makeTrtColLbl v Creates Trait column labels
NB. result is boxed list of trait column labels sorted by infotype then trait
NB. y is boxed list of trait base names
NB. x is boxed list of infotypes
makeTrtColLbl=: 3 : 0
  ('phen';'genD';'genDe') makeTrtColLbl y
:
  ps=. ('phen';'genD';'genDe') e. boxopen x
  ps=. ps# ('p';''),('g';'d'),:('g';'de')
  z=. ps prefsuf boxopen y NB. prefix/suffix traits
)

NB.*sortTrtColLbl v Sorts trait column labels by trait then infotype
NB. result is y sorted by trait then infotype
NB. y is boxed list of trait column labels from makeTrtColLbl
NB. x is 2-item integer list 0{x is #Trts, 1{x is #infotypes
sortTrtColLbl=: ] /: ,@|:@i.@[

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
      vals=. <"0 ANIMINI getIniVals y
      nmes=. 'Female';'Male'
    case. 'hrdsizes'    do.
      vals=. <"0 ANIMINI getIniVals y
      if. 1 do. NB.! 'select'-:pr_ctype NB. if select control
        seld=. boxopen vals
        vals=. <"0 (100,200*>:i.5), 1500 2000 4000
      end.
    case. 'mateage' do.
      vals=. <"0 ANIMINI getIniVals y
      nmes=. 'Female';'Male'
    case. 'objectvrevs' do.
      nmes=. ANIMINI getIniVals 'trtsavail' 
      vals=. (#nmes)#a:
      tmpv=. <"0 ANIMINI getIniVals y
      tmpn=. 0{:: getParamState 'trts2select'
      vals=. tmpv (nmes i. tmpn)}vals
    case. 'selnmeth'    do.
      'seld vals nmes'=. getParamState 'coltypes'
      tmp=. ANIMINI getIniVals 'selectlistcols'
      tmp=. getTrtsOnly tmp NB. only Traits
      tmp=. {:>{:tmp  NB. just need to check one (all same type)
      seld=. ('ed' i. tmp){ |.vals NB. dependent on order of vals
    case. 'summtype'    do.
      'seld vals nmes'=. getParamState 'coltypes'
      tmp=. ANIMINI getIniVals'respons2outpt'
      tmp=. getTrtsOnly tmp NB. only Traits
      tmp=. ~.{:@>tmp   NB. unique last chars
      tmp=. (0<+/-.tmp e. 'de'),'de'e.tmp  NB. last chars present
      seld=. tmp#vals   NB. dependent on order of vals
    case. 'trtsrecorded' do.
      vals=. ANIMINI getIniVals 'trtsavail'
      vals=. getTrtsPhn vals
      nmes=. 'TrtCaption' getTrtInfo vals
      seld=. ANIMINI getIniVals y
    case. 'trts2select';'trts2summ' do.
      vals=. ANIMINI getIniVals 'trtsavail'
      nmes=. 'TrtCaption' getTrtInfo vals
      nmes=. ('(',each vals ,each <') '),each nmes
      tmp=. (('trts2select';'trts2summ')i. boxopen y) { 'selectlistcols';'respons2outpt'
      tmp=. ANIMINI getIniVals tmp
      tmp=. getTrtsOnly tmp  NB. only Traits
      tmp=. tmp -. each <'pdge' NB. dropout all of 'pdge'
      seld=. ~. tmp NB. unique traits
    case. do. NB. no special handling required - just look up ANIMINI
    NB. 'currcycle';'ncycles';'dams2hrdsire';'allelefreq';'trtsavail'
      vals=. ANIMINI getIniVals y
      if. isnum vals do. vals=. <"0 vals end.
      vals=. boxopen vals  NB. box any open string
  end.
  seld;vals;<nmes
)

NB.*updateKeyState v updates INI file configuration based on submitted Selection Details form
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
      initrts=. getTrtBase getTrtsOnly ;(<ANIMINI) getIniVals each initrts
      frmtrts=. ;qparamList each frmtrts
      kval=. ~.frmtrts,initrts
    case. 'getebvs'   do.
    NB. 1 if 'genDe' is a member of selnmeth or summtype else 0
      kval=. qparamList key2upd8
      if. ''-:kval do. NB. if not set directly in form
        frmflds=. 'selnmeth';'summtype'
        notset=. -.frmflds e. x
        iniflds=. notset# 'selectlistcols';'respons2outpt'
        isebv=. 'e' e. {:@>getTrtsOnly ;(<ANIMINI) getIniVals each iniflds
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
        kval=. sm makeTrtColLbl trts NB. prefix/suffix trts2select traits based on selnmeth
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
      initrts=. getTrtBase getTrtsOnly ;(<ANIMINI) getIniVals each initrts
      frmtrts=. ;qparamList each frmtrts
      kval=. getTrtsPhn ~.(<'NLB'),frmtrts,initrts  NB. make sure NLB (or LSZ) is included
    case. 'respons2outpt'  do.
      if. (<'trts2summ') e. x do. NB. only calculate if trts2summ is set in form
        trts=. qparamList 'trts2summ'
        if. (<'summtype') e. x do.
          st=. qparamList 'summtype'
        else. st=. 'phen';'genD' end. NB. default to phenotype & genotype if summtype not set
        kval=. st makeTrtColLbl trts NB. prefix/suffix trts2summ traits based on summtype
      else. key2upd8=. '' end.
    case. 'selectlistcols' do.
      if. (<'trts2select') e. x do. NB. only calculate if trts2select is set in form
        trts=. qparamList 'trts2select'
        if. (<'selnmeth') e. x do.
          sm=. qparamList 'selnmeth'
        else. sm=. <'phen' end. NB. default to phenotype if selnmeth not set
        trtflds=. sm makeTrtColLbl trts NB. prefix/suffix trts2select traits based on selnmeth
        nttrt=. getTrtsNot ANIMINI getIniVals key2upd8 NB.non-trait fields already in SelectListCols
        kval=. nttrt,trtflds
      else. key2upd8=. '' end.
    case. 'trts2sim' do.
    NB. unique traits from trtsrecorded,trts2select,trts2summ
      frmtrts=. ;:'trtsrecorded trts2select trts2summ'
    NB. substitute not set keysform above with keysini TrtsRecorded,SelectListCols,Respons2Outpt
      notset=. -. frmtrts e. x
      initrts=. notset# ;:'trtsrecorded selectlistcols respons2outpt'
      initrts=. getTrtBase getTrtsOnly ;(<ANIMINI) getIniVals each initrts
      frmtrts=. ;qparamList each frmtrts
      kval=. ~.frmtrts,initrts
    case. do. NB. default case
      kval=. qparamList key2upd8
  end.
  kidx=. ANIMINI getIniIdx key2upd8
  if. -.''-:kidx do.
    ANIMINI=: (<kval) (<kidx,4) } ANIMINI
  end.
  ''
)
