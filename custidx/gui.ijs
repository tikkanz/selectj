NB. =========================================================
NB. GUI for Customised Indexes Application

TITLE=: 'Customised Indexes'

NB. DBFILE=: jpath '~user/projects/custidx/custidx_tst.sqlite'
DEVOPTS=: OPTIONS_jzgrid_

create=: 3 : 0
  dbcon=: db=: ''
  wd 'fontdef "MS Sans Serif" 10'
  wd F
  wd 'set tab Address Scenario Price_Profile REVs Index_List'
  wd 'setselect tab 0'
  showFlip 0
  editingTable 0
  chwsingProfile 0
  addingTable 1
  wd 'setenable btcalcREVs 0'
  connect DBFILE=: y
  wd 'pshow;'
)

destroy=: 3 : 0
  NB.   if. 0=checkDirty'' do. return. end.
  connect''
  wd'pclose'
  destroy__grid ''
  codestroy''
)

MBO_DB=: 'SQLite (*.sqlite)|*.sqlite|SQLite (*.db)|*.db|All files (*.*)|*.*'

openDb=: 3 : 0
  wd 'mbopen "Open Client database" "" "" "',MBO_DB,'" ofn_createprompt ofn_pathmustexist'
)

NB. =========================================================
NB. controller

connect=: 3 : 0
  if. #db do. destroy__db'' end.
  dbcon=: db=: ''
  if. 0=#y do. return. end.
  dbcon=: y
  db=: 'psqlite' conew~ dbcon
  setTitle dbcon
  viewClients getClients ''
  wd 'setselect lsObj 0'
  clid=: 0 { _1,CLIDS
  grid=: i.0  NB. otherwise crash cause gets grid_z_ when grid not defined in class
  viewTable i.0 0
)

'TAB_ADD TAB_SCN TAB_PRP TAB_REV TAB_IDX'=: i.5

redisplaygrd=: 3 : 0
  tab_select=: ".tab_select
  lsObj_select=. ".lsObj_select
  NB.   if. lsObj_select-: i.0 do. '' return. end.
  clid=: lsObj_select { _1,CLIDS
  viewTable tab getTable clid
  wd 'setenable btAdd ', ": -.(clid=_1) *. (-.tab-: 'Address')
  t=. (tab-: 'REVs') *. (+:/; a: -: each 2{._3}."1 chk) *. ((3$a:) -: _3{."1 chk=. {: 'chkoldREVs' getTable clid)
  wd 'setenable btcalcREVs ', ": t
  ''
)

setTitle=: 3 : 0
  wd 'pn *',y,' - ',TITLE
)

NB. checkDirty=: 3 : 0
NB.   if. CELLDATA -: CELLDATA__grid do.
NB.     1 return. end.
NB.   if. a=. 3 wdquery TITLE;'Data changed',LF,'Would you like to save?' do.
NB.     -.<:a return.end.
NB.   saveTable EDITTAB
NB. )


NB. =========================================================
NB. view

viewClients=: 3 : 0
  if. 0=#y do. return. end.
  CLIDS=: >{:"1 }.y
  dat=. (<'New Client'),}:"1 }.y
  wd 'set lsObj *',(TAB,LF) delim dat
)

viewTable=: 3 : 0
  'grddef' viewTable y
  :
  erase DEVOPTS
  if. 0=#y do.
    0!:100 grddefEmpty
  else.
    addingTable 0
    CELLDATA=: y
    CELLFONTS=: '"MS Sans Serif" 10';'Arial 12'
    CELLFONT=: 0
    GRIDFLIP=: *./ -.;('Price_Profile';'Index_List') -:each <tab
    0!:100 ". x,tab
  end.
  nms=. (0 = 4!:0 DEVOPTS) # DEVOPTS
  pkg=. nms,.".each nms
  if. #grid do.
    destroy__grid''
  end.
  grid=: ''conew'jzgrid'
  GRIDLOC=: grid
  show__grid pkg
)

