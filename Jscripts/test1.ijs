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
   enrolUsers 4;ofids NB. enrol joe bloggs as dummy user

Note 'Things to do'
 add a field set that only has infotypes for phenotype 
 and genotype (no ebv).

 add a new case based on current scendefs but with new
 fieldset so no ebv calculation except for when manually
 selecting parents.

 update instruction text for case 1 and 3
)
