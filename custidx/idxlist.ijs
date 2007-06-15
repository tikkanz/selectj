NB. =========================================================
NB. Import Sale Catalogue and Create Customised Index matricies for Clients

NB. ---------------------------------------------------------
NB.*importCatalog v Import Excel file of Sale Catalog
importCatalog=: 3 : 0
  fnme=. wd 'mbopen  "Import Sale Catalogue"  ""  ""  "Excel;(*.xls)|*.xls" ofn_filemustexist'
  NB. handle cancel by return.
  cat=. readexcel fnme
  cat=. (({."1 cat) i. <i.0) {. cat NB. drop summary rows
  hdrcol=. <;._2 'Lot No;Tag;Index;MFD1;Yld1;MFD(EBV);GFW1;CFW1;CFW(EBV);MFD2;Yld2;MFD3;Yld3;GFW2;CFW2;SIRE;CV%;'
  cat=. hdrcol,}.cat NB. Standardize column headings so can find impt columns later
  yrs=. ({.6!:0 '')+i:5  NB. Prompt for Sale year default 1+curr year
  yr=. 6 wdselect 'Which year is the Ram Sale catalogue for?';<8!:0 <&>yrs
  if. -. 0{::yr do. return. end.
  yr=. (1{::yr) { yrs
  ('impCatalog';0 1) insertDBTable yr;<3!:1 cat NB. Save Array in database as Blob
)

NB. ---------------------------------------------------------
NB.*viewCatalog v Displays chosen year's catalog in Grid
viewCatalog=: 3 : 0
  yrs=. ,>}.'yrsCatalog' getTable ''
  yr=. (<:#yrs) wdselect 'Which year''s Ram Sale catalogue?';<8!:0 <&>yrs
  if. -. 0{::yr do. return. end.
  yr=. (1{::yr) { yrs
  cat=. 3!:2 ;}.'viewCatalog' getTable yr NB. retrieve latest catalog from database
  grid_z_ cat
)

NB. ---------------------------------------------------------

NB.*calcIndexList v Create client Index list
NB.   y is matrix (rv_id,rv_client,rv_cfw,rv_mfd,rv_value) with hdr row & row for each client
NB.   z is ??vector of boxed matrices or planes of matrices
NB.   ability to choose sale year?(drop down) default to most recent
calcIndexList=: 3 : 0
  NB. retrieve latest catalog from database
  yrs=. ,>}.'yrsCatalog' getTable ''
  yr=. {: yrs
  cat=. 3!:2 ;}. 'viewCatalog' getTable yr
  NB. Calc index column
  hdr=. {.cat
  cat=. }.cat
  ndxBV=. hdr i. 'CFW(EBV)';'MFD(EBV)'
  index=. |:(>2 3{"1 }. y) +/ . * >|: ndxBV {"1 cat
  rank=. /:@\: index NB. Calc rank column 
  NB. Menu option to change minimum price to other than 450
  value=. 450+(>{:"1 }.y)*"1 index-"1 <./ index   NB. Calc Value column
  ilist=. _2|."1 (<&>value,.rank,.index),. (}."1) 2|."1 cat
  hdr=. _2|.  ('$Value';'Your Ranking';'Your Index') ,}.2|.hdr
  hdr,ilist
)

