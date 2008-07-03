NB. =========================================================
NB. Generalized writing of one or more Excel sheets to a workbook using tara
NB. Similar idea to readexcelsheets

NB.*writesheets v write arrays to sheets of Excel workbook
NB. returns: numeric 1 if successful.
NB. form: ([<sheetname(s)>],.<sheetcontent(s)>) writesheets <filename>
NB. y is: literal filename of workbook to create
NB. x is: One of;
NB.       literal (data to write in topleft cell of Sheet1)
NB.       numeric matrix (data to write to Sheet1)
NB.       boxed (numeric/literal/mixed) matrix (data to write to Sheet1)
NB.       2-column matrix,
NB.          Sheetnames in 1st col (literal)
NB.          Associated data formats (above) for sheetnames
NB. if <sheetname(s)> not given then defaults used default
writesheets=: 4 : 0
  if. 0=#x do. empty'' return. end. NB. if empty xarg then return.
  shts=. makexarg x
  shtnme=. ((0 < #) {:: 'Sheet1'&;) (<0 0) {:: shts
  bi=. ('Arial' ; 220 ; shtnme) conew 'biffbook'
  shtdat=. (<0 1){:: shts
  bi writeShtdat shtdat
  shts=. }.shts
  bi addSheets"1 shts
  save__bi y
  destroy__bi ''
)

NB. isdata v Verb decides on type of x argument to writesheets
NB. returns 0 for array of names and data, 1 for single data matrix.
isdata=: 3 : 0
  if. 1< lvls=. L. y do. 0 return. NB. if 1<L.x must be multiple sheets
  elseif. 0= lvls do. 1 return. NB. if not boxed then must be data for single sheet
  elseif. 2< {:$ y do. 1 return. NB. if more than 2 items/cols then data for one sheet
  elseif. -. *./2= 3!:0 &> {."1 y do. 1 return. NB. if not all 1st col contents are literal then must be one sheet
  elseif. 1< #@$ &> {:"1 y do. 0 return. NB. if any last col contents have rank greater than 1 then must be multiple sheets
  elseif. do. 1 NB. else assume that boxed data for one sheet
  end.
)

NB. makexarg v Ensures that xarg to writesheets has right form.
NB. returns: 2-item/column vector/array.
NB.       {."1 are sheetnames, {:"1 are boxed rank-2 arrays of sheetdata
makexarg=: 3 : 0
  if. isdata y do.
    if. 2= 3!:0 y do. y=. <y end.
    y=. a:,. <mfva y
  else.
    if. 2>{:$ y do. NB. if only 1 item/col add empty column of sheetnames
      y=. a:,.y
    end.
    if. #idx=. (I. b=. ischar &>{:"1 y) do.  NB. sheets with unboxed string data
      upd=. ({."1 ,. mfva@<&.>@({:"1)) b#y NB. boxed versions
      y=. upd idx }y
    end.
  end.
  mfv1 y
)

NB. addSheets v Creates new sheet and writes data to it
NB. form: <wkbklocale> addSheets <sheetname>;<array>
addSheets=: 4 : 0
  'shtnme shtdat'=. y
  addsheet__x shtnme
  x writeShtdat shtdat
)

NB. writeShtdat v Writes array to current worksheet
NB. form: <wkbklocale> writeShtdat <array>
NB. Writes blocks of string data and numeric data separately
NB. Only 1d blocks at present. to minimise the number of calls it would be good to
NB. find rectangular blocks of same type and write them
NB. using (<corner>,:<shape>) u;.0 <array>
writeShtdat=: 4 : 0
  if. 0=L.y do.
    writenumber__x 0 0;y
  else.
    as=. ischar &> y
    blks=. blocks as
    tls=. {.0 2|: blks
    dat=: blks <;.0 y NB. blocks of char
    writestring__x"1 (<"1 tls),.dat
    blks=. blocks -.as
    tls=. {.0 2|: blks
    dat=. blks ([:<>);.0 y  NB. blocks of non-char
    writenumber__x"1 (<"1 tls),.dat
  end.
)

NB. =========================================================
NB. test
Note 'testargs'
x1=: i.3 4
x2=: 'No name, single char'
x3=: 'num array0';i.3 4
x4=: ('num array1';i.3 4),:'num array2';i.2 2
x5=: ('num array3';i.3 4),:'boxnum array';<<"0 i.2 2
x6=: ('num array4';i.3 4),:'boxchr array';<4 2$'abcd';'kdisd';'eiij asj'
x7=: ('';i.3 4),:'boxmix array';<4 2$'abcd';54;'eiij';2;4.4
x8=: 'data 1';'data 2'
x9=: 4 2$'abcd';54;'eiij';2;4.4
x10=: ('numarr';i.3 4),: 'boxchr';'jsadla'
x11=: (x3,x4,x5,x6,x7,x10)
)

