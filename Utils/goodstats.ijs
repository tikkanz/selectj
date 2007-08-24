
NB. var is better numerically than the statfns var
NB. not lots of subtractions

sumsq=: [: +/ *:
sqsum=: *:&(+/) % #

sumpr=: +/@:*~
prsum=: *&(+/)~ % [: # ]

cssq=: sumsq-sqsum
cspr=: sumpr-prsum

var=: cssq % [: <: #
std=: %:@:var

cov=: cspr % [: <:&#]

corr=: cspr % [: %: ([: cspr [) * [: cspr ]
corr2=: cspr % [: %: ([: cssq [) * [: cssq ]

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
subtractions, where mine does not. Is this because J is smart?

)


NB. correlation matrix of columns of an array
corrmtx=: corr"1/~ & |:



covmtx=: cov"1/~&|:

NB. returns beta for regression of numeric list y on numeric list x
NB. if no x then regresses on sitself
regr=: cspr % ([: sumpr ]) - [: prsum ]