saveTable=: 3 : 0
  if. CELLDATA -: CELLDATA__grid do. 1 return.
  else.
  NB. code to update/add data to DB
    CELLDATA=: CELLDATA__grid
    select. y
      case. 'Address' do.
        if. clid=_1 do. NB. new client
          clid=: y insertDBTable CELLDATA
          viewClients getClients ''
          wd 'setselect lsObj ', ": (_1,CLIDS) i. clid
        else.  NB. updating
          y updateDBTable CELLDATA,.<clid  NB. update edits to current clid
        end.
      case. 'Scenario' do.
        ('valid',y) updateDBTable (day=. 10{.isotimestamp 6!:0 '');clid NB. update validuntil of current scenario
        dat=. (day;clid)(,"1) }."1 CELLDATA
        scid=. y insertDBTable dat NB. insert edited scenario as new record with null validuntil
        y handlDBREVs scid NB. update REVs as req'd
      case. 'Price_Profile' do.
        if. HDRROW -: '' do.  NB. saving custom prices
          ppid=. ('new',y) insertDBTable (<10{.isotimestamp 6!:0 ''), <clid
          dat=. (I.((<0)~: val) *. a:~: val=. {:"1 CELLDATA) { CELLDATA NB. drop where price is zero or null
          'newPrices' insertDBTable (<ppid),.dat
        else.  NB. chosen existing profile
          colch=. (I. >{.CELLDATA)
          ppid=. colch { >PPids
        end.
        y handlDBREVs ppid NB. update REVs as req'd
      case. 'REVs' do.
        if. +./ ;a:-:each 1 2{"1 CELLDATA  do. NB. creating new one with manual REVs
          ('valid',y) updateDBTable (day=. 10{.isotimestamp 6!:0 '');clid NB. update current rev to no longer current ??OK for no current??
          dat=. (day;clid)(,"1) 3}."1 CELLDATA
          ('man',y) insertDBTable dat NB. insert new rev with new/old sc_id & old/new pp_id but NULL for rv_mfd rv_cfw & rv_value
        else.  NB. saving calculated client REVs
          ('clientcalc',y) updateDBTable 3}."1 CELLDATA,.<clid
        end.
    end.
    1
  end.
)

handlDBREVs=: 4 : 0
  oldrevs=. 'chkoldREVs' getTable clid
  fkeyids=. 2{.}.{:oldrevs
  try.
    fkeyids=. (('s';'p')-:each tolower {.": x) {"0 1 fkeyids,"0 <y
  catch.
  NB. no valid rev record for client ids, default to null
    fkeyids=. a:,a:
    fkeyids=. (('s';'p')-:each tolower {.": x) {"0 1 fkeyids,"0 <y
  end.
  if. (3$a:) -: _3{."1 {: oldrevs do. NB. if new rev already created
    'fkeysREVs' updateDBTable fkeyids,{.{:oldrevs NB. update current rev with new id
  else.
    'validREVs' updateDBTable (day=. 10{.isotimestamp 6!:0 '');clid NB. update current rev to no longer current ??OK for no current??
    dat=. day;clid;fkeyids
    'newREVs' insertDBTable dat NB. insert new rev with new/old sc_id & old/new pp_id but NULL for rv_mfd rv_cfw & rv_value
  end.
)

chooseProfile=: 3 : 0
  if. CELLDATA-:i.0 0 do.  NB. no current profile
    crPrf=. 23  NB. use ID of Custom profile
  else.
    crPrf=. ;}.'currentPrice_Profile' getTable y
  end.
  tbl=. |: cast 'choosePrice_Profile' getTable crPrf
  PPids=: }. {. tbl
  tbl=. }.tbl
  ndx=. ({.tbl) i. <'Custom'
  tbl=. (<'Custom') (<0;ndx)} (<i.0) (ndx)}"1 tbl NB. replace zeros with empty cell
  sel=. '';<&>  1 ((>PPids) i. crPrf)}(<:{:$tbl)$0
  tbl=. _1|. sel, 1|.tbl NB. insert boolean 2nd row for checkboxes
  NB.   tbl=. (<'MFD') (<0;0)}tbl
  'grddefch' viewTable tbl
  chwsingProfile 1
)

editCustom=: 3 : 0
  'grddefcust' viewTable  ;:'dummy data'
  wd 'setfocus grid'
)

NB. =========================================================
NB. model

getClients=: 3 : 0
  query__db sqlsel_Clients
)

getTable=: 4 : 0
  y query__db ".'sqlsel_',x
)

updateDBTable=: 4 : 0
  y apply__db ". 'sqlupd_',x
)

insertDBTable=: 4 : 0
  if. (L.=0:) x do.
    sql=. ". 'sqlins_',x
  else.
    'x blb'=. x
    sql=. (". 'sqlins_',x);blb
  end.
  y apply__db sql
)

NB. =========================================================
NB. interface

showFlip=: 3 : 0
  wd 'setshow btFlip ',": y
)

editingTable=: 3 : 0
  wd 'setenable btEdit ', ":-.y
  wd 'setenable btSave ', ": y
  wd 'setenable btCancel ', ": y
  wd 'setenable lsObj ', ":-.y
  wd 'setenable tab ', ":-.y
  wd 'setfocus grid'
  if. y do.
    CELLEDIT__grid=: (". 'celledit',tab) mkmask CELLDATA NB. get appropriate array for current tab
  else.
    try. CELLEDIT__grid=: 0 catch. end.
  end.
)

addingTable=: 3 : 0
  wd 'setshow btAdd ', ": y
  wd 'setshow btEdit ', ": -.y
)
chwsingProfile=: 3 : 0
  wd 'setshow btSave ', ": -.y
  wd 'setshow btChoose ', ": y
)


NB. =========================================================
NB. utils

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

NB. =========================================================
NB. Customised Indexes form definition

F=: 0 : 0
pc f nomax;
menupop "&File";
menu con "&Connect" "" "" "";
menusep;
menu exit "E&xit" "" "" "";
menupopz;
menupop "&Tools";
menu updAllREVs "&Update All REVs" "" "" "";
menusep;
menu impCat "&Import Sale Catalogue" "" "" "";
menu viewCat "&View Sale Catalogue" "" "" "";
menupopz;
menupop "&Help";
menu about "&About" "" "" "";
menupopz;
xywh 21 10 50 10;cc ccstatic static;cn "Clients";
xywh 17 22 64 149;cc lsObj listbox ws_vscroll es_autovscroll es_autohscroll bottommove;
xywh 90 8 205 188;cc tab tab bottommove rightmove;
xywh 96 23 195 172;cc grid isigraph bottommove rightmove;
xywh 300 21 57 16;cc btEdit button leftmove rightmove;cn "&Edit";
xywh 300 41 57 16;cc btSave button leftmove rightmove;cn "&Save Changes";
xywh 300 61 57 16;cc btCancel button leftmove rightmove;cn "&Cancel Changes";
xywh 300 81 57 16;cc btcalcREVs button leftmove rightmove;cn "Calculate &REVs";
xywh 300 101 57 16;cc btFlip button leftmove rightmove;cn "&Flip";
xywh 312 177 44 12;cc btClose button leftmove rightmove;cn "Close";
xywh 300 41 57 16;cc btChoose button leftmove rightmove;cn "C&hoose Profile";
xywh 300 21 57 16;cc btAdd button leftmove rightmove;cn "&Add";
pas 6 6;pcenter;
rem form end;
)

f_close=: destroy
f_btClose_button=: destroy
f_exit_button=: destroy

f_lsObj_select=: redisplaygrd
f_tab_button=: redisplaygrd

f_btFlip_button=: 3 : 0
  if. (i.0 0) -: CELLDATA do. return. end.
  flip__grid ''
)

f_con_button=: 3 : 0
  if. 0=#f=. openDb'' do. return. end.
  connect DBFILE=. f
)

f_btEdit_button=: 3 : 0
  editingTable 1
  select. tab
    case. 'Price_Profile' do.
      chooseProfile clid
      return.
    case. 'REVs' do.
      'grddefnew' viewTable ;:'dummy data'
      return.
  end.
  show__grid ''
)

