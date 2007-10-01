Note 'make summary table'
NB. args are labels of columns to use as keys and
NB.          labels of columns to summarise (trait columns)
NB. also need to know enrolment (user/course) to find correct summaries
smry=: readcsv jpath '~temp/summary.csv' NB. read summary csv
'hdr sm'=: split smry
invtble=: ifa sm
key=: listatom (hdr i. <'YOB'){invtble  NB. summarise by Year of birth
NB. dat=: 0". each 9}.invtble
dat=: 0".each (hdr i. (<'pNLB')-.~ getTrtsOnly hdr){invtble NB. all trait columns except pNLB
NB. replace pNLB with number born each year % popln size

sum=: key tkeytble (<tfreq key),key tkeyavg dat

)

Note 'regression (slope & intercept) of traits'
)

Note 'how to plot'
Summarise at the level of a user/course (enrolment)
So user can compare between different case instances of the same case
and between different case instances from different cases offered within the a course

Need to be careful with different cases if info is too different.

User has list of summarised case-instances to choose from, can choose
one or more to compare.

Once chosen then can choose which traits and which type of info to graph.
Options available is superset of all traits and trait info types available
in the case-instances to be compared.

Multiplot row for each chosen trait, Multiplot column for each chosen info type.
Each indiv-plot has a series for each case-instance which contains that info combination.
Key


When summarising between case-instances then genD, Phen & genDe should
all be plotted on different graphs in a multiplot. Use light colour for
plot background to help distinguish the three types.

When summarising within case-instance then might want to show genD, Phen
& genDe on the same graph - but use 2ndry y axis for genDe & genD. The
lines should have the colour corresponding to the plot backgrounds for
between case-instance plots.

)

Note 'plot summary'
yr0=. '2006' NB. get yearzero
strt=. (tnub key) tindexof boxopen yr0
NB. if use plot rather than pd then labels must be numeric
lbls=. 0". &> {.strt}. each sum
data=. > }.strt }. each sum
plot lbls ; data
)

Note 'test data for plotsummry'
  X=. i. each 6 + i.9
  Y=. X ^ each 1 + 0.3 * i.9
  Y=. (*: , +: ,: ]) each Y
  Y=. (<1 2 4 9 16 25,(0 6$0),0 1 2 3 4 5) (0)}Y
plotsummry X;<Y
((>'Fleece weight 12';'No. Lambs Born';'Live weight 8');(>'phen';'genD';'genDe');>'My first one';'My second version';'Base case' )plotsummry X;<Y

  Y=. matvect each <"1 data
  X=. ((#Y)#<0".lbls)
  dat=. X;<Y
  datinfo=. (>'No of Lambs Born';'Live weight 8';'Fleece weight 12';'Fat Depth';'carcass Lean';'carcass Fat');(>'phen';'genD');>'My first one'
datinfo plotsummry dat
)

NB. customised from Plot demo
NB. y is boxed list of xdata;<ydata
NB. x is boxed list of lists trtnames;infotypes;ci names;
plotsummry=: 3 : 0
  inftyps=. >;:'phen genD genDe'
  ntrts  =. %/# every (1{::y);inftyps NB. tally ydata divided by num info types.
  trtnms =. 'Trait ',"_ 1 (8!:2) ,.>:i.ntrts
  ncis   =. >./ #every 1{::y NB. max tally of each ydata
  cinms  =. 'Scenario ',"_ 1 (8!:2) ,.>:i.ncis
  (trtnms;inftyps;cinms) plotsummry y
:
  'X Y'=. 2{. boxopen y
  'trtnms inftyps cinms'=. x
  infotypes=.('phen';'Phenotype'),('genD';'Genotype'),:('genDe';'EBV')
  idx=. (<"1&dtb"1 inftyps) i. ~{."1 infotypes NB. which infotypes
  frmt=. [: vfms dquote"1@dtb"1
  pd 'reset'
  pd 'multi ',": (#trtnms),#inftyps
  pd 'title Comparison of Trait progress by Scenario'
  pd 'captionfont arial 13'
  pd 'xcaption ', frmt >idx { {:"1 infotypes
  pd 'ycaption ', frmt trtnms
  pd 'xgroup ',": (#idx)#0 NB. all the same x axis
  NB. pd 'ygroup 0 3 3 1 4 4 2 5 5'
  pd 'ygroup ',": ,  idx{"1 |:({:,~])i.2, #trtnms 
  pd 'key ', frmt cinms
  pd 'keypos center top outside'
  pd 'keystyle left boxed horizontal fat'
NB.  pd 'keycolor ',clrs=.',' join (#cinms){.;:'red blue green yellow pink brown'
  allcmd=.'type line; pensize 2' NB.,'; itemcolor ',clrs
  fbclrs=. (#Y)$ idx { 'lightcyan';'mistyrose';'lemonchiffon'
  pd ((<allcmd,'; framebackcolor '),each fbclrs),. <"1 X,.Y
 NB. pd 'pdf'
  pd 'visible 0'
  pd 'isi'
  pd 'save png'
 NB. pd 'show'
)
