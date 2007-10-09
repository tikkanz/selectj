NB. Collected Definitions from
NB. http://www.jsoftware.com/jwiki/Essays/Inverted_Table
coclass 'z'

ifa =: <@(>"1)@|:              NB. inverted from atoms
afi =: |:@:(<"_1@>)            NB. atoms from inverted

tassert=: 3 : 0
 assert. (1>:#$y) *. 32=3!:0 y  NB. boxed scalor or vector
 assert. 1=#~.#&>y             NB. same # items in each box (with at least one box)
 1
)

ttally    =: #@>@{.
tindexof  =: i.&>~@[ i.&|: i.&>
tmemberof =: i.&>~ e.&|: i.&>~@]
tless     =: <@:-.@tmemberof #&.> [
tnubsieve =: ~:@|:@:(i.&>)~
tnub      =: <@tnubsieve #&.> ]
tkey      =: 1 : '<@tindexof~@[ u/.&.> ]'
tgrade    =: > @ ((] /: {~)&.>/) @ (}: , /:&.>@{:)
tgradedown=: > @ ((] \: {~)&.>/) @ (}: , \:&.>@{:)
tsort     =: <@tgrade {&.> ]
tfrom     =: <@[ {&.> ] NB. forums


tfreq     =: #/.~@:|:@:(i.&>)~  NB. frequency of unique keys RGS

Note 'forum Roger'
- Alternative defns for tfreq are:
tfreq=: #/.~@tindexof~
tfreq=: >@(# tkey)~

tsort1 should perhaps be "order x by y" rather than the proposed "order y by x", to follow the dyads /: and \: .

)


NB. Below are my additions to the above verbs 
NB. for summarising inverted tables using key columns
NB. require jpath '~user/usercontrib/invertedtables.ijs'

NB.*tsort1 v sorts inverted table y by tgrade of inverted table x
NB. eg. ,.each key tsort1 invtble
NB. eg. ,.each (tnub key) tsort1 tfreqtble key
NB. tsort1=: ] {&.>~ [: < [: tgrade [
tsort1    =: <@tgrade@[ {&.> ]

NB.*tfreq v frequency of unique rows of inverted table y
NB.  returns list of frequencies for nub rows of inverted table in order they occur.
NB.  y is inverted table, usually key columns of a bigger inverted table
NB. eg. ,.each tfreq key
tfreq     =: #/.~@:|:@:(i.&>)~

NB.*tfreqtble v sorted frequency table of unique rows of inverted table y
NB. returns inverted table with unique rows of y prepended to their frequencies
NB. y is inverted table
NB. eg. ,.each tfreqtble key
tfreqtble =: [: tsort tnub , <@:tfreq

NB.*tkeytble v sorted table with prepended unique keys
NB. y is list or inverted table of data to prepend tnub x to.
NB. x is inverted table of key columns to prepend to y
NB. eg. ,.each key tkeytble tfreq key
NB. eg. ,.each key tkeytble key keysum dat
tkeytble  =: [: tsort1 ([: tnub [) , [: boxopen ]

NB.*tkeysum v sum inverted table y by unique keys in x
NB. y is list or inverted table of data 
NB. x is inverted table of key columns to sum by
NB. eg. ,.each key keysum dat
NB. eg. ,.each key tkeytble key keysum dat
NB. tkeysum   =: ] +//.&.>~ <@:tindexof~@:[
tkeysum=: <@:tindexof~@:[ +//.&.> ]

tkeyavg   =: tkeysum % &.> <@:tfreq@:[
tkeyavg1  =: (+/ % #)tkey  NB. 2x slower 3.5x smaller than tkeyavg

NB.*tkey a inverted table version of /. (key)
NB. usage. x u tkey y
NB. y is inverted table of data to summarise
NB. x is inverted table of keys to summarise by
NB. u is verb to summarise with
NB. eg. key  +/tkey dat NB. sums by key
NB. eg. key >./tkey dat NB. max by key
NB. eg. key tkeytble key +/tkey dat  NB. prepend sums by key with keys
tkey      =: 1 : '<@tindexof~@[ u/.&.> ]'


Note 'Test animalsim data'
require 'csv'
smry=: readcsv jpath '~temp/summary.csv'
smrysm=:({.smry),(40?<:#smry){ }.smry
'hdr sm'=:split smry
invtble=: ifa sm

key=: 1 3{invtble NB. YOB Sex
dat=: 0".each 7 10 12{invtble   NB. Freq, pLW8, pFW12

key=: listatom 1{invtble
dat=: 0". each 9}.invtble
NB. dat=: 0".each (hdr i. (<'pNLB')-.~ getTrtsOnly hdr){invtble

('year';'freq';9}.hdr),: ,.each key tkeytble (<tfreq key),key tkeyavg dat
)

Note 'Test generic data'
hdr=: ;: 'ID DOB Sex Nat Height Weight Arrests'
x0=: 'ID',"1 ];._1 ' ',": 10000+ i.40
x1=: 1998+ 40 ?.@$ 4
x2=: (40 ?.@$ 2){ >'Female';'Male'
x3=: (40 ?.@$ 3){ >'NZ';'US';'CH'
x4=: 1.2 +  1 * (40?.@$ 0)
x5=:  60 + 12 * (40?.@$ 0)
x6=: 40 ?.@$ 6
invtble=: x0;x1;x2;x3;x4;x5;x6

key=: 1 3 2{invtble
dat=: 4 5 6{invtble
NB. next line gives sorted table of keys with freqs and avgs for Height, Weight and Arrests
,.each key tkeytble (<tfreq key),key tkeyavg dat
)