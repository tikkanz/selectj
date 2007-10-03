Note 'make summary table'
NB. args are labels of columns to use as keys and
NB.          labels of columns to summarise (trait columns)
NB.          list of ciids to compare
NB. if trait column not present create and use zeros for Y.
sumry=. ''
For each ciid
  smry=: readcsv jpath '~temp/summary.csv' NB. read summary csv
  'hdr sm'=: split smry
  invtble=: ifa sm
  key=: listatom (hdr i. <'YOB'){invtble  NB. summarise by Year of birth
  NB. dat=: 0". each 9}.invtble
  dat=: 0".each (hdr i. (<'pNLB')-.~ getTrtsOnly hdr){invtble NB. all trait columns except pNLB
  NB. replace pNLB with number born each year % popln size
  sum=: key tkeytble (<tfreq key),key tkeyavg dat
  sumry=.sumry,<sum
Next ciid
sumry

yr0=. '2006' NB. get yearzero
strt=. (tnub key) tindexof boxopen yr0
NB. if use plot rather than pd then labels must be numeric
lbls=. 0". &> {.strt}. each sum
data=. > }.strt }. each sum

)

Note 'user interface'
Summarys at the level of a user/course (enrolment)
So user can compare between different case instances of the same case
and between different case instances from different cases offered within a course

Need to be careful with different cases if info is too different.

User has list of summarised case-instances to choose from, can choose
one or more to compare.

Case Summaries page - pretty much like list of course cases page, but 
lists summarized case instances with their user name and descriptions. 
Check box associated with each case instance. User to check one or more
case instances to compare. Click "Compare" button. Also options to  
download AnimSummary.csv for each case instance, Delete case instance
summary(s).

Once chosen then can choose which traits and which type of info (phen,genD,genDe) to graph.
Options available is superset of all traits and trait info types available
in the case-instances to be compared.

Page with form - table showing traits by case instances with a 
tick in each cell if that trait is available for that case instance.
Last column is check boxes - check which traits to summarize.
Choose which infotypes (phen,genD,genDe) to summarize.
Choose graphical or tabular summary (regression too)
Display graph/table below table or in separate window.
)


Note 'Consolidate summaries from multiple cases'

)

Note 'regression (slope & intercept) of traits'
)

Note 'how to plot'
Multiplot row for each chosen trait, Multiplot column for each chosen info type.
Each indiv-plot has a series for each case-instance which contains that info combination.

When creating the Y data for the comparison:
  Need to make sure that data is in right/same order 
use a row of 0s for missing info
 (e.g. if one of the case-instances does not have a certain trait). The
plot verb will compress out the the 0 rows & use that info to select the
appropriate itemcolors.

May run into problems if different case instances have different numbers
of selection cycles (i.e. length of x differs between series.
In that case would need to do multiple plots on a single graph rather
than plot multiple series. (e.g. graph 6 of Mixed Multiplot in Plot demo)
or pd every <"1 x1;y1,:x2;y2

When summarising between case-instances then genD, Phen & genDe should
all be plotted on different graphs in a multiplot. Use light colour for
plot background to help distinguish the three types.

When summarising within case-instance then might want to show genD, Phen
& genDe on the same graph - but use 2ndry y axis for genDe & genD. The
lines should have the colour corresponding to the plot backgrounds for
between case-instance plots.

)

Note 'test data for plotsummry'
  X=. i. each 6 + i.9
  Y=. X ^ each 1 + 0.3 * i.9
  Y=. (*: , +: ,: ]) each Y
  Y=. (<1 2 4 9 16 25,(0 6$0),0 1 2 3 4 5) (0)}Y
plotsummry X;<Y
((>'Fleece weight 12';'No. Lambs Born';'Live weight 8');(>'phen';'genD';'genDe');>'My first one';'My second version';'Base case' )plotsummry X;<Y

  Y=. matvect each <"1 data  NB. ensure vectors are 1 row matricies
  X=. ((#Y)#<lbls)  NB. X is probably same for each y
  dat=. X;<Y
  datinfo=. (>'No of Lambs Born';'Live weight 8';'Fleece weight 12';'Fat Depth';'carcass Lean';'carcass Fat');(>'phen';'genD');>'My first one'
datinfo plotsummry dat
)

NB. customised from Plot demo
NB. y is boxed list of xdata;<ydata
NB. x is boxed list of rank-2 lists trtnames;infotypes;ci names;
plotsummry=: 3 : 0
  inftyps=. >;:'phen genD genDe' NB. assumes all infotypes but can't know
  ntrts  =. %/# every (1{::y);inftyps NB. tally ydata divided by num info types.
  trtnms =. 'Trait ',"_ 1 (8!:2) ,.>:i.ntrts
  ncis   =. >./ #every 1{::y NB. max tally of each ydata
  cinms  =. 'Scenario ',"_ 1 (8!:2) ,.>:i.ncis
  (trtnms;inftyps;cinms) plotsummry y
:
  'X Y'=. 2{. boxopen y
  'trtnms inftyps cinms'=. matvect each x
  infotypes=.('phen';'Phenotype'),('genD';'Genotype'),:('genDe';'EBV')
  idx=. (<"1&dtb"1 inftyps) i. ~{."1 infotypes NB. which infotypes
  frmt=. [: vfms dquote"1@dtb"1
  pd 'reset'
  pd 'visible 1'
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
  clrs=. ;:'blue red green purple fuchsia olive teal yellow tan aqua brown gray'
  pd 'keycolor ',',' join (#cinms){. clrs
  allcmd=. 'type line; pensize 2'
  cidx=.([: I. [: (*./"1) 0&~:) each Y NB. non-zero y series
  Y=. cidx {each Y  NB. leave out any y series that are all zero
  msknull=. *&#each cidx  NB. caseinstances with at least one non-zero y series

  itmclr=. cidx { each <clrs  NB. drop colors for dropped y series
  itmclr=. ',' join each (<a:) (I.-.*#&>tstm)}tstm NB. handle empty & delimit
  NB. itmclr=. }.&;each ',',each / each itmclr  NB. handle empty & delimit
  itmclr=. (<'; itemcolor '), each itmclr

  fbclr=. (#Y)$ idx { 'lightcyan';'mistyrose';'lemonchiffon'
  fbclr=. (<'; framebackcolor '), each fbclr

  opts=. (<allcmd),each ;each <"1 itmclr,.fbclr
  NB.opts=. (<allcmd),each ; each <"1 itmclr,.fbclr,.option3,.option4
  opts=. msknull# each opts  NB. blank where no Y series
  data=. msknull# each <"1 X,.Y
  pd opts ,. data
 NB. pd 'pdf'
  pd 'isi'
  pd 'save png'
 NB. pd 'show'
)

Note 'to use platimg instead of image3'
  NB. see Capture Graphics heading on 
  NB. http://www.jsoftware.com/jwiki/Addons/media/platimg
  load 'media/platimg'
  coinsert 'jgl2'
  glqall=: (|. $ [:glqpixels 0 0&,)@glqwh
  pd 'visible 0'
  pd 'isi'
  NB. instead of pd 'save png' do
  'tst.png' writeimg~ glqall''
  tstpng=: 'png' putimg~ glqall'' NB. or this to not write file

To resize window/image before capture use:
   glwh=: 3 : 'wd''pmovex '',(+0 0,y-glqwh_jgl2_@$@#)&.".wd''qformx'''
   glwh 4 3*200  NB. resize to 800x600
)

tstplot=: 3 : 0
pd 'new 40x 20x -40x -70x'
pd 'title sin(exp) vs cos(exp)'
pd 'color red,green'
pd 'key sin(exp),cos(exp)'
x=. steps _1 2 100
pd x;sin ^x
pd x;cos ^x
pd 'visible 1'
pd 'isi'
pd 'save png'
)