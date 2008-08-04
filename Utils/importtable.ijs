require 'files misc'

NB.*importTable v imports a numeric table with header row from a text file.
NB. returns: 2-item boxed list of header row and numeric data
NB. y is: name of file to import. If empty then prompts for file name
NB. x is: optional delimiter (default space)
importTable=: 3 : 0
  ' ' importTable y      NB. default delimiter is space
:
  if. ''-:y do. 
    y=. fselect ''
    if. ''-:y do. '' return. end.
  end.
  data=. 'm' fread y
  'hdr data'=. split x chop"1 data
  val=. _999&". >data
  hdr;val
)


Note 'testing'
 PTH=: jpath '~temp',PATHSEP_j_
 datspc  fwrites PTH,'datspc.txt'
 dattab  fwrites PTH,'dattab.txt'
 datpipe fwrites PTH,'datpipe.txt'

     importTable PTH,'datspc.txt'
 TAB importTable PTH,'dattab.txt'
 '|' importTable PTH,'datpipe.txt'
 TAB importTable ''
)

NB. =========================================================
NB. test data

datspc=: 0 : 0
Item    Price   Qty
1       13.5    3
2       10.3    5
3       5.25    25
4       13      -3
)

dattab=: 0 : 0
Item	Price	Qty
1	13.5	3
2	10.3	5
3	5.25	25
4	13	-3
)

datpipe=: 0 : 0
Item|Price|Qty
1|13.5|3
2|10.3|5
3|5.25|25
4|13|-3
)
