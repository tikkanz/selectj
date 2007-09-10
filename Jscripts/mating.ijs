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
   NB. get dams2hrdsire hrdsizes usesiresxhrd from ini file
   NB. get column index of Flock/Flk in female selection list
   NB. no. of occurences of each flock number (sorted ascending by flock no)
   NB. calc required no. of females and males (for each sub-popln)
   NB. check correct number of females and males listed (for each sub-popln).
  end.
)

makeMateAlloc=:3 : 0

  fpth=. ('caseinstfolder' getFnme ciid),'MateAlloc.csv'
)

NB.*allocateMatings v Allocates matings for list of dams and sires.
NB. returns 2-item boxed list containing 
NB.     0{ list of boxed column labels for array in 1{
NB. 	1{ 2d array of four columns damtag, damFlkID & siretag, sireFlkID.
NB. 	   Each row is a mating. Dams should only appear once, sires can appear many times.
NB. y is 2-item boxed list containing 
NB.     0{ list of boxed column labels for array in 1{
NB.     1{ 2d array of dam info.
NB. x is 2-item boxed list containing 
NB.     0{ list of boxed column labels for array in 1{
NB.     1{ 2d array of sire info.
allocateMatings=: 3 : 0



)
