NB. =========================================================
NB.Calculates REVs for Forest Range Station clients

NB. ---------------------------------------------------------
NB.*getNewREVs v finds revs that need calculating, calculates them and updates database
NB.   z is 4-col matrix (rv_cfw,rv_mfd,rv_value,rv_id)
NB.   y is string indicating the SQL command to run 
NB.   x is optional vector of client ids
getNewREVs=: 3 : 0
  '' getNewREVs y
  :
  rvs=.   > }. y getTable x
  'scslbls scs'=. getScenarios {:"1 rvs
  wvg=. (3}.each scslbls) calcWoolValueGrid |: scs
  rvids=. 0{"1 rvs
  'twvs sumry'=. rvids calcTotWoolValues wvg
  revs=. (|: >2{.sumry) calcREVs twvs
  revs,. rvids
)

NB. =========================================================
NB.  Determine $/kg sale price

NB. ---------------------------------------------------------
NB.*getPrices v gets 1 or more prices for 1 or more price profiles
NB. x is vector of rv_ids to get prices for
NB. y is boxed vector of mfds to get prices for, for each rv_id
NB. output is vectors of prices boxed by rv_id
getPrices=: 4 : 0
  y=. <^:(L. = 0:) y  NB. box if not boxed (1 profile)
  profiles=. getProfiles x   NB. get profile for each rvid
  profiles calcPrices y
)

NB. ---------------------------------------------------------
NB.*getProfiles v gets 1 or more price profiles
NB.   z is vector of boxed price profile matrices. One box for each rv_id
NB.   y is vector of rv_ids to get price profiles for
getProfiles=: 3 : 0
  profs=. > }. 'calcpricePrice_Profiles' getTable y 
  if. -.profs-: 0 3$'' do.
    pp=. {."1 profs
    ((_1}.pp~:1|.pp),1) <;.2 profs NB. box profiles by profile
  end.
)

