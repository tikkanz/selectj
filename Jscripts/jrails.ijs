NB. http://pylonshq.com/WebHelpers/module-webhelpers.rails.form_options.html
NB. =========================================================
NB. form_options
NB.    codestroy_jweb_ ''
NB.   require jpath '~Projects\utils\webxhtml.ijs'
coclass 'pwebforms'

NB. =========================================================
NB. verbs for building dynamic form for on case.jhp?action=params

NB.*buildButtons v builds xhtml div code for form submit/reset buttons
NB. y is ''
buildButtons=: 3 : 0
  bt=. INPUT class 'button' type 'submit' onclick 'formsubmit()' value 'Save Changes' ''
  bt=. bt,LF, INPUT class 'button' type 'reset' value 'Discard Changes' ''
  DIV class 'buttonrow' bt
)

NB.*buildForm v builds xhtml form code for a case
NB. y is ci_id of case
buildForm=: 3 : 0
  ANIMINI_z_=: }."1 'animini' getScenarioInfo y
  ANIMINI_z_=: (tolower each {."1 ANIMINI) (0)}"0 1 ANIMINI
  TRTINFO_z_=: 'alltrtinfo' getScenarioInfo y
  info=. 'paramform' getTable_psqliteq_ y  NB. gets legend, fs_ids,cf_value
  'hdr dat'=. split info
  (hdr)=. |:dat                   NB. assign hdrnames
  lgd=. P class 'legend' 'This is the legend for my form'
  fsts=. cf_value buildFieldset each fs_id
  frm=. LF join lgd;fsts, boxopen buildButtons ''
  frm=. FORM id 'params' name 'params' enctype 'multipart/form-data' method 'post' action 'case.jhp?action=chgparams' frm
  DIV class 'form-container' frm
)

NB.*buildFieldset v builds xhtml fieldset code for a fieldset in a form
NB. y is fs_id of fieldset
NB. x is cf_value or disabled status (0 disabled, 1 not disabled)
buildFieldset=: 3 : 0
  1 buildFieldset y
:
  info=. 'fieldset' getTable_psqliteq_ y NB. gets fs_name,pr_id
  'hdr dat'=. split info
  (hdr)=. |:dat                   NB. assign hdrnames
  lgd=. LEGEND {.fs_name        NB. repeated for each pr_id
  pdvs=. buildParamDiv each boxitemidx <"0 each fs_id;pr_id
  fst=. FIELDSET LF join lgd;pdvs
  dsabld=. (x<1)#'disabled="disabled"'
  fst=. ('disabled';dsabld) stringreplace fst
)

NB.*buildParamDiv v builds relevant xhtml div for a parameter in a fieldset
NB. y is list of fieldsetid,parameterid (fp_fsid,fp_prid)
buildParamDiv=: 3 : 0
  info=. 'param' getTable_psqliteq_ y  NB. gets pr_class,pr_name,fp_label,pr_note,fp_note,pr_code
  'hdr dat'=. split info
  (hdr)=. ,dat                   NB. assign hdrnames
  if. #fp_label do. pr_name=. fp_label end. NB. update default label
  if. #fp_note  do. pr_note=. fp_note  end. NB. update default note
  info=. getParamState pr_code NB.! get seld,nms,vals,idx
  'seld vals nms'=. 3{. info
  ctrlprops=. <LF-.~".'ctrlprops_',pr_code NB. get ctrlprops
  ctrlprops=. (#vals)#ctrlprops
  idx=. makeidx (<:^:(=1:)) #vals NB. a: if 1=#val
  if. 'select'-: pr_ctype do. idx=.a: end. NB. otherwise mismatch label id for select
  if. pr_class-:'controlset' do.
    lbl=. LABEL class 'controlset' pr_name
    ctrls=.seld buildControlset  ctrlprops;vals;nms;<idx
    ctrls=.boxopen DIV ctrls
    nte=. buildNote pr_note
    pdv=. DIV class 'controlset' LF join lbl;ctrls,<nte
  else.
    lbl=. 'pr_code' buildLabel pr_name;{.idx
    select. pr_ctype  NB. choose control type
      case. 'select' do.
        if. -.a:-:nms do. vals=.boxitemidx vals;<nms end.
        ctrls=.boxopen seld buildSelect (0{::ctrlprops);<vals
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
  'cprops vals nms idx'=. 4{.y
  ctrls=. x&buildInput each boxitemidx cprops;vals;<idx
  lbls=.  buildLabel each boxitemidx nms;<idx
  LF join ,ctrls,.lbls,.<BR ''
)

NB.*buildInput v builds Input form control
NB. y is 3-item list of boxed Ctrlprops;Controlvalues[;Controlindicies]
NB. x is optional list of boxed Controlvalues to be checked
buildInput=: 3 : 0
 '' buildInput y
:
  'Ctrlprops Val Idx'=. 3{.y
  Val=. ,8!:2 Val
  x=. 8!:0 x
  Pcode=.'pr_code'
  Chk=. 'checked="checked"'
  ". '((x e.~ <Val)#Chk) INPUT id (Pcode,Idx) value Val name Pcode disabled ',Ctrlprops,' '''''
)

NB.*buildLabel v builds Label for form control
NB. y is 1- or 2-item list of boxed Labeltext[;Controlindex]
NB. x is optional parameter code
buildLabel=: 3 : 0
  'pr_code' buildLabel y
:
  'nme idx'=. 2{. boxopen y
  Pcode=. x NB. parameter code
  LABEL for (Pcode,idx) nme
)

NB.*buildLabel v builds Note code for form control
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
buildOption=: 3 : 0
  '' buildOption y
:
  'Val Descr'=. 2$y
  sel=. 'selected="selected"'
  ((x e.~ <Val)#sel) OPTION value Val Descr
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
  opts=. 8!:0 each opts
  x=. boxopen 8!:0 x
  Pcode=.'pr_code'
  opts=. x&buildOption each opts
  opts=. LF join opts
  ". 'SELECT id Pcode name Pcode disabled ',Ctrlprops,' opts'
)

NB.*getParamState v retrieves parameter state from caseinstance
NB. returns 2- or 3- item boxed list of selectedvalues;values;valuenames
NB. y is pr_code (code for parameter eg. 'ncycles')
NB. this is dummy function until implement proper one - scenarios!!!
getParamStateX=: 3 : 0
  seld=. boxopen ".'seld_',y
  vals=. boxopen ".'vals_',y
  nms=.  boxopen ".'nmes_',y
seld;vals;<nms
)

NB.dict v parses list of boxed name=value pairs
NB. returns list of boxed 2-item boxed lists
NB.     {.item is name, {: item is value
dict=: 3 : 0
NB.jdj
)

NB. =========================================================
NB. Utilities

NB. removes quotes
unquote=: 3 : 0
  y-.'"'
)
NB. replaces quotes with spaces
unquot=: 3 : 0
'" ' charsub y
)

NB.*join v unbox and delimit a list of boxed items y with x
NB. from forum post
NB. http://www.jsoftware.com/pipermail/programming/2007-June/007077.html
NB. eg. '","' join 'item1';'item2'
NB. eg. LF join 'item1';'item2'
NB. eg. 99 join <&> i.8
join=: ' '&$. : (4 : '(;@(#^:_1!.(<x))~  1 0$~_1 2 p.#) y')  NB. ignore $.

NB.*makeidx v creates list of boxed literal numerics from 0 to y
makeidx=:[: 8!:0 i.
NB. makeidx=: ' ' -.~ [: ": i.


boxitemidx=:<"1@:|:@:>

NB. =========================================================
Note 'useful code'
('pr_code';'nCycles';'disabled';tst1) stringreplace INPUT id 'pr_code' name 'pr_code' type 'text' disabled ''
('checked="checked" ') INPUT value (y) name 'pr_code' id 'pr_code' ''
LABEL for 'pr_code' 'pr_name'
each control has its own verb that creates the control
verb that calls the control verb for each value or value, name pair

Once the controls are created for the param, do the string replace for
pr_code

Once the fieldset is created do a stringreplace for disabled that will
sort out all the controls in the fieldset
)

NB. =========================================================
Note 'tests'
tst=: ('Dollar';'$')
rarg=:('Dollar';'$');(<'Kroner';'DKK')
larg=:''
selectoptions rarg
larg selectoptions rarg
NB. <option value="$">Dollar</option>\n<option value="DKK">Kroner</option>

rarg=: ('VISA';'MasterCard')
larg=: 'MasterCard'
larg selectoptions rarg
NB. <option value="VISA">VISA</option>\n<option value="MasterCard" selected="selected">MasterCard</option>

rarg=: dict 'Basic="$20"';'Plus="$40"'
larg=:'$40'
larg selectoptions rarg
NB. <option value="$20">Basic</option>\n<option value="$40" selected="selected">Plus</option>

rarg=:  'VISA';'MasterCard';'Discover'
larg=:  'VISA';'Discover'
larg selectoptions rarg
NB. <option value="VISA" selected="selected">VISA</option>\n
NB. <option value="MasterCard">MasterCard</option>\n
NB. <option value="Discover" selected="selected">Discover</option>

rarg=:  ('No. of Lambs Born';'NLB');('Live weight at 8-mon';'LW8');('Fleece weight at 12-mon';'FW12');(<'Ultrasound backfat depth';'FD')
larg=:  'NLB';'FD'
larg selectoptions rarg
NB. <option value="NLB" selected="selected">No. of Lambs Born</option>\n
NB. <option value="LW8">Live weight at 8-mon</option>\n
NB. <option value="FW12">Fleece weight at 12-mon</option>\n
NB. <option value="FD" selected="selected">Ultrasound backfat depth</option>
)

buildForm_z_=: buildForm_pwebforms_