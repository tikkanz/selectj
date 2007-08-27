NB. I think this will be about working out what templates are available
NB. Presenting those options to user


NB.! TraitInfo table abbrev;Full name

NB.*getAllTrtNames v gets names of all defined traits for scenario
NB. result is column of boxed strings, 0{. is <'TrtName'
NB. y is numeric caseinstance id
NB. eg. setcolnames getTrtNames 1
getAllTrtNames=: 3 : 0
  xlfnme=. 'TrtInfo' getFnme y
  }.,1{."1 'tDefn' readexcel xlfnme
)

NB.*getScenarioInfo v gets Scenario info from ini files
NB. y is numeric caseinstance id
NB. x is optional vector of boxed strings specifying info to get
NB.   [default is 'main']
NB. other options will let us read 
getScenarioInfo=: 3 : 0
  'animini' getScenarioInfo y
  :
  for_ityp. boxopen x do.
    select. ityp
      case. <'animini' do.
      fnme=. 'animini' getFnme y
      res=. getPPAllSections fnme
    end.
  end.
)

NB.*getParamState v retrieves parameter state from caseinstance
NB. returns 2- or 3- item boxed list of selectedvalues;values[;valuenames]
NB. y is pr_code (code for parameter eg. 'ncycles')
NB. if selected not relevant result is: '';value

Note 'design for getParamState'
  read whole of ini at once and store in memory (at start of buildform?)
  Individual params read from memory store.
  makeVals key keyval }."1 animini
  also need to read total possible traits from traitinfo
  probably select case for params that can handle inidividual
  should numeric lists be individually boxed?
)
Note 'design for updateParamState'
  read whole of ini at once and store in memory (at start of updateform?)
  writes params to memory store and then write whole 
  memory store to file.
)

