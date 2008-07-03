ischar   =: 3!:0 e. 2 131072"_

NB.======= RGS 1st soln =====================================
NB. 1d tacit
firstones=: > 0: , }: NB. Mask of first ones

tlcols=: <@I.@firstones"1        NB. leftmost columns of blocks of 1s
toplefts=: i.@:# ,.&.> tlcols    NB. topleft index of blocks of 1s

bytype=: 1 : 'u;.1~ (1, 2~:/\ ])'
lens=: <@({.bytype # #bytype)"1  NB. lengths of blocks of 1s
shapes1=: 1: ,. &.> lens          NB. shapes of blocks of 1s

blocks1=: ;@toplefts ,:"1 ;@shapes1 NB. blocks of 1s

Note 'testing RGS1'
  ;toplefts tst1          NB. list of topleft of blocks of 1s
  ;toplefts -.tst1        NB. list of topleft of blocks of 0s
  (;@toplefts ,:"1 ;@shapes) tst1  NB. List of blocks
  ;(toplefts ,:"1 &.> shapes) tst1 NB. Also list of blocks

  (blocks1   ischar &> tsta) <;.0 tsta  NB. blocks of char (you will need to create a tsta to run this)
  (blocks1 -.ischar &> tsta) <;.0 tsta  NB. blocks of non-char
)
NB.======= RGS 2nd soln ========================================
NB. 1d tacit
firstones=: > 0: , }:
lastones=: > 0: ,~ }.
NB. indices=: $ #: I.@,   NB. get row,.col indices of 1s in matrix
indices=: 4:$.$.       NB. get row,.col indices of 1s in matrix

NB. (works best for row-oriented blocks)
tls=: [: indices firstones"1 NB. topleft index of blocks of 1s
brs=: [: indices lastones"1  NB. bottomright index of blocks of 1s

shapes2=: [: >: brs - tls  NB. shapes of blocks of 1s
blocks2=: tls ,:"1 shapes2  NB. blocks of 1s

NB.======= RGS 3rd soln ========================================
NB. 1d explicit solution (chooses best block orientation)

firstones=: > 0: , }:
lastones=: > 0: ,~ }.
NB. indices=: $ #: I.@,   NB. get row,.col indices of 1s in matrix
indices=: 4:$.$.       NB. get row,.col indices of 1s in matrix
isrowblks=: >/@(+/^:(#&$)"_1) NB. are blocks row oriented

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

NB.======= REBoss 1st soln adapted ==============================
incgrp=: [:($$ [:+/\ ,) (1, }:~: }.)"1 NB. running sum of starts of connected 1s in each row
rpl=: ] - (-/ , 0:)@[ {~ {.@[ i. ] NB. numeric replace (RMiller)

hv=: *"_ _1 incgrp,: incgrp&.|:  NB. hor. & vert. connected 1s.
rplhv=: (([:(,:|.) ,"_1) rpl"_1 ]) @: hv
NB. rectgrps=: ({.@]($@[ $ ]) i.~@,.&,/) @: rplhv NB. rectangular groups of 1s
rectgrps=: ({.@] ($@[ $ ]) }.@(i.~@(0&,@(,.&,/))))@:rplhv
tlbr=: ($#: (](i.}.@,. i:) 0~.@,])@,) @: rectgrps NB. topleft and bottomright corners of each group
NB. blocks3=: ([,: (-~>:))/"_1 @: tlbr
tlshape=: ([,: (-~>:))/"_1 NB. converts tl,:br to tl,:shape
blocks3=: tlshape @: tlbr


NB.======= REBoss 2nd soln ==============================
NB. The following solution is better.

NB. blocks per row; top left in first and bottom right in last column!
bpr=: i.@# ,:"0 1&.> <@([:((0 1 I.@E.]) ,.1 0 <:@I.@E. ]) 0,~0,])"1
bpr=: i.@# ,:"0 1&.> <@((I.@firstones) ,.(I.@lastones))"1

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
blocks4a=: tlshape@:blcks  NB. accept just rowwise blocks

NB. Determine blcks for array and its transpose 
NB. and take the solution with least blocks
blcksmin=:[:([`]@.(>&#))&>/ [:({., |."1&.>@{:) [:blcks &.> (;|:)
blocks4b=: tlshape@:blcksmin NB. get smallest of rowwise & columnwise blocks

Note  'test'
 ;(; blocks4)&.>(;|:)tst1
)

NB.======= REBoss 2nd soln alternative ================
fones=: > 0: ,.  }:"1
lones=: > 0: ,.~ }."1
NB. indices (fones ,: lones) tst1
blkrow=: (indices@:fones ,."1 indices@:lones)
bxbyrow=: ( {."1@:{."2 </.] )
bpr0=: bxbyrow blkrow

NB. =========================================================
NB. test data
NB. tsta=: readexcel jpath '~temp/tararead.xls'
NB. tst1=: ischar every tsta
alpha=:/:~ '!"#$%&()*+,-./:;<=>?@[\]^_`{|}~','0123456789',(],toupper) 'abcdefghijklmnopqrstuvwxyz'
chkchar=: ([: , ]) # [:, tstchar
tstchar=: alpha $~ $

chknum=: ([: , ]) # [: , tstnum
tstnum=: [: i. $

NB. (blocks1 tstchar) <;.0 tstchar  NB. blocks of 1s
NB. (blocks1 tstchar) <;.0 tstnum  NB. blocks of 0s
tstblkverb=: 1 : '(u y) <;.0 tstnum y'
chkblkverb=: 1 : '(chknum y) -: /:~ ;,&.> u tstblkverb y'

Note 'example tests'
NB. retrieve blocks from tstchar tst1 using blocks1
 blocks1 tstblkverb tst1 
NB. checks that blocks retrieved from tstchar tst1 
NB. using blocks1 match chkchar tst1
NB. i.e. checks that blocks1 works correctly
 assert blocks1 chkblkverb tst1 
 assert blocks2 chkblkverb -.tst1 
)

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

tst2=: _99&".;._2 (0 : 0)
1 1 1 1 1 1 1 1 1
1 1 1 1 1 1 1 1 1
1 1 0 0 0 0 1 1 1
1 1 0 0 1 0 1 1 1
1 1 0 1 0 0 1 1 1
1 1 0 0 0 0 1 1 1
1 1 1 1 1 1 1 1 1
1 1 1 1 1 1 1 1 1
)

tst3=: _99&".;._2 (0 : 0)
1 1 1 1 1 1
1 0 1 1 0 0
1 0 1 1 0 0
1 0 1 1 0 0
1 0 1 1 0 0
1 0 1 1 0 0
)

tst4=: 1,499# ,:500?.@$ 2
tst5=: 500 500 ?.@$ 2
tst6=: 1,499# ,:70?.@$ 2
tst7=: 500 70 ?.@$ 2

Note 'Conclusion'
blocks3 gives incorrect answer on some arrays (e.g tst2)
blocksx probably best blend of lean and fast
blocksx never gives more blocks than blocks1 or blocks2
blocks4b gives smallest # of blocks but 10 to 40x slower
blocks4a gives few more blocks but 2x faster than blocks4b

writing tst7 (writenumber) is 0.2s faster with blocks4a
than blocksx. blocks4a tst7 is only 0.09s slower than
blocksx tst7, so better to use blocks4a

blocks4a probably best.
mtch is slow part of blocks4a.
)