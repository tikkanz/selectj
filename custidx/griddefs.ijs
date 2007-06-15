NB. =========================================================
NB. Definitions for Grid control in Customised Index application
grddefEmpty=: 0 : 0
  CELLDATA=: i.0 0
  HDRCOL=: ''
  HDRROW=: ''
  addingTable 1
)

grddefAddress=: 0 : 0
  CELLDATA=: }.CELLDATA
  CELLCOLOR=: 2|i.{:$CELLDATA
  CELLEDIT=: 0
  COLMINWIDTH=: 0 100
  HDRCOL=: ;: 'Lastname Firstname Title Initial Address City Email Phone Fax Mobile'
  HDRCOLALIGN=: 2
  HDRROW=: ''
)
grddefnewAddress=: 0 : 0
  CELLCOLOR=: 2|i.{:$CELLDATA
  HDRCOL=: ;: 'Lastname Firstname Title Initial Address City Email Phone Fax Mobile'
  HDRCOLALIGN=: 2
  HDRROW=: ''
  CELLDATA=: |:,.($HDRCOL)$<''
  COLMINWIDTH=: 0 200
)
grddefScenario=: 0 : 0
  CELLDATA=: }.CELLDATA
  CELLCOLOR=: 2|i.{:$CELLDATA
  CELLEDIT=: 0
  CELLFMT=: <;._2 '0 0 0 0.1 0.1 0.1 0 0.2 0.2 0.2 0.2 0.1 0.1 0 0.2 0.2 0.2 0.2 '
  hc=. 'Created;Ewes to Ram;Years Ram Used;Lambing %;'
  hc=. hc,'% of Ewe lambs retained;% of Ewe hoggets retained;'
  hc=. hc,'Years Ewes kept;Ewe hogget CFW;Ewe hogget MFD;Ewe CFW;Ewe MFD;'
  hc=. hc,'% Wether lambs retained;% Wether hoggets retained;'
  hc=. hc,'Years Wethers kept;Wether hogget CFW;Wether hogget MFD;Wether CFW;Wether MFD;'
  HDRCOL=: <;._2 hc
  HDRCOLALIGN=: 2
  HDRROW=: ''
)
grddefnewScenario=: 0 : 0
  CELLFMT=: <;._2 '0 0 0 0.1 0.1 0.1 0 0.2 0.2 0.2 0.2 0.1 0.1 0 0.2 0.2 0.2 0.2 '
  hc=. 'Created;Ewes to Ram;Years Ram Used;Lambing %;'
  hc=. hc,'% of Ewe lambs retained;% of Ewe hoggets retained;'
  hc=. hc,'Years Ewes kept;Ewe hogget CFW;Ewe hogget MFD;Ewe CFW;Ewe MFD;'
  hc=. hc,'% Wether lambs retained;% Wether hoggets retained;'
  hc=. hc,'Years Wethers kept;Wether hogget CFW;Wether hogget MFD;Wether CFW;Wether MFD;'
  HDRCOL=: <;._2 hc
  HDRCOLALIGN=: 2
  HDRROW=: ''
  CELLDATA=: |:,. ({.6!:0 '');(<:$HDRCOL)$a:
  CELLCOLOR=: 2|i.{:$CELLDATA
)

grddefPrice_Profile=: 0 : 0
  CELLDATA=: }.CELLDATA
  CELLEDIT=: 0
  CELLFMT=: <;._2 '0.0 0.1 0.2 '
NB.   COLSCALE=: 1
  HDRCOL=: <;._2 'Created;MFD;Price/kg;'
  HDRCOLALIGN=: 2
  HDRROW=:''
)
grddefchPrice_Profile=: 0 : 0
  HDRTOP=: <'MFD'
  hc=. 8!:0 }.{.CELLDATA
  HDRCOL=: hc,:~(<'Client Defined') (i.>: hc i. <'Custom')}($hc)$<'     Industry Averages'
  HDRCOLMERGE=:1 0
  HDRROW=: 8!:0 {."1 }.y
  CELLDATA=: }."1 }. CELLDATA
  CELLTYPE=: 100 (0)}($CELLDATA)$0
NB.   CELLEDIT=: 1
  CELLEDIT=: 1 (0)}($CELLDATA)$0
NB.   GRIDFLIP=: -.GRIDFLIP
  HDRCOLALIGN=:2,:~0=i.~{.HDRCOL    NB. (#hc)$"1,.0 2
)
grddefcustPrice_Profile=: 0 : 0
  CELLDATA=: (<&>13 + i.12),.12$a:
  CELLEDIT=: 1
NB.   GRIDFLIP=: -.GRIDFLIP
  HDRROW=: ''
  HDRCOL=: 'MFD';'Price/kg'
)

grddefREVs=: 0 : 0
  CELLDATA=: }.CELLDATA
  CELLEDIT=: 0
  CELLCOLOR=: 2|i.{:$CELLDATA
  CELLFMT=: <;._2 '0.0 0.0 0.0 0.2 0.2 c0.2 '
  HDRCOL=: <;._2 'Created;Scenario ID;Price Profile ID;CFW REV;MFD REV;Index Unit value;'
  HDRROW=: ''
)

grddefnewREVs=: 0 : 0
  CELLDATA=: |:,. ({. 6!:0 '');a:,a:, <&> 1 1 1  NB. yr,null,null,default,default,default
  CELLCOLOR=: 2|i.{:$CELLDATA
  CELLFMT=: <;._2 '0.0 0.0 0.0 0.2 0.2 c0.2 '
  CELLEDIT=: celleditREVs mkmask CELLDATA
  HDRCOL=: <;._2 'Created;Scenario ID;Price Profile ID;CFW REV;MFD REV;Index Unit value;'
  HDRROW=: ''
)

grddefIndex_List=: 0 : 0
  defIndexList ''
)

NB.   verb because can't have if.else. in noun script
defIndexList=: 3 : 0
  if. +./ >a: -:each _3{.{:CELLDATA do. NB. check that none of rv_mfd, rv_cfw or rv_value is empty
    0!:100 grddefEmpty
  else.
    CELLDATA=: calcIndexList CELLDATA
    HDRTOP=:  1{.{.CELLDATA
    HDRCOL=:  1}.{.CELLDATA
    CELLFMT=: <;._2 '0 m<$->p<$>c0.2 0 0.2 0.1 0.1 0.2 0.1 0.1 0.2 0.1 0.1 0.1 0.1 0.1 0.1 0 0.1 '
    HDRROW=:  (8!:0) 1{."1 }.CELLDATA
    CELLDATA=: 1}."1 }.CELLDATA
    CELLDRAW=: CELLDATA
    GRIDSORT=: 1
    CELLEDIT=: 0
  end.
)

mkmask=: 4 : '({:$y) ($!.1) x# 0'  NB. x is number of non-editable cells at start, y is matrix

celleditAddress=: 0   NB. number of non-editable columns from start
celleditScenario=: 1
celleditPrice_Profile=: 1
celleditREVs=: 3
celleditIndex_List=: 18