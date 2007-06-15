NB. =========================================================
NB. Utilities for reshaping data formats

NB.*melt v reshape table to database style
NB. optional left arg for number of "label" columns
NB.   should also get rid of results with missing values
NB.   (not necessarily zero) for value
NB. semi-inverts cast

melt=: 3 : 0
  1 melt y
  :
  lbls=. (x{.{.y),;:'variable value'
  rows=. }. x {."1 y
  cols=. x }. {. y
  dat=. , x }."1 }. y
  lbls,((#cols)#rows),.(($dat)$cols),.dat
  NB. lbls,(>,{(<"1 a);<b),.,c
)


NB.*cast v reshape database style data structure to table structure
NB. Assumes last two columns of y are variable name & variable value
NB. semi-inverts melt

cast=: 3 : 0
  datalbls=. /:~ ~. cols=. _2 {"1 }. y NB. sorted unique names from 2nd to last column
  collbls=. datalbls ,~ _2}. {. y NB. all except last 2 labels in first row + datalbls
  colidx=. datalbls i. cols
  rowlbls=. ~. rws=. (<"1) _2}."1 }. y  NB. prefix with /:~ if want sorted
  rowidx=. rowlbls i. rws
  dat=. >{:"1 }.y
  dat=. (rowidx,.colidx) crosstab dat
  collbls,(>rowlbls),.dat
)

NB.*crosstab v crosstablulate y according to x (pivot tables)
NB. form: 0 2 1 1 2 3 3 4 0 0 crosstab 6 37 22 26 10 2 33 33 46 19
NB.   or: (2 2 4 1 1 4 0 3 3 0,.2 1 0 1 2 0 1 0 1 2) crosstab 6 37 22 26 10 2 33 33 46 19
NB.  Joey Tuttle JForum 25 June 2000
crosstab=: 4 : '(x</.y)(<"(<:#$x)~.x)}(#@~."1|:x)$a:'