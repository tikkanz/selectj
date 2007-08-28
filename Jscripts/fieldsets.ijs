coclass 'pwebforms'
NB. =========================================================
NB. dummy data to be replaced by verbs that retrieve this info from
NB. the files in the caseinstance folder

vals_trts2select=: ;:'NLB LW8 FW12 FD FAT LEAN'
nmes=. '(FAT) Carcass Fat content';'(LEAN) Carcass Lean content '
nmes=. '(FW12) Fleece weight at 12-mon';'(FD) Ultrasound backfat depth';nmes
nmes_trts2select=: '(NLB) No. of Lambs Born';'(LW8) Live weight at 8-mon';nmes
seld_trts2select=:  'NLB';'FAT'

vals_popsizes=: <&>(100,200*>:i.5), 1500 2000 4000
seld_popsizes=:  200

vals_ncycles=: <10
vals_currcycle=: <3

vals_dams2sire=: <50
vals_cullage=: <&> 7 8
vals_mateage=: <&> 1 2
vals_allelefreq=: <&> 0.1 0.9
vals_objectvrevs=:<&> 1 3 _4 5 3 0.5
nmes_objectvrevs=: ;:'NLB LW8 FW12 FD FAT LEAN'
vals_selnmeth=: ;:'phen genD genDe'
nmes_selnmeth=: 'Phenotypes';'Genotypes';'Estimated Breeding Values'
seld_selnmeth=: 'genD'
vals_summtype=: vals_selnmeth
nmes_summtype=: nmes_selnmeth
seld_summtype=: ;:'phen genDe'
vals_trts2summ=: vals_trts2select
nmes_trts2summ=: nmes_trts2select
seld_trts2summ=: ;:'NLB FAT LEAN LW8'
vals_trtsrecorded=: ;:'NLB LW8 FW12 FD'
nmes=. '(FW12) Fleece weight at 12-mon';'(FD) Ultrasound backfat depth'
nmes_trtsrecorded=:'(NLB) No. of Lambs Born';'(LW8) Live weight at 8-mon';nmes
NB. seld_trtsrecorded=:

NB. =========================================================
NB. nouns for xhtml control properties of each parameter
NB. could maybe write these in params table instead
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

ctrlprops_objectvrevs=: ctrlprops_allelefreq

ctrlprops_popsizes=: ''

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
