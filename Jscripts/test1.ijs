NB. =========================================================
NB. Test script 
NB. creates 3 course offerings
NB. imports class lists as users to each of those course offerings
NB. enrols Joe Bloggs as user in each of the offerings

NB. 117.352 Sheep production courses internal & extramural
]ofids=: createOfferings 2 2008 4 2 1 ,: 2 2008 1 1 1
 ALLofids=: ofids

NB. Add cases for each offering
 ofids addOfferingCases 1 3

NB. 117.352 Sheep production class extramural
tstfile=.jpath 'c:\d\teach\117352\admin\classlist200812.csv'
'file not found' assert fexist tstfile
]uids=: ({. ofids) createUsers importUsers tstfile

NB. 117.352 Sheep production class internal
tstfile=.jpath 'c:\d\teach\117352\admin\classlist200801.csv'
'file not found' assert fexist tstfile
]uids=: ({: ofids) createUsers importUsers tstfile

NB. 227.202 Vet Genetics course and class
]ofids=: createOfferings 3 2008 1 1 1
 ofids addOfferingCases 1 3 NB. Add cases for each offering
 ALLofids=: ALLofids,ofids

tstfile=.jpath 'c:\d\teach\227202\admin\classlist200801.csv'
'file not found' assert fexist tstfile
]uids=: ofids createUsers importUsers tstfile
   enrolUsers 4;ALLofids NB. enrol joe bloggs as dummy user in all offerings

NB. updated intro text for the new offerings
SheepProdInternalTxt=: 0 : 0
The flock simulations below should help you think about and understand some
of the concepts that we have covered in the genetics section of the paper.</p>
<p>You can use the <em> Population Size</em> to get familiar
with how AnimalSim works.</p>
<p>The <em>Select animals manually</em> case
is used for your Assignment. By all means have a look at the case
and the available options, but you need to complete the first three
questions of the assignment before you start breeding your population.
)

NB. create new textblock linked to extramural 117.352 offering
SheepProdInternalTxt updateOfferingText {.ALLofids NB. update 117352 extramural course
  xbid=: getOfferingxbids {.ALLofids NB. get textblock id of new textblock
  xbid updateOfferingxbid"0 ,.}.ALLofids  NB. use same id for other two offerings
NB. SheepProdInternalTxt updateOfferingText 1{ALLofids NB. update 117352 internal course
NB. SheepProdInternalTxt updateOfferingText 2{ALLofids NB. update 227202 internal course

Note 'Things to do'
 add a field set that only has infotypes for phenotype 
 and genotype (no ebv).

 Remove REVs control in MANSEL form.
 add a new case based on current scendefs but with new
 fieldset so no ebv calculation except for when manually
 selecting parents. 
)
