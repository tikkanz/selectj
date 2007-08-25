
NB. var is better numerically than the statfns var
NB. not lots of subtractions

sumsq=: [: +/ *:         NB. sum of squares
sqsum=: *:&(+/) % #      NB. square of sum

sumpr=: +/@:*~           NB. sum of products
prsum=: *&(+/)~ % [: # ] NB. product of sums

cssq=: sumsq-sqsum      NB. corrected sum of squares
cspr=: sumpr-prsum      NB. corrected sum of products

var=: cssq % [: <: #   NB. sample variance
std=: %:@:var          NB. sample standard deviation

cov=: cspr % [: <:&#]  NB. covariance

corr=: cspr % [: %: ([: cspr [) * [: cspr ] NB. correlation
corr2=: cspr % [: %: ([: cssq [) * [: cssq ] NB. correlation2

NB. from forum
NB. http://www.jsoftware.com/pipermail/programming/2007-June/007208.html
NB. this only correlates list x with list y
corr_oleg=: (+/@:* % *&(+/)&.:*:)&(- +/ % #)~

Note 'Olegs corr verb'
basically does classic 
  Sum[(x-xbar)(y-ybar)]/SQRT(Sum[(x-xbar)^2]Sum[(y-ybar)^2])

(+/@:* % *&(+/)&.:*:) is Sum(xy)/SQRT(Sum(x^2)Sum(y^2))
 where x is (x-xbar) and y is (y-ybar)
 x u&v y (Compose) <--> (v x) u (v y)

Why is this numerically stable but my verb is not. His uses lots of 
subtractions, where mine does not.
http://en.wikipedia.org/wiki/Correlation says that mine is
"notorious for its numerical instability".
)

NB. correlation matrix of columns of an array
corrmtx=: corr"1/~ & |:

covmtx=: cov"1/~&|:

NB. returns beta for regression of numeric list y on numeric list x
NB. if no x then regresses on sitself
regr=: cspr % ([: sumpr ]) - [: prsum ]


NB. Brian Schott
NB. http://www.jsoftware.com/pipermail/programming/2007-June/007186.html
coclass 'bi'   NB. bivariate approach of Devon
coinsert 'base'

corr =: cov % *&stddev
cov =: spdev % <:@#@]
spdev =: +/@(*~ dev)
dev =: -"_1 _ mean
mean =: +/ % #
stddev =: %:@var
var =: ssdev % <:@#
ssdev =: +/@:*:@dev

coclass 'multi'   NB. multivariate approach

coinsert 'base'

sum =: +/
transpose =: |:

ss =: sum@:*:

ctr =: sum%# NB. centroid
mnc =: ] -"1 ctr NB. meancorrected
mp =: sum . * NB. matrix product
sscp =: transpose mp ]
SSCP =: sscp@mnc
stddev =: ss@mnc %:@% <:@#
std =: mnc %"1 stddev NB. standardized
R =: SSCP@std % <:@#
Note 'testing'
  Y =: 12 3$1 1 1 1 2 1 1 2 2 1 3 2 2 5 4 2 5 6 2 6 5 2 7 4 3 10 8 3 11 7 3 11 9 3 12 10
  YY =: |: Y
  ]a =: corr_bi_ "1/~ |:Y
  ]b =: corr_bi_ "1/~   YY
  ]c =: R_multi_ Y
  a -: b
  a -: c
  6!:2 'corr_bi_ "1/~ |:Y'
  6!:2 'corr_bi_ "1/~   YY'
  6!:2 'R_multi_ Y'
)
Note 'my tests'
  'tst1 tst2 tst3'=: 3 1000000?.@:$0
   tst=: tst1,.tst2,.tst3
   corr "1/~   |:tst
   corr_oleg "1/~  |: tst
   R_multi_ tst
   20] 6!:2 'corr_oleg "1/~  |: tst'
  NB. Test of Numerical stability
   0j20":corr"1/~ 900000000(+,:-)1+i.1000000
   0j20":R_multi_ |:900000000(+,:-)1+i.1000000
   0j20":corr_oleg"1/~ 900000000(+,:-)1+i.1000000

)