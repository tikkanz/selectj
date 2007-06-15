NB.Calculates and produces Customised Indexes for Forest Range Station clients

NB. =========================================================
NB.  Create connection to custidx database
NB. =========================================================

NB. require 'data/sqlite'

FDIR=: jpath '~user/projects/custidx/'
'FDB FDDL FDATA'=: cut 'custidx_tst.sqlite custidx_ddl.sql custidx_data.sql '
NB. ferase FDIR,FDB NB. deletes database file

]db=: 'psqlite'conew~ FDIR,FDB  NB. creates new connection (and database file if required)

NB. =========================================================
NB. Utility verbs
NB. =========================================================

NB. ---------------------------------------------------------
getColumns=: 3 : 0
  NB. getColNames v gets boxed names of fields in table
  strquery__db 'PRAGMA table_info(',y,');'
)

NB. ---------------------------------------------------------
NB.*getColNames v gets boxed names of fields in table
getColNames=: 3 : 0
  }. 1 {"1 getColumns y
)

NB. ---------------------------------------------------------
NB.*delim v delimits 1d or 2d array
NB.  y is 1d or 2d array
NB.  x is optional 1 or 2 element vector of intra-line and end-of-line delimiters
NB.    default intra-line delimiter is ','
NB.    default end-of-line delimiter is LF if x not given or 1=#x
NB.  eg. ',;' delim i.4 5
NB.  eg. delim i.4 5
delim=: 3 : 0
  (',',LF) delim y
  :
  select. #x
    case. 1 do. NB. assume only intra-line delimiter specified
      (x,LF) delim y
    case. 2 do.
      if. 2<L. x do. NB. report arg error
      elseif. 2>L. x do.
        x=. <each x
      end.
      'il eol'=. x
      y=. 8!:0 y
      b=. 0>._1+2*{:$y
      b=. b$1 0      NB. calc boolean
      ;eol,"1~ b &#^:_1!.il"1 y
    case. do.
    NB. report arg error
  end.
)

NB. ---------------------------------------------------------
NB.*melt v reshape table to database style 
NB. optional left arg for number of "label" columns
melt=: 3 : 0
	1 melt y
:
	lbls=. (x{.{.y),;:'variable value'
	rows=. }. x {."1 y
	cols=. x }. {. y
	dat=. , x }."1 }. y
	lbls,((#cols)#rows),.(($dat)$cols),.dat
	NB. lbls,(>,{(<"1 a);<b),.,c
)

NB. ---------------------------------------------------------
NB. delim v delimits boxed y with ',' or optional x
NB. delim=: 3 : 0
NB.   ',' delim y
NB.   :
NB.   _1}.; y , each x
NB. )

NB. =========================================================
NB.  Display Clients Scenario & REVs
NB. =========================================================

NB. ---------------------------------------------------------
GetClientScenarios=: 3 : 0
	sqlcmd=. 0 : 'SELECT * FROM scenarios WHERE sc_client=? ;'
	;"0 1 (1 4}. y query__db sqlcmd)
)


NB. =========================================================
NB.  Determine $/kg sale price
NB. =========================================================

NB. ---------------------------------------------------------
NB.*GetPrices v gets 1 or more prices for 1 or more price profiles
NB. x is vector of price profile ids to get prices for
NB. y is boxed vector of mfds to get prices for, for each price profile
NB. output is vectors of prices boxed by price profile
GetPrices=: 4 : 0
  y=. <^:(L. = 0:) y  NB. box if not boxed (1 profile)
  profiles=. GetProfiles x   NB. get profile for each profile id
   profiles CalcPrices y
)

 NB. table names don't work in SQLite with brackets so use below
NB. sqlcmd =: 0 : 0
NB. SELECT clients.cl_lname, clients.cl_title, revs.rv_validuntil, price_profiles.pp_year, prices.pr_mfd, prices.pr_price
NB. FROM (price_profiles INNER JOIN prices ON price_profiles.pp_id = prices.pr_pp) INNER JOIN (clients INNER JOIN revs ON clients.cl_id = revs.rv_client) ON price_profiles.pp_id = revs.rv_pp
NB. WHERE clients.cl_id=? AND revs.rv_validuntil Is Null
NB. ORDER BY clients.cl_lname, prices.pr_mfd;
NB. )

sqlcmd_ppSELb=: 0 : 0
SELECT pp_year, pp_id, pr_mfd, pr_price
FROM price_profiles INNER JOIN prices ON pp_id = pr_pp 
WHERE pp_id=?
ORDER BY pr_mfd;
)

NB. (if didn't know pp_id then could use)
NB. sqlcmd_ppSEL =: 0 : 0
NB. SELECT cl_lname, cl_title, pp_year, pp_id, pr_mfd, pr_price
NB. FROM (price_profiles INNER JOIN prices ON pp_id = pr_pp) INNER JOIN (clients INNER JOIN revs ON cl_id = rv_client) ON pp_id = rv_pp
NB. WHERE cl_id=? AND rv_validuntil Is Null
NB. ORDER BY cl_id, pr_mfd;
NB. )

NB. ---------------------------------------------------------
NB.*GetProfiles v gets 1 or more price profiles
GetProfiles=: 3 : 0
  NB. get price profiles for each client
  profs=. > _3 {."1 }. y query__db sqlcmd_ppSELb NB. get last three columns of query
  if. -.profs-: 0 3$'' do.
    NB. 'pp mfd prc'=: |: profs NB. assign each column to name
    pp=. {."1 profs
    profiles=. ((_1}.pp~:1|.pp),1) <;.2 profs NB. box profiles by profile
  end.
)

NB. ---------------------------------------------------------
NB.*CalcPrices v calculates prices for fibre diameters based on 1 or more price profiles
NB. x is boxed tables of price profiles
NB. y is vectors of mfds to get prices for boxed by price profile
NB. output is vectors of prices boxed by price profiles
NB. when price is out of profile range extrapolates slope
CalcPrices=: 4 : 0
  mfds=. 1{"1 each x
  prices=._1{."1 each x
  idxs=. 0 >.each <:each +/each mfds (<:"0 1) each y
NB.   idxs=. <:each mfds I. each x
  diffs=. 2-/\each prices
  diffs=. diffs,each _1{.each diffs NB. handle mfds bigger that profile
  diffs=. (y-each idxs{each mfds) * each idxs{each diffs
  ,each(idxs{each prices) -each diffs
)

NB. =========================================================
NB.  Updating REVs
NB. =========================================================

NB. clients that need to recalculate REVs
NB.  get current REVs where rv_mfd rv_cfw rv_value are NULL
sqlcmd_rvSEL_2update =: 0 : 0
  SELECT rv_id, rv_pp, rv_scenario
  FROM revs
  WHERE rv_validuntil IS NULL AND rv_mfd IS NULL;
)

NB. ---------------------------------------------------------
NB.*GetREVs2Update v returns 3 column matrix of revs to update (rv_id, rv_pp, rv_scenario)
GetREVs2Update=: 3 : '> }. query__db sqlcmd_rvSEL_2update'


sqlcmd_scSELcalc=: 0 : 0
  SELECT sc_ewes2ram, sc_yrs_ram, sc_pct_lmb, 
     sc_ret_elmb, sc_ret_wlmb, sc_ret_ehog, sc_ret_whog, sc_yrs_ewe, sc_yrs_weth,
     sc_cfw_ehog, sc_cfw_whog, sc_cfw_ewe, sc_cfw_weth,
     sc_mfd_ehog, sc_mfd_whog, sc_mfd_ewe, sc_mfd_weth
  FROM scenarios
  WHERE sc_id=?;
)

NB. ---------------------------------------------------------
NB.*GetScenarios v Gets scenario data given vector of sc_id's
NB.   returns 2-element boxed vector
NB.       0{z is boxed vector of column labels from scenarios table 
NB.       1{z is boxed matrix of rows from scenarios table with requested sc_ids
NB.   y is vector of sc_ids
GetScenarios=: 3 : 0
  scs=. y query__db sqlcmd_scSELcalc
  ({. ,&< >&}.) scs 
)

NB. ---------------------------------------------------------
NB.*CalcWoolValueGrid v calculates stock profile and massages fleece data
NB.   returns a 3d array:3 planes (nanims, cfw, mfd)
NB.                      1 row for each id
NB.                      4 columns of stock classes (ewe hogs, weth hogs, ewes, weths)
NB.   x is boxed vector of column labels of scenarios table with first 3 characters dropped
NB.   y is matrix with col for each sc_id and row for each column of scenarios
NB. form: (3{.each tablelabels) CalcWoolValueGrid (|: }. scenarios)
CalcWoolValueGrid=: 4 : 0
  ewes2ram=. (x i. <'ewes2ram') { y
  yrs_ram=. (x i. <'yrs_ram') { y
  pct_lmb=. (x i. <'pct_lmb') { y
  nlmbs=. ewes2ram*yrs_ram*pct_lmb%100
  colsstarting=. ] {~ [: I. [: > (3{. each x) -:&.> [
  pct_retnd=.(<'ret') colsstarting y
  yrs_kept=. }. (<'yrs') colsstarting y NB. drop yrs_ram
  cfw=. (<'cfw') colsstarting y
  mfd=. (<'mfd') colsstarting y
  nanims=. 0.5* nlmbs *"1 (2{. pct_retnd%100) NB. hogget numbers
  nanims=. nanims, yrs_kept * nanims * _2{. pct_retnd%100 NB. append adult numbers
  |:(nanims),"0 1 cfw,"0 mfd
)

NB. ---------------------------------------------------------
NB.*CalcTotWoolValues v calculates sensitivity table of Total Wool Value to MFD and CFW
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
CalcTotWoolValues=: 4 : 0
  nanims=. {.y
  delta=.,"2 |: > { 2 # <0.1*i:2 NB. sensitivity table for delta_CFW & delta_MFD
  flc=. (}. y) +/"1 delta NB. array of alternative mfd & cfw vals for each scenario
  cfw=. {. flc
  mfd=. {: flc
  prc=. x GetPrices (,each <"2 mfd)
  prc=. (}.$mfd)$"1 >prc
  totanims=. +/"1 nanims
  totwool=. +/"1 nanims * 1{y
  avgcfw=. totwool%totanims
  avgmfd=. (+/"1 nanims * (1{y) * 2{y)% totwool
  avgprc=. (+/"1 nanims * (1{y) * (<. 0.5* #|:prc){"1 prc)%totwool
  totvalue=. +/"2 nanims * cfw * prc NB. col7 ("profit")
  am=. avgmfd +/"0 |.delta
  ac=. avgcfw +/"0 delta
  NB.  alternative to below but needs work 
  acm=. ac ,"0 am
  totvalue=. 1,"1 totvalue,"1 0~ }:"1 acm,"1 (acm * acm),"1 acm * |."1 acm
NB.   totvalue=. (am*ac),"0 totvalue     NB. col6 & 7 (mfd*cfw),(totvalue)
NB.   totvalue=. (am^2),"0 1 totvalue    NB. col5 (mfd*mfd)
NB.   totvalue=. (ac^2),"0 1 totvalue    NB. col4 (cfw*cfw)
NB.   totvalue=. (am),"0 1 totvalue      NB. col3 (mfd) 
NB.   totvalue=. (ac),"0 1 totvalue      NB. col2 (cfw) 
NB.   totvalue=. 1,"0 1 totvalue         NB. col1 (mu)
  totvalue;<(avgcfw;avgmfd;avgprc;totanims;totwool)
)

NB. ---------------------------------------------------------
NB.*CalcREVs v calculates REVs for 1 or more rev_id
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
CalcREVs=: 4 : 0
  split=. ({:"1 ,&< }:"1) NB. split last column and rest
  'b A'=. split y
  'avgcfw avgmfd'=. 0 1{ |: x NB. first two cols are avgcfw & avgmfd
  coeffs=. b %."1 2 A
  dPrftdCFW=. (1{coeffs)+(avgcfw*2*3{coeffs)+(avgmfd*5{coeffs)
  dPrftdMFD=. (2{coeffs)+(avgmfd*2*4{coeffs)+(avgcfw*5{coeffs)
  revs=. dPrftdMFD % dPrftdCFW
  1,.revs,. dPrftdCFW
)

sqlcmd_rvUPD=: 0 : 0
 UPDATE revs 
 SET rv_cfw=?,rv_mfd=?,rv_value=?
 WHERE rv_id=?
)

NB. ---------------------------------------------------------
NB.*UpdateREVs v writes updated REVs to database
NB.  no result ??or maybe result of apply__db??
NB.  x is vector of rv_ids to update
NB.  y is 3-col matrix rv_cfw,rv_mfd,rv_value) with row for each rv_id
NB. form: rv_ids UpdateREVs matrix_of_revs
UpdateREVs=: 4 : '(y,.x) apply__db sqlcmd_rvUPD'


NB. ---------------------------------------------------------
NB.*GetNewREVs v finds revs that need calculating, calculates them and updates database
GetNewREVs=: 3 : 0
  rvs=. GetREVs2Update ''
  'scslbls scs' =. GetScenarios {:"1 rvs
  wvg=. (3}.each scslbls) CalcWoolValueGrid |: scs
  profs=. 1{"1 rvs
  'twvs sumry'=. profs CalcTotWoolValues wvg
  revs=. (|: >2{.sumry) CalcREVs twvs
  (0{"1 rvs) UpdateREVs revs
)

NB. Current REVs for a client
sqlcmd_rvSEL =: 0 : 0
SELECT cl_lname, cl_title, revs.*
FROM clients INNER JOIN revs ON cl_id = rv_client 
WHERE cl_id=? AND rv_validuntil IS NULL;
)

NB. =========================================================
NB.  Creating customised indexes
NB. =========================================================

NB. =========================================================
NB.  Updating Client scenario
NB. =========================================================

NB. get current scenario for client
NB. edit with new values in interface
NB. save new scenario
NB.      update current scenario to no longer current
NB.      insert new scenario
NB.    If current rev has NULL for rv_mfd, rv_cfw, rv_value 
NB.      (new rev already created maybe due to price profile update)
NB.      update current rev with new sc_id
NB.    Else (new rev required)
NB.      update current rev to no longer current
NB.      insert new rev with new sc_id & old pp_id but NULL for rv_mfd etc

NB. Current scenario for a client
sqlcmd_scSEL =: 0 : 0
SELECT cl_lname, cl_title, scenarios.*
FROM clients INNER JOIN scenarios ON cl_id = sc_client 
WHERE cl_id=? AND sc_validuntil IS NULL;
)
NB. |: (>: i.14) query__db sqlcmd NB. get all clients with current scenario

NB. Update current scenario to no longer current
NB. sqlcmd =: 0 : 0
NB. UPDATE clients INNER JOIN scenarios ON clients.cl_id = scenarios.sc_client 
NB. SET scenarios.sc_validuntil = ?
NB. WHERE scenarios.sc_validuntil IS NULL AND clients.cl_id=? ;
NB. )
NB. can't do the one above - SQLite doesn't support joins in UPDATE???
sqlcmd_scUP=: 0 : 0
UPDATE scenarios 
SET sc_validuntil = ?
WHERE sc_validuntil IS NULL AND sc_client=? ;
)
NB. (({.6!:0 '');2) query__db sqlcmd NB. updates client 2 to current year

NB. sets field to NULL
NB. (a:;2) apply__db 'UPDATE scenarios SET sc_validuntil=? WHERE sc_client=? ;'


NB. =========================================================
NB.  Updating Client price profile
NB. =========================================================

NB. get current price profile for client & old profiles for that client plus generic profiles
NB. interface lets choose new profile column or edit current
NB. If choose new profile column (profile already in database)
NB.    If current rev has NULL for rv_mfd, rv_cfw, rv_value 
NB.      (new rev already created maybe due to scenario update)
NB.      update current rev with new pp_id
NB.    Else (new rev required)
NB.      update current rev to no longer current
NB.      insert new rev with new pp_id & old sc_id but NULL for rv_mfd etc
NB. If edit current price profile and save
NB.      insert new prices and new price profile
NB.    If current rev has NULL for rv_mfd, rv_cfw, rv_value 
NB.      (new rev already created maybe due to scenario update)
NB.      update current rev with new pp_id
NB.    Else (new rev required)
NB.      update current rev to no longer current
NB.      insert new rev with new pp_id & old sc_id but NULL for rv_mfd etc

NB. Choices of price profile for a client
NB. sqlcmd_ppSELa =: 0 : 0
NB. SELECT cl_lname, cl_title, pp_id, pp_year 
NB. FROM price_profiles LEFT OUTER JOIN clients ON pp_client = cl_id 
NB. WHERE pp_client=? OR pp_client IS NULL;
NB. )

NB. sqlcmd_ppSELb =: 0 : 0
NB. SELECT pp_id, pp_year , pr_mfd, pr_price
NB. FROM price_profiles LEFT OUTER JOIN prices ON pp_id = pr_pp 
NB. WHERE pp_client=2 OR pp_client IS NULL
NB. ORDER BY pp_id, pr_mfd ;
NB. )
NB. sqlcmd_ppSELc =: 0 : 0
NB. SELECT pr_pp, pp_year, pr_mfd, pr_price
NB. FROM (price_profiles INNER JOIN prices ON pp_id = pr_pp) INNER JOIN revs ON .pp_id = rv_pp
NB. WHERE (rv_validuntil Is Null AND rv_client=?) OR pp_client Is Null
NB. ORDER BY pp_year, pr_mfd;
NB. )
NB. sqlcmd_ppSELc =: 0 : 0
NB. SELECT pr_pp, pp_year, pr_mfd, pr_price, rv_validuntil, rv_client, pp_client
NB. FROM (price_profiles INNER JOIN prices ON pp_id = pr_pp) LEFT JOIN revs ON pp_id = rv_pp
NB. WHERE (rv_validuntil Is Null AND rv_client=3) OR (pp_client Is Null)
NB. ORDER BY pp_year, pr_mfd;
NB. )

   
sqlsel_choosePrice_Profile =: 0 : 0
  SELECT pr_pp, pp_year, pr_mfd, pr_price
  FROM (price_profiles INNER JOIN prices ON pp_id = pr_pp) LEFT JOIN revs ON pp_id = rv_pp
  WHERE (rv_validuntil Is Null AND rv_client=?) OR (pp_client Is Null)
  ORDER BY pp_client DESC, pp_year, pr_mfd;
)
  cast dat
  }. |: cast 3 query__db sqlsel_choosePrice_Profile

NB. =========================================================
NB.  Useful queries from custidx database
NB. =========================================================