f_btAdd_button=: 3 : 0
  select. tab
    case. 'Address';'Scenario';'REVs' do.
      'grddefnew' viewTable ;: 'dummy data'
    case. 'Price_Profile' do.
      f_btEdit_button ''
      return.
  end.
  editingTable 1
  show__grid ''
)

f_btSave_button=: 3 : 0
  editingTable 0
  saveTable tab
  redisplaygrd ''
)

f_btChoose_button=: 3 : 0
  colch=. (I. >{.CELLDATA__grid)
  chwsingProfile 0
  if. 'Custom'-: colch{:: ,}.HDRCOL do.  NB. define custom prices
    editCustom ''
  else.
    f_btSave_button ''
  end.
)

f_btCancel_button=: 3 : 0
  chwsingProfile 0
  editingTable 0
  redisplaygrd ''
)

f_btcalcREVs_button=: 3 : 0
  NB. calc REVs for client based on rv_pp & rv_scenario
  NB. leave in editingTable mode so can save or cancel change
  revs=. clid getNewREVs 'updateclientREVs'
  CELLDATA__grid=: ( _3}."1 CELLDATA__grid),. <&> (3{."1 revs)
  editingTable 1  NB. enable save/cancel buttons
  CELLEDIT__grid=: 0  NB. but no editing
  show__grid ''
)

f_updAllREVs_button=: 3 : 0
  NB. calc REVs for all clients that need updated REVs based on their rv_pp & rv_scenario
  NB. update to database
  revs=. '' getNewREVs 'all2updateREVs'
  nupd=. 'calcREVs' updateDBTable revs
  redisplaygrd ''
  wdinfo 'REVs calculated';(": #nupd), ' client REVs recalculated.'
)

f_impCat_button=: 3 : 0
  importCatalog ''
)

f_viewCat_button=: 3 : 0
  viewCatalog ''
)

NB. IDEAS for event handlers
NB. would like to let F2 start edit of cell in grid
NB. would like LeftArrow, RightArrow while in listbox to cycle through tabs

grid_gridhandler=: 3 : 0
  if. y -: 'change' do.
    changex__grid''
    if. (tab-:'Price_Profile') *. (0 = Row__grid) do.
      CELLDATA__grid=: (<&>1 (Col__grid)} Ccls__grid#0) (0)}CELLDATA__grid
    end.
  end.
)

custidx_z_=: conew&'pcustidx'