NB. ---------------------------------------------------------
NB.*calcPrices v calculates prices for fibre diameters based on 1 or more price profiles
NB. x is boxed tables of price profiles
NB. y is vectors of mfds to get prices for boxed by price profile
NB. output is vectors of prices boxed by price profiles
NB. when price is out of profile range extrapolates slope
calcPrices=: 4 : 0
  mfds=. 1{"1 each x
  prices=. _1{."1 each x
  idxs=. 0 >.each <:each +/each mfds (<:"0 1) each y
  NB.   idxs=. <:each mfds I. each x
  diffs=. 2-/\each prices
  diffs=. diffs,each _1{.each diffs NB. handle mfds bigger that profile
  diffs=. (y-each idxs{each mfds) * each idxs{each diffs
  ,each(idxs{each prices) -each diffs
)

NB. =========================================================
NB.  Calculating Profit function and sensitivity

NB. ---------------------------------------------------------
NB.*getScenarios v Gets scenario data given vector of sc_id's
NB.   returns 2-element boxed vector
NB.       0{z is boxed vector of column labels from scenarios table
NB.       1{z is boxed matrix of rows from scenarios table with requested sc_ids
NB.   y is vector of sc_ids
getScenarios=: 3 : 0
  scs=. 'calcrevsScenario' getTable y
  ({. ,&< >&}.) scs
)

NB. ---------------------------------------------------------
NB.*calcWoolValueGrid v calculates stock profile and massages fleece data
NB.   returns a 3d array:3 planes (nanims, cfw, mfd)
NB.                      1 row for each id
NB.                      4 columns of stock classes (ewe hogs, weth hogs, ewes, weths)
NB.   x is boxed vector of column labels of scenarios table with first 3 characters dropped
NB.   y is matrix with col for each sc_id and row for each column of scenarios
NB. form: (3{.each tablelabels) CalcWoolValueGrid (|: }. scenarios)
calcWoolValueGrid=: 4 : 0
  ewes2ram=. (x i. <'ewes2ram') { y
  yrs_ram=. (x i. <'yrs_ram') { y
  pct_lmb=. (x i. <'pct_lmb') { y
  nlmbs=. ewes2ram*yrs_ram*pct_lmb%100
  colsstarting=. ] {~ [: I. [: > (3{. each x) -:&.> [
  pct_retnd=. (<'ret') colsstarting y
  yrs_kept=. }. (<'yrs') colsstarting y NB. drop yrs_ram
  cfw=. (<'cfw') colsstarting y
  mfd=. (<'mfd') colsstarting y
  nanims=. 0.5* nlmbs *"1 (2{. pct_retnd%100) NB. hogget numbers
  nanims=. nanims, yrs_kept * nanims * _2{. pct_retnd%100 NB. append adult numbers
  |:(nanims),"0 1 cfw,"0 mfd
)

NB. ---------------------------------------------------------
NB.*calcTotWoolValues v calculates sensitivity table of Total Wool Value to MFD and CFW
NB. returns boxed vector 2=#z
NB.   0{z is array of sensitivity data.
NB.                planes for each price_profile_id.
NB.                25 rows for each plane
NB.                7 cols (mu,cfw,mfd,cfw*cfw,mfd*mfd,cfw*mfd,profit)
NB.   1{z is 5-element boxed vector of (#x)-element vectors
NB.                avgCFW,avgMFD,avgPrice,totAnimsShorn,totWoolShorn
NB. x is vector of price_profile_ids
NB. y is an array with 3 planes (nanims, cfw, mfd)
NB.                    1 row for each id
NB.                    4 columns of stock classes (ewe hogs, weth hogs, ewes, weths)
NB. form: price_profile_ids CalcTotWoolValues wool_value_grid
calcTotWoolValues=: 4 : 0
  nanims=. {.y
  delta=. ,"2 |: > { 2 # <0.1*i:2 NB. sensitivity table for delta_CFW & delta_MFD
  flc=. (}. y) +/"1 delta NB. array of alternative mfd & cfw vals for each scenario
  cfw=. {. flc
  mfd=. {: flc
  prc=. x getPrices (,each <"2 mfd)
  prc=. (}.$mfd)$"1 >prc
  totanims=. +/"1 nanims
  totwool=. +/"1 nanims * 1{y
  avgcfw=. totwool%totanims
  avgmfd=. (+/"1 nanims * (1{y) * 2{y)% totwool
  avgprc=. (+/"1 nanims * (1{y) * (<. 0.5* #|:prc){"1 prc)%totwool
  totvalue=. +/"2 nanims * cfw * prc NB. col7 ("profit")
  am=. avgmfd +/ {:delta
  ac=. avgcfw +/ {.delta
  acm=. ac ,"0 am
  totvalue=. 1,"1 totvalue,"1 0~ }:"1 acm,"1 (acm * acm),"1 acm * |."1 acm
  totvalue;<(avgcfw;avgmfd;avgprc;totanims;totwool)
)

NB. =========================================================
NB.  Deriving REVs & index value

NB. ---------------------------------------------------------
NB.*calcREVs v calculates REVs for 1 or more rev_id
NB. returns 3-col matrix (rv_cfw,rv_mfd,rv_value) with row for each rv_id
NB. x is 2-col matrix of avgcfw avgmfd with row for each rv_id
NB. y is array of sensitivity data. planes for each rv_id.
NB.   25 rows for each plane, 7 cols (mu,cfw,mfd,cfw*cfw,mfd*mfd,cfw*mfd,profit)
NB. Profit=f+gCFW+hMFD+iCFW^2+jMFD^2+kCFW.MFD
NB. the partial derivative of the Profit function with respect to CFW. is
NB. dProft/dCFW=g+2iCFW+kMFD
NB. the partial derivative of the Profit function with respect to MFD. is
NB. dProft/dMFD=h+2jMFD+kCFW
NB. @@@ could calculate R-sq as (xTATb)/(bTb)
calcREVs=: 4 : 0
  split=. ({:"1 ,&< }:"1) NB. split last column and rest
  'b A'=. split y
  'avgcfw avgmfd'=. |: x NB. cols are avgcfw & avgmfd
  coeffs=. |: b %."1 2 A
  dPrftdCFW=. (1{coeffs)+(avgcfw*2*3{coeffs)+(avgmfd*5{coeffs)
  dPrftdMFD=. (2{coeffs)+(avgmfd*2*4{coeffs)+(avgcfw*5{coeffs)
  revs=. dPrftdMFD % dPrftdCFW
  1,.revs,. dPrftdCFW
)