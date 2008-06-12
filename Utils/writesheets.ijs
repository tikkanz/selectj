NB. =========================================================
NB. generalized writing of one or more excel sheets to a workbook using tara
NB. similar to readexcelsheets
NB. form: (<sheetname(s)>,.<sheetcontent(s)>) writesheets <filename>
NB. if <sheetname(s)> not given then use default
NB. if 1=L.x then assume contains data for 1 worksheet.
NB. could assume if x is numeric table it is data for 1 worksheet
NB. could assume for literal x with L.=0 that is data for topleft cell of 1 worksheet
NB. ? when 2<L.x then error?


NB. need to write string data and numeric data separately
NB. to minimise the number of calls it would be good to
NB. find rectangular blocks of same type and write them
NB. using (<corner>,:<shape>) u;.0 <array>




NB. large workbook > 10MB size
test12=: 3 : 0
bi=. ('Courier New' ; 220) conew 'biffbook'
writenumber__bi 0 0 ; < < ("0) i.6 10
writestring__bi 6 0 ; < < ("1) 6 10 7$'ABCDEFGHIJKLMNOPQRSTUVW'
save__bi jpath '~temp/tara12.xls'
destroy__bi ''
)
NB. Adding New Worksheet
test8=: 3 : 0
bi=. ('Courier New' ; 220 ; 'first worksheet') conew 'biffbook'  NB. name of first worksheet as the third parameter
writestring__bi 1 3 ; 'total 3 worksheets'
addsheet__bi ''
writestring__bi 1 3 ; 'sheet2'
addsheet__bi 'last sheet'                NB. name of worksheet
writestring__bi 1 3 ; 'last sheet'
NB. switch to sheet1, (sheeti is 0-based)
sheeti__bi=. 0
writestring__bi 2 3 ; 'sheet1'
save__bi jpath '~temp/tara8.xls'
destroy__bi ''
)




tsta=: readexcel jpath '~temp/tararead.xls'
tst1=: ischar every tsta
tst1=: _99&".;._2 (0 : 0)
0 0 0 1 1 1
0 0 0 0 0 0
1 1 1 0 0 0
0 0 0 1 1 1
0 0 0 1 1 1
1 1 1 0 0 0
1 1 1 0 0 0
1 1 1 1 1 1
1 1 1 1 1 1
1 1 1 1 1 1
0 0 0 1 1 1
0 0 0 1 1 1
)

blocks tst1
0 3  NB. topleft of block
1 3  NB. shape of block

2 0
1 3

3 3
2 3

5 0
5 3

7 3
5 3

topleft -.tst1
0 0
2 3

3 2
2 3

3 0
2 3

5 3
2 3

11 3
2 3




]tst2=: 5 9?.@$2
0 1 0 1 1 1 0 0 0
1 0 1 0 0 1 0 0 0
0 0 1 1 1 0 0 0 0
0 1 1 0 0 1 0 1 0
0 0 0 1 0 1 0 0 0

tmp=: 4 6$'abcdefghijklmnopqrstuvwx'
((1 1,: 3 2) ,: 0 3,:2 3) <@toupper;.0 tmp

tl=: (firstones *. firstones"1)  NB. topright
br=: (lastones *. lastones"1)    NB. bottomleft
NB. indices=: (1 , {:@$) *"1 [: (<. ,. 1&|) {:@$ %~ [: I. ,
indices=: $ #: I.@, NB. get row,.col indices of 1s in matrix

('tst1';'firstones';'lastones';'firstones"1';'lastones"1'),:(;firstones;lastones;firstones"1;lastones"1) tst1

indices tl tst1
indices br tst1

NB. =========================================================
NB. working solution for creating blocks.
ischar=: 3!:0 e. 2 131072"_
firstones=: > 0: , }:
lastones=: > 0: ,~ }.
indices=: $ #: I.@,   NB. get row,.col indices of 1s in matrix


tls=: [: indices firstones"1 NB. topleft index of blocks of 1s
brs=: [: indices lastones"1  NB. bottomright index of blocks of 1s

minblks=: >/@(+/^:(#&$)"_1) NB. are blocks column oriented
f1s=: [: (minblks { ]) firstones ,: firstones"1
l1s=: [: (minblks { ]) lastones ,: lastones"1

tlsop=: [: indices f1s
brsop=: [: indices l1s

shapes=: [: >: brsop - tlsop  NB. shapes of blocks of 1s
blocks=: tlsop ,:"1 shapes  NB. blocks of 1s

Note 'testing'
tls tst1          NB. list of topleft of blocks of 1s
tls -.tst1        NB. list of topleft of blocks of 0s

(blocks   ischar &> tsta) <;.0 tsta  NB. blocks of char (you will need to create a tsta to run this)
(blocks -.ischar &> tsta) <;.0 tsta  NB. blocks of non-char
)
NB. =========================================================


Note 'old stuff'
bytype=: 1 : 'u;.1~ (1, 2~:/\ ])'
NB. box bytype     <bytype
NB. count bytype   #bytype
NB. type bytype   {.bytype
lens=: <@({.bytype # #bytype)"1  NB. lengths of blocks of 1s
shapes=: [: ; 1: ,. &.> lens          NB. shapes of blocks of 1s

tlcols=: <@I.@firstones"1  NB.  leftmost columns of blocks of 1s
toplefts=: i.@:# ,.&.> tlcols  NB. topleft index of blocks of 1s
)

Note 'old testing'
;toplefts tst2   NB. list of topleft of blocks of 1s
;toplefts -.tst2 NB. list of topleft of blocks of 0s

(;@toplefts ,:"1 ;@shapes) tst1
;(toplefts ,:"1 &.> shapes) tst1