Note 'tests for writesheets'
x1 writesheets jpath '~temp/tarawsht1.xls'
x2 writesheets jpath '~temp/tarawsht2.xls'
x3 writesheets jpath '~temp/tarawsht3.xls'
x4 writesheets jpath '~temp/tarawsht4.xls'
x5 writesheets jpath '~temp/tarawsht5.xls'
x6 writesheets jpath '~temp/tarawsht6.xls'
x7 writesheets jpath '~temp/tarawsht7.xls'
x8 writesheets jpath '~temp/tarawsht8.xls'
x9 writesheets jpath '~temp/tarawsht9.xls'
x10 writesheets jpath '~temp/tarawsht10.xls'
x11 writesheets jpath '~temp/tarawsht11.xls'
)

NB. =========================================================
NB. working 1d solution for creating blocks.
mfv1=: ,:^:(#&$ = 1:)       NB. makes 1-row matrix from vector
mfva=: ,:^:([: 2&> #@$)^:_  NB. makes a matrix from an atom or vector
ischar=: 3!:0 e. 2 131072"_
firstones=: > 0: , }:
lastones=: > 0: ,~ }.
indices=: $ #: I.@,   NB. get row,.col indices of 1s in matrix
indices=: 4$.$.       NB. faster leaner?
isrowblks=: >/@(+/^:(#&$)"_1) NB. are blocks row oriented

NB. ---------------------------------------------------------
NB. explicit solution (chooses best block orientation)
blocksx=: 3 : 0
  fo=. (firstones ,: firstones"1) y
  if. isr=. isrowblks fo do. NB. row-oriented
    tl=. indices isr { fo
    br=. indices lastones"1 y
  else. NB. column-oriented
    tl=. |."1 indices |: isr { fo
    br=. |."1 indices |: lastones y
  end.
  tl ,:"1 >:br-tl
)

Note 'testing'
tls tst1          NB. list of topleft of blocks of 1s
tls -.tst1        NB. list of topleft of blocks of 0s

(blocks ischar &> tsta) <;.0 tsta  NB. blocks of char (you will need to create a tsta to run this)
(blocks -.ischar &> tsta) <;.0 tsta  NB. blocks of non-char
(blocksx -.ischar &> tsta) ([:<>);.0 tsta  NB. blocks of non-char
)

NB. =========================================================
NB. 2d version for creating blocks

NB. RE Boss better solution programming forum June 2008
tlc=: [: I. firstones      NB. column indices of toplefts
brc=: [: I. lastones       NB. column indices of bottomrights
tlbrc=: <@(tlc ,. brc)"1   NB. box by row
bpr=: i.@# ,:"0 1&.> tlbrc NB. laminate row indices

mtch=: 4 : 0
's t'=.<"0 x (](#~; (#~-.)) e.~&:(<@{:"2))&> {.y
t=. t((,&.>{:)`[)@.(1=#@])y
s=. x([:(<@{:"2 ({:@{.@{:(<0 1)} {.)/.]) ,)&> s
s;t
)

NB. rowwise blocks (topleft,:bottomright)
blcks=: [:/:~ [:|:"2 [:,&>/ [:mtch/ bpr
blcks=:       [:|:"2 [:,&>/ [:mtch/ bpr
blcks=:       [:|:"2 [:;    [:mtch/ bpr

tlshape=: ([,: (-~>:))/"_1 NB. converts tl,:br to tl,:shape
blocks=: tlshape@:blcks  NB. accept just rowwise blocks

NB. =========================================================
NB. test data
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

Note 'examples'
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

]tst2=: 5 9?.@$2

tmp=: 4 6$'abcdefghijklmnopqrstuvwx'
((1 1,: 3 2) ,: 0 3,:2 3) <@toupper;.0 tmp

)

NB. =========================================================
NB. Workbook writing examples

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
