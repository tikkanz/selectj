load '~Projects/utils/csv.ijs'
require 'format'

sc=. ,: 12;'The black dog';1;'E';9.32;54;'XL'
sc=.sc,15;'likes to';0;'R';4.45;5.24;''
sc=.sc,22;'eat';1;'E';(i.0);455;'XS'
sc=.sc,96;'juicy, red bones';1;'W';5.45;924;'M'
simpcol=: sc

mixedcol=: 4 6$,simpcol

ssimpcol=: makecsv simpcol

smixedcol=: makecsv mixedcol

ts=: 6!:2 , 7!:2@]

Note 'csv scripts'
 load '~Projects/utils/csv.ijs'
 load '~Source/packages/files/csv.ijs'
 load 'csv'
)

Note 'performance tests'
  clipfmt 100 ts 'makecsv i.50 70'
  clipfmt   1 ts '  makecsv i.5000 70'

  clipfmt 100 ts 'makecsv <"0 i.50 70'
  clipfmt   1 ts 'makecsv <"0 i.5000 70'

  clipfmt   1 ts 'makecsv 5000 70$''abcd'' '

  clipfmt 100 ts 'makecsv simpcol'
  clipfmt   1 ts 'makecsv 5000$simpcol'

  clipfmt 100 ts 'makecsv mixedcol'
  clipfmt   1 ts 'makecsv 5000$mixedcol'

  clipfmt 100 ts 'fixcsv ssimpcol'
  clipfmt   1 ts 'fixcsv 171250$ssimpcol'

  clipfmt 100 ts 'fixcsv smixedcol'
  NB.clipfmt 1 ts 'fixcsv 171250$ssimpcol'
)

