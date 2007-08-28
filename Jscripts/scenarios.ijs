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
    case. <'alltrtinfo' do.
      xlfnme=. 'TrtInfo' getFnme y
      'tDefn' readexcel xlfnme
  end.
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
    case. 'hrdsizes'    do.
      vals=. makeVals 'flksizes' keyval ANIMINI
      if. 1 do. NB. 'select'-:pr_ctype NB. if select control
        seld=. boxopen vals
        vals=. <"0 (100,200*>:i.5), 1500 2000 4000
      end.
    case. 'selnmeth'    do.
      'seld vals nmes'=. getParamState 'coltypes'
      tmp=. makeVals 'selectlistcols' keyval ANIMINI
      tmp=. (({.@> tmp) e. 'pg')#tmp NB. just p's & g's
      tmp=. {:>{:tmp  NB. just need to check one (all same type)
      seld=. ('ed' i. tmp){ |.vals NB. dependent on order of vals
    case. 'summtype'    do.
      'seld vals nmes'=. getParamState 'coltypes'
      tmp=. makeVals 'respons2outpt' keyval ANIMINI
      tmp=. (({.@> tmp) e. 'pg')#tmp NB. just p's & g's
      tmp=. ~.{:@>tmp   NB. unique last chars
      tmp=. (0<+/-.tmp e. 'de'),'de'e.tmp  NB. last chars present
      seld=. tmp#vals   NB. dependent on order of vals
    case. 'coltypes' do.
      seld=. <'phen'
      vals=. ;:'phen genD genDe'
      nmes=. 'Phenotypes';'Genotypes';'Estimated Breeding Values'
    case. 'trts2select';'trts2summ' do.
      vals=. makeVals 'trtsavail' keyval ANIMINI
      getTrtInfo=. TRTINFO {~[:<(({."1 TRTINFO) i.]);({.TRTINFO) i.[:<[
      nmes=. 'TrtCaption' getTrtInfo vals
      nmes=. ('(',each vals ,each <') '),each nmes
      tmp=. (('trts2select';'trts2summ')i. boxopen y) { 'selectlistcols';'respons2outpt'
      tmp=. makeVals tmp keyval ANIMINI
      tmp=. (({.@> tmp) e. 'pg')#tmp NB. just p's & g's
      tmp=. tmp -. each <'pdge' NB. dropout all of 'pdge'
      seld=. ~. tmp NB. unique traits
    case. 'objectvrevs' do.
      nmes=. makeVals 'trtsavail' keyval ANIMINI
      vals=. (#nmes)#a:
      tmpv=. <"0 makeVals y keyval ANIMINI
      tmpn=. 0{:: getParamState 'trts2select'
      vals=. tmpv (nmes i. tmpn)}vals
    case. 'trtsrecorded' do.
      vals=. makeVals 'trtsavail' keyval ANIMINI
      getTrtInfo=. TRTINFO {~[:<(({."1 TRTINFO) i.]);({.TRTINFO) i.[:<[
      msk=. 9999&~:@>'AOM' getTrtInfo vals NB. recordable traits
      vals=. msk#vals
      nmes=. 'TrtCaption' getTrtInfo vals
      seld=. makeVals y keyval ANIMINI

    NB. Next cases just use diff names to AnimalSim
    NB. Once AnimalSim updated to use 'hrd' names, can remove these cases.
    case. 'dams2hrdsire' do.
      'seld vals nmes' =. getParamState 'flkdams2sire'
    case. 'usesiresxhrd' do. 
      'seld vals nmes' =. getParamState 'usesiresxflk'
    case. 'samplehrdeffects' do. 
      'seld vals nmes' =. getParamState 'sampleflkeffects'
    case. 'hrdspecfnme' do. 
      'seld vals nmes' =. getParamState 'flkspecfnme'
    case. 'currcycle' do. 
      'seld vals nmes' =. getParamState 'curryear'
    case. do. NB. no special handling required - just look up ANIMINI
      NB. 'curryear';'ncycles';'dams2sire';'cullage';'mateage';
      NB. 'allelefreq';'trtsavail'
      vals=. makeVals y keyval ANIMINI
      if. isnum vals do. vals=. <"0 vals end.
      vals=. boxopen vals  NB. box any open string 
  end.
  seld;vals;<nmes
)


Note 'design for updateParamState'
read whole of ini at once and store in memory (at start of updateform?)
writes params to memory store and then write whole
memory store to file.
)

