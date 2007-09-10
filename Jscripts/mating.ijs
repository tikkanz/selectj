NB. =========================================================
NB. verbs for validation of selection lists, mate allocation (selection?)

NB.*validateSelectLists v Checks selection lists are correct.
NB. returns list of boxed error messages if error(s) or 1 if all OK.
NB. y is 2-row (female, male) by 2-column (filename, filecontents) boxed array
NB. x is caseinstance id
validateSelectLists=: 4 : 0
  oklen=.*#@> {:"1 y NB. not zero length
  okext=.'.csv'-:"1 ]_4&{.@> {."1 y  NB. have '.csv' extension
  fcs=. fixcsv each toJ each {:"1 y NB. file contents
  hdrs=. >{. each fcs NB. headers
  NB. Headers must contain (Tag or uid) and (Flk or Flock)
  okhdr=. (([: +./"1('Flk';'Flock')&e."1)*.[: +./"1('uid';'Tag')&e."1) hdrs
  if. -.*./*./ok=. oklen,okext,:okhdr do.
    msg=.'selection list is empty.';'selection list file extension is not ".csv".';'selection list does not contain "Tag" and/or "Flk" column labels.'
    msg=.(,.'Female ';'Male ') prefsuf msg
    msg=. (,|:-.ok)#msg
  else.
    ANIMINI_z_=. 'animini' getScenarioInfo ciid
    'ndams d2s xhrd'=. ('hrdsizes';'dams2hrdsires';'usesiresxhrd') getIniVals each <ANIMINI
    nsires=. <.0.5&+ ndams%d2s   NB. no. of males required for each sub-popln
    NB.! add handling for across-herd as well as within-herd mating of sires
    NB.! get index of flock/Flk columns in selection lists column labels
    hrds=. NB.! get flock/flk columns from selection lists
    nprnts=. (([: #@> </.~) /: ~.) each hrds NB. no. of occurences of each flock number (sorted ascending by flock no)
    okf=. ndams-:{.nprnts NB. check correct number of females listed (for each sub-popln)
    okm=. *./3>nsires-{:nprnts NB. check approx correct number of males listed (for each sub-popln)
    if. -.*./okf,okm do.
      msg=. 'incorrect number of females in selection list';'incorrect number of males in selection list'
      msg=. (-.okf,okm)#msg
    else.
      msg=.1 
    end.
  end.
)

NB.*makeMateAlloc v Creates and writes Mate Allocation file.
makeMateAlloc=:4 : 0
  fpth=. 'matealloc' getFnme x
  dat=. allocateMatings y
  dat fwrite fpth
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
allocateMatings=: 3 : 0


)

NB.*validMateAlloc v Checks that MateAlloc.csv exists and is valid.
NB. returns 1 for "all ok", error messages for not
NB. y is case stage
NB. x is ciid 
validMateAlloc=: 4 : 0
  if. y=21 do. NB. stage 21 (Manual selection) 
    fnme=. 'matealloc' getFnme x NB. then matealloc.csv file required
    if. fexist fnme do. NB. file is present 
      NB.! check is file valid (e.g. right animals/right year - how??)
      res=. 1
    else.
      res=. 'mate allocation file does not exist' NB. return error message.
    end.
  else. NB. mate alloc file not required
    res=. 1
  end.
)
