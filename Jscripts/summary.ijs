NB. Summarise one or more case instances

Note 'test data'

NB. test data 1
keylbls=. ;:'YOB'
trtlbls=. ;:'NLB LW8 FW12 FD LEAN FAT'
inftyps=. ;:'phen genD'
csinsts=. 1 2 3

NB. test data 2
keylbls=. ;:'YOB'
trtlbls=. ;:'NLB WWT LW8 FW12'
inftyps=. ;:'phen'
csinsts=. 1 2

datlbls=. ((#trtlbls),#inftyps) sortTrtColLbl inftyps makeTrtColLbl trtlbls
NB. sumrys=: (<keylbls;< datlbls) sumSummaryCSV each csinsts
(keylbls;< datlbls) plotSummaries csinsts
)

NB.*sumSummaryCSV v Summarise CSV data cols by key cols
NB. returns 2-row boxed table of labels & summarised info
NB.                 0{ is boxed list of column labels
NB.                 1{ is summary info in inverted table form                      
NB. y is case instance id of summary.csv to summarise
NB. x is 2-item boxed list. 
NB.           0{x is boxed list of column labels to use as summary keys
NB.           1{x is boxed list of trait column labels to summarise
NB. e.g. ((<'YOB');< ;:'pLW8 pFW12') sumSummaryCSV 1
sumSummaryCSV=: 4 :0
  'keylbls datlbls'=. x
  'hdr invtble'=. 'animsumry' getInfo y
  keyidx=. hdr idxfnd keylbls NB. indexes of only keylbls found in hdr
  key=. listatom keyidx{invtble  NB. get keycols (listatom nolonger reqd?)
  datidx=. hdr i. datlbls
  dat=. 0".each datidx{(<@((,.'0') #~ ttally),~]) invtble NB. append column of zeros to invtble to handle datlbls not in hdr
  sum=. key tkeytble (<tfreq key),key tkeyavg dat NB.! keep tfreq??
  ini=. 'animini' getInfo y
  yr0=. ini getIniString 'yearzero' NB. yearzero as string
  strt=. ((keylbls i. <'YOB'){tnub key) tindexof boxopen yr0
  if. (#datlbls)>idx=.datlbls i.<'pNLB' do. NB. replace pNLB with number born each year % popln size
    NB.! handle for keys other than just <'YOB'
    popsz=. +/ ini getIniValue 1 transName 'hrdsizes' 
    sum=. (<popsz %~ tfreq key ) (idx+>:#keyidx)}  sum
  end.
  sum=. strt}. each sum  NB. drop pre-yearzero info
  ((keyidx{hdr),(<'Freq'),datlbls),:sum
)

Note 'user interface'
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


Note 'how to plot'
Multiplot row for each chosen trait, Multiplot column for each chosen info type.
Each indiv-plot has a series for each case-instance which contains that info combination.

plotsummry recognizes a series with only 0s as missing info
  (e.g. if one of the case-instances does not have a certain trait). 
  The verb will compress out the missing rows & their colors.

plotsummry can handle situation where different case instances have
different numbers of selection cycles (i.e. length of x differs between series.)
In that case need to do multiple plots on a single graph rather
than plot multiple series (plotsummry1 below). This may have a performance penalty.

pd every <"1 x1;y1,:x2;y2

When summarising between case-instances then genD, Phen & genDe are 
plotted on different graphs in a multiplot. A light colour 
plot background helps distinguish the three types.

When summarising within case-instance then might want to show genD, Phen
& genDe on the same graph - but use 2ndry y axis for genDe & genD. The
lines should have the colour corresponding to the plot backgrounds for
between case-instance plots.

How to handle plots where summary is by something other than YOB??
)


NB.*preplotsummry v prepare arguments for plotsummry
NB. returns 2-item boxed list of x and y arguments for plotsummry
NB. y is case instance id(s) of summary.csv(s) to plot
NB. x is output from sumSummaryCSV
preplotsummry=: 4 :0
  collbls=. {.{. every x NB. collbls should all be the same could check
  keylen=. collbls i. <'Freq'
  data=. {: each x
  X=. 0". &> each keylen{.each data
  Y=. > each (>:keylen)}. each data NB. drop key
  Y=. ;,.each/ <"1 each Y  NB. make table
  inftyps=. getTrtInfoTyps getTrtsOnly collbls
  inftyps=. >inftyps
  NB.! Format for trait names needs some thought
  NB. Could just use base trait labels
  NB. Or if only a few (1-3) traits to display could look up full Trait name
  NB. could investigate wrapping Trait name label over multiple lines if long.
  NB. trtnms =. >'Fleece weight 12';'Live weight 8' NB. get text for base traits
  trtnms =. >~.getTrtBase getTrtsOnly collbls NB. just base trait labels for now
  NB. database lookup of (user) names for case instances.
  cinms=. 'caseinstname' getInfo  boxopenatoms y
  cinmsidx=. 0=# every {."1 }. cinms
  cinms=. >(<"1 (i.<:#cinms),.cinmsidx){}.cinms
 NB. cinms=. (#csinsts)$ >'My first one';'My second version';'Base case'
  fnme=. ('sumryfolderpath' getFnme ;{.y),'sumryplot.pdf'
  res=. (trtnms;inftyps;cinms;fnme) ;< X;<Y
)

NB.*plotSummaries v 
NB. y is case instance id(s) of summary.csv(s) to plot
NB. x is 2-item boxed list. 
NB.        0{x is boxed list of column labels to use as summary keys
NB.        1{x is boxed list of trait column labels to summarise
plotSummaries=: 4 :0 
 NB.  ('starting',LF)fwrites 'D:\Web\SelectJ\userpop\tikka\jhp.log'
 sumrys=. (<x) sumSummaryCSV each y
 NB.  ('sumSummaryCSV complete',LF) fappends 'D:\Web\SelectJ\userpop\tikka\jhp.log'
 'names data'=. sumrys preplotsummry y
 NB.  ('preplotsummry complete',LF)fappends 'D:\Web\SelectJ\userpop\tikka\jhp.log'
 names plotsummry data
 NB.  ('plotsummry complete',LF)fappends 'D:\Web\SelectJ\userpop\tikka\jhp.log'
)

Note 'test data for plotsummry'
   X=: 2001&+&i. each 5 3 4
   Y=: i. each 5 3 4
   Y=: Y,:2* each Y
   Y=: Y,8- each {.Y
   Y=: Y,3#a:
   Y=: (a:) (<1 0)}Y
   Y=: (10%~3 5 7)+each"1 Y

((>'Fleece weight 12';'Live weight 8');(>'phen';'genD');>'My first one';'My second version';'Base case' )plotsummry X;<Y
)

NB.*plotsummry v  plots traits by infotypes for one or more caseinstance summaries
NB. handles - caseinstances with diff nCycles
NB.         - caseinstances with diff trait combos
NB.         - traits with missing infotypes
NB. y is boxed list of xdata;<ydata
NB.    xdata is boxed list (length #caseinstances) of 
NB.        numeric lists (length #cycles in caseinstance)
NB.    ydata is rank-2 boxed array. 
NB.        row for each plot in multiplot ((#traits) * #infotypes)
NB.        col for each case instance
NB. x is boxed list of rank-2 lists trtnames;infotypes;ci names;filename for plot image
plotsummry=: 3 : 0
  inftyps=. >;:'phen genD genDe' NB. assumes all infotypes but can't know
  ntrts  =. %/# every (1{::y);inftyps NB. tally ydata divided by num info types.
  trtnms =. 'Trait ',"_ 1 (8!:2) ,.>:i.ntrts
  ncis   =. >./ #every 1{::y NB. max tally of each ydata
  cinms  =. 'Scenario ',"_ 1 (8!:2) ,.>:i.ncis
  (trtnms;inftyps;cinms) plotsummry y
:
  'X Y'=. 2{. boxopen y
  'trtnms inftyps cinms fnme'=. mfv1 each x
  infotypes=.('phen';'Phenotype'),('genD';'Genotype'),:('genDe';'EBV')
  idx=. (<"1&dtb"1 inftyps) i. ~{."1 infotypes NB. which infotypes
  nplots=. */#every trtnms;inftyps;cinms
  msksnull=. <"1 +./@:*every Y NB. non-zero y series
  mskpnull=. -.+./every msksnull NB. plots with no non-zero y series
  frmt=. [: vfms dquote"1@dtb"1
  clrs=. ;:'blue red green purple fuchsia olive teal yellow tan aqua brown gray'
  pd 'reset'
  pd 'visible ',":-. IFCONSOLE  NB. don't display isi if run by console
  pd 'multi ',": (#trtnms),#inftyps
  pd 'title Comparison of Trait progress by Scenario'
  pd 'captionfont arial 13'
  pd 'xcaption ', frmt >idx { {:"1 infotypes
  pd 'ycaption ', frmt trtnms
  NB. pd 'xgroup ',": (#idx)#0 NB. all the same x axis
  pd 'xgroup ',": mskpnull NB. all the same x axis
  NB. pd 'ygroup 0 3 3 1 4 4 2 5 5'
  pd 'ygroup ',": ,  idx{"1 |:({:,~])i.2, #trtnms NB. phens in diff group to genD & genDe
  pd 'key ', frmt cinms
  pd 'keypos center top outside'
  pd 'keystyle left boxed horizontal fat'
  pd 'keycolor ',',' join (#cinms){. clrs
  xtp=. ';xticpos ',,":(] {::~ (] i. >./)@:(#&>)) X  NB. xticpos
  allcmd=. 'type line; pensize 2;',xtp

  itmclr=. nplots$(#cinms) {. clrs
  itmclr=. (<';itemcolor '), each itmclr

  fbclr=. (nplots)$(#cinms) # idx { 'lightcyan';'mistyrose';'lemonchiffon'
  fbclr=. (<';framebackcolor '), each fbclr

  opts=. (<allcmd),each ;each <"1 itmclr,.fbclr
  NB.opts=. (<allcmd),each ; each <"1 itmclr,.fbclr,.option3,.option4
  opts=. (nplots $(#cinms){.1)<;.1 opts NB. group plot series together
  opts=. msksnull# each opts  NB. blank where no Y series
  data=. ,.each/"1 (<X),. <"1 Y
  data=. msksnull# each data
  pd ,.each/"1 opts ,. <"1 each data
  NB. pd 'isi'
  NB. pd 'save png'
  pd 'pdf ',(,fnme),' 600 400'
)

NB.*captureIsi v capture the contents of an isigraph form
NB. returns #bytes written to file or actual img file content
NB. y is character list (either filename to write to or format to return)
NB. x is optional width and height in pixels. Defaults to 800 600.
NB. e.g. captureIsi jpath '~temp/myfile.gif'
NB. e.g. 1024 768 captureIsi 'png'
captureIsi=: 3 :0
  800 600 captureIsi y
:
  if. -.*#y do. y=.jpath '~temp/tstcapture.png' end.
  require 'media/platimg'
  coinsert 'jgl2'
  glwh=: 3 : 'wd''pmovex '',(+0 0,y-glqwh_jgl2_@$@#)&.".wd''qformx'''
  glwh x
  glqall=: (|. $ [:glqpixels 0 0&,)@glqwh
  if. (<toupper y) e. ;:'BMP GIF JPEG PNG TIFF EXIF ICO WMF EMF' do.
    y putimg~ glqall'' NB. or this to not write file
  else.
    y writeimg~ glqall''  NB. write to file
  end.
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


Note 'test data for plotsummry1'
  X=. i. each 6 + i.9
  Y=. X ^ each 1 + 0.3 * i.9
  Y=. (*: , +: ,: ]) each Y
  Y=. (<1 2 4 9 16 25,(0 6$0),0 1 2 3 4 5) (0)}Y
plotsummry1 X;<Y
((>'Fleece weight 12';'No. Lambs Born';'Live weight 8');(>'phen';'genD';'genDe');>'My first one';'My second version';'Base case' )plotsummry1 X;<Y

  Y=. mfv1 each <"1 data  NB. ensure vectors are 1 row matricies
  X=. ((#Y)#<lbls)  NB. X is probably same for each y
  dat=. X;<Y
  datinfo=. (>'No of Lambs Born';'Live weight 8';'Fleece weight 12';'Fat Depth';'carcass Lean';'carcass Fat');(>'phen';'genD');>'My first one'
datinfo plotsummry1 dat
)

NB. plotsummry1 v plots traits by infotypes for one or more caseinstance summaries
NB. handles - caseinstances with diff trait combos
NB.         - traits with missing infotypes
NB. y is boxed list of xdata;<ydata
NB.      xdata is boxed list of numeric lists
NB.      ydata is boxed list of rank-2 numeric arrays
NB. x is boxed list of rank-2 lists trtnames;infotypes;ci names;
plotsummry1=: 3 : 0
  inftyps=. >;:'phen genD genDe' NB. assumes all infotypes but can't know
  ntrts  =. %/# every (1{::y);inftyps NB. tally ydata divided by num info types.
  trtnms =. 'Trait ',"_ 1 (8!:2) ,.>:i.ntrts
  ncis   =. >./ #every 1{::y NB. max tally of each ydata
  cinms  =. 'Scenario ',"_ 1 (8!:2) ,.>:i.ncis
  (trtnms;inftyps;cinms) plotsummry1 y
:
  'X Y'=. 2{. boxopen y
  'trtnms inftyps cinms'=. mfv1 each x
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