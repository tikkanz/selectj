
vals=. ('(FAT) Carcass Fat content';'FAT');(<'(LEAN) Carcass Lean content ';'LEAN')
vals=. ('(FW12) Fleece weight at 12-mon';'FW12');('Ultrasound backfat depth';'FD');vals
vals_Trts2Select=: ('(NLB) No. of Lambs Born';'NLB');('Live weight at 8-mon';'LW8');vals
seld_Trts2Select=:  'NLB';'FAT'


trt2select=: 3 : 0
  1 trt2select y
  :
  dsble=. (x~:1)#'disabled="disabled"'
  fs=. LEGEND 'Selection Strategy'
  dv=. LABEL for 'Trts2Select' 'Traits to Select for'
  selopts=. seld_Trts2Select buildSelect vals_Trts2Select
  dv=. dv,LF, dsble SELECT id 'Trts2Select' name 'Trts2Select' size '7' multiple 'multiple' selopts
  fs=. fs,LF,DIV dv
  FIELDSET fs
)


vals_FlkSizes=: <&>(100,200*>:i.5), 1500 2000 4000
seld_FlkSizes=:  200

popsz=: 3 : 0
  1 popsz y
  :
  dsble=. (x~:1)#'disabled="disabled"'
  fs=. LEGEND 'Population Size'
  dv=. LABEL for 'FlkSizes' 'No. of Breeding females'
  selopts=. (8!:0 seld_FlkSizes) buildSelect 8!:0 vals_FlkSizes
  dv=. dv,LF, dsble SELECT id 'FlkSizes' name 'FlkSizes' selopts
  dv=. dv,LF, P class 'note' 'Replacement females that are too young to breed are not included in this figure', (BR''),'&nbsp;'
  fs=. fs,LF,DIV dv
  FIELDSET fs
)

vals_nCycles=: 10
vals_currCycle=: 3

progress=: 3 : 0
  1 progress y
  :
  dsble=. (x~:1)#'disabled="disabled"'
  fs=. LEGEND 'Progress'
  dv=. LABEL for 'nCycles' 'No. years to select for'
  dv=. dv,LF, dsble INPUT id 'nCycles' name 'nCycles' type 'text' value vals_nCycles maxlength '3' size '4' ''
  fs=. fs,LF, DIV dv
  dv=. LABEL for 'currCycles' 'Current year of selection'
  dv=. dv,LF, dsble INPUT id 'currCycles' name 'currCycles' type 'text' value vals_currCycle maxlength '3' size '4' ''
  fs=. fs,LF, DIV dv
  FIELDSET fs
)

makeCaseForm=: 3 : 0
  frm=. P class 'legend' 'This is the legend for my form'
  frm=. LF join frm;(progress'');(popsz'');(trt2select'');buildButtons''
  frm=. FORM id 'params' name 'params' enctype 'multipart/form-data' method 'post' action 'case.jhp?action=chgparams' frm
  DIV class 'form-container' frm
)

buildButtons=: 3 : 0
  bt=. INPUT class 'button' type 'submit' onclick 'formsubmit()' value 'Save Changes' ''
  bt=. bt,LF, INPUT class 'button' type 'reset' value 'Discard Changes' ''
  DIV class 'buttonrow' bt
)

NB. y is pr_id
buildParamDiv=: 3 : 0
  info=. 'param' getTable_pselectdb_ y  NB. gets pr_class,pr_name,fp_label,pr_note,fp_note,pr_code
  'hdr dat'=. split info
  (hdr)=. |:dat                   NB. assign hdrnames
  if. #fp_label do. pr_name=.fp_label end.
  if. #fp_note  do. pr_note=.fp_note  end.
  NB.! get seld,nms,vals,idx
  NB.! get ctrlprops
  if. pr_class-:'controlset' do.
    lbl=. LABEL class 'controlset' pr_name
    ctrls=. seld buildControlset  ctrlprops;vals;nms;idx
    nte=. P class 'note' pr_note
    pdv=. DIV class 'controlset' LF join lbl;ctrls;nte
  else.
    lbl=. 'pr_code' buildLabel pr_name
    select. inputtype  NB.! expression to choose control type
      case. 'select' do.
        ctrls=. seld buildSelect ({.ctrlprops);vals;nms
      case. 'textarea' do.
        ctrls=. buildTextarea
      case. 'input' do.
        ctrls=. seld&buildInput each ctrlprops;vals;idx
    end.
    nte=. P class 'note' pr_note
    pdv=. DIV class LF join lbl;ctrls;nte
  end.
  pdv=. ('pr_code';pr_code) stringreplace pdv
)

NB. y is fs_id
NB. x is cf_value
buildFieldset=: 3 : 0
  info=. 'fieldset' getTable_pselectdb_ y NB. gets fs_name,pr_id
  'hdr dat'=. split info
  (hdr)=. |:dat                   NB. assign hdrnames
  lgd=. LEGEND 0{::fs_name        NB. repeated for each pr_id
  pdvs=. buildParamDiv each pr_id
  fst=. FIELDSET LF join lgd;pdvs
  dsabld=. (x<1)#'disabled="disabled"'
  fst=. ('disabled';dsabld) stringreplace fst
)

NB. y is cs_id
buildForm=: 3 : 0
  info=. 'paramform' getTable_pselectdb_ y  NB. gets legend, fs_ids,cf_value
  'hdr dat'=. split info
  (hdr)=. |:dat                   NB. assign hdrnames
  lgd=. P class 'legend' 'This is the legend for my form'
  fsts=. cf_value buildFieldset each fs_id
  frm=. LF join lgd;fsts;buildButtons ''
  frm=. FORM id 'params' name 'params' enctype 'multipart/form-data' method 'post' action 'case.jhp?action=chgparams' frm
  DIV class 'form-container' frm
)


ctrlprops_allelefreq=: 0 : 0
 type 'text' size '5'
)

ctrlprops_cullage=: ctrlprops_allelefreq

ctrlprops_currcycle=: 0 : 0
 type 'text' maxlength '3' size '4'
)

ctrlprops_dams2sire=: ctrlprops_allelefreq

ctrlprops_mateage=: ctrlprops_allelefreq

ctrlprops_ncycles=: ctrlprops_currcycle

ctrlprops_popsizes=: ctrlprops_allelefreq

ctrlprops_revs=: 0 : 0
 type 'text' size '7'
)

ctrlprops_selnmeth=: 0 : 0
 type 'radio'
)

ctrlprops_summtype=: 0 : 0
 type 'checkbox'
)

ctrlprops_trts2select=: 0 : 0
 onchange 'REVStatus' multiple 'multiple' size '6'
)

ctrlprops_trts2summ=:  0 : 0
 multiple 'multiple' size '6'
)

ctrlprops_trtsrecorded=: ctrlprops_trts2summ



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