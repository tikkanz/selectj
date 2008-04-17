NB. 117.352 Sheep production courses internal & extramural
]ofids=: createOfferings 1 2008 4 2 1 ,: 1 2008 1 1 1

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
]ofids=: createOfferings 2 2008 1 1 1
 ofids addOfferingCases 1 3 NB. Add cases for each offering

tstfile=.jpath 'c:\d\teach\227202\admin\classlist200801.csv'
'file not found' assert fexist tstfile
]uids=: ofids createUsers importUsers tstfile
   enrolUsers 4;7 8 9 NB. enrol joe bloggs as dummy user

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

SheepProdInternalTxt updateOfferingText 8 NB. update 117352 internal course
SheepProdInternalTxt updateOfferingText 9 NB. update 227202 internal course

Note 'Things to do'
 add a field set that only has infotypes for phenotype 
 and genotype (no ebv).

 Remove REVs control in MANSEL form.
 add a new case based on current scendefs but with new
 fieldset so no ebv calculation except for when manually
 selecting parents.
 
)
