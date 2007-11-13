NB. http://pylonshq.com/WebHelpers/module-webhelpers.rails.form_options.html
NB. =========================================================
NB. form_options
NB.    codestroy_jweb_ ''
NB.   require jpath '~Projects\utils\webxhtml.ijs'
coclass 'rgswebforms'
coinsert COBASE NB. path of rgswebforms is <starting local>;'z'

NB. =========================================================
NB. verbs for building dynamic form for on case.jhp?action=params

NB.*buildButtons v builds xhtml div code for form submit/reset buttons
NB. y is ''
buildButtons=: 3 : 0
  bt=. INPUT class 'button' type 'submit' value 'Save Changes' ''
  bt=. bt,LF, INPUT class 'button' type 'reset' value 'Discard Changes' ''
  DIV class 'buttonrow' bt
)

NB.*buildForm v builds xhtml form code for a case
NB. y is ci_id of case
buildForm=: 3 : 0
  ANIMINI_z_=: 'animini' getInfo y
  TRTINFO_z_=: 'trtinfoall' getInfo y
  info=. 'paramform' getInfo y  NB. gets legend, fs_ids,cf_value
  'hdr dat'=. split info
  (hdr)=. |:dat                   NB. assign hdrnames
  lgd=. P class 'legend' 'This is the legend for my form'
  lgd=. lgd, INPUT class 'input' type 'hidden' name 'action' id 'action' value 'chgparams' ''
  fsts=. cf_value buildFieldset each fs_id
  frm=. LF join lgd;fsts, boxopen buildButtons ''
  frm=. FORM id 'params' name 'params' method 'post' action 'case.jhp' frm
  DIV class 'form-container' frm
)

NB.*buildFieldset v builds xhtml fieldset code for a fieldset in a form
NB. y is fs_id of fieldset
NB. x is disabled status (0 disabled, 1 not disabled)
buildFieldset=: 3 : 0
  1 buildFieldset y
  :
  info=. 'fieldset' getDBTable y NB. gets fs_name,pr_id
  'hdr dat'=. split info
  (hdr)=. |:dat                   NB. assign hdrnames
  lgd=. LEGEND {.fs_name        NB. repeated for each pr_id
  pdvs=. buildParamDiv each boxitemidx <"0 each fs_id;pr_id
  fst=. FIELDSET LF join lgd;pdvs
  dsabld=. (x<1)#'disabled="disabled"'
  fst=. ('disabled="disabled"';dsabld) stringreplace fst
)

NB.*buildParamDiv v builds relevant xhtml div for a parameter in a fieldset
NB. y is list of fieldsetid,parameterid (fp_fsid,fp_prid)
buildParamDiv=: 3 : 0
  info=. 'param' getDBTable y  NB. gets pr_class,pr_name,fp_label,pr_note,fp_note,pr_code
  'hdr dat'=. split info
  (hdr)=. ,dat                   NB. assign hdrnames
  if. #fp_label do. pr_name=. fp_label end. NB. update default label
  if. #fp_note  do. pr_note=. fp_note  end. NB. update default note
  if. #fp_class do. pr_class=. fp_class end. NB. update default class
  if. #fp_ctype do. pr_ctype=. fp_ctype end. NB. update default control type
  if. #fp_cprops do. pr_cprops=. fp_cprops end. NB. update default control properties
  info=. getParamState pr_code NB. get seld,nms,vals
  'seld vals nms'=. 3{. info
  ctrlprops=. boxopen pr_cprops
  ctrlprops=. (#vals)#ctrlprops
  idx=. makeidx (<:^:(=1:)) #vals NB. a: if 1=#val
  if. 'select'-: pr_ctype do. idx=. a: end. NB. otherwise mismatch label id for select
  if. pr_class-:'controlset' do.
    lbl=. LABEL class 'controlset' pr_name
    ctrls=. seld buildControlset  ctrlprops;vals;nms;<idx
    ctrls=. boxopen DIV ctrls
    nte=. buildNote pr_note
    pdv=. DIV class 'controlset' LF join lbl;ctrls,<nte
  else.
    lbl=. 'pr_code' buildLabel pr_name;{.idx
    select. pr_ctype  NB. choose control type
      case. 'select' do.
        if. -.a:-:nms do. vals=. boxitemidx vals;<nms end.
        ctrls=. boxopen seld buildSelect (0{::ctrlprops);<vals
      case. 'textarea' do.
        ctrls=. buildTextarea ctrlprops;<vals
      case. 'input' do.
        ctrls=. seld&buildInput each boxitemidx ctrlprops;vals;<idx
    end.
    nte=. buildNote pr_note
    pdv=. DIV LF join lbl;ctrls,<nte
  end.
  pdv=. ('pr_code';pr_code) stringreplace pdv
)

NB.*buildControlset v builds group of Input form controls with labels
NB. y is list of boxed 3- or 4-item lists
NB.             Ctrlprops;Controlvalues;Controlnames[;Controlindicies]
NB. x is optional list of boxed controlvalues to be checked
buildControlset=: 3 : 0
  '' buildControlset y
  :
  'cprops vals nms idx'=. 4{. y
  ctrls=. x&buildInput each boxitemidx cprops;vals;<idx
  lbls=. 'pr_code'&buildLabel each boxitemidx nms;<idx
  LF join ,ctrls,.lbls,.<BR ''
)

NB.*buildInput v builds Input form control
NB. y is 3-item list of boxed Ctrlprops;Controlvalues[;Controlindicies]
NB. x is optional list of boxed Controlvalues to be checked
buildInput=: 3 : 0
  '' buildInput y
  :
  'Ctrlprops Val Idx'=. 3{. y
  Val=. ,8!:2 Val
  x=. 8!:0 x
  Pcode=. 'pr_code'
  Chk=. 'checked="checked"'
  ". '((x e.~ <Val)#Chk) INPUT id (Pcode,":Idx) value Val name Pcode disabled Pcode ',Ctrlprops,' '''''
)

NB.*buildLabel v builds Label for form control
NB. y is 1- or 2-item list of boxed Labeltext[;Controlindex]
NB. x is optional parameter code
NB. for="{paramcode},{Controlindex}" (matches unique ID of control)
NB. eg. buildLabel 'Height'   or 'trait' buildLabel 'Height';4
buildLabel=: 3 : 0
  '' buildLabel y
  :
  'nme idx'=. 2{. boxopen y
  Pcode=. x NB. parameter code
  LABEL for (Pcode,":idx) nme
)

NB.*buildNote v builds Note code for form control
NB. returns '' if y is '' else code for Note
NB. y is string for note
buildNote=: 3 : 0
  if. #y do.
    P class 'note' y
  else. y end.
)

NB.*buildOption v builds xhtml option code for an option in a select form control
NB. y is a 1- or 2-item list of boxed Optionvalue[;Optiontext]
NB. x is optional list of boxed Optionvalues to be selected
NB. used by buildSelect
NB. eg. (3;4;5) buildOption 0;'Blue'
NB. eg. (0;4;5) buildOption 0;'Blue'
buildOption=: 3 : 0
  '' buildOption y
  :
  'Val Descr'=. 2$y
  sel=. 'selected="selected"'
  ((x e.~ <Val)#sel) OPTION value Val ":Descr
)

NB.*buildSelect v creates select control with options.
NB. y is a 2-item boxed list
NB.      0{ is ctrlprops
NB.      1{ is list of boxed 1- or 2-item lists
NB.         if 1-item list then use for both option value and text
NB.         if 2-item list then use {. for value and {: for text
NB. x is list of boxed values specifying the options selected
buildSelect=: 3 : 0
  '' buildSelect y
  :
  'Ctrlprops opts'=. 2{. y
  opts=. ,each (<"0^:(L.=1:)) opts NB. ensure box depth 2 and no atoms
  NB.   opts=. 8!:0 each opts
  NB.   x=. boxopen 8!:0 x
  Pcode=. 'pr_code'
  opts=. x&buildOption each opts
  opts=. LF join opts
  ". 'SELECT id Pcode name Pcode disabled Pcode ',Ctrlprops,' opts'
)

NB.*makeTable v create simple XHTML table from boxed matrix
makeTable=: 3 : 0
  TABLE TBODY LF join TR each ,each/"1 TD each y
)

enclose=: [ , ,~

buildTag=: 4 :0
  'tgn attn attv'=. x
  attr=. ((' 'enclose each boxopen attn),each quote each boxopen attv)
  tgdefs=. ,each/"1 |: (<toupper tgn),attr
  ".each tgdefs ,each (' ',each quote each y)
)

NB. eg. 'r' altclass 4
altclass=: 13 : '(<''class'') ,. x ,&.> (8!:0) >:2&| i.y'

buildSJForm=: 3 : 0
  '' buildSJForm y
  :
  select. x
    case. 'sumryplotsrc' do.
      ciids=. y
      page=. 'coursesumry_plot.jhp'
      qry=. '?',args ((<'ciids'),.ciids),((<'trts'),.trtsseld),(<'inftyps'),.inftypsseld
      frm=. ('src';page,qry),('id';'sumryplot'),: 'alt';'Summary plot'
      qry=. '?',args (<'ciids'),.{.ciids
      frm=. tag  ('href';'coursesumry_plotpdf.jhp',qry) atr (,'a') (txt elm)~(frm) atr elm 'img'
    case. 'sumrydef' do.
      ciids=. y
      hdrs=. 'animsumryhdr'&getInfo each ciids
      trtflds=. getTrtsOnly each hdrs
      trts=. ~.&getTrtBase each trtflds NB. get trait abbrevs
      dict=. 0 _1&{"1&('trtinfoall'&getInfo) each ciids
      trts=. trts ,. each (trts) keyval each each <"0 dict
      unqtrts=. ~.; trts
      inftyps=. getTrtInfoTyps each trtflds NB. get info types for each ciid
      dict=. <(;:'phen genD genDe'),.(cut 'Phenotypes Genotypes Est.&nbsp;Genotypes')
      inftyps=. inftyps ,. each (inftyps) keyval each each <"0 dict
      unqinftyps=. ~.; inftyps NB. get nub of superset of all info types codes
      trtmsk=. |:unqtrts&e. every trts
      trtmsk=. trtmsk{ '-';'*'
      NB. trtmsk=. trtmsk{ '&nbsp;';'&#9679;'
      inftypmsk=. |:unqinftyps&e. every inftyps
      inftypmsk=. inftypmsk{ '-';'*'
      NB. inftypmsk=. inftypmsk{ '&nbsp;';'&#9679;'
      csinsts=. 'caseinstname' getInfo  boxopenatoms ciids
      csinstsidx=. 0=# every {."1 }. csinsts
      csnmes=. (<"1 (i.<:#csinsts),.csinstsidx){}.csinsts
    NB.! could also add headerrow to table with sd_name in it as well as
    NB.! put in ciid in headerrow too.
      
      mkchks=.  elm"1~ (elm 'input') atr"2 1~ ]
      mktblh2=. (;:'class tblheading2') atr"1 'td' elm~"1 ]
      mktblbodyhdg=. ('th' (txt elm)~ [) , 'td' elm"0 1~ ' ' #~ [: >:@# ]
      S=. LF elm ''
      nhcols=. 2
      trtids=. ('traits'&,each 8!:0 i. #unqtrts)
      inftypids=. ('inftyps'&,each 8!:0 i. #unqinftyps)
      caseids=. ('ciid'&,each 8!:0 i. #ciids)
      
    NB. header rows
      csnmes=. csnmes ,each (' (';')') prefsuf 8!:0 ciids
      cinms=. 'th' elm~"1 ((<'for'),.caseids) atr"1 'label' (txt elm)~"1 >csnmes
      cichks=. ('checked';''),('type';'checkbox'),:('name';'ciid')
      cichks=. (((<'id'),.caseids ),:"1 ((<'value'),.ciids)),"2 _ cichks
      cichks=. 'th' mkchks cichks
      hdr=. S,"2 ((('colspan';":nhcols) atr elm 'th'),"2 cinms,:cichks),"2 S
      hdr=. 'thead' elm~ 'tr' elm~"1 2 hdr
      
    NB. trts 
      trtcnts=. ('class';'tbltick') atr"1 (>,each trtmsk) elm"1 'td'
      trtchks=. ('type';'checkbox'),:('name';'traits')
      trtchks=. (('checked';'') (({."1 unqtrts) idxfnd trtsseld)}((#unqtrts),2)$a:),"1 _ trtchks
      trtchks=. (((<'id'),.trtids),:"1 ((<'value'),.{."1 unqtrts)),. trtchks
      trtchks=. 'td' mkchks trtchks
      
      trtabrs=. (<'abbr'),.(<"1(<'title'),.{:"1 unqtrts),.{."1 unqtrts
      trtlbls=. ((<'for'),.trtids) atr"1 'label' elm"1 2~ trtabrs
      trtlbls=. mktblh2 trtlbls
      
      trthdg=. 'Traits' mktblbodyhdg ciids
      
      trtbdy=. S,"2 (trthdg,trtlbls,.trtchks,.trtcnts) ,"2 S
      trtbdy=. ('r' altclass >:#unqtrts) atr"1 'tr' (txt elm)~"1 2 trtbdy
      trtbdy=. ('id';'trts')atr 'tbody' elm~ trtbdy
      
    NB. inftyps
      inftypcnts=. ('class';'tbltick') atr"1 (>,each inftypmsk) elm"1 'td'
      inftypchks=. ('type';'checkbox'),:('name';'inftyps')
      inftypchks=. (('checked';'') (({."1 unqinftyps) idxfnd inftypsseld)}((#unqinftyps),2)$a:),"1 _ inftypchks
      inftypchks=. (((<'id'),.inftypids),:"1 ((<'value'),.{."1 unqinftyps)),. inftypchks
      inftypchks=. 'td' mkchks inftypchks
      
      inftypabrs=. (<'abbr'),.(<"1(<'title'),.{:"1 unqinftyps),.{."1 unqinftyps
      inftyplbls=. ((<'for'),.inftypids) atr"1 'label' elm"1 2~ inftypabrs
      inftyplbls=. mktblh2 inftyplbls
      
      inftyphdg=. 'InfoTypes' mktblbodyhdg ciids
      
      inftypbdy=. S,"2 (inftyphdg,inftyplbls,.inftypchks,.inftypcnts) ,"2 S
      inftypbdy=. ('r' altclass >:#unqinftyps) atr"1 'tr' (txt elm)~"1 2 inftypbdy
      inftypbdy=. ('id';'inftyps')atr 'tbody' elm~ inftypbdy
      
    NB. footer rows
      tls=. 'Plot Summary';'Tabulate Summary'
      tls=.  ((<'value'),.tls),"1 _('type';'submit'),:('name';'action')
      tls=. ('colspan';":nhcols+#ciids) atr 'td' elm~ tls (atr elm)"2 'input'
      ftr=. 'tfoot' elm~ ('class';'tbltools') atr 'tr' elm~ tls
      
    NB. form table
      tbl=. ('cellspacing';'0') atr 'table' elm~ hdr,trtbdy,inftypbdy,:ftr
      frm=. (<;._1' id action method name'),.<;._1' defsumry coursesumry.jhp post defsumry'
      frm=. tag frm atr 'form' elm~ tbl
      
    case. do.
  end.
)

Note  'Build Sumrydef Table'
cols4row=. (TD class 'tbltick')"1  '1st','&nbsp;',:'hello'
cols4row=. (TD class 'tbltick') every '1st';'&nbsp;';'hello'
row=. TR class 'r1' vfm cols4row
INPUT type 'checkbox' name 'traits' id 'traits0' ''
LF join TR each ,each/"1 |: TD classA ('r1';'r2';'r3') |: 8!:0 i.  4 3
LF join TR each ,each/"1    TD classA  'r1' 8!:0 i.  4 3
TABLE id 'sumrydef' TBODY id 'infotyps' LF join TR each ,each/"1 |: TD class2 ('r1';'r2';'r3') |: 8!:0 i.  4 3
(TD classA ('trait'&,each 8!:0 >:i.4) 8!:0 i.  4 1),.TD classA ('tbletick') 8!:0 i.  4 3
unbox1=: >^:(<:&L.) NB. unbox down to 1 level
unbox1 TD ismap noresize checked 8!:0 i. 3 4
TABLE id 'sumrydef' TBODY id 'trts' LF join TR classA ('r1';'r2';'r1') ,each/"1(TD each tst),. TD classA ('s1';'s2';'s3') 8!:0 i.3 2

NB.  cell=:4 :0
NB.   'nm cl'=.x
NB.   TD name nm class cl y
NB.  ) NB. from Raul

((;:'n1 n2 n3') <@,"0 ;:'s1 s2 s3') cell each 8!:0 i.3 2
('TD' ;('name';'id';'class');< ('n1';'id1';'s3')) buildTag '3'
('TD' ;('name';'id';'class');< ('n1';'id1';'s3')) buildTag 8!:0 i.3 2
('TD' ;('name';'id';'class');< ((;:'n1 n2 n3') , (;:'id1 id2 id3') ,: ;:'s1 s2 s3')) cell1 8!:0 i.3 2
('TD' ;('name';'id';'disabled');< ((;:'n1 n2 n3') , (;:'id1 id2 id3') ,: ;:'s1 s2 s3')) buildTag 8!:0 i.3 2

)


Note 'using `tag` verb'
]smrytbl=. ('class';'r1') atr 'tr' elm~('class';'tbltick') atr"1 (>8!:0 i.4) txt"1 elm"1 'td'
tag smrytbl
]smrytbl=. ('class';'r1') atr"1 'tr'elm~"1 2 ('class';'tbltick') atr"1 (>8!:0 i.3 4) txt"1 elm"1 'td'
,(tag"1 smrytbl),.LF
]smrytbl=. (('class';'r1'),('class';'r2'),:('class';'r1')) atr"1 'tr'elm~"1 2 ('class';'tbltick') atr"1 (>8!:0 i.3 4) txt"1 elm"1 'td'
,(tag"1 smrytbl),.LF
]icls=.   ((<'id'),.'traits'&,each 8!:0 i.4),"1 _ (('value';'1'),('type';'checkbox'),:('name';'traits'))
tag"1 icls atr"2 1 elm 'input'
((icls atr"2 1 elm 'input') elm"1 'td'),. ('class';'tbltick') atr"1 (>8!:0 i.4 3 ) elm"1 'td'
)

NB. =========================================================
NB. Utilities

NB. makeidx v creates list of boxed literal numerics from 0 to y
makeidx=: [: 8!:0 i.
NB. makeidx=: ' ' -.~ [: ": i.


boxitemidx=: <"1@:|:@:>

NB. =========================================================
Note 'tests'
NB. tests need to be rewritten to work with above names.
tst=: ('Dollar';'$')
rarg=: ('Dollar';'$');(<'Kroner';'DKK')
larg=: ''
selectoptions rarg
larg selectoptions rarg
NB. <option value="$">Dollar</option>\n<option value="DKK">Kroner</option>

rarg=: ('VISA';'MasterCard')
larg=: 'MasterCard'
larg selectoptions rarg
NB. <option value="VISA">VISA</option>\n<option value="MasterCard" selected="selected">MasterCard</option>

rarg=: dict 'Basic="$20"';'Plus="$40"'
larg=: '$40'
larg selectoptions rarg
NB. <option value="$20">Basic</option>\n<option value="$40" selected="selected">Plus</option>

rarg=:  'VISA';'MasterCard';'Discover'
larg=:  'VISA';'Discover'
larg selectoptions rarg
NB. <option value="VISA" selected="selected">VISA</option>\n
NB. <option value="MasterCard">MasterCard</option>\n
NB. <option value="Discover" selected="selected">Discover</option>

rarg=:  '';('No. of Lambs Born';'NLB');('Live weight at 8-mon';'LW8');('Fleece weight at 12-mon';'FW12');(<'Ultrasound backfat depth';'FD')
larg=:  'NLB';'FD'
larg buildSelect rarg
NB. <option value="NLB" selected="selected">No. of Lambs Born</option>\n
NB. <option value="LW8">Live weight at 8-mon</option>\n
NB. <option value="FW12">Fleece weight at 12-mon</option>\n
NB. <option value="FD" selected="selected">Ultrasound backfat depth</option>
)

buildSJForm_z_=: buildSJForm_rgswebforms_
buildForm_z_=:  buildForm_rgswebforms_
makeTable_z_=:  makeTable_rgswebforms_
buildTable_z_=: buildTable_rgswebforms_
