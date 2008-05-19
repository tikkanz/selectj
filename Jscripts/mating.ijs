NB. =========================================================
NB. verbs for to do with selection and mate allocation lists, breeding

NB.*makeMateAlloc v Checks selection lists are correct, creates and writes MateAlloc.csv.
NB. returns list of boxed error messages if error(s) or 1 if all OK.
NB. y is 2-row (female, male) by 2-column (filename, filecontents) boxed array
NB. x is caseinstance id
makeMateAlloc=: 4 : 0
  okexist=. -.a:= fnms=. {."1 y  NB. files were found and uploaded
  okext=. '.csv'(-:"1) _4&{.@> fnms  NB. have '.csv' extension
  NB.oklen=.*#@> {:"1 y NB. not zero length
  msg=. 'selection list doesn''t exist.';'selection list file extension is not ".csv".'
  msg=. |:2 2$(,.'Female ';'Male ') prefsuf msg
  if. *./*./ok=. okexist,:okext do. NB. continue checks
    fcs=. fixcsv each toJ each {:"1 y NB. file contents
    hdrs=. {.!.a: each fcs NB. headers
    fcs=. }.each fcs NB. drop headers
    NB. Headers must contain (Tag or uid) and (Flk or Flock)
    okhdr=. (([: +./"1('Flk';'Flock')&e."1)*.[: +./"1('uid';'Tag')&e."1) >hdrs
    ms=. boxopen 'selection list does not contain "Tag" and/or "Flk" column labels.'
    msg=. msg, (,.'Female ';'Male ') prefsuf ms
    if. *./*./ok=. ok,okhdr do. NB. continue checks
      anini=. 'animini' getInfo x
      'ndams d2s xhrd'=. (<anini) getIniVals each ('hrdsizes';'dams2hrdsire';'usesiresxhrd')
      nsires=. <.0.5&+ ndams%d2s   NB. no. of males required for each sub-popln
      NB.! add handling for across-herd as well as within-herd mating of sires
      idx=. <"0 <./"1 (>hdrs) i."1 'Flk';'Flock' NB. get index of Flock/Flk columns in selection lists column labels
      hrds=. idx {"1 each fcs NB. get flock/flk columns from selection lists
      nprnts=. (([: #@> </.~) /: ~.) each hrds NB. no. of occurences of each flock number (sorted ascending by flock no)
      okf=. (listatom ndams)-: nfems=. 0{::nprnts NB. check correct number of females listed (for each sub-popln)
      okm=. *./3>|nsires- nmales=. _1{::nprnts NB. check approx correct number of males listed (for each sub-popln)
      ms=. 'Female selection list contained ',(":nfems),' animals, there should be ',(":ndams),'.'
      msg=. msg, ms;'Male selection list contained ',(":nmales),' animals, there should be approximately ',(":nsires),'.'
      ok=. ok,okf,okm
    end.
  end.
  if. *./*./ok do. NB. passed all checks
    fpth=. 'mateallocpath' getFnme x
    dat=. xhrd allocateMatings hdrs,.fcs
    ok=. 0<(;dat) writecsv fpth
    msg=. ok{:: 'Error writing Mate Allocation file';1
  else.
    msg=. (,-.ok)#,msg
  end.
)

NB.*allocateMatings v Allocates matings for list of dams and sires.
NB. returns 2-item boxed list containing
NB.     0{ list of boxed column labels for array in 1{
NB. 	1{ 2d array of four columns damtag, damFlkID & siretag, sireFlkID.
NB. 	   Each row is a mating. Dams should only appear once, sires can appear many times.
NB. y is 2-item, rank 2, boxed list containing
NB.     0{   2-item boxed list of female info
NB.     1{   2-item boxed list of smale info
NB.     0{"1 lists of boxed column labels for array in 1{"1
NB.     1{"1 2d array of parent info (row for each parent, column for each label in 0{"1.
NB. x is boolean whether selection is across-herd
allocateMatings=: 4 : 0
  lbls=. >{."1 y
  slsts=. {:"1 y
  idx=. (({:$lbls)>idx)#"1 idx=.lbls i."1 'Tag';'uid';'Flk';'Flock'
  parents=. (<"1 idx) {"1 each slsts NB. just keep Tag & flock columns
  if. x do. NB. across-herd matings
    nparents=. # @> parents
  else.     NB. within-herd matings
    nparents=. (([: #@> </.~) /: ~.) @> 1{"1 each parents NB. no. of occurences of each flock number (sorted ascending by flock no)
  end.
  nsiremtgs=. <. %/nparents
  rem=. |/|.nparents NB. remainder
  rem=. (,rem,.rem-~{:nparents)# (+:#rem)$1 0
  mtgs=. rem+({:nparents)#nsiremtgs
  parents=. parents /: each |."1 each parents  NB. necessary for matching sires & dams within flock  
  sires=. mtgs#>{:parents
  sires=. sires /: x}."1 (1{"1 sires),.<"0 (#sires)?@#0 NB. randomly sort sires within or across flocks
  (;:'DTag DFlk STag SFlk');< (>{.parents),.sires
)

NB.*breedPopln v Breeds population if necessary and possible.
NB. returns 1 for successfully bred, 0 for breeding not required, else error messages
NB. y is ciid
breedPopln=: 3 : 0
  stages=. 1 21 99 NB. caseintro, casebtwncycles, caseconc
  stge=. (>:checkCycle y){stages
  if. stge<99 do.   NB. check if cycles complete
    msg=. y validMateAlloc stge
    if. 1-:msg do. NB. passed all checks
      if. okansim=. runAnimalSim y do.
        if. stge=1 do.
          inipath=. 'animinipath' getFnme y
          writeIniStrings 1;'Resume';'Control';inipath
        end.
        stge=. (>:checkCycle y){stages
        updateCaseStage stge;y
        msg=. 1
      else.     NB. AnimalSim error
        msg=. 'There was an error running AnimalSim.'
      end.
    end.
  else. msg=. 0 NB. cycles already complete
  end.
  msg
)

NB.*validMateAlloc v Checks if valid Mate Allocation list is present
NB. returns 1 for "all ok", error messages for not
NB. y is integer, stage of case instance.
NB. x is ciid
validMateAlloc=: 4 : 0
  if. y=21 do. NB. stage 21 (between cycles Manual selection)
    okexist=. fexist fnme=. 'mateallocpath' getFnme x
    msg=. boxopen 'Mate Allocation list not found.<br/>Did you upload your selected parents?'
    if. *./ok=. okexist do. NB. continue checks
      ma=. readcsv fnme
      oklen=. *# ma NB. not zero length
      'hdr ma'=. split ma
      anini=. 'animini' getInfo x
      'popsz cage mage'=. (<anini) getIniVals each 'hrdsizes';'cullage';'mateage'
      oknmtgs=. (#ma)=+/popsz
      NB. Arguable as to whether additional checks should be made here or
      NB.  within AnimalSim. Do here for now.
      NB. check that animals in matealloc.csv all present in selection lists.
      slsts=. <@readcsv"1 'selnlistpath' getFnme x
      lbls=. >{.each slsts NB. get labels
      slsts=. }.each slsts NB. drop labels
      idx=. (({:$lbls)>idx)#"1 idx=.lbls i."1 'Tag';'uid';'Flk';'Flock'
      slsts=. (<"1 idx) {"1 each slsts   NB. just keep Tag & flock columns
      okf=. *./( 2{."1 ma) e. 0{:: slsts NB. ma Tag,Flk all found in femaleSL Tag,Flk
      okm=. *./(_2{."1 ma) e. 1{:: slsts NB. ma Tag,Flk all found in maleSL Tag,Flk
      okanims=. *./okf,okm
      msg=. msg,<'Mate Allocation file is zero length.'
      msg=. msg,<'Incorrect number of matings in Mate Allocation file.'
      msg=. msg,<'There are animals in the Mate allocation list, that were not in the selection lists. Have you uploaded new selection lists for this cycle?'
      ok=. ok,oklen,oknmtgs,okanims
    end.
  else. ok=. 1  NB. Don't need to check Mate Allocation (most probably at stage 1).
  end.
  if. *./ok do.
    msg=. 1
  else.
    msg=. (,-.ok)#,msg
  end.
)

NB.*checkCycle v Determines 0th, last or other cycle.
NB. returns -1, 0, 1 for initial cycle, inbetween, last cycle respectively
NB. y is caseinstance id
checkCycle=: 3 : 0
  'crcyc ncyc'=. 'caseprogress' getInfo y
  issm=. fexist 'animsumrypath' getFnme y
  res=. (issm *. crcyc = ncyc)-crcyc=0
)

NB.*runAnimalSim v calls AnimalSim for caseinstance
NB. returns 0 if error, 1 if successful
NB. y is caseinstance id
runAnimalSim=: 3 : 0
  inipath=. 'animinipath' getFnme y
  if. -.fexist inipath do. 0 return. end.
  crcyc=. getIniValue key=. (1&transName 'currcycle');'GenCycle';inipath
  _1 fork '"c:\program files\animalsim\animalsim" ',inipath
  if. fexist  'errorlog.txt',~ cifldr=. 'caseinstpath' getFnme y do. NB.AnimalSim error
    if. crcyc< getIniValue key do.
      writeIniStrings crcyc;key  NB. reset CurrYear
    end.
    0
  else.
    1
  end.
)
