NB. built from project: ~Projects/custidx/custindex
NB. =========================================================
NB. GUI for Customised Indexes Application

NB. standalone defs:
3 : 0 ''
if. 0 = 4!:0 <'PATHSEP_j_' do. return. end.
PATHSEP_j_=: ((9!:12'') e. 6 7) { '/\'
jhostpath_z_=: PATHSEP_j_ & (I. @ (e.&'/\')@] })
jpath_z_=: jhostpath @ (}.~'~'={.)
load_z_=: require_z_=: ]
0
)


NB. sysenv - System Environment
NB.
NB. ---------------------------------------------------------
NB. Main definitions are in z:

NB. ---------------------------------------------------------
NB. verbs:
NB.*jhostpath v    converts path name to use host path separator
NB.*jcwdpath v     adds path to J current working directory
NB.*jsystemdefs v  loads appropriate netdefs or hostdefs

NB. ---------------------------------------------------------
NB. nouns:
NB. (fonts are redefined in configuration)
NB.*   ARGV n         command line
NB.*   PROFILE n      name of profile file
NB.*   FIXFONT n      fixed space font (used in session windows)
NB.*   PROFONT n      proportional font (used in forms)
NB.*   IF64 n         if a 64 bit J system
NB.*   IFCONSOLE n    if a console front end
NB.*   IFJAVA n       if a Java front end
NB.*   IFUNIX n       if UNIX
NB.*   IFWIN32 n      if Windows (9x,ME,NT,2000,XP)
NB.*   IFWINNT n      if Windows NT,2000,XP
NB.*   IFWINCE n      if Windows CE
NB.*   UNAME n        name of UNIX o/s

NB. Other nouns defined in j:
NB.*   JIJX n         1 if -jijx parameter (i.e. don't create ijx window)

18!:4 <'z'

NB. =========================================================
3 : 0 ''

notdef=. 0: ~: 4!:0 @ <

if. notdef 'ARGV' do. ARGV=: <'undefined' end.
if. notdef 'PROFILE' do. PROFILE=: 1!:45'' end.
if. notdef 'PATHSEP_j_' do. PATHSEP_j_=: '/\'{~6=9!:12'' end.
jhostpath=: PATHSEP_j_ & (I. @ (e.&'/\')@] })
if. notdef 'IFJIJX_j_' do. IFJIJX_j_=: (<'-jijx') = 1 { ARGV,a: end.

NB. ---------------------------------------------------------
IF64=: 16={:$3!:3[2 NB. possibly better tests don't work yet
IFCONSOLE=: 0 -: (11!:0) :: 0: ''
IFJAVA=: 'jjava'-: (11!:0) :: 0: 'qwd'
'IFUNIX IFWIN32 IFWINCE'=: 5 6 7 = 9!:12''

NB. ---------------------------------------------------------
if. IFUNIX do.
  UNAME=: (2!:0 'uname')-.10{a.
else.
  UNAME=: 'Win'
end.

NB. ---------------------------------------------------------
NB. get Windows NT flag
if. IFWIN32 do.
  'hi lo'=. 256 256 #: > {. 'kernel32 GetVersion i' 15!:0 ''
  IFWINNT=: (hi = 0) +. lo > 4
else.
  IFWINNT=: 0
end.

NB. ---------------------------------------------------------
if. IFJAVA do.
  if. notdef 'FIXFONT' do. FIXFONT=: 'monospaced 12' end.
  if. notdef 'PROFONT' do. PROFONT=: 'sansserif 10' end.
else.
  if. notdef 'FIXFONT' do. FIXFONT=: '"Courier New" 12' end.
  if. notdef 'PROFONT' do. PROFONT=: '"MS Sans Serif" 8' end.
end.
)

NB. =========================================================
jcwdpath=: (1!:43@(0&$),])@jhostpath@((*@# # '\'"_),])

NB. =========================================================
jsystemdefs=: 3 : 0
0!:0 <jpath '~system\main\defs\',y,'_',(tolower UNAME),(IF64#'_64'),'.ijs'
)

NB. standard library
NB.
NB. these definitions are assumed available to other programs

NB. TAB            tab
NB. LF             linefeed
NB. FF             formfeed
NB. CR             carriage return
NB. CRLF           CR LF pair
NB. DEL            ascii 127
NB. EAV            ascii 255
NB. noun           0
NB. adverb         1
NB. conjunction    2
NB. verb           3
NB. monad          3
NB. dyad           4
NB.
NB. assert         assert value is true
NB. bind           binds argument to a monadic verb
NB. boxopen        box argument if open
NB. boxxopen       box argument if open and 0<#
NB. bx             indices of 1's in boolean
NB. clear          clear all names in locale
NB. cutopen        cut argument if open
NB. datatype       noun datatype
NB. def            : (explicit definition)
NB. define         : 0 (explicit definition script form)
NB. do             do (".)
NB. drop           drop (}.)
NB. each           each (&.>)
NB. empty          return empty result
NB. erase          erase
NB. every          every (&>)
NB. exit           exit (2!:55)
NB. expand         boolean expand data
NB. fetch          fetch ({::)
NB. inv, inverse   inverse (^:_1)
NB. items          items ("_1)
NB. leaf           leaf (L:0)
NB. list           list data formatted in columns
NB. names          formatted namelist
NB. nameclass      name class
NB. namelist       name list
NB. nc             name class
NB. nl             selective namelist
NB. Note           note in script
NB. on             on @:
NB. pick           pick (>@{)
NB. rows           rows ("1)
NB. script         load script
NB. scriptd        load script with display
NB. sign           sign (*)
NB. smoutput       output to session
NB. sort           sort up
NB. split          split head from tail
NB. table          function table
NB. take           take ({.)
NB. toCRLF         converts character strings to CRLF delimiter
NB. toJ            converts character strings to J delimiter (linefeed)
NB. toHOST         converts character strings to Host delimiter
NB. tolower        convert text to lower case
NB. toupper        convert text to upper case
NB. type           object type
NB. wcsize         size of execution window
NB. ucp            return code point chars
NB. ucpcount       code point count
NB. utf8           return utf8 chars

NB. =========================================================
NB.*TAB n tab character
NB.*LF n linefeed character
NB.*FF n formfeed character
NB.*CR n carriage return character
NB.*CRLF n CR LF pair
NB.*DEL n ascii 127 character
NB.*noun n integer 0
NB.*adverb n integer 1
NB.*conjunction n integer 2
NB.*verb n integer 3
NB.*monad n integer 3
NB.*dyad n integer 4

18!:4 <'z'

NB. =========================================================
'TAB LF FF CR DEL EAV'=: 9 10 12 13 127 255{a.
CRLF=: CR,LF

'noun adverb conjunction verb monad dyad'=: 0 1 2 3 3 4

NB. =========================================================
NB.*apply v apply verb x to y
apply=: 128!:2

NB. =========================================================
NB.*def c : (explicit definition)
def=: :

NB.*define a : 0 (explicit definition script form)
define=: : 0

NB.*do v name for ".
do=: ".

NB.*drop v name for }.
drop=: }.

NB.*each a each (&.>)
each=: &.>

NB.*exit v 2!:55
exit=: 2!:55

NB.*every a every (&>)
every=: &>

NB.*inv a inverse (^:_1)
NB.*inverse a inverse (^:_1)
inv=: inverse=: ^:_1

NB.*items a ("_1)
items=: "_1

NB.*fetch v name for {::
fetch=: {::

NB.*leaf a leaf (L:0)
leaf=: L:0

NB.*nameclass v name for 4!:0
NB.*nc v name for 4!:0
nameclass=: nc=: 4!:0

NB.*namelist v name for 4!:1
namelist=: 4!:1

NB.*on c name for @:
on=: @:

NB.*pick v pick (>@{)
pick=: >@{

NB.*rows a rows ("1)
rows=: "1

NB.*sign a sign (*)
sign=: *

NB.*sort v sort up
sort=: /:~ : /:

NB.*take v name for {.
take=: {.

NB. =========================================================
NB.*assert v assert value is true
NB. assertion failure if  0 e. y
NB. e.g. 'invalid age' assert 0 <: age
assert=: 0 0"_ $ 13!:8^:((0: e. ])`(12"_))

NB. =========================================================
NB.*bind c binds argument to a monadic verb
NB. binds monadic verb to an argument creating a new verb
NB. that ignores its argument.
NB. e.g.  fini=: wdinfo bind 'finished...'
bind=: 2 : 'x@(y"_)'

NB. =========================================================
NB.*boxopen v box argument if open
NB. boxxopen    - box argument if open and # is not zero
NB. e.g. if script=: 0!:0 @ boxopen, then either
NB.   script 'work.ijs'  or  script <'work.ijs'
NB. use cutopen to allow multiple arguments.
boxopen=: <^:(L.=0:)

NB.*boxxopen v box argument if open and 0<#
boxxopen=: <^:(L.<*@#)

NB. =========================================================
NB.*bx v indices of 1's in boolean
bx=: I. NB. added j503, definition retained for compatibility

NB. =========================================================
NB.*clear v clear all names in locale
NB.         returns any names not erased
NB. example: clear 'myloc'
clear=: 3 : 0
". 'do_',(' '-.~y),'_ '' (#~ -.@(4!:55)) (4!:1) 0 1 2 3'''
)

NB. =========================================================
NB.*cutopen v cut argument if open
NB. this allows an open argument to be given where a boxed list is required.
NB. most common situations are handled. it is similar to boxopen, except
NB. allowing multiple arguments in the character string.
NB.
NB. x is optional delimiters, default LF if in y, else blank
NB. y is boxed or an open character array.
NB.
NB. if y is boxed it is returned unchanged, otherwise:
NB. if y has rank 2 or more, the boxed major cells are returned
NB. if y has rank 0 or 1, it is cut on delimiters in given in x, or
NB.   if x not given, LF if in y else blank. Empty items are deleted.
NB.
NB.  e.g. if script=: 0!:0 @ cutopen, then
NB.   script 'work.ijs util.ijs'
NB.
cutopen=: 3 : 0
y cutopen~ (' ',LF) {~ LF e. ,y
:
if. L. y do. y return. end.
if. 1 < #$y do. <"_1 y return. end.
(<'') -.~ (y e.x) <;._2 y=. y,1{.x
)

NB. =========================================================
NB.*datatype v noun datatype
datatype=: 3 : 0
n=. 1 2 4 8 16 32 64 128 1024 2048 4096 8192 16384 32768 65536 131072
t=. '/boolean/literal/integer/floating/complex/boxed/extended/rational'
t=. t,'/sparse boolean/sparse literal/sparse integer/sparse floating'
t=. t,'/sparse complex/sparse boxed/symbol/unicode'
(n i. 3!:0 y) pick <;._1 t
)

NB. =========================================================
NB.*empty v return empty result (i.0 0)
empty=: (i.0 0)"_

NB. =========================================================
NB.*erase v erase namelist
erase=: [: 4!:55 ;: ::]

NB. =========================================================
NB.*expand v boolean expand
NB. form: boolean expand data
expand=: # inverse

NB. =========================================================
NB.*list v list data formatted in columns
NB. syntax:   {width} list data
NB. accepts data as one of:
NB.   boxed list
NB.   character vector, delimited by CR, LF or CRLF; or by ' '
NB.   character matrix
NB. formats in given width, default screenwidth
list=: 3 : 0
w=. {.wcsize''
w list y
:
if. 0=#y do. i.0 0 return. end.
if. 2>#$y=. >y do.
  d=. (' ',LF) {~ LF e. y=. toJ ": y
  y=. [;._2 y, d #~ d ~: {: y
end.
y=. y-. ' '{.~ c=. {:$ y=. (": y),.' '
(- 1>. <. x % c) ;\ <"1 y
)

NB. =========================================================
NB.*nl v selective namelist
NB. Form:  [mp] nl sel
NB.
NB.   sel:  one or more integer name classes, or a name list.
NB.         if empty use: 0 1 2 3.
NB.   mp:   optional matching pattern. If mp contains '*', list names
NB.         containing mp, otherwise list names starting mp. If mp
NB.         contains '~', list names that do not match.
NB.
NB.  e.g. 'f' nl 3      - list verbs that begin with 'f'
NB.       '*com nl ''   - list names containing 'com'
nl=: 3 : 0
'' nl y
:
if. 0 e. #y do. y=. 0 1 2 3 end.

if. 1 4 8 e.~ 3!:0 y do.
  nms=. (4!:1 y) -. ;: 'x y x. y.'
else.
  nms=. cutopen_z_ y
end.

if. 0 e. #nms do. return. end.

if. #t=. x -. ' ' do.
  'n s'=. '~*' e. t
  t=. t -. '~*'
  b=. t&E. &> nms
  if. s do. b=. +./"1 b
  else. b=. {."1 b end.
  nms=. nms #~ n ~: b
end.
)

NB. =========================================================
NB.*names v formatted namelist
names=: list_z_ @ nl

NB. =========================================================
NB.*Note v notes in script
NB.
NB. Monadic form:
NB.   This enables multi line comments without repeated NB. and
NB.   requires a right parenthesis in the first column of a line to
NB.   close. The right argument may be empty, numeric, text, or any
NB.   noun. Reads and displays the comment text but always returns an
NB.   empty character string so the comment is not duplicated on screen.
NB.
NB. The right argument can number or describe the notes, e.g.
NB.   Note 1     Note 2.2   or    Note 'The special case' etc.
NB.
NB. Dyadic form
NB.   This permits a single consist form of comment for any lines which are
NB.   not tacit definitions. The left argument must be a noun. The function
NB.   code displays the right argument and returns the left argument.
NB.
NB. examples:
NB.
NB. Note 1
NB. ... note text
NB. )
NB.
NB. (2 + 3)=(3 + 2) Note 'addition is commutative'
Note=: 3 : '0 0 $ 0 : 0' : [

NB. =========================================================
NB.*script v load script, cover for 0!:0
NB.*scriptd v load script with display, cover for 0!:1
script=: [: 3 : '0!:0 y [ 4!:55<''y''' jpath_z_ &.: >
scriptd=: [: 3 : '0!:1 y [ 4!:55<''y''' jpath_z_ &.: >

NB. =========================================================
NB.*smoutput v output to session
smoutput=: 0 0 $ 1!:2&2

NB. =========================================================
NB.*split v split head from tail
NB. examples:
NB.    split 'abcde'
NB.    2 split 'abcde'
split=: {. ,&< }.

NB. =========================================================
NB.*table a function table
NB. table   - function table  (adverb)
NB. e.g.   1 2 3 * table 10 11 12 13
NB.        +. table i.13
table=: 1 : 0~
:
(((#~LF-.@e.])5!:5<'u');,.y),.({.;}.)":x,y u/x
)

NB. =========================================================
NB.*tolower v convert text to lower case
NB.*toupper v convert text to upper case
NB. 
NB. earlier defs can fail on unicode data:
NB. 'l u'=. (a.i.'aA') +each <i.26
NB. tolower=: a.&i. { ((l{a.) u} a.)"_
NB. toupper=: a.&i. { ((u{a.) l} a.)"_

tolower=: 3 : 0
x=. I. 26 > n=. ((65+i.26){a.) i. t=. ,y
($y) $ ((x{n) { (97+i.26){a.) x}t
)

toupper=: 3 : 0
x=. I. 26 > n=. ((97+i.26){a.) i. t=. ,y
($y) $ ((x{n) { (65+i.26){a.) x}t
)

NB. =========================================================
NB.*type v object type
t=. <;._1 '/invalid name/not defined/noun/adverb/conjunction/verb/unknown'
type=: {&t@(2&+)@(4!:0)&boxopen

NB. =========================================================
NB.*ucp v convert text to unicode code point
NB. This is 7-bit ascii (if possible) or utf16 (compare uucp)
NB. inverse is utf8
ucp=: 7&u:

NB. =========================================================
NB.*ucpcount v unicode code point count
NB. counts number of unicode code points (glyphs) in a string.
NB. A unicode character has one code point, even though it
NB. may have several bytes in its representation.
ucpcount=: # @ (7&u:)

NB. =========================================================
NB.*utf8 v convert string to utf8
NB. inverse of ucp
utf8=: 8&u:

NB. =========================================================
NB.*uucp v convert text to unicode code point
NB. This is always utf16 (compare ucp)
uucp=: u:@(7&u:) 

NB. =========================================================
NB.*toCRLF v converts character strings to CRLF delimiter
NB.*toHOST v converts character strings to Host delimiter
NB.*toJ v converts character strings to J delimiter (linefeed)
NB.*wcsize v size of execution window

NB. platform-dependent definitions:
3 : 0''
h=. 9!:12''
subs=. 2 : 'x I. @(e.&y)@]} ]'

toJ=: (LF subs CR) @: (#~ -.@(CRLF&E.@,))
toCRLF=: 2&}. @: ; @: (((CR&,)&.>)@<;.1@(LF&,)@toJ)

if. h e. 0 1 2 4 6 7 do.
  toHOST=: toCRLF
elseif. h=3 do.      NB. Mac
  toHOST=: (CR subs LF) @: toJ
elseif. 1 do.
  toHOST=: [
end.

NB. flag if wd available:
ifwd=. 0 <: #@(11!:0) :: _1: 'qer'

NB. size of output window (cols, rows)
if. ifwd *. h e. 2 6 do.
  wcsize=: 79 24"_
elseif. ifwd *. h=7 do.
  wcsize=: 77 14"_
elseif. do.
  wcsize=: 79 24"_
end.

1
)

NB. class/object library

NB. defines:
NB.
NB. coclass        set co class
NB. cocreate       create object
NB. cocurrent      set current locale
NB. codestroy      destroy current object
NB. coerase        erase object
NB. cofullname     return name with locale qualifier
NB. coinsert       insert into path (before z)
NB. coname         return current co name
NB. conames        formatted co name list
NB. conew          create object
NB. conl           return co name list
NB. copath         set/get co path
NB. coreset        destroy all object locales

18!:4 <'z'

coclass=: 18!:4 @ boxxopen

NB. =========================================================
NB.*cocreate v create object
cocreate=: 18!:3

NB. =========================================================
NB.*cocurrent v set current locale
cocurrent=: 18!:4 @ boxxopen

NB. =========================================================
NB.*codestroy v destroy current object
codestroy=: coerase @ coname

NB. =========================================================
NB.*coerase v erase object
NB. example: coerase <'jzplot'
coerase=: 18!:55

NB. =========================================================
NB.*cofullname v return name with locale qualifier
cofullname=: 3 : 0
y=. ,> y
if. #y do.
  if. ('_' = {: y) +: 1 e. '__' E. y do.
    y,'_',(>18!:5''),'_'
  end.
end.
)

NB. =========================================================
NB.*coinsert v insert into path (before z)
NB.
NB. adds argument and copath of argument to current path.
NB.
NB. paths are in order of argument, except that z is at the end.
NB.   coinsert 'cdir'
NB.   coinsert 'cdir pobj'
NB.   coinsert 'cdir';'pobj'
coinsert=: 3 : 0
n=. ;: :: ] y
p=. ; (, 18!:2) @ < each n
p=. ~. (18!:2 coname''), p
(p /: p = <,'z') 18!:2 coname''
)

NB. =========================================================
NB.*coname v return current co name
coname=: 18!:5

NB. =========================================================
NB.*conames v formatted co name list
conames=: list_z_ @ conl

NB. =========================================================
NB.*conew v create object
conew=: 3 : 0
c=. <y
obj=. cocreate''
coinsert__obj c
COCREATOR__obj=: coname''
obj
:
w=. conew y
create__w x
w
)

NB. =========================================================
NB.*conl v return co name list
NB. form: conl n
NB.   0 e. n  = return named locales
NB.   1 e. n  = return numbered locales
NB.   conl '' = return both, same as conl 0 1
conl=: 18!:1 @ (, 0 1"_ #~ # = 0:)

NB. =========================================================
NB.*copath v set/get co path
copath=: 18!:2 & boxxopen

NB. =========================================================
NB.*coreset v destroy object locales,
NB. other than for jijs and jijx windows
coreset=: 3 : 0
try.
  fms=. wdforms_j_''
  exc=. (2 {"1 fms) #~ (3 {"1 fms) e. 'jijs';'jijx'
catch.
  exc=. ''
end.
coerase (conl 1) -. exc
)

NB. standard windows library
NB.
NB. These definitions are assumed available to other windows programs

NB. wd            main window driver
NB. wde           wd error - as wd but displays error and signals break
NB. wdbox         box wd argument
NB. wdcenter      center form on another
NB. wdclipread    read clipboard
NB. wdclipwrite   write to clipboard
NB. wdfit         ensure form fits in window
NB. wdforms       wd form info
NB. wdget         get values from matrix, e.g. wd'q'
NB. wdhandler     wd handler
NB. wdinfo        information box
NB. wdishandle    if a form handle
NB. wdisparent    if a parent window
NB. wdmove        position window
NB. wdpclose      close parent window
NB. wdqshow       display result of wdq
NB. wdquery       query box
NB. wdreset       reset window driver
NB. wdstatus      put status message on screen

18!:4 <'z'

NB. =========================================================
NB.*wd v main window driver, name for 11!:0
wd=: 11!:0

NB.*wdreset v reset window driver
wdreset=: wd bind 'reset'

NB.*wdclipread v read clipboard
wdclipread=: toJ @ wd bind 'clippaste'

NB. =========================================================
NB.*wdbox v box wd argument
NB. use this to analyze arguments to wd
NB. in code: whs=whitepace, del=delimiters
wdbox=: 3 : 0
whs=. 8 9 10 13 32{a.
del=. 127{a.
dat=. ' ',y
msk=. ~:/\ dat e. del
mqt=. 2: +./\ 0: , 2: | +/\ @ (=&'"')
mquote=. -. mqt dat
msk=. mquote *. msk
ndx=. 1 i.~ msk < dat='*'
end=. < }. ndx }. dat
dat=. ndx{.dat
msk=. mquote *.(ndx {. msk) < dat e. whs
dat=. (msk <;._1 dat) , end
a: -.~ dat -. each <del
)

NB. =========================================================
NB.*wdcenter v center form on another
NB. form: wdcenter xywh
NB. use this to center a form on another
wdcenter=: 3 : 0
'fx fy fw fh'=. 0&". :: ] y
'sx sy'=. sxy=. 2 {. 0 ". wd 'qm'
'w h'=. sxy <. _2 {. 0 ". wd 'qformx'
x=. 0 >. (sx-w) <. fx + <. -: fw-w
y=. 0 >. (sy-h) <. fy + <. -: fh-h
wd 'pmovex ',": x,y,w,h
)

NB. =========================================================
NB.*wdclipwrite v write to clipboard
wdclipwrite=: 3 : 0
txt=. y
if. L. txt do.
  txt=. }. ; (LF&, @ , @ ": each) txt
else.
  txt=. ": txt
  if. 1 < #$txt do. txt=. }. , LF,"1 txt end.
end.
wd 'clipcopy *',toHOST txt
#txt
)

NB. =========================================================
NB.*wde v as wd but displays error and signals break
wde=: 3 : 0
try. res=. wd y
catch.
  err=. wd 'qer'
  ndx=. >: err i. ':'
  msg=. ndx {. err
  pos=. {.". ndx }. err
  cmd=. (>:j i.';') {. j=. pos}.y
  if. 50 < #cmd do.
    cmd=. (47{.cmd),'...' end.
  wdinfo 'Window Driver';'wd error ',msg,LF,cmd
  wderr=. 13!:8@1:
  wderr ''
end.
)

NB. =========================================================
NB.*wdfit v fit form in window
NB. y is two integers for horizontal and vertical
NB. in each case, the entire form will be shown
NB.
NB. values are:
NB.   0   move the side out of view back into the window
NB.       - typically reduces the form size
NB.   1   move the form so it is all visible
NB.       - typically leaves the form size unchanged
NB.   2   stretch the form to the window
NB.   3   maximize the form to full screen, hiding caption and borders
NB.
NB. an empty argument is treated as 1 1
NB.
NB. wd'qm' - return system metrics:
NB. 0-1 screen width, screen height,
NB. 2-3 x logical unit, y logical unit,
NB. 4-5 cxborder, cyborder,
NB. 6-7 cxfixedframe, cyfixedframe,
NB. 8-9 cxframe, cyframe,
NB. 10-11 cycaption, cymenu,
NB. 12-15 desktop xywh
wdfit=: 3 : 0

if. IFJAVA do. return. end.

'mx my'=. 2{.y,(#y)}.1 1
'x y w h'=. 0 ". wd 'qformx'
'fx fy zx zy yc ym sx sy sw sh'=. 6 }. 0 ". wd 'qm'

select. mx
case. 0 do.
  w=. w - 0 <. sx - x
  x=. x >. sx
  w=. 0 >. w <. sx + sw - x
case. 1 do.
  x=. sx >. x <. (sx+sw) - w
  w=. 0 >. w <. sx + sw - x
case. 2 do.
  x=. sx
  w=. sw
case. 3 do.
  x=. - fx
  w=. sw + 2 * fx
end.

select. my
case. 0 do.
  h=. h - 0 <. sy - y
  y=. y >. sy
  h=. 0 >. h <. sy + sh - y
case. 1 do.
  y=. sy >. y <. (sy+sh) - h
  h=. 0 >. h <. sy + sh - y
case. 2 do.
  y=. sy
  h=. sh
case. 3 do.
  y=. - yc + fy
  h=. sh + yc + 2 * fy
end.

wd 'pmovex ',":x,y,w,h
)

NB. =========================================================
NB.*wdforms v info about all forms
NB.
NB. columns are:
NB.  0 name
NB.  1 handle
NB.  2 locale
NB.  3 type: jijx, jijs or empty
NB.  4 recent use (sequence number)
NB.  5 title
NB.
NB. e.g.
NB.    wdforms''
NB. +-----------+---+--------+----+--+---------------+
NB. |jijs       |100|0       |jijx|10|1.ijx          |
NB. +-----------+---+--------+----+--+---------------+
NB. |projectform|102|jproject|    |8 |Project Manager|
NB. +-----------+---+--------+----+--+---------------+
NB. |jijs       |198|1       |jijs|9 |winlib.ijs     |
NB. +-----------+---+--------+----+--+---------------+
wdforms=: <;._2;._2 @ wd bind 'qpx'

NB. =========================================================
NB.*wdget v get values from matrix, e.g. wd'q'
NB. utility to index 2-column boxed array, e.g. result of wd 'q'
NB. form:  names wdget data
NB. returns items in second column indexed on names in first column
NB. result is boxed if left argument is boxed
NB. e.g. 'sysfocus' wdget wdq
wdget=: 4 : 0
nms=. {."1 y
vls=. {:"1 y
if. L. x do. vls {~ nms i. ,&.>x
else. > vls {~ nms i. <,x
end.
)

SYSPPC=: (<'syschild'),.'ppcnext';'ppcprevious'

NB. =========================================================
NB.*wdhandler v wd handler
NB. runs in form locale
NB. sets global event data: wdq
NB. runs first found of: form_handler, form_event, form_default,
NB. with global event variables from wdq
NB. if debug is off, wraps event handler in try. catch.
NB. catch exits if error message is the last picked up by debug.
wdhandler=: 3 : 0
wdq=: wd 'q'
wd_val=. {:"1 wdq
({."1 wdq)=: wd_val
if. 3=4!:0<'wdhandler_debug' do.
  try. wdhandler_debug'' catch. end.
end.
if. IFWINCE do.
  if. 1 e. SYSPPC e. wdq do.
    (syschild,'_jijs_')~'' return.
  end.
end.
wd_ndx=. 1 i.~ 3 = 4!:0 [ 3 {. wd_val
if. 3 > wd_ndx do.
  wd_fn=. > wd_ndx { wd_val
  if. 13!:17'' do.
    wd_fn~''
  else.
    try. wd_fn~''
    catch.
      wd_err=. 13!:12''
      if. 0=4!:0 <'ERM_j_' do.
        wd_erm=. ERM_j_
        ERM_j_=: ''
        if. wd_erm -: wd_err do. i.0 0 return. end.
      end.
      wd_err=. LF,,LF,.}.;._2 wd_err
      wdinfo 'wdhandler';'error in: ',wd_fn,wd_err
    end.
  end.
end.
i.0 0
)

NB. =========================================================
NB.*wdinfo v information box
NB. syntax: wdinfo [title;] message
wdinfo=: 3 : 0
'a b'=. _2{. boxopen y
if. 2=#$b=. ":b do. b=. }.,LF,.b end.
f=. 8 u: DEL&, @ (,&DEL) @ -.&(0 127{a.)
empty wd 'mb ',(f a),' ',(f b),' mb_iconinformation'
)

NB. =========================================================
NB.*wdisparent v return 1 if a parent window
wdisparent=: boxopen e. <;._2 @ wd bind 'qp'

NB. =========================================================
NB.*wdishandle v return 1 if a window handle
wdishandle=: boxopen e. 1: {"1 wdforms

NB. =========================================================
NB.*wdmove v position window, relative to side of screen
NB. form: [window] wdmove offset
NB.
NB. offset is the xy offset.
NB.   if  >: 0  the offset is from topleft
NB.   if  < 0   the offset is from bottomright (less 1)
NB.
NB. e.g.
NB.     0 0  = topleft
NB.   _1 _1  = bottomright
NB.    5 _11 = 5 from left, 10 from bottom
wdmove=: 3 : 0
'' wdmove y
:
if. IFJAVA do. return. end.
'px py'=. y
'sx sy sw sh'=. 12 13 14 15 { 0 ". wd 'qm'
if. #x do. wd 'psel ',x end.
'x y w h'=. 0 ". wd 'qformx'
if. px < 0 do. px=. sw - w - 1 + px end.
if. py < 0 do. py=. sh - h - 1 + py end.
wd 'pmovex ',": (px+sx),(py+sy),w,h
)

NB. =========================================================
NB.*wdpclose v close parent window
wdpclose=: [: wd :: empty 'psel ' , ,&';pclose'

NB. =========================================================
NB.*wdqshow v display result of wdq
NB. display wdq result - useful for testing forms
wdqshow=: 3 : 0
txt=. (>{."1 wdq),.TAB,.>{:"1 wdq
wdinfo 'wdq';(60 <. {:$txt) {."1 txt
)

NB. =========================================================
NB.*wdquery v query box
NB. form: [opt] wdquery [title;] message
NB.   opt has one or two elements:
NB.    0{  = 0    okcancel          (ok=0 cancel=1)
NB.          1    retrycancel       (retry=0 cancel=1)
NB.          2    yesno             (yes=0 no=1)
NB.          3    yesnocancel       (yes=0 no=1 cancel=2)
NB.          4    abortretryignore  (abort=0 retry=1 ignore=2)
NB.    1{ = default button (0, 1 or 2)
wdquery=: 3 : 0
0 wdquery y
:
msg=. ;:'okcancel retrycancel yesno yesnocancel abortretryignore'
res=. ;:'OK CANCEL RETRY YES NO ABORT IGNORE'
ndx=. 0 1;2 1;3 4;3 4 1;5 2 6
't d'=. 2{.x [ 'a b'=. _2{. boxopen y
if. 2=#$b=. ":b do. b=. }.,LF,.b end.
f=. 8 u: DEL&, @ (,&DEL) @ -.&(0 127{a.)
m=. 'mb ',(f a),' ',(f b),' mb_iconquestion mb_',>t{msg
if. d e. 1 2 do. m=. m,' mb_defbutton',":>:d end.
(res {~ >t{ndx) i. <wd m
)

NB. =========================================================
NB.*wdselect v selection box
NB. windows selection box
NB.
NB. y is a either:   boxed list of choices
NB.             or:   title ; <boxed list of choices
NB.    if y is empty, closes selection box if open.
NB.
NB. x. is optional of up to 3 values (default 0). the second and
NB.    third options are only referenced when the box is created:
NB.   0{ initial selection
NB.   1{ 0=single selection, 1=multiple selection
NB.   2{ 0=close on exit, 1=leave open if selection made
NB.
NB. returns 2 item boxed list:
NB.   0{ 0=cancel, 1=accept
NB.   1{ indices of selections
wdselect=: 3 : 0
0 wdselect y
:
if. 0=#y do.
  empty wd 'psel wdselect;pclose' return.
end.

'n s e'=. 3{.x

if. 2=L.y do. 'hdr sel'=. y
else. hdr=. '' [ sel=. y
end.

'r c'=. $,.>sel
sel=. ;sel ,each LF

'c r'=. (12,5*6>r) + >. 4 8 * >. c,r
c=. 205 <. 80 >. (4*#hdr) >. c
r=. 128 <. r

if. (<'wdselect') e. <;._2 wd 'qp' do.
  wd 'psel wdselect;pn '",hdr,'";'
else.
  wd 'pc wdselect;pn *',hdr
  wd 'xywh 4 4 ',":c,r
  wd 'cc l0 listbox ws_vscroll rightmove bottommove',s#' lbs_multiplesel'
  wd 'setfont l0 ',PROFONT
  wd 'cc e0 editm; setshow e0 0'
  wd 'xywh ',(":14+c),' 6 36 12;cc ok button leftmove rightmove bottommove;cn "OK";'
  wd 'xywh ',(":14+c),' 21 36 12;cc cancel button leftmove rightmove bottommove;cn "Cancel";'
  wd 'pas 4 2;pcenter;'
end.

wd 'set e0 *',sel
wd 'set l0 *',sel
wd (_1 ~: n) # 'setselect l0 ',":n
wd 'setfocus l0'
wd 'pshow'

while. 1 do.
  wdq=. wd 'wait;q'
  ({."1 wdq)=. {:"1 wdq
  done=. (<'cancel') e. systype;syschild
  button=. systype -: 'button'
  ok=. button *. (<syschild) e. ;:'l0 ok enter'
  if. ok +. done do.
    wd (ok *: e)#'pclose'
    ok;".l0_select
    break.
  end.
end.
)

NB. =========================================================
NB.*wdstatus v put status message on screen
NB. write status message on screen
NB.
NB. {title} wdstatus message    - write message
NB.         wdstatus ''         - close message box
NB.
NB. default text size is 1 row of 50 characters.
NB. for a larger size, call wdstatus initially with a message
NB. of the required size (pad with blanks if necessary).
NB. once created, the message box is not resized.
wdstatus=: 3 : 0
'' wdstatus y
:
if. 0 e. $y do.
  empty wd :: [ 'psel status;pclose'
  return.
end.

msg=. y
if. 2=#$msg=. ":msg do. msg=. }.,LF,.msg
else. msg=. toJ (-LF={:msg)}.msg
end.

pn=. (*#x)#'pn ',DEL,x,DEL,';'

if. (<'status') e. <;._2 wd 'qp;' do.
  wd 'psel status;',pn
else.
  size=. |. 0 100 >. 8 4*$];._2 msg,LF
  wd 'pc status closeok;',pn
  wd 'xywh 10 10 ',(":size),';'
  wd 'cc s0 static;'
  wd 'pas 10 10;pcenter;'
end.

wd 'set s0 *',msg
wd 'pshow;'
)

NB. font.ijs     utilities for fonts
NB.
NB. Fonts are specified as: fontname size [bold] [italic]
NB. The fontname should have "" delimiters if it contains blanks.
NB.
NB. Example:
NB.   "MS Sans Serif" 14 bold eom
NB.
NB. verbs:
NB.    getfont         - returns font spec as boxed list
NB.                      fontname;size;[bold;italic]
NB.
NB.    getfontsize     - get size of a font spec
NB.    setfontsize     - set size into a font spec
NB.
NB.    changefont      - change various elements of a font spec

cocurrent 'z'

NB. =========================================================
NB.*changefont v optlist changefont fontspec
NB.
NB. optlist may contain:  bold    nobold
NB.                       italic  noitalic
NB.                       size    fontsize
NB.
NB. font should be: fontname size [bold] [italic]
NB.
NB. e.g. ('bold';20) changefont '"Lucida Console" 20' 
changefont=: 4 : 0
font=. getfont y
opt=. x
if. 0=L. opt do. opt=. cutopen ":opt end.
opt=. a: -.~ (-.&' ' @ ":) each opt
num=. _1 ~: _1 ". &> opt
if. 1 e. num do.
  font=. ({.num#opt) 1} font
  opt=. (-.num)#opt
end.
ayes=. ;:'bold italic'
noes=. ;:'nobold noitalic'
font=. font , opt -. noes
font=. font -. (noes e. opt)#ayes
}: ; ,&' ' each ~. font
)

NB. =========================================================
NB.*getfont v getfont fontspec
getfont=: 3 : 0
font=. ' ',y
b=. (font=' ') > ~:/\font='"'
a: -.~ b <;._1 font
)

NB. =========================================================
NB.*getfontsize v getfontsize fontspec
getfontsize=: 13 : '{.1{._1 -.~ _1 ". y'

NB. =========================================================
NB.*setfontsize v size setfontsize fontspec
setfontsize=: 4 : 0
b=. ~: /\ y='"'
nam=. b#y
txt=. ;:(-.b)#y
ndx=. 1 i.~ ([: *./ e.&'0123456789.') &> txt
nam, }: ; ,&' ' &.> (<": x) ndx } txt
)

NB. 2D graphics definitions

coclass 'jgl2'

PS_DASH=: 1
PS_DASHDOT=: 3
PS_DASHDOTDOT=: 4
PS_DOT=: 2
PS_INSIDEFRAME=: 6
PS_NULL=: 5
PS_SOLID=: 0

IDC_ARROW=: 32512
IDC_IBEAM=: 32513
IDC_WAIT=: 32514
IDC_CROSS=: 32515
IDC_UPARROW=: 32516
IDC_SIZENWSE=: 32642
IDC_SIZENESW=: 32643
IDC_SIZEWE=: 32644
IDC_SIZENS=: 32645
IDC_SIZEALL=: 32646
IDC_NO=: 32648
IDC_APPSTARTING=: 32650
IDC_HELP=: 32651

glarc=: 11!:2001
glbrush=: 11!:2004
glbrushnull=: 11!:2005
glcapture=: 11!:2062
glcaret=: 11!:2065
glclear=: 11!:2007
glclip=: 11!:2078
glclipreset=: 11!:2079
glcmds=: 11!:2999
glcursor=: 11!:2069
glellipse=: 11!:2008
glemfopen=: 11!:2084
glemfclose=: 11!:2085
glemfplay=: 11!:2086
glfile=: 11!:2066
glfont=: 11!:2012
gllines=: 11!:2015
glnodblbuf=: 11!:2070
glpaint=: 11!:2020
glpen=: 11!:2022
glpie=: 11!:2023
glpixel=: 11!:2024
glpixelsx=: 11!:2075
glpixels=: 11!:2076
glprint=: 11!:2089
glprintmore=: 11!:2091
glpolygon=: 11!:2029
glqextent=: 11!:2057
glqextentw=: 11!:2083
glqpixels=: 11!:2077
glqprintpaper=: 11!:2092
glqprintwh=: 11!:2088
glqtextmetrics=: 11!:2058
glqwh=: 11!:2059
glqhandles=: 11!:2060
glrect=: 11!:2031
glrgb=: 11!:2032
glroundr=: 11!:2033
glsel=: 11!:2035
gltext=: 11!:2038
gltextcolor=: 11!:2040
gltextxy=: 11!:2056
glwindoworg=: 11!:2045


NB. package utilities
NB.
NB. a package is a 2-column matrix of:  name, value
NB. that can be used to store nouns, or otherwise
NB. associate names and values.
NB.
NB. A name is any character vector. pack and pdef work
NB. only when the names are proper J names.
NB.
NB. definitions for nouns only:
NB.   pk=.        pack nl         create package from namelist
NB.   nl=.        pdef pk         define package
NB.
NB. definitions for any names:
NB.   text=. pk1  pcompare pk2   compare packages
NB.   val=.  name pget pk        get value of name in package
NB.   pk=.   new  pset old       merge new and old packages
NB.   pk=.   nl   pex pk         remove namelist from package
NB.   pk=.   nl   psel pk        select namelist from package
NB.   res=.  packlocale locs     package all nouns in locales

cocurrent 'z'

NB. =========================================================
NB.*pack v package namelist
NB.
NB. form:  pack 'one two three'
NB.        pack 'one';'two';'three'
pack=: [: (, ,&< ".) &> [: /:~ ;: ::]

NB. =========================================================
NB.*packlocale v package locales
NB.
NB. form: packlocale locales
NB.
NB. example: packlocale 'base';'z';'j'
NB.
NB. each locale is packaged and forms one row of the result
packlocale=: 3 : 0
ids=. , ,each boxxopen y
res=. ''
for_i. ids do.
  cocurrent i
  res=. res,< 3 : '(, ,&< ".) &> (4!:1 [ 0) -. ;:''y y.''' ''
end.
ids,.res
)

NB. =========================================================
NB.*pdef v package define
NB. form: pdef pk
pdef=: 3 : 0
if. 0 e. $y do. empty'' return. end.
names=. {."1 y
(names)=: {:"1 y
names
)

NB. =========================================================
NB.*pcompare v compare two packages
NB. form: pk1 pcompare pk2
pcompare=: 4 : 0
n0=. {."1 x -. y
n1=. {."1 x
n2=. {."1 y
list=. ;:^:_1
r=. ''
r=. r,(*#d)#LF,'not in 1: ',list d=. n2 -. n1
r=. r,(*#d)#LF,'not in 2: ',list d=. n1 -. n2
r=. r,(*#n)#LF,'not same in both: ',list n=. n0 -. d
}.r,(0=#r)#LF,'no difference'
)

NB. =========================================================
NB.*pex v remove namelist from package
NB. form: namelist pex pk
pex=: ] -. psel

NB. =========================================================
NB.*pget v return value of name in package
NB. form: name pget pk        - return value of name in package
pget=: 13 : '> {: y {~ ({."1 y) i. {. boxopen,x'

NB. =========================================================
NB.*psel v select namelist from package
NB. form: namelist psel pk
psel=: 13 : 'y {~ ({."1 y) i. ;: ::] x'

NB. =========================================================
NB.*pset v merge new into old
NB. form: new pset old
NB. result has values in new, plus remaining values in old
pset=: (#~ [: ~: {."1) @ ,

NB. string manipulation

NB. charsub        character substitution
NB. cut            cut text, by default on blanks
NB. cuts           cut y at x (conjunction)
NB. deb            delete extra blanks
NB. debc           delete extra blank columns in matrix
NB. dlb            delete leading blanks
NB. dltb           delete leading and trailing blanks
NB. dltbs          delete multiple leading and trailing blanks
NB. dtb            delete trailing blanks
NB. dtbs           delete multiple trailing blanks
NB. delstring      delete occurrences of x from y
NB. ljust          left justify
NB. rjust          right justify
NB. rplc           replace in string
NB. ss             string search for x in y
NB.
NB. dropafter      drop after x in y
NB. dropto         drop to x in y
NB. takeafter      take after x in y
NB. taketo         take to x in y
NB.
NB. stringreplace  replace in string
NB. fstringreplace replace in file

NB. For example:
NB.
NB.   3       =  'de' # cuts _1 'abcdefg'
NB.   'abcfg' =  'de' delstring 'abcdefg'
NB.   'abcde' =  'de' dropafter 'abcdefg'
NB.   'defg'  =  'de' dropto    'abcdefg'
NB.   'fg'    =  'de' takeafter 'abcdefg'
NB.   'abc'   =  'de' taketo    'abcdefg'

cocurrent 'z'

NB. =========================================================
NB.*cuts v cut y at x (conjunction)
NB. string (verb cuts n) text
NB.   n=_1  up to but not including string
NB.   n= 1  up to and including string
NB.   n=_2  after but not including string
NB.   n= 2  after and including string
cuts=: 2 : 0
if. n=1 do. [: u (#@[ + E. i. 1:) {. ]
elseif. n=_1 do. [: u (E. i. 1:) {. ]
elseif. n= 2 do. [: u (E. i. 1:) }. ]
elseif. 1 do. [: u (#@[ + E. i. 1:) }. ]
end.
)

NB. =========================================================
NB.*cut v cut text, by default on blanks
NB.*deb v delete extra blanks
NB.*dlb v delete leading blanks
NB.*dltb v delete leading and trailing blanks
NB.*dtb v delete trailing blanks
NB.*delstring v delete occurrences of x from y
NB.*ljust v left justify
NB.*rjust v right justify
NB.*ss v string search

cut=: ' '&$: :([: -.&a: <;._2@,~)
deb=: #~ (+. 1: |. (> </\))@(' '&~:)
debc=: #~"1 [: (+. (1: |. (> </\))) ' '&(+./ .~:)
delstring=: 4 : ';(x E.r) <@((#x)&}.) ;.1 r=. x,y'
dlb=: }.~ =&' ' i. 0:
dltb=: #~ [: (+./\ *. +./\.) ' '&~:
dtb=: #~ [: +./\. ' '&~:
ljust=: (|.~ +/@(*./\)@(' '&=))"1
rjust=: (|.~ -@(+/)@(*./\.)@(' '&=))"1
ss=: I. @ E.

NB. =========================================================
NB.*dropafter v drop after x in y
NB.*dropto v drop to x in y
NB.*takeafter v take after x in y
NB.*taketo v take to x in y

dropto=: ] cuts 2
dropafter=: ] cuts 1
taketo=: ] cuts _1
takeafter=: ] cuts _2

NB. =========================================================
NB.*charsub v character substitution
NB. characterpairs charsub string
NB. For example:
NB.    '-_$ ' charsub '$123 -456 -789'
NB.  123 _456 _789
NB. Use <rplc> for arbitrary string replacement.
NB.
NB. thanks to Dan Bron/Jforum 25 April 2006
charsub=: 4 : 0
'f t'=. |: _2 ]\ x
l=. f i."1 0 y
x=. l { t,'?'
c=. l = #f
c } x ,: y
)

NB. =========================================================
NB.*dltbs v delete multiple leading and trailing blanks
NB. text is delimited by characters in x with default LF
NB. example:
NB.    < 'A' dltbs ' A abc  def  Ars  A  x y  z  '
NB. +-------------------+
NB. |Aabc  defArsAx y  z|
NB. +-------------------+
dltbs=: LF&$: : (4 : 0)
txt=. ({.x), y
a=. txt ~: ' '
b=. (a # txt) e. x
c=. b +. }. b, 1
d=. ~: /\ a #^:_1 c ~: }: 0, c
}. (a >: d) # txt
)

NB. =========================================================
NB.*dtbs v delete multiple trailing blanks in text
NB. text is delimited by characters in x with default CRLF
NB. example:
NB.    < 'A' dtbs ' A abc  def  Ars  A  x y  z  '
NB. +----------------------+
NB. |A abc  defArsA  x y  z|
NB. +----------------------+
NB.
NB. Algorithm thanks to Brian Bambrough (JForum Nov 2000)
dtbs=: 3 : 0
CRLF dtbs y
:
txt=. y , {.x
blk=. txt ~: ' '
ndx=. +/\ blk
b=. blk < }. (txt e. x), 0
msk=. blk >: ndx e. b # ndx
}: msk # txt
)

NB. =========================================================
NB.*rplc v replace characters in text string
NB.
NB. form: text rplc oldnew
NB.   oldnew is a 2-column boxed matrix of old ,. new
NB.   or a vector of same
NB.
NB. replace priority is the same order as oldnew
NB.
NB. Examples:
NB.
NB.    'ababa' rplc 'aba';'XYZT';'ba';'+'
NB. XYZT+
NB.
NB.    'ababa' rplc 'ba';'+';'aba';'XYZT'
NB. a++
rplc=: stringreplace~

NB. =========================================================
NB.*fstringreplace v file string replace
NB. form: (old;new) fstringreplace file
fstringreplace=: 4 : 0
nf=. 'no match found'
y=. boxopen y
try. size=. 1!:4 y catch. nf return. end.
if. size=0 do. nf return. end.
old=. 1!:1 y
new=. x stringreplace old
if. old -: new do. nf return. end.
new 1!:2 y
cnt=. +/ (0 pick x) E. old
(":cnt),' replacement',((1~:cnt)#'s'),' made'
)

NB. =========================================================
NB.*stringreplace v replace characters in text string
NB.
NB. form: oldnew stringreplace text
NB.   oldnew is a 2-column boxed matrix of old ,. new
NB.   or a vector of same
NB.
NB. stringreplace priority is the same order as oldnew
NB.
NB. Examples:
NB.
NB.    ('aba';'XYZT';'ba';'+') stringreplace 'ababa'
NB. XYZT+
NB.
NB.    ('ba';'+';'aba';'XYZT') stringreplace 'ababa'
NB. a++

stringreplace=: 4 : 0

txt=. ,y
t=. _2 [\ ,x
old=. {."1 t
new=. {:"1 t
oldlen=. # &> old
newlen=. # &> new

if. *./ 1 = oldlen do.
  
  hit=. (;old) i. txt
  ndx=. I. hit < #old
  
  if. 0 e. $ndx do. txt return. end.
  
  cnt=. 1
  exp=. hit { newlen,1
  hnx=. ndx { hit
  bgn=. ndx + +/\ 0, (}: hnx) { newlen - 1
  
else.
  
  
  hit=. old I. @ E. each <txt
  cnt=. # &> hit
  
  if. 0 = +/ cnt do. txt return. end.
  
  bgn=. set=. ''
  
  pick=. > @ {
  diff=. }. - }:
  
  for_i. I. 0 < cnt do.
    ln=. i pick oldlen
    cx=. (i pick hit) -. set, ,bgn -/ i.ln
    while. 0 e. b=. 1, <:/\ ln <: diff cx do. cx=. b#cx end.
    hit=. (<cx) i} hit
    bgn=. bgn, cx
    set=. set, ,cx +/ i.ln
  end.
  
  cnt=. # &> hit
  msk=. 0 < cnt
  exp=. (#txt) $ 1
  del=. newlen - oldlen
  
  if. #add=. I. msk *. del > 0 do.
    exp=. (>: (add{cnt) # add{del) (;add{hit) } exp
  end.
  
  if. #sub=. I. msk *. del < 0 do.
    sbx=. ; (;sub{hit) + each (sub{cnt) # i. each sub{del
    exp=. 0 sbx } exp
  end.
  
  hit=. ; hit
  ind=. /: (#hit) $ 1 2 3
  hnx=. (/: ind { hit) { ind    NB. hnx=. /: hit
  bgn=. (hnx { hit) + +/\ 0, }: hnx { cnt # del
  
end.

ind=. ; bgn + each hnx { cnt # i.each newlen
rep=. ; hnx { cnt # new
rep ind} exp # txt
)

NB. script_z_ '~system/packages/misc/font.ijs'
NB. script_z_ '~system/main/gl2.ijs'
NB. script_z_ '~system/main/pack.ijs'

coclass 'jzgrid'


coinsert 'jgl2'
create=: 3 : 0
if. #y do.
  locP=: boxopen y
else.
  locP=: COCREATOR
end.
EMPTY
)
destroy=: 3 : 0
try.
  glsel GRIDHWNDC
  capture 0
catch. end.
codestroy''
)
ALPHA=: a. {~ (a.i.'A') + i.26
BOXEMPTY=: <''
EMPTY=: i.0 0
BOXTYPE=: 32 
CHARTYPE=: 2 131072 
kbBS=: 8
kbLF=: 10
kbENTER=: 13
kbPUP=: 16
kbPDOWN=: 17
kbEND=: 18
kbHOME=: 19
kbLEFT=: 20
kbUP=: 21
kbRIGHT=: 22
kbDOWN=: 23
kbESC=: 27
kbINS=: 28
kbDEL=: 29
alfndx=: 3 & u:
assign=: 4 : '".x,''=:y'''
boxitem=: ,`(<"_1) @. (0=L.)
boxstrings=: ,`(<"_1) @. (2=3!:0)
citemize=: ,:^:(2 > #@$)
colorinv=: 255&-
distint=: [: (- 0 , }:) [: <. 0.5 + +/\
flips=: ]
fmt=: 8!:0
if=: ^:
index=: #@[ (| - =) i.
intersect=: e. # [
is1color=: 3 = */ @ $
isboxed=: 0 < L.
ischar=: 3!:0 e. CHARTYPE"_
isnum=: [: -. 3!:0 e. (CHARTYPE,BOXTYPE)"_
isextended=: 3!:0 e. 64 128"_
isempty=: 0 e. $
isinteger=: (-: <.) :: 0:
is1integer=: ({. -: <.) :: 0:
isscalar=: 0 = #@$
join=: ,.&.>/
lfp=: #;.1
parens=: '('"_ , ": , ')'"_
partition=: 1 , [: -. }. -:"_1 }:
rank=: #@$
reshape=: $,
rounddown=: [ * [: <. %~
roundint=: <.@:+&0.5
rots=: ]
sortfns=: /:`\: @.
stretch=: [ $ ] , ($ ,: @ {:)
takeboxed=: {. !. BOXEMPTY
tolist=: }. @ ; @: (LF&, @ , @ ": each)
tomatrix=: (_2 {. 1 1"_ , $) $ ,
tominus=: '-'&(I. @(e.&'_')@]})
towords=: ;: inverse
qextenth=: {: @ glqextent
qextentw=: {. @ glqextent
qextentwv=: glqextentw @ ; @: (,each&LF)
qextentwm=: $ $ qextentwv@,
qextentw16=: qextentw @ utf8
qextentW=: 3 : 0
glfont y
glqextent 'W'
)
amendx=: 2 : 0
:
if. m >: #y do.
  x m } (m+1) {.!.n y
else.
  x m } y
end.
)
ascii2utf8=: 3 : 0
y=. a. i. y
y=. y #~ 1 j. 127 < y
c=. y {~ ndx=. I. 127 < y
n=. 192 128 +"1 [ 0 64 #: c
a. {~ n (ndx +/ 0 1) } y
)
capture=: 3 : 0
glcapture Capture=: y
)
dimsum=: 4 : 0
s=. 1 x}$y
r=. (#$y) - x
s reshape +/"r y
)
dimtotal=: 4 : 0
r=. (#$y) - x
y ,"(r-0 1) +/"r y
)
fits=: 4 : 0
'tot wid'=. y
sum=. +/ wid
if. (0 = +/x) +. tot <: sum do. wid return. end.
scl=. (#wid) stretch x
distint wid + (tot - +/wid) * scl % +/ scl
)
fmt01=: 3 : 0
dat=. ":!.9 y
'-' (I. dat='_') } dat
)
fmtndx=: 3 : 0
if. GRIDVIRTUALMODE do.
  y
else.
  y - each (Cy-Cy);Cx-Cx
end.
)
fontscale=: 4 : 0
(roundint x*getfontsize y) setfontsize y
)
getcellfont=: 3 : 0
if. #$CellFont do.
  ((<y) { CellFont) pick CellFonts
else.
  CellFont pick CellFonts
end.
)
getindex=: 4 : 0
if. #$y do. x { y else. y end.
)
getspans=: 3 : 0
getspans1 "1 +./\ (1,}.~:}:)"1 y
)
getspans1=: 3 : 0
len=. #;.1 y
(len # I.y),:len # len
)
getalpha=: 3 : 0
<"1 (26 #. ^:_1 y) { ALPHA
)
getxywhx=: 3 : 0
0 0, _2 {. 0 ". wd 'qchildxywhx ',GRIDID
)
gpixel=: 3 : 0
glcmds ,4 2024 ,"1 y
)
gridfocus=: 3 : 0
if. -. GRIDID -: sysfocus__locP do.
  wd 'setfocus ',GRIDID
end.
)
info=: 3 : 0
wdinfo 'Grid';y
)
inint=: 4 : 0
(x >: {.y) *. x <: +/ y
)
inrect=: 4 : 0
if. 0 = # y do. 0 return. end.
'px py'=. x
'x y w h'=. |: y
1 e. (px >: x) *. (px <: x + w) *. (py >: y) *. (py <: y + h)
)
inrectx=: 4 : 0
if. 0 = #y do. 0 return. end.
'px py'=. x
'x y w h'=. |: y
1 i.~ (px >: x) *. (px <: x + w) *. (py >: y) *. (py <: y + h)
)
ispk=: 3 : 0
select. L. y
case. 0 do. 0
case. 1 do.
  if. 2 ~: {:$y do. 0 return. end.
  1 < >./ #@$ each y
case. do. 1
end.
)
makepattern=: 4 : 0
pat=. 1 1 0
step=. # pat
len=. pat i. 0
off=. - <. -: len
cnt=. >. y % step
px=. off + step * i.cnt
pr=. px + len
(x+0>.px);x+pr<.y
)
makedots=: 3 : 0
'w h'=. 0 >. y
x=. h # i.w
y=. (w*h) $ i.h
m=. 2 | x + y
(m#x),.m#y
)
readloc=: 4 : 0
nms=. y
if. 0 = L. nms do.
  nms=. ;: toupper nms
end.
nms=. nms -. <,LF
cnm=. nms ,each <'__x'
msk=. 0 = 4!:0 cnm
nms=. msk # nms
(nms)=: ". each msk#cnm
nms
)
runbegin=: 1: , }. ~: }:
setnamesx=: 3 : 0
if. L. y do.
  unpack y
else.
  locP readloc y
end.
)

setnames=: setnamesx
shrinkrect=: 4 : 0
x + , 1 _1 * +/\ _2 [\ 4 $ y
)
stretch=: [ $ ] , ($ ,: @ {:)
sumtomax=: 4 : 0
+/\ ^:_1 x <. +/\ y
)
unpack=: 3 : 0
if. 0 e. $y do. '' return. end.
y=. citemize y
nms=. toupper each {."1 y
(nms)=: {:"1 y
nms
)

leftarrow=: 3 : 0
'w h p'=. y
m=. (|.,}.) <:/~ i.p
m=. h {. (1 - p + >. -: h + 1) {. m
w {."1 (- <. -: p + w) {."1 m
)
uparrow=: 3 : 0
'w h p'=. y
|: leftarrow h,w,p
)
makearrowsLR=: 3 : 0
'whp c'=. y
c=. _2 [\ 256 #. _3[\,c
a=. (leftarrow whp) {"2 1 c
b=. |."1 a
wh=. 2{.whp
(wh,"1 ,"2 a) ; wh ,"1 ,"2 b
)
makearrowsUD=: 3 : 0
'whp c'=. y
c=. _2 [\ 256 #. _3[\,c
a=. (uparrow whp) {"2 1 c
b=. |."2 a
wh=. 2{.whp
(wh,"1 ,"2 a) ; wh ,"1 ,"2 b
)

clipfmt=: 3 : 0
if. 0 e. $y do. '' return. end.
t=. 3!:0 y
if. 2=t do.
  y=. ,y,"1 CRLF
elseif. 32<:t do.
  y=. ,&TAB @ ": &.>y
  y=. ;,&CRLF@}: &.><@;"1 y
elseif. 1 do.
  y=. ;,&CRLF @ ": &.><"1 y
  y=. '-' ((# i.@#)y='_') } y
  y=. TAB ((# i.@#)y=' ') } y
end.
y
)
clipunfmt=: 3 : 0
if. 0 e. $y do. 0 0 $ a: return. end.
(<;._2~ e.&(9 10{a.));.2 y,LF -. {:y=. toJ y
)

WDCOLORS=: <;._2 (0 : 0)
COLOR_SCROLLBAR
COLOR_BACKGROUND
COLOR_ACTIVECAPTION
COLOR_INACTIVECAPTION
COLOR_MENU
COLOR_WINDOW
COLOR_WINDOWFRAME
COLOR_MENUTEXT
COLOR_WINDOWTEXT
COLOR_CAPTIONTEXT
COLOR_ACTIVEBORDER
COLOR_INACTIVEBORDER
COLOR_APPWORKSPACE
COLOR_HIGHLIGHT
COLOR_HIGHLIGHTTEXT
COLOR_BTNFACE
COLOR_BTNSHADOW
COLOR_GRAYTEXT
COLOR_BTNTEXT
COLOR_INACTIVECAPTIONTEXT
COLOR_BTNHIGHLIGHT
COLOR_3DDKSHADOW
COLOR_3DLIGHT
COLOR_INFOTEXT
COLOR_INFOBK
)

(WDCOLORS)=: 0 ". wd 'qcolor ',"1 ": ,. i.25
3 : 0 ''
if. IFJAVA do.
  COLOR_MENU=: 255 255 255
  COLOR_MENUTEXT=: 0 0 0
  COLOR_HIGHLIGHT=: 184 207 229
  COLOR_HIGHLIGHTTEXT=: 0 0 0
  COLOR_BTNTEXT=: 0 0 0
  COLOR_BTNFACE=: 236 233 216
  COLOR_BTNSHADOW=: 172 168 153
  COLOR_BTNHIGHLIGHT=: 255 255 255
  COLOR_3DDKSHADOW=: 113 111 100
  COLOR_3DLIGHT=: 241 239 226
  COLORBACK=: 238 238 238
else.
  COLORBACK=: COLOR_BTNFACE
end.
)

BLACK=: 0 0 0
BLUE=: 0 0 255
BLUESEL=: 51 102 204
CORAL=: 255 127 80
DARKSLATEGRAY=: 47 79 79
DARKGRAY=: 169 169 169
LIGHTSEAGREEN=: 32 178 170
PALEYELLOW=: 255 255 205
RED=: 255 0 0
SILVER=: 192 192 192
WHITE=: 255 255 255

state=: 3 : 0
s=. (> , ': '"_ , 5!:5)"0
CellData=. $ CellData
CellDFmt=. $ CellDFmt
Scrollrc=. Scrollr,Scrollc
n=. 'CellData CellDFmt'
n=. n,' CELLMARK'
n=. n,' Cxyst Cxyst'
n=. n,' FmtMax Slack MaxSRows MaxSCols'
n=. n,' MaxDataRows MaxDataCols'
n=. n,' Scrollrc'
s ;: n
)
coclass 'jzgrid'

show=: 3 : 0
if. 0=#locP do. 
  locP=: COCREATOR
end.
setnames y
initevents''
drawinit''
setrxywh getxywhx''
refresh''
)
paint=: 3 : 0
xywh=. getxywhx ''
if. Rxywh -: xywh do. return. end.
inc=. 1 e. (Rw,Rh) < _2 {. xywh
setrxywh xywh
State=: State * State e. StateResize
ShowMark=: 0
showitn inc { 3 5
)
setrxywh=: 3 : 0
'Rx Ry Rw Rh'=: Rxywh=: y
)
initxywh=: 3 : 0
'Sx Sy Sw Sh'=: Sxywh=: Rxywh + Roff * 1 1 _1 _1
Gx=: Sx
Gy=: Sy
Gxy=: Gx,Gy
)
iLET=: 0
iRIGHT=: 1
iCENTER=: 2

GridZinc=: 1.1     
MaxNdx=: 1e9
Cx=: Cy=: ''
CellDP=: ''        
SortIndex=: ''     

locP=: ''          
NaN=: __           

NoShow=: 0
Roff=: 0           
'Scw Sch'=: 2 {. 0 ". wd'qm' 
Cube=: 0           
CMx=: 8            
CMy=: 6            
NewMark=: 0        
Show=: 0           
ShowMark=: 1       
Ebufmax=: 50       

Mouseup=: ''       
Mousetime=: 0      
Mousewait=: 0.2    
Mousetol=: 2       
VSlack=: 5         
Slack=: 0          

SBh=: SBv=: 0      
HdrColWid=: HdrRowWid=: '' 
HdrRowPad=: 0              
CBSize=: 13
CBDots=: 0 2 5 8 11 14 16 ,: 1 4 7 10 13 15 17
MinTh=: 50         
MinTw=: 25         
MinScrollv=: 1000  
MaxScrollr=: MaxScrollc=: 0
Scrollr=: Scrollc=: 0 

HDRFONT=: PROFONT
CELLFONTS=: PROFONT;FIXFONT
CELLFONT=: 0
j=. COLOR_BTNTEXT,COLOR_BTNFACE,COLOR_BTNSHADOW,COLOR_BTNHIGHLIGHT
GRIDBUTTONCOLOR=: j,COLOR_3DDKSHADOW,COLOR_3DLIGHT
AXISALIGN=: 0 1     
AXISNAMES=: ''      
AXISLABELS=: ''     
AXISORDER=: ''      
j=. WHITE,BLUESEL,WHITE,LIGHTSEAGREEN,WHITE,CORAL
c0=. BLACK,PALEYELLOW,j
c1=. BLACK,WHITE,j
CELLCOLORS=: c0,:c1

CELLALIGN=: 2
CELLALIGNV=: 0 
CELLCOLORDEF=: ,.0 1
CELLCOLOR=: $0
CELLDATA=: i.0 0
CELLDRAW=: i.0 0
CELLEDIT=: 1
CELLHIGH=: 0
CELLMARK=: $0 
CELLMARKER=: 1 
CELLMASK=: 0
CELLMASKCOLOR=: '' 
CELLOVERFLOW=: 0
CELLRANGE=: ''
CELLITEMS=: ''
CELLTYPE=: 0
CELLFMT=: ''
COLAUTOFIT=: 1
COLSCALE=: ''
COLWIDTH=: 0
COLRESIZE=: 0
COLMINWIDTH=: 20
COLTOTAL=: 0
GRIDBACKCOLOR=: COLORBACK
GRIDCOLOR=: SILVER,BLACK,WHITE,DARKGRAY,DARKSLATEGRAY
GRIDEXTERN=: ''        
GRIDZOOM=: 1
GRIDFLIP=: 0           
GRIDMARGIN=: 4 6 2 0  
GRIDWINDOW=: 0
GRIDID=: 'grid'
GRIDHWNDC=: ''
GRIDPID=: ''
GRIDLOC=: ''

GRIDBORDER=: 0 
GRIDLINES=: 1 1 
GRIDSBMINWIDTH=: 0 
GRIDSORT=: 0 
GRIDROWMODE=: 0
GRIDVIRTUALMODE=: 0
HDRCOLOR=: (3 4 5 { GRIDBUTTONCOLOR),BLACK
HDRCOL=: ''
HDRCOLALIGN=: 1
HDRCOLMERGE=: ''
HDRCOLTOTAL=: 'Total'
HDRROW=: ''
HDRROWALIGN=: 1
HDRROWMERGE=: ''
HDRROWTOTAL=: 'Total'
HDRTOP=: ''
HDRTOPALIGN=: 1
HDRSTYLE=: 1
LVLCOL=: ''         
LVLCOLTOP=: 0       
LVLCOLLEN=: 1       
LVLCOLID=: ''       
LVLCOLMASK=: ''     
LVLCOLSORTDIR=: 0   
LVLCOLSORTROW=: ''  
LVLROW=: ''         
LVLROWTOP=: 0       
LVLROWLEN=: 1       
LVLROWID=: ''       
LVLROWMASK=: ''     
LVLROWSORTDIR=: 0   
LVLROWSORTROW=: ''  
MENUCOLOR=: COLOR_MENUTEXT,COLOR_MENU,COLOR_HIGHLIGHTTEXT,COLOR_HIGHLIGHT
ROWAUTOFIT=: 1
ROWSCALE=: ''
ROWHEIGHT=: 0
ROWMINHEIGHT=: 10
ROWRESIZE=: 0
ROWTOTAL=: 0
OPTIONS=: <;._2 (0 : 0)
AXISALIGN
AXISLABELS
AXISNAMES
AXISORDER
CELLALIGN
CELLALIGNV
CELLCOLOR
CELLCOLORS
CELLDATA
CELLDRAW
CELLEDIT
CELLFMT
CELLFONT
CELLFONTS
CELLHIGH
CELLITEMS
CELLMARK
CELLMARKER
CELLMASK
CELLMASKCOLOR
CELLOVERFLOW
CELLRANGE
CELLTYPE
COLAUTOFIT
COLMINWIDTH
COLRESIZE
COLSCALE
COLTOTAL
COLWIDTH
GRIDBACKCOLOR
GRIDBORDER
GRIDBUTTONCOLOR
GRIDCOLOR
GRIDEXTERN
GRIDFLIP
GRIDHWNDC
GRIDID
GRIDPID
GRIDLINES
GRIDLOC
GRIDMARGIN
GRIDROWMODE
GRIDSBMINWIDTH
GRIDSORT
GRIDVIRTUALMODE
GRIDWINDOW
GRIDZOOM
HDRCOL
HDRCOLALIGN
HDRCOLMERGE
HDRCOLOR
HDRCOLTOTAL
HDRFONT
HDRROW
HDRROWALIGN
HDRROWMERGE
HDRROWTOTAL
HDRSTYLE
HDRTOP
HDRTOPALIGN
LVLCOL
LVLCOLTOP
LVLCOLLEN
LVLCOLID
LVLCOLMASK
LVLCOLSORTDIR
LVLCOLSORTROW
LVLROW
LVLROWTOP
LVLROWLEN
LVLROWID
LVLROWMASK
LVLROWSORTDIR
LVLROWSORTCOL
ROWAUTOFIT
ROWHEIGHT
ROWMINHEIGHT
ROWRESIZE
ROWSCALE
ROWTOTAL
)

initcell=: 3 : 0

'rws cls'=. rots Crws,Ccls
if. 0 = #cc=. CELLCOLOR do.
  cc=. CELLCOLORDEF
end.
if. 1 = */ $ cc do.
  CellColor=: {. cc
else.
  CellColor=: rws $ cls $"1 tomatrix cc
end.
if. 1 = */ $ CELLEDIT do.
  CellEdit=: {. CELLEDIT
else.
  CellEdit=: rws $ cls $"1 tomatrix CELLEDIT
end.
if. 1 = */ $ CELLFONT do.
  CellFont=: {. CELLFONT
else.
  CellFont=: rws $ cls $"1 tomatrix CELLFONT
end.
if. 0 -: CELLHIGH do.
  CellHigh=: 0
else.
  CellHigh=: rws $ cls $"1 tomatrix CELLHIGH
end.
if. 0 -: CELLOVERFLOW do.
  CellOverFlow=: 0
else.
  CellOverFlow=: rws $ cls $"1 tomatrix CELLOVERFLOW
end.
if. 0 -: CELLMASK do.
  CellMask=: 0
else.
  CellMask=: rws $ cls $"1 tomatrix CELLMASK
  CellMaskColor=: CELLMASKCOLOR,(0=#CELLMASKCOLOR)#{.GridBackColor
end.
if. 1 = */ $ CELLTYPE do.
  if. CELLTYPE do.
    CellType=: (rws,cls) $ CELLTYPE
  else.
    CellType=: 0
  end.
else.
  CellType=: rws $ cls $"1 tomatrix CELLTYPE
end.
if. 0 -: CellType do.
  if. 1 = */ $ CELLALIGN do.
    CellAlign=: {. CELLALIGN
  else.
    CellAlign=: rws $ cls $"1 tomatrix CELLALIGN
  end.
else.
  if. 1 = */ $ CELLALIGN do.
    if. CELLALIGN = 0 do.
      CellAlign=: 0
    else.
      CellAlign=: (-.iscombo CellType) * (rws,cls) $ CELLALIGN
    end.
  else.
    CellAlign=: (-.iscombo CellType) * rws $ cls $"1 tomatrix CELLALIGN
  end.
end.
cf=. CELLFMT
if. #cf do.
  select. 3!:0 cf
  case. 2 do.
    cf=. <;._1 ',' , cf
  case. 32 do.
    cf=. ":each cf
  end.
  select. #$cf
  case. 1 do.
    if. 1 = #cf do.
      cf=. {. cf
    else.
      cf=. cls $ cf
    end.
  case. 2 do.
    cf=. rws $ cls $"1 cf
  end.
end.
CellFmt=: cf
EMPTY
)

j=. 'mbldbl mbldown mblup mbrdbl mbrdown mbrup mmove mwheel'
EVENTS=: ;: j,' char copy paint paste undo'
initevents=: 3 : 0

if. #GRIDPID do.
  pid=. GRIDPID
else.
  fms=. <;._2;._2 wd 'qpx'
  act=. 0 ". &> 4 {"1 fms
  fms=. fms \: (act=0),.act
  ndx=. (2 {"1 fms) i. locP
  pid=. 0 pick ndx { fms
end.
if. 3=nameclass__locP <GRIDID,'_gridhandler' do.
  makehandler GRIDID,'_gridhandler__locP'
else.
  gridhandler=: 1:
end.
if. 0=#GRIDLOC do. GRIDLOC=: GRIDID end.
if. 0=#GRIDHWNDC do.
  GRIDHWNDC=: wd 'qhwndc ',GRIDID
end.
if. 0=nameclass__locP <GRIDLOC do.
  if. (coname'') -: (GRIDLOC,'__locP')~ do.
    f=. (<pid,'_',GRIDID,'_') ,each EVENTS
    m=. _1 = nameclass__locP f
    if. 1 e. m do.
      t=. (m#EVENTS) ,each <'__',GRIDLOC,LF
      t=. ;(m#f) ,each (<'=: ') ,each t
      cocurrent locP
      0!:100 t
    end.
  end.
end.
0
)
makehandler=: 3 : 0
a=. 'r=. ',y,' y',LF
a=. a,'if. 0 e. $r do. 1 else. {.,r end.'
gridhandler=: 3 : a
EMPTY
)
initextents=: 3 : 0
glfont HdrFont
HdrRowHex=: qextentwm HdrRow
HdrTopHex=: qextentwm HdrTop
HdrCellWid=: qextentwm HdrCol
SBHit=: GRIDSBMINWIDTH >. HdrHit + My 
if. #CELLITEMS do.
  r=. i.0 0
  for_f. CELLFONTS do.
    glfont >f
    r=. r,(>./ @: qextentwv) &> CELLITEMS
  end.
  CellItemsHex=: r
end.
if. #HdrRowMerge do.
  if. Cube do.
    'Hrmbgn Hrmlen'=: ARspan
  else.
    'Hrmbgn Hrmlen'=: 0 2 |: getspans HdrRowMerge { |: HdrRow
  end.
else.
  Hrmbgn=: Hrmlen=: ''
end.

gethdrcolwid''
)
gethdrcolwid=: 3 : 0
if. #HdrColMerge do.
  if. Cube do.
    'Hcmbgn Hcmlen'=: ACspan
  else.
    'Hcmbgn Hcmlen'=: 0 2 |: getspans HdrColMerge { HdrCol
  end.
  HdrColWid=: >./ (>. (HdrColMerge { HdrCellWid) % Hcmlen) HdrColMerge } HdrCellWid
else.
  Hcmbgn=: Hcmlen=: ''
  HdrColWid=: >./ HdrCellWid
end.
EMPTY
)

initflip=: 3 : 0
if. GRIDFLIP do.
  flips=: |:
  rots=: |.
  ColScale=: ROWSCALE
  ColWidth=: 0
  ColAutoFit=: ROWAUTOFIT
else.
  flips=: ]
  rots=: ]
  ColScale=: COLSCALE
  ColWidth=: COLWIDTH
  ColAutoFit=: COLAUTOFIT
end.
)
flip=: 3 : 0

GRIDFLIP=: -. GRIDFLIP
initflip''
'Scrollr Scrollc'=: Scrollc,Scrollr
if. 4 = #CELLMARK do.
  CELLMARK=: 1 0 3 2 { CELLMARK
else.
  CELLMARK=: |. CELLMARK
end.

'Crws Ccls'=: Ccls,Crws
if. GRIDVIRTUALMODE do.
  showit 4 return.
end.
if. GRIDFLIP *. COLAUTOFIT=0 do.
  showit 4 return.
end.
HdrTop=: |: HdrTop
HdrTopHex=: |: HdrTopHex
hr=. |: HdrCol
hra=. |: HdrColAlign
hrm=. HdrColMerge
hrx=. |: HdrCellWid
hrmb=. Hcmbgn
hrml=. Hcmlen
if. 0=#HdrColWid do.
  gethdrcolwid''
end.
hrw=. HdrColWid
HdrCol=: |:HdrRow
HdrColAlign=: |: HdrRowAlign
HdrColMerge=: HdrRowMerge
HdrCellWid=: |: HdrRowHex
Hcmbgn=: Hrmbgn
Hcmlen=: Hrmlen
if. 0=#HdrRowWid do.
  gethdrcolwid''
else.
  HdrColWid=: HdrRowWid
end.
HdrRow=: hr
HdrRowAlign=: hra
HdrRowMerge=: hrm
HdrRowHex=: hrx
Hrmbgn=: hrmb
Hrmlen=: hrml
HdrRowWid=: hrw
Hc=: {:$HdrRow
Hr=: #HdrCol
if. ColAutoFit do.
  getcellwid''
end.
getcellhit''
showit 1
)

initheader=: 3 : 0

HdrCol=: gethdrcol HDRCOL
HdrRow=: gethdrrow HDRROW
if. GRIDFLIP do.
  hc=. HdrCol
  HdrCol=: |: HdrRow
  HdrRow=: |: hc
  HdrColAlign=: (#HdrCol) $ Ccls $"1 tomatrix HDRROWALIGN
  HdrRowAlign=: Crws $ ({:$HdrRow) $"1 tomatrix HDRCOLALIGN
  HdrColMerge=: I. HDRROWMERGE
  HdrRowMerge=: I. HDRCOLMERGE
  if. #HDRTOP do.
    HdrTop=: ((#HdrCol),{:$HdrRow) takeboxed |: tomatrix boxopen HDRTOP
    HdrTopAlign=: (#HdrTop) $ (({:$HdrTop)) $"1 |: tomatrix HDRTOPALIGN
  else.
    HdrTop=: ''
  end.
  
else.
  HdrColAlign=: (#HdrCol) $ Ccls $"1 tomatrix HDRCOLALIGN
  HdrRowAlign=: Crws $ ({:$HdrRow) $"1 tomatrix HDRROWALIGN
  HdrColMerge=: I. HDRCOLMERGE
  HdrRowMerge=: I. HDRROWMERGE
  if. #HDRTOP do.
    HdrTop=: ((#HdrCol),{:$HdrRow) takeboxed tomatrix boxopen HDRTOP
    HdrTopAlign=: (#HdrTop) $ (({:$HdrTop)) $"1 tomatrix HDRTOPALIGN
  else.
    HdrTop=: ''
  end.
end.

if. Cube do.
  HdrRowMerge=: }: i.#0 pick AXISORDER
  HdrColMerge=: }: i.#1 pick AXISORDER
end.
Hc=: {:$HdrRow
Hr=: #HdrCol
)
gethdrcol=: 3 : 0
hc=. y
if. GRIDVIRTUALMODE do.
  len=. >: Cs - Cx
else.
  len=. >: Cs - Cx
end.
if. 0 = #hc do.
  i.0,len
elseif. 1 = */$hc do.
  ndx=. Cx + i. len
  if. isinteger hc do.
    ,: ": each ({.hc) + ndx
  elseif. 'A' = hc do.
    ,: getalpha ndx
  elseif. do.
    (1,len) $ ,boxopen hc
  end.
elseif. do.
  len {."1 tomatrix boxxopen hc
end.
)
gethdrrow=: 3 : 0
hr=. y
if. GRIDVIRTUALMODE do.
  len=. >: Ct - Cy
else.
  len=. >: Ct - Cy
end.
if. 0 = #hr do.
  hr=. i.len, 0
elseif. 1 = */$hr do.
  ndx=. Cy + i. len
  if. isinteger hr do.
    ,. ": each ({.hr) + ndx
  elseif. 'A' = hr do.
    ,. getalpha ndx
  elseif. do.
    (len,1) $ ,boxopen hr
  end.
  if. #SortIndex do.
    SortIndex { hr
  end.
elseif. do.
  len {. ,. boxxopen hr
end.
)


initmisc=: 3 : 0

if. 0=#GRIDEXTERN do.
  drawextern=: ]
else.
  drawextern=: GRIDEXTERN~
end.
Cube=: 0 < #AXISNAMES
Hier=: 0 < (#LVLCOL) + #LVLROW
gw=. 4 {. GRIDWINDOW
Roff=: GridWindow=: gw + 0 0,2{.gw
if. GRIDVIRTUALMODE do.
  Slack=: VSlack
  GridSort=: 0
else.
  Slack=: 0
  if. Cube do.
    GridSort=: (#$CELLDATA) $ GRIDSORT
  else.
    GridSort=: 2$GRIDSORT
  end.
end.
ButtonColor=: 6 3 $ GRIDBUTTONCOLOR
GridBackColor=: 2 3 $ GRIDBACKCOLOR
GridColor=: 5 3 $ GRIDCOLOR
MenuColor=: 4 3 $ MENUCOLOR
ColResize=: COLRESIZE *. COLAUTOFIT=0
a=. _6 [\ ,24 $"1 CELLCOLORS
CellColorFore=: 3 {."1 a
CellColorBack=: 3 }."1 a
if. 6=$HDRCOLOR do.
  HdrColor=: _3 [\ HDRCOLOR,(colorinv HDRCOLOR), HDRCOLOR
else.
  HdrColor=: 6 3 $ HDRCOLOR
end.

OffColor=: 0 { HdrColor
OnColor=: <. 4 %~ +/ 3 1 * 1 2 { ButtonColor
GridLines=: 2 $ GRIDLINES
CellFonts=: CELLFONTS

ColWidth=: COLWIDTH  
RowHeight=: ROWHEIGHT
HdrFont=: HDRFONT
glfont HdrFont
HdrHit=: qextenth 'X'
'Mx Mw My Mh'=: GRIDMARGIN
Mx2=: +:Mx
My2=: +:My
'w h'=. <./ qextentW &> CellFonts
MinW=: w + Mw + Mx2
MinH=: h + My2
)
initrange=: 3 : 0
if. -. GRIDVIRTUALMODE do. return. end.
if. #CELLRANGE do.
  Txyst=: 0 0,2 {. CELLRANGE <. MaxNdx
else.
  Txyst=: 0 0, 2 # MaxNdx
end.
'Tx Ty Ts Tt'=: Txyst
'Cx Cy Cs Ct'=: Cxyst=: Txyst
Twh=: 1 + (Ts - Tx),Tt - Ty
)

showit=: 3 : 0
showitn y
glpaint''
)
showitn=: 3 : 0
select. Show >. {. y,0
  
fcase. 5 do.
  initmisc''
  inithier''
  initflip''
  initzoom''
  initrange''
  initcube''
  
fcase. 4 do.
  if. GRIDVIRTUALMODE do.
    getdata'' return.
  end.
  
fcase. 3 do.
  initxywh ''
  initaxes''
  initdata''
  initcell''
  initheader''
  initextents''
  
fcase. 2 do.
  getfmt ''
  getextent''
  
fcase. 1 do.
  initsizes''
end.

Show=: 0
if. ShowMark do.
  if. showmark'' do. return. end.
else.
  if. showscroll'' do. return. end.
end.
ShowMark=: 1
if. NoShow do.
  NoShow=: 0 return.
end.
drawgrid''
if. NewMark do.
  mark ''
  NewMark=: 0
end.

1
)
showitempty=: 3 : 0
Crws=: Ccls=: 0
Hc=: Hr=: Hx=: Hy=: Hw=: Hh=: 0
VSxywh=: HSxywh=: Gxywh=: 0 0 0 0
Vcx=: Vcy=: 0
drawinit''
glpaint''
)
refresh=: showit bind 5

initsizes=: 3 : 0

RowHeights=: ((Hr$HdrHit), Crws$CellHit) + My2
if. ColAutoFit do.
  wid=. (>./HdrTopHex,HdrRowHex+HdrRowPad), HdrColWid >. CellWid
  wid=. ColWidth >. wid + Mw + Mx2
else.
  wid=. (Hc + Ccls) $ ColWidth
end.
colwid=. ColMinWidth >. wid
Hw=: +/ Hcw=: Hc {. colwid
Hh=: +/ Hrh=: Hr {. RowHeights
Hx=: }: +/\ Gx, Hcw
Hy=: }: +/\ Gy, Hrh
Hwh=: Hw,Hh
datacolwid=. Hc }. colwid
if. GRIDVIRTUALMODE do.
  sv=. Trws > Crws
  sh=. Tcls > Ccls
else.
  sv=. sh=. 0
end.
if. sv +. Sh <: +/ RowHeights do.
  SBv=: 1
  if. #ColScale do.
    ColWidths=: Hcw,ColScale fits (Sw-1+Hw+SBHit);datacolwid
  else.
    ColWidths=: colwid
  end.
  SBh=: sh +. Sw <: SBHit + +/ ColWidths
  
else.
  if. #ColScale do.
    ColWidths=: Hcw,ColScale fits (Sw-1+Hw);datacolwid
  else.
    ColWidths=: colwid
  end.
  if. sh +. Sw <: +/ ColWidths do.
    SBh=: 1
    SBv=: sv +. Sh <: SBHit + +/ RowHeights
    if. SBv *. #ColScale do.
      ColWidths=: Hcw,ColScale fits (Sw-1+Hw+SBHit);datacolwid
    end.
  else.
    SBv=: SBh=: 0
  end.
end.
Gw=: Sw - SBv * SBHit
Gh=: Sh - SBh * SBHit
Gxywh=: Gx,Gy,Gw,Gh

ch=. 0 >. Gh - Hh
cw=. 0 >. Gw - Hw

Dw=: Hc }. ColWidths
Dh=: Hr }. RowHeights

MaxDataRows=: >. ch % <./ Dh
MaxDataCols=: >. cw % <./ Dw
mr=. (ch >: +/\. Dh ) i. 1
mc=. (cw >: +/\. Dw ) i. 1

if. GRIDVIRTUALMODE do.
  if. Trws < MaxNdx do.
    MaxScrollr=: Trws + mr - #Dh
  else.
    MaxScrollr=: MaxScrollr >. MinScrollv >. +: Scrollr
  end.
  if. Tcls < MaxNdx do.
    MaxScrollc=: Tcls + mc - #Dw
  else.
    MaxScrollc=: MaxScrollc >. MinScrollv >. +: Scrollc
  end.
else.
  MaxScrollr=: mr
  MaxScrollc=: mc
end.
ScrollrInc=: 1 >. <. MaxScrollr % 100
ScrollcInc=: 1 >. <. MaxScrollc % 100
Scrollr=: Scrollr <. MaxScrollr
Scrollc=: Scrollc <. MaxScrollc
)


j=. <;._2 (0 : 0)
Normal normal
Edit edit
Select select
HSlider horizontal slider
VSlider vertical slider
CResize column resize
RResize row resize
Check checkbox clicked
Combo combobox clicked
ACombo axis combobox clicked
XCombo external combobox clicked
AMove axis move
)

('i' ,each (j i.&> ' ') {.each j)=: i.#j
iCombos=: iCombo;iACombo;iXCombo

State=: 0
StateResize=: iEdit,iSelect,iCheck,;iCombos
StateRowMark=: iNormal,iCheck,iCombo
redo=: 3 : 0
if. State = iEdit do.
  editredo''
end.
)
undo=: 3 : 0
if. State = iEdit do.
  editundo''
end.
)

initzoom=: 3 : 0
if. GRIDZOOM ~: 1 do.
  HdrFont=: GRIDZOOM fontscale HdrFont
  CellFonts=: GRIDZOOM fontscale each CellFonts
  Mx=: roundint GRIDZOOM * Mx
  My=: roundint GRIDZOOM * My
  Mw=: roundint GRIDZOOM * Mw
  ColWidth=: roundint GRIDZOOM * ColWidth
  RowHeight=: roundint GRIDZOOM * RowHeight
end.
ColMinWidth=: MinW >. roundint GRIDZOOM * COLMINWIDTH
RowMinHeight=: MinH >. roundint GRIDZOOM * ROWMINHEIGHT
MaxSCols=: >. Scw % ColMinWidth
MaxSRows=: >. Sch % RowMinHeight
)
zoomin=: 3 : 0
GRIDZOOM=: GRIDZOOM * GridZinc
refresh''
)
zoomout=: 3 : 0
GRIDZOOM=: GRIDZOOM % GridZinc
refresh''
)
zoomrestore=: 3 : 0
GRIDZOOM=: 1
refresh''
)
coclass 'jzgrid'

char=: 3 : 0
select. State
case. iEdit do.
  if. editchar '' do. return. end.
case. iCombo do.
  if. bcchar '' do. return. end.
case. iACombo do. return.
end.
State=: 0
m=. 0 ". sysmodifiers__locP
key sysdata__locP;(m e. 2 3);m e. 1 3
)
keyx=: 3 : 0

d=. alfndx {. Char
m=. Shift + +: Ctrl
if. d > 32 do.
  if. #CELLMARK do.
    pos=. rots 2 {. CELLMARK
    if. iseditable pos do.
      CELLMARK=: 2 {. CELLMARK
      edit 1;Char;pos
    end.
  end.
  return.
end.
select. d
  
case. kbENTER do.
  movenext''
  
case. 32 do.
  movexall m
  
case. kbLEFT ; kbUP ; kbRIGHT ; kbDOWN do.
  d=. ((kbLEFT,kbUP,kbRIGHT,kbDOWN) i. d) { 0 _1, _1 0, 0 1,: 1 0
  select. m
  case. 0 do.
    moveby d
  case. 1 do.
    movexby d
  case. 2 do.
    moveedge d
  case. 3 do.
  end.
  
case. kbPUP ; kbPDOWN do.
  select. m
  case. 0 do.
    moveby 0 ,~ Srws * (d=kbPDOWN) { _1 1
  case. 2 do.
    moveby 0 , Scls * (d=kbPDOWN) { _1 1
  end.
  
case. kbEND do.
  select. m
  case. 0 do.
    if. _ > Ccls do.
      moveto ({.CELLMARK), <: Ccls
    end.
  case. 2 do.
    if. _ > Crws + Ccls do.
      moveto <: Crws,Ccls
    end.
  end.
  
case. kbHOME do.
  select. m
  case. 0 do.
    moveto ({.CELLMARK), 0
  case. 2 do.
    moveto 0 0
  end.
  
case. kbDEL do.
  if. m e. 0 2 do.
    delete''
  end.
  
end.

showit''
)
cut=: ]
copy=: 3 : 0
a=. readmark''
select. #a
case. 2 do.
  t=. readfmt a
case. 4 do.
  'b e'=. _2 [\ a
  xy=. b <. e
  t=. readfmt xy (+ i.) each 1 + (b >. e) - xy
case. do.
  t=. ''
end.
wdclipwrite clipfmt flips t
)


delete=: 3 : 0
a=. readmark''

select. #a
case. 0 do.
  return.
case. 2 do.
  xy=. a
  wh=. 1 1
case. 4 do.
  'b e'=. _2 [\ a
  xy=. b <. e
  wh=. 1 + (b >. e) - xy
end.
old=. readblock xy,wh
typ=. readblocktype xy,wh
dat=. getdelete old;typ
dat change xy
refresh''
)
getdelete=: 3 : 0

'old typ'=. y

shp=. $old
if. isnum old do.
  shp $ 0 return.
end.
typ=. ,typ
old=. boxxopen ,old
num=. isnum &> old
new=. ($old) $ <''
ndx=. I. num *. typ = 0
new=. (<0) ndx } new

ndx=. I. typ e. 100 101
new=. (<0) ndx } new

ndx=. I. (typ>:200) *. typ<300  
new=. (ndx { old) ndx } new

shp $ new
)

paste=: 3 : 0
new=. clipunfmt wdclipread''
a=. readmark''
select. #a
case. 0 do.
  return.
case. 2 do.
  xy=. a
  wh=. ($new) <. (Crws,Ccls) - xy
  new=. wh {. new
case. 4 do.
  'b e'=. _2 [\ a
  xy=. b <. e
  wh=. 1 + (b >. e) - xy
  if. -. *./ (wh = $new) +. wh = 1 do.
    info 'Clipboard does not match selected area' return.
  end.
  new=. ({.wh) $ ({:wh) $"1 new
end.
old=. readblock xy,wh
typ=. readblocktype xy,wh
'rc dat'=. validate old;new;typ
if. rc do. return. end.
dat change xy
refresh''
)

f=. [: NaN&". e.&'-_.0123456789' # ]
valfix=: ]`f @. (2:=3!:0) f.
validate=: 3 : 0

'old new typ'=. y

shp=. $new
if. isnum old do.
  if. isnum new do.
    0;new
  else.
    val=. ,valfix &> boxxopen new
    if. rc=. NaN e. val do.
      info 'Not numeric: ',": (val i. NaN) pick new
    end.
    rc;<shp$val
  end.
  return.
end.
typ=. ,typ
old=. boxxopen ,old
new=. boxxopen ,new
if. #ndx=. I. typ=0 do.
  if. #ind=. ndx #~ isnum &> ndx { old do.
    val=. valfix &> ind { new
    if. NaN e. val do.
      info 'Not numeric: ',": ((val i. NaN){ind) pick new
      1;'' return.
    end.
    new=. (<&> val) ind } new
  end.
end.
if. #ndx=. I. typ e. 100 101 do.
  val=. valfix &> ndx { new
  if. 0 e. val e. 0 1 do.
    info 'Not boolean: ',": (((val e. 0 1) i. 0){ndx) pick new
    1;'' return.
  end.
  new=. (<&> val) ndx } new
end.
if. #ndx=. I. (typ>:200) *. typ<300 do.
  val=. ndx { new
  msk=. (typ-200) } val&e. &> CELLITEMS
  if. 0 e. msk do.
    info 'Not in selection: ',": ((msk i. 0){ndx) pick new
    1;'' return.
  end.
end.
if. #ndx=. I. (typ>:300) *. typ<400 do.
  dtp=. (typ-300) { 3!:0 &> CELLITEMS
  msk=. dtp = 3!:0 &> ndx { new
  if. 0 e. msk do.
    info 'Incorrect type: ',": ((msk i. 0){ndx) pick new
    1;'' return.
  end.
end.
0;<shp $ new
)
coclass 'jzgrid'


BCx=: 4  
BCy=: 1  
bcinit=: 3 : 0

if. 0 -: CellType do. 0 return. end.
Bcell=: y
Btype=: (<Bcell) { CellType
Bfont=: getcellfont y
if. -. iscombo Btype do. 0 return. end.
State=: iCombo

Bcap=: 0
Bmove=: 0
Blist=: (100|Btype) pick CELLITEMS
Blen=: #Blist

'row col'=. (rots Bcell) - Scrollr,Scrollc
txt=. readcell Bcell
Bpos=: Blist i. <txt

glfont Bfont
hit=. qextenth 'X'
wid=. >./ qextentwv Blist
Bhext=: hit

wid=. wid + +: BCx
bit=. (Blen * hit) + 1 + +: BCy
'x y w h'=. (Hw+col{Vcx),(Hh+row{Vcy),1+(col{Vcw),row{Vch
wid=. w >. wid
Bhit=: h - 2 
x=. Hw >. x - 0 >. wid + x - Sw
w=. wid <. Sw - x
below=. Sh - y + h - 1

if. below >: bit do.
  y=. y + h - 1
  bh=. bit
  Brws=: Blen
else.
  above=. y - Hh
  if. above >: bit do.
    y=. y - bit
    bh=. bit
    Brws=: Blen
  else.
    max=. above >. below
    Brws=: <. (max - +: BCy) % hit
    bh=. (Brws * hit) + 1 + +: BCy
    if. above > below do.
      y=. y - bh
    else.
      y=. y + h - 1
    end.
  end.
end.

'Bx By Bw Bh'=: Bxywh=: x,y,w,bh
Bxy=: (x + BCx),.(y + BCy) + hit * i.Brws
Bcap=: Bpos <. Blen - Brws
showit''
bcshow 0
)
bcinitaxis=: 3 : 0
sel=. y
State=: iACombo
rect=. sel { ATrect
Bdim=: sel { 2 pick AXISORDER
pos=. cubegetindex Bdim
list=. Bdim pick AXISLABELS
bcinitrest list;pos;rect
)


BCx=: 4  
BCy=: 1  
bcinitextern=: 3 : 0
State=: iXCombo
'list pos rect verb'=. y
bcxcombo=: verb~
bcinitrest list;pos;rect
)
bcinitrest=: 3 : 0
'Blist Bpos Brect'=: y

Bfont=: HdrFont
Blen=: #Blist
Bcap=: 0
Bmove=: 0

glfont Bfont
hit=. qextenth 'X'
wid=. >./ qextentwv Blist
Bhext=: hit
wid=. wid + +: BCx
bit=. (Blen * hit) + 1 + +: BCy
'x y w h'=. Brect
wid=. w >. wid
Bhit=: h - 2 
x=. 0 >. x - 0 >. wid + x - Sw
w=. wid <. Sw - x
below=. Sh - y + h - 1

if. below >: bit do.
  y=. y + h - 1
  bh=. bit
  Brws=: Blen
else.
  above=. y
  if. above >: bit do.
    y=. y - bit
    bh=. bit
    Brws=: Blen
  else.
    Brws=: <. (below - +: BCy) % hit
    bh=. (Brws * hit) + 1 + +: BCy
    y=. y + h - 1
  end.
end.

'Bx By Bw Bh'=: Bxywh=: x,y,w,bh
Bxy=: (x + BCx),.(y + BCy) + hit * i.Brws
Bcap=: Bpos <. Blen - Brws
showit''
bcshow 0
)

bcchar=: 3 : 0

d=. alfndx {. sysdata__locP
select. d
  
case. kbENTER do.
  bcfini 1 return.
case. kbESC do.
  bcfini 0 return.
end.

bcshow 1

0
)

bcfini=: 3 : 0
old=. State
State=: 0
Show=: 0
if. y do.
  select. old
  case. iCombo do.
    Show=: 2
    txt=. <Bpos pick Blist
    txt change Bcell
  case. iACombo do.
    Show=: 5
    cubeputindex Bdim,Bpos
  case. iXCombo do.
    bcxcombo Bpos return.
  end.
end.
showit''
y
)


bcmouse=: 3 : 0
2 {. 0 ". sysdata__locP
)
bcmbldown=: 3 : 0
pos=. bcmouse ''
if. pos inrect BSxywh do.
  Bmove=: 1
  Pos=: (1{BSSxywh), {: pos
elseif. pos inrect Bxywh do.
  Bmove=: 0
  Bpos=: Bcap + bcrow {:pos
  bcfini 1
elseif. do.
  bcfini 0
end.
)
bcmblup=: 3 : 0
Bmove=: 0
)
bcrow=: 3 : 0
y=. y - By + BCy + 1
0 >. (<:Brws) <. <. y % Bhext
)
bcmmove=: 3 : 0
pos=. bcmouse ''
if. Bmove do.
  new=. ({.Pos) + {: pos - Pos
  'mx my mw mh'=. 1 { BSBxywh
  'sx sy sw sh'=. BSSxywh
  sy=. my >. (my+mh-sh) <. new
  BSSxywh=: sx,sy,sw,sh
  Bcap=: <. 0.5 + (Blen - Brws) * (sy - my) % mh-sh
  bcshow 1
elseif. (pos inrect Bxywh) > pos inrect BSxywh do.
  bp=. Bcap + bcrow {:pos
  if. Bpos ~: bp do.
    Bpos=: bp
    bcshow 1
  end.
end.
)

bcinitscroll=: 3 : 0
if. Brws = Blen do.
  BSxywh=: ''
  BCs=: 0 return.
end.

BCs=: Bhit
x=. Bx + Bw - BCs
y=. By + 1
r=. Bx + Bw - 2
w=. r - x
h=. Bh

hit=. BCs
BSxywh=: x,y,w,h
'BSx BSy BSw BSh'=: BSxywh

top=. x,y,w,BCs
mid=. x,(y+BCs+1),w,h-5++:BCs
bot=. x,(y+h-BCs+3),w,BCs
BSBxywh=: top,mid,:bot
glbrush glrgb 1 { ButtonColor
glpen 1 0 [ glrgb 3 { ButtonColor
glrect x,y,(BCs-1),h-2
glbrush glrgb 3 { ButtonColor
glpen 1 0
glrect (x+1),(y+hit+1),(hit-2),h-4++:hit
glpen 1 0 [ glrgb 1 { ButtonColor
glpixel (x,y+hit+1) +"1 makedots (hit-1),h-4++:hit
glpen 1 0 [ glrgb 4 { ButtonColor
gllines (x-1),y,(x-1),By + h - 1
gllines r,y,r,By + h - 1
gllines x,(y+hit),r,(By+1+hit)
gllines x,(y+h - hit + 4),r,(y+h - hit + 4)
gllines x,(y+h-3),r,(y+h-3)
w=. <. 0.25 * _2 + hit
x=. <: x + >.-: hit - +:w
y=. By + 1 + <. -: hit - w
glbrush glrgb 0 { ButtonColor
glpen 1 0
glpolygon x,(y+w),(x+w),y,(x++:w),y+w
y=. y + h - BCs + 1
glpolygon x,y,(x+w),(y+w),(x++:w),y
)
bcsetscroll=: 3 : 0
'x y w h'=. 1 { BSBxywh
hit=. BCs >. <. h * Brws % Blen
top=. (h - hit) * Bcap % Blen - Brws
BSSxywh=: x,(y+top),w,hit
)
bcshowscroll=: 3 : 0

'x y w h'=. BSSxywh
x1=. x+1
r=. x + w
s=. y + h

glpen 1 0 [ glbrush glrgb 1 { ButtonColor
glrect BSSxywh

glpen 1 0 [ glrgb 3 { ButtonColor
gllines x1,(y+1),x1,s-1
gllines x1,(y+1),(r-1),y+1

glpen 1 0 [ glrgb 2 { ButtonColor
gllines (r-1),(y+1),(r-1),s
gllines x1,(s-1),r,s-1

glpen 1 0 [ glrgb 4 { ButtonColor
gllines x,s,r,s

)

bcshow=: 3 : 0
redraw=. y

glbrush glrgb 1 { MenuColor
glpen 1 0 [ glrgb 0 0 0
glrect Bxywh
bcinitscroll''
glfont Bfont
glrgb 0 { MenuColor
glpen 1 0
gltextcolor ''

txt=. > (Bcap + i. Brws) { Blist
txt (gltext@[ gltextxy)"1 Bxy
ndx=. Bpos - Bcap
if. (ndx >: 0) *. ndx < Brws do.
  'x y'=. ndx { Bxy
  glbrush glrgb 3 { MenuColor
  glpen 1 0
  glrect (x+1-BCx),y,(Bw - BCs + 2),Bhit-2
  glrgb 2 { MenuColor
  gltextcolor''
  gltextxy ndx { Bxy
  gltext ndx { txt
end.
if. Brws < Blen do.
  if. redraw=0 do.
    bcsetscroll''
  end.
  bcshowscroll''
end.

glpaint''
)
coclass 'jzgrid'

initdatax=: 3 : 0
if. Cube do.
  cubegetmatrix ''
  'rws cls'=. $CellData
elseif. Hier do.
  hiergetdata''
'rws cls'=. $CellData
elseif. do.
  s=. $CELLDATA
  if. 1 = #s do.
    cls=. s
    if. L. CELLDATA do.
      CELLDATA=: ,. each boxstrings each CELLDATA
      rws=. # 0 pick CELLDATA
    elseif. 0 = cls do.
      CELLDATA=: i.0 0
      rws=. 0
    elseif. do.
      CELLDATA=: tomatrix CELLDATA
      rws=. 1
    end.
  else.
    'rws cls'=. s
  end.
  CellData=: CELLDATA
end.

Cshape=: $CellData
'Crws Ccls'=: rots rws,cls
if. GRIDVIRTUALMODE do.
  Ct=: Cy + rws - 1
  Cs=: Cx + cls - 1
  Cxyst=: Cx,Cy,Cs,Ct
  'Tcls Trws'=: rots Twh
else.
  'Cx Cy Cs Ct'=: Cxyst=: 0 0,<:cls,rws
  'Tx Ty Ts Tt'=: Txyst=: Cxyst
  Tcls=: Ccls
  Trws=: Crws
end.
if. #CELLMARK do.
  CELLMARK=: CELLMARK <. (#CELLMARK) $ <:Trws,Tcls
end.

0
)
initdata=: initdatax
changex=: 3 : 0
Value writeblock Cell
)

getextent=: 3 : 0

if. (#CellDFmtM) +. #$CellFont do.
  dat=. ,CellDFmt
  cft=. ($dat) $ ,CellFont
  wid=. hit=. ($dat) $ 0
  
  for_c. ~.cft do.
    glfont c pick CellFonts
    ndx=. I. c=cft
    wid=. (qextentwv ndx { dat) ndx } wid
    hit=. (qextenth 'X') ndx } hit
  end.
  
  if. #CellDFmtM do.
    CellHexM=: (#CellDFmtM) $ <''
    cfx=. CellDFmtM { cft
    for_c. ~.cfx do.
      glfont c pick CellFonts
      ndx=. I. c=cfx
      sel=. ndx { CellDFmtL
      wdx=. glqextentw each sel
      CellHexM=: wdx ndx } CellHexM
      wdx=. >./ &> wdx
      wid=. wdx (ndx{CellDFmtM) } wid
      htx=. (qextenth 'X') * +/ &> LF =each sel
      hit=. htx (ndx{CellDFmtM) } hit
    end.
  else.
    CellHexM=: ''
  end.
  
  wid=. Fshape$wid
  hit=. Fshape$hit
  CellVex=: hit
  getcellhit''
else.
  glfont CellFont pick CellFonts
  wid=. qextentwm CellDFmt
  CellHit=: CellVex=: qextenth 'X'
end.
if. -. 0 -: CellType do.
  msk=. iscombo CellType
  if. 1 (e.,) msk do.
      min=. msk * (msk * 100|CellType) { CellHit + CellFont { CellItemsHex
      wid=. wid >. min
  end.
end.
CellHex=: wid
getcellwid''
)
getcellhit=: 3 : 0
if. GRIDFLIP do.
  CellHit=: >./ CellVex
else.
  CellHit=: >./"1 CellVex
end.
)
getcellwid=: 3 : 0
if. GRIDFLIP do.
  CellWid=: >./"1 CellHex
else.
  if. 0 < #$CellOverFlow do.
    CellWid=: >./ CellHex * -. CellOverFlow
  else.
    CellWid=: >./ CellHex
  end.
end.
)

getdata=: 3 : 0
w=. >: Ts - Cx
h=. >: Tt - Cy
mrws=. MinTh >. (+:MaxSRows) >. MaxSRows + +:Slack
mcls=. MinTw >. (+:MaxSCols) >. MaxSCols + +:Slack
if. GRIDFLIP do. 'mrws mcls'=. mcls,mrws end.
rws=. Cy + i. mrws <. h
cls=. Cx + i. mcls <. w
get rws;cls
1
)
set=: 3 : 0
setnames y
showit 3
)

getx=: set

readcell=: 3 : '0 pick ,readblock y,1 1'
readblock=: 3 : 0
'row col rws cls'=. y
row=. row - Cy
col=. col - Cx
if. (1=#Cshape) *. L. CellData do.
  (<row+i.rws) {each (col+i.cls) { CellData
else.
  (<(row+i.rws);col+i.cls) { CellData
end.
)
readblocktype=: 3 : 0
'row col rws cls'=. y
if. CellType -: 0 do.
  (rws,cls) $ 0
else.
  row=. row - Cy
  col=. col - Cx
  (<(row+i.rws);col+i.cls) { CellType
end.
)
readedit=: 3 : 0
txt=. readcell y
if. ischar txt do.
  if. 1 < #$txt do.
    flatn txt
  end.
else.
  fmt01 txt
end.
)
readfmt=: 3 : 0
(<fmtndx y) { CellDFmt
)


ischeck=: 3 : 0
y e. 100 101
)
iscombo=: 3 : 0
(200 <: y) *. y <: 399
)
iscombolist=: 3 : 0
(200 <: y) *. y <: 299
)
iscombodrop=: 3 : 0
(300 <: y) *. y <: 399
)

writecell=: 4 : 0
if. Cube do. x writecube y return. end.
'row col'=. y - Cy,Cx
ndx=. <row;col
new=. x
if. L. CELLDATA do.
  if. 1=#Cshape do.
    dat=. col pick CELLDATA
    if. L. dat do.
      dat=. (boxopen new) row } dat
    else.
      dat=. new row } dat
    end.
    CELLDATA=: (<dat) col } CELLDATA
  else.
    CELLDATA=: (boxopen new) (<row,col) } CELLDATA
  end.
else.
  CELLDATA=: new (<row,col) } CELLDATA
end.
CellData=: CELLDATA
EMPTY
)
writeblock=: 4 : 0
if. Cube do. x writecube y return. end.
'row col'=. y - Cy,Cx
new=. x
if. ischar new do. new=. <new end.
new=. tomatrix new
rwx=. row + i.#new
clx=. col + i.{:$new
if. (1=#$new) *. L.new do.
  if. 1=#Cshape do.
    new writecol each rwx&; each clx return.
  elseif. L.CELLDATA do.
    new=. |: boxitem &> new
  elseif. do.
    new=. |: > new
  end.
else.
  select. 1 = (L.CELLDATA),L.new
  case. 0 1 do.
    new=. > new
  case. 1 0 do.
    new=. <&> new
  end.
end.
ndx=. <rwx;clx
CELLDATA=: new ndx } CELLDATA
CellData=: CELLDATA
EMPTY
)
writecol=: 4 : 0
new=. x
'rwx col'=. y
dat=. col pick CELLDATA
if. L. dat do.
  dat=. (boxopen new) rwx } dat
else.
  dat=. new rwx } dat
end.
CELLDATA=: (<dat) col } CELLDATA
EMPTY
)
writecube=: 4 : 0
new=. tomatrix x
'row col'=. y - Cy,Cx
rwx=. row + i.#new
clx=. col + i.{:$new
ndx=. <rwx;clx
CellData=: new ndx } CellData
cubesetmatrix''
)
coclass 'jzgrid'

drawarrow=: 4 : 0
's px py'=. y
if. s do.
  addhover px,py,2{x
  glpixels px,py,s{x
else.
  p=. px,py,s{x
  subhover 4 {. p
  glpixels p
end.
)
drawleftarrow=: 3 : 'LeftArrow drawarrow y'
drawrightarrow=: 3 : 'RightArrow drawarrow y'
drawuparrow=: 3 : 'UpArrow drawarrow y'
drawdownarrow=: 3 : 'DownArrow drawarrow y'
drawatt=: 3 : 0

if. # $ CellAlign do.
  Valn=: , flips Vrndx { CellAlign
else.
  Valn=: CellAlign
end.
if. (GRIDFLIP=0) *. 0 < # $ CellOverFlow do.
  Vcof=: flips Vrndx { CellOverFlow
else.
  Vcof=: 0
end.
if. #$CellFont do.
  Vfnt=: , flips Vrndx { CellFont
else.
  Vfnt=: CellFont
end.
if. 0 -: CellMask do.
  Vmsk=: 0
else.
  Vmsk=: , flips Vrndx { CellMask
end.
if. 0 -: CellType do.
  Vtyp=: 0
else.
  if. # $ CellType do.
    Vtyp=: , flips Vrndx { CellType
  else.
    Vtyp=: Vlen $ CellType
  end.
end.
ndx=. < rots Cyndx;Cxndx
Vdat=: , flips ndx { CellDFmt
Vhex=: , flips ndx { CellHex
if. #$ CellVex do.
  Vvex=: , flips ndx { CellVex
else.
  Vvex=: CellVex
end.
if. #CellDFmtM do.
  'r c'=. >ndx
  ndx=. , flips (r*{:Fshape)+/c
  msk=. CellDFmtM e. ndx
  Vfm=: ndx i. msk # CellDFmtM
  Vhm=: msk # CellHexM
  Vfl=: msk # CellDFmtL
else.
  Vfm=: ''
end.
EMPTY

)


drawbackground=: 3 : 0

glbrush glrgb 1 { GridBackColor
if. GRIDBORDER do.
  glrgb 1 { GridColor
  glpen 1 0
else.
  glpen 0 0
end.
glrect Sxywh

if. SBv +: SBh do. return. end.
if. SBh do.
  if. SBv do.
    h=. Sh
  else.
    h=. Vh
  end.
  w=. Sw
else.
  h=. Sh
  w=. Vw
end.
glbrush glrgb 0 { GridBackColor
glpen 0 0
glrect Gx,Gy,w,h

)
drawcellback=: 3 : 0

clr=. Vclr { CellColorBack
rec=. _1 _1 2 2 +"1 Vrect
r=. 6 2078 ,"1 rec
Gclr=: 5 2032 ,"1 clr
Gbuf=: <"1 r,.Gclr,.2 2004 4 2022 0 0 6 2031 ,"1 rec
)
drawcellmask=: 3 : 0
if. 0 -: CellMask do. return. end.
glbrush glrgb CellMaskColor
glpen 1 0
glrect 0 0 1 1 +"1 (-.Vmsk) # Vrect
)
drawhdrback=: 3 : 0
if. 0 = Hc + Hr do. return. end.
glbrush glrgb 0 { HdrColor
glpen 0 0
glrect Gxy, 1 + Hwh + (+/Vcw), 0
glrect Gxy, 1 + Hwh + 0,+/Vch
)

drawcellagain=: 3 : 0
ndx=. y
aln=. ndx { Valn
ext=. ndx { Vhex
clr=. Vclr
if. #$clr do.
  clr=. ndx { clr
end.

'row col'=. (0,Vcls) #: ndx
x=. Hw + col{Vcx
y=. Hh + row{Vcy
w=. col{Vcw
h=. row{Vch

glrgb clr { CellColorBack
glbrush''
glrgb 0 { GridColor
glpen 1 0
glrect x,y,,1+w,h

txt=. ndx pick Vdat
x=. x + Mx + (aln=0) + aln * (-Mx) + -: w + ext
y=. y + My
gltextxy Gxy + x,.y
gltext txt
)
drawcellover=: 3 : 0
if. 0 = # $ Vcof do. return. end.
r=. ''
for_i. I. +./"1 Vcof do.
  r=. r, drawcellover1 i
end.
msk=. # &> r { Vdat
if. 0 = +/ msk do. return. end.
drawcellagain &> (0 < msk) # r
)

drawcellover1=: 3 : 0
row=. y
ndx=. I. row { Vcof
rdx=. row * Vcls
ind=. ndx + rdx
txt=. ind { Vdat
len=. qextentwv txt
if. 0 e. len do.
  msk=. len > 0
  if. 0 = +/msk do. return. end.
  ind=. msk # ind
  ndx=. msk # ndx
  len=. msk # len
  txt=. msk # txt
end.
aln=. ind { Valn
bgn=. Mx + (ndx { Vcx) + (aln=0) + >. aln * (ndx{Vcmw) - -: len
x=. 0 >. <: +/ Vcx <:/ bgn
r=. Vcls <. +/ Vcx </ bgn + Mx + len
if. r <: x + 1 do. '' return. end.
y=. row { Vcy
vx=. x { Vcx
vr=. r { Vcx
rec=. 1 + vx,.y,._3 +(vr-vx),.row { Vch
txt=. alfndx each txt
len=. 2 + # &> txt
pos=. 4 2056 ,"1 (bgn ,. y+My) ,"1 len,.2038

if. #$Vclr do.
  c=. 5 2032 ,"1 (ind{Vclr) { CellColorBack
  glcmds ,c,.2 2004 4 2022 0 0 6 2031 ,"1 rec
  c=. 5 2032 ,"1 (ind{Vclr) { CellColorFore
  glcmds ; (<"1 c ,. pos) ,each txt
else.
  glrgb Vclr { CellColorBack
  glpen 0 0
  glbrush''
  glrect rec
  glrgb Vclr { CellColorFore
  gltextcolor''
  glcmds ; (<"1 pos) ,each txt
end.
rdx + ndx -.~ I. 0 < +/\ ((i.Vcls) e. x) - (i.Vcls) e. r
)


drawcelltext=: 3 : 0

x=. (Vlen $ Mx + }:Vcx) + Valn=0
s=. x + >. Valn * (Vlen $ Vcmw) - -: Vhex
y=. (Vcls # My + }:Vcy) + CELLALIGNV * (Vcls # Vcmh) - -: Vvex
pos=. Hwh +"1 s,.y
clr=. Vclr { CellColorFore
pcf=. 5 2032 ,"1 clr,"1 [ 2 2040
dat=. alfndx each Vdat
len=. 2 + # &> dat
p=. <"1 [ pcf ,. 4 2056 ,"1 pos ,"1 len,.2038
p=. p ,each dat
p=. Gbuf ,each p ,each <2 2079
if. #$ Vfnt do.
  fnt=. ~.Vfnt
  p=. Vfnt <@; /. p
  for_f. fnt do.
    glfont f pick CellFonts
    glcmds f_index pick p
  end.
else.
  glfont Vfnt pick CellFonts
  glcmds ;p
end.
if. 0=#Vfm do. return. end.
x=. Vfm { x
y=. Vfm { y
aln=. Vfm getindex Valn
vex=. Vfm getindex Vvex
cmh=. Vfm { Vcls # Vcmh
cmw=. Vfm { Vlen $ Vcmw
rws=. # &> Vhm
msk=. ;rws {.each 1
pcf=. (Vfm { Gbuf) ,each <"1 Vfm { pcf
x=. (rws # x) + >. (rws # aln) * (rws # cmw) - -: ; Vhm
x=. msk <;.1 x
y=. y + each vex * each (i.%[) each rws
pos=. (Hwh) +"1 >. ; x ,.each y
dat=. ; <;._2 each Vfl
dat=. alfndx each dat
len=. 2 + # &> dat
p=. 4 2056 ,"1 pos ,"1 len,.2038
p=. (<"1 p) ,each dat
p=. msk <@; ;.1 p
p=. pcf ,each p ,each <2 2079
if. #$ Vfnt do.
  vfnt=. Vfm { Vfnt
  fnt=. ~.vfnt
  p=. vfnt <@; /. p
  for_f. fnt do.
    glfont f pick CellFonts
    glcmds f_index pick p
  end.
else.
  glfont Vfnt pick CellFonts
  glcmds ; p
end.
)


drawcheckbox=: 3 : 0
ndx=. I. Vtyp e. 100 101
if. 0 = #ndx do. return. end.
vrec=. ndx { Vrect
r=. 2 2004 4 2022 0 0 6 2031 ,"1 vrec
glcmds ,(ndx { Gclr),.r
t=. CBSize
'x y w h'=. |: vrec
x=. x + <.-:w-t
y=. y + <.-:h-t
xy=. x,.y
ck=. xy #~ '1' e. &> ndx { Vdat
msk=. 100 = ndx { Vtyp
if. 1 e. msk do.
  glbrush glrgb 3 { ButtonColor
  glrgb 4 { GridColor
  glpen 1 0
  glrect msk # xy,"1 t,t
end.
msk=. 101 = ndx { Vtyp
if. 1 e. msk do.
  x=. msk # x
  y=. msk # y
  xy=. msk # xy
  r=. x + t - 2
  s=. y + t - 2
  
  glbrush glrgb 3 { ButtonColor
  glpen 1 0
  glrect xy,"1 t,t
  
  glrgb 2 { ButtonColor
  glpen 1 0
  gllines x,.y,.(r+1),.y
  gllines x,.y,.x,.s + 1
  
  glrgb 4 { ButtonColor
  glpen 1 0
  gllines 1 + xy,.x,.s-2
  gllines 1 + xy,.(r-2),.y
  
  glrgb 5 { ButtonColor
  glpen 1 0
  gllines r,.(y+1),.r,.s-1
  gllines (x+1),.s,.(r+1),.s
  
end.
glrgb 0 { ButtonColor
glpen 1 0
r=. 3 4 5 6 7 8 9
s=. 5 6 7 6 5 4 3
gllines (ck,.ck) +"1/ r,.s,.r,.s + 3
)


drawcolor=: 3 : 0

if. # $ CellColor do.
  Vclr=: 4 * , flips Vrndx { CellColor
else.
  Vclr=: Vlen $ 4 * CellColor
end.
if. -. 0 -: CellHigh do.
  Vclr=: Vclr + +: , flips Vrndx { CellHigh
end.
if. GRIDROWMODE *. (0 < #CELLMARK) *. State e. StateRowMark do.
  r=. ({. CELLMARK) - Scrollr
  if. (r >: 0) *. r < Vrws do.
    ndx=. (Vcls * r) + i. Vcls
    Vclr=: (1 + ndx { Vclr) ndx } Vclr
  end.
  
else.
  if. 4 = #CELLMARK do.
    'mark markx'=. _2 [\ CELLMARK
    if. -. mark -: markx do.
      rc=. mark <. markx
      'r c'=. rc - Scrollrc
      's t'=. 1 + (mark >. markx) - rc
      r=. r + i. s
      c=. c + i. t
      r=. r #~ (r >: 0) *. r < Vrws
      c=. c #~ (c >: 0) *. c < Vcls
      ndx=. , (Vcls * r) +/ c
      ndx=. ndx -. Vcls #. markx - Scrollrc
      Vclr=: (1 + ndx { Vclr) ndx } Vclr
    end.
  end.
  
end.

1
)

drawcombobox=: 3 : 0
ndx=. I. iscombo Vtyp
if. 0 = #ndx do. return. end.
drawcombobox1 ndx { Vrect
)
drawcombobox1=: 3 : 0
'x y w h'=. |: y
r=. x + w
s=. y + h - 1
x=. r - h

glbrush glrgb 1 { ButtonColor
glpen 1 0 [ glrgb 5 { ButtonColor
glrect x,.y,.h,.h

glpen 1 0 [ glrgb 3 { ButtonColor
gllines (x+1),.y,.r,.y
gllines 1 + x,.y,.x,.s-1

glpen 1 0 [ glrgb 4 { ButtonColor
gllines (x+1),.s,.r,.s
gllines (r-1),.(y+1),.(r-1),.s

w=. <. 0.25 * _2 + {. h
xy=. (x + >.-: h - +:w),.y + <. -: h - w

glbrush glrgb 0 { ButtonColor
glpen 1 0
glpolygon (6$"1 xy) +"1/ 0 0,w,w,+:w,0
)

drawcontrols=: 3 : 0
if. Vtyp -: 0 do. return. end.
drawcheckbox''
drawcombobox''
)


drawcube=: 3 : 0
if. -. Cube do. return. end.
glbrush glrgb 1 { GridBackColor
glpen 1 0
if. Sy do.
  glrect 0 0,Rw,Sy
end.
glrect 0,(Sy+Sh),Rw,Rh-Sy+Sh
glrect (Sx+Sw),0,(Rw-Sx+Sw),Rh
glpen 1 0 [ glrgb 0 0 0
gllines (*a)-~a=. 0 0,Rw,0,Rw,Rh,0,Rh,0 0
glbrush glrgb 0 { HdrColor
glpen 1 0 [ glrgb 3 { GridColor
glrect AXrect

'px py pw ph'=. |: AXrect
glpen 1 0 [ glrgb 2 { GridColor
gllines 1 + px,.py,.(px+pw-2),.py
gllines 1 + px,.py,.px,.py+ph-2
glpen 1 0 [ glrgb 3 { GridColor
gltextcolor glrgb 1 { HdrColor
nms=. (;3{.AXISORDER) { AXISNAMES
pos=. (Mx,My) +"1 [ 2 {."1 AXrect
glfont HdrFont
for_i. i.#nms do.
  gltextxy i{pos
  gltext i pick nms
end.
if. 0 = #sel=. 2 pick AXISORDER do. return. end.
nms=. (cubegetindex sel) {&> sel { AXISLABELS
pos=. ((Mw + Mx2) + (0 {"1 ASrect) + sel { Axwid),.1 {"1 ASrect
glbrush glrgb 1 { MenuColor
glrect ATrect
for_i. i.#nms do.
  gltextxy (Mx,My) + i{pos
  gltext i pick nms
end.
)


drawgrid=: 3 : 0

drawinit''
drawclip''
drawpos''
drawatt''
drawcolor''

drawbackground''

cells=. Vrws *. Vcls

if. cells do.
  drawcellback''
  drawcelltext''
  drawcelllines''
  drawcellover''
  drawcontrols''
  drawcellmask''
end.

drawhdrback''
drawhdrlight''
drawhdrcol''
drawhdrrow''
drawhdrtop''
drawhdrshadow''

if. cells do.
  drawmark''
end.

drawcube''
drawscrollback''
drawborder''
drawscrollbutton''

drawhier''
drawextern''
drawsort''
drawhover''
)
drawclip=: 3 : 0
Sclip=: '' return.
if. Sxywh -: Rxywh do.
  Sclip=: ''
else.
  Sclip=: 6 2078,Sxywh
end.
)
drawinit=: 3 : 0
glsel GRIDHWNDC
glclear''
glcursor IDC_ARROW
HvRects=: i.0 4
HvOns=: ''
)


drawhdrcol=: 3 : 0
if. 0 = (#HdrCol) * #Vxndx do. return. end.
for_i. i.#HdrCol do.
  drawhdrcolrow i
end.
)
drawhdrcolrow=: 3 : 0
row=. y

py=. row { Hy
ph=. row { Hrh
if. row e. HdrColMerge do.
  ndx=. <(HdrColMerge i.row);Vxndx
  bgn=. ndx { Hcmbgn
  msk=. ~:bgn
  bgn=. msk # bgn
  len=. msk # ndx { Hcmlen
  ind=. ({.bgn) + i. +/len
  ndx=. <row;bgn
  nms=. ndx { HdrCol
  aln=. ndx { HdrColAlign
  ext=. ndx { HdrCellWid
  wid=. ind { Dw
  vw=. (<:+/\len) { +/\ wid
  cw=. (-: vw - 0,}:vw) - Mx
  off=. - +/ (({.Vxndx)-{.bgn) {. wid
  pr=. Gx + Hw + off + 0,vw
  
else.
  ndx=. <row;Vxndx
  nms=. ndx { HdrCol
  aln=. ndx { HdrColAlign
  ext=. ndx { HdrCellWid
  pr=. Hw + Vcx
  cw=. Vcmw
end.

px=. }: pr

pos=. (Mx,My) +"1 (px + (>. aln * cw - -:ext) + aln { 1 0 _1),.py
glpen 1 0 [ glrgb 2 { GridColor
gllines 1 + px,.py,.px,.py + ph-1
gllines 1 + px,.py,.px,.py + ph-1

glpen 1 0 [ glrgb 3 { GridColor
gllines pr,.py,.pr,.py + ph
p=. ((Mx,My) +"1 px,.py),.0 >. ((}.pr) - 3 + px),.ph-1
p=. 6 2078 ,"1 p
glfont HdrFont
gltextcolor glrgb 1 { HdrColor

s=. alfndx each nms
len=. 2 + # &> s
p=. <"1 [ p,. 4 2056 ,"1 pos ,"1 len,.2038
glcmds ; p ,each s ,each <2 2079
)

drawhdrrow=: 3 : 0
if. 0 = (#HdrRow) * #Vyndx do. return. end.
for_i. i.{:$HdrRow do.
  drawhdrrowcol i
end.
)
drawhdrrowcol=: 3 : 0
col=. y
px=. col { Hx
pw=. col { Hcw
cw=. (-: col { Hcw) - Mx
if. col e. HdrRowMerge do.
  ndx=. <(HdrRowMerge i.col);Vyndx
  bgn=. ndx { Hrmbgn
  msk=. ~:bgn
  bgn=. msk # bgn
  len=. msk # ndx { Hrmlen
  ind=. ({.bgn) + i. +/len
  ndx=. <bgn;col
  nms=. ndx { HdrRow
  aln=. ndx { HdrRowAlign
  ext=. ndx { HdrRowHex
  hit=. ind { Dh
  vh=. (<:+/\len) { +/\ hit
  vb=. (<:+/\len) { hit
  ch=. -: vh - vb + 0,}:vh
  off=. - +/ (({.Vyndx)-{.bgn) {. hit
  ps=. Gy + Hh + off + 0,vh
  py=. }: ps
  pyc=. py
else.
  ndx=. <Vyndx;col
  nms=. ndx { HdrRow
  aln=. ndx { HdrRowAlign
  ext=. ndx { HdrRowHex
  ps=. Hh + Vcy
  py=. }: ps
  pyc=. py + Vcmh - -: HdrHit
end.

pos=. (Mx,My) +"1 <. (px + aln * cw - -:ext),.pyc
glpen 1 0 [ glrgb 2 { GridColor
gllines 1 + px,.py,.(px+pw-1),.py
glpen 1 0 [ glrgb 3 { GridColor
gllines px,.ps,.(px+pw),.ps
glfont HdrFont
gltextcolor glrgb 1 { HdrColor

s=. alfndx each nms
len=. 2 + # &> s
p=. <"1 [ 4 2056 ,"1 pos ,"1 len,.2038
glcmds ; p ,each s
)

drawhdrtop=: 3 : 0

if. 0 = Hc + Hr do. return. end.

glbrush glrgb 0 { HdrColor
glpen 0 0
glrect Gxy, 1 + Hwh

glrgb 2 { GridColor
glpen 1 0

pr=. }.Hx,Gx+Hw
ps=. }.Hy,Gy+Hh
ph=. {. Hrh
x=. (Hc * Hr) $ Hx
y=. Hc # Hy
r=. <: (Hc * Hr) $ pr
s=. <: Hc # ps
pos=. (Hc * HDRSTYLE=2) }. x,.y,.r,.y
pos=. pos,x,.y,.x,.s
gllines 1 + pos
if. #HdrTop do.
  
  'rws cls'=. $HdrTop
  nms=. ,HdrTop
  aln=. ,HdrTopAlign
  ext=. ,HdrTopHex
  
  p=. ((Mx,My) +"1 x,.y),.0 >. (r - 3 + x),.ph-1
  p=. 6 2078 ,"1 p
  
  px=. (x + Mx) + aln * (<.-:r - x + ext) - Mx
  py=. cls # My + Hy
  pos=. px,.py
  
  s=. alfndx each nms
  len=. 2 + # &> s
  p=. <"1 [ p,. 4 2056 ,"1 pos ,"1 len,.2038
  glcmds ; p ,each s ,each <2 2079
  
end.

)

drawhier=: 3 : 0
if. -. Hier do. return. end.
drawhierinit''
drawhierrow''
drawhiercol''
)
drawhierinit=: 3 : 0
glfont HdrFont
glbrush glrgb 1 { GridBackColor
glpen 0 0
glrect 0 0,Sw,Lh
LvlHit=: My2 + HdrHit
if. LvlCol *: LvlRow do.
  LvlCx=: Sw * LvlRow return.
end.
LvlDivider=: 1
lm=. +: LCMx + {.ArrowHbox
rm=. (+:LCMx) + 1 + {.ArrowVbox
Sw2=. -: Sw
rlen=. LvlHit + +/ LCMx + Mx2 + qextentwv (LVLROWTOP { LVLROWID) 0 } LRWalks
clen=. LvlHit + +/ LCMx + Mx2 + qextentwv (LVLCOLTOP { LVLCOLID) 0 } LCWalks
b=. Sw2 >: (lm + rlen), rm + clen
if. *./ b do.
  LvlCx=: <. Sw2
elseif. Sw >: lm + rlen + rm + clen do.
  LvlCx=: ({.b) pick (lm + rlen);Sw - rm + clen
elseif. do.
  LvlCx=: lm + <. (Sw - lm + rm) * rlen % rlen + clen
  LvlDivider=: 0
end.
)
drawhiercol=: 3 : 0
if. -.LvlCol do. return. end.

if. LvlRow do.
  glbrush glrgb 1 { GridBackColor
  glpen 0 0
  glrect LvlCx,0,Sw,Lh
  if. LvlDivider do. glpen 1 0 [ glrgb 4 { GridColor
    gllines LvlCx,My2,LvlCx,Lh+1-My2
  end.
end.

'w h'=. ArrowVbox
x=. Sw - 1 + LCMx + w
y=. >. -: Lh - +: h
lon=. LCend > LCbgn
ron=. LCend < <:#LCnms
LCArect=: x,.(y+0,h-1),.(>:w,w),.h
drawuparrow lon,2 {. {. LCArect
drawdownarrow ron,2 {. {: LCArect
walks=. (LVLCOLTOP { LVLCOLID) 0 } LCWalks
avail=. x - LvlCx + LvlHit + LCMx * #walks
ext=. Mx2 + qextentwv walks
if. avail < +/ext do.
  ext=. <. ext * avail % +/ext
end.
wid=. ext + (#ext) {. LvlHit
LCWrect=: (LvlCx + +/\LCMx+0,}:wid),.LCMy,.>:wid,.LvlHit
glbrush glrgb OffColor
glpen 1 0 [ glrgb 3 { GridColor
glrect LCWrect
'px py pw ph'=. |: LCWrect
glpen 1 0 [ glrgb 2 { GridColor
gllines 1 + px,.py,.(px+pw-2),.py
gllines 1 + px,.py,.px,.py+ph-2
glbrush glrgb OnColor
glpen 1 0 [ glrgb 4 { GridColor
glrect LCWalkn{LCWrect
pos=. (Mx,My) +"1 [ 2 {."1 LCWrect
for_w. walks do.
  glclip w_index{LCWrect
  gltextxy w_index{pos
  gltext >w
end.
glclipreset''
x=. ({.ext) + {.{.LCWrect
w=. <. 0.25 * LvlHit + 1
xy=. (x + 1 + >.-: LvlHit - +:w),.LCMy + <. -: LvlHit - w
LCLrect=: (x+1),LCMy,LvlHit,>:LvlHit
glbrush glrgb 1 { GridBackColor
glpen 0 0
glrect LCLrect + 1 1 _2 _2
glpen 1 0 [ glrgb ((0<LCWalkn){4 3) { GridColor
gllines (x+2),(LCMy+1),(x+2),LCMy+LvlHit
glbrush glrgb 0 { ButtonColor
glpen 1 0
glpolygon (6$"1 xy) +"1/ 0 0,w,w,+:w,0
LCrect=: LCWrect,LCArect
EMPTY
)
drawhierrow=: 3 : 0
if. -.LvlRow do. return. end.

'w h'=. ArrowHbox

lon=. LRend > LRbgn
ron=. LRend < <:#LRnms
LRArect=: (LCMx+0,w-1),"0 1 (<.LCMy+-:LvlHit-h),w,h
drawleftarrow lon,2 {. {. LRArect
drawrightarrow ron,2 {. {: LRArect
x=. LCMx + +: w
walks=. (LVLROWTOP { LVLROWID) 0 } LRWalks
avail=. LvlCx - x + LvlHit + LCMx * #walks
ext=. Mx2 + qextentwv walks
if. avail < +/ext do.
  ext=. <. ext * avail % +/ext
end.
wid=. ext + (#ext) {. LvlHit
LRWrect=: (x + +/\LCMx+0,}:wid),.LCMy,.>:wid,.LvlHit
glbrush glrgb OffColor
glpen 1 0 [ glrgb 3 { GridColor
glrect LRWrect

'px py pw ph'=. |: LRWrect
glpen 1 0 [ glrgb 2 { GridColor
gllines 1 + px,.py,.(px+pw-2),.py
gllines 1 + px,.py,.px,.py+ph-2
glbrush glrgb OnColor
glpen 1 0 [ glrgb 4 { GridColor
glrect LRWalkn{LRWrect

pos=. (Mx,My) +"1 [ 2 {."1 LRWrect
for_w. walks do.
  glclip w_index{LRWrect
  gltextxy w_index{pos
  gltext >w
end.
glclipreset''
x=. ({.ext) + {.{.LRWrect
w=. <. 0.25 * LvlHit + 1
xy=. (x + 1 + >.-: LvlHit - +:w),.LCMy + <. -: LvlHit - w
LRLrect=: (x+1),LCMy,LvlHit,>:LvlHit
glbrush glrgb 1 { GridBackColor
glpen 0 0
glrect LRLrect + 1 1 _2 _2
glpen 1 0 [ glrgb ((0<LRWalkn){4 3) { GridColor
gllines (x+2),(LCMy+1),(x+2),LCMy+LvlHit
glbrush glrgb 0 { ButtonColor
glpen 1 0
glpolygon (6$"1 xy) +"1/ 0 0,w,w,+:w,0
LRrect=: LRWrect,LRArect
EMPTY
)

HvRect=: ''
HvRects=: i.0 4
HvOff=: ''
HvOns=: ''
addhover=: 3 : 0
HvOns=: HvOns,<y
HvRects=: HvRects,4{.y
)
clearhover=: 3 : 0
if. #HvRect do.
  glpixels HvOff
  glpaint''
  HvRect=: ''
end.
)
drawhover=: 3 : 0
if. #HvRect do.
  HvRect=: HvRect intersect HvRects
  if. #HvRect do.
    glpixels (HvRects i. HvRect) pick HvOns
  else.
    glpixels HvOff
  end.
  glpaint''
end.
)
sethover=: 3 : 0
if. HvRect -: y do. return. end.
clearhover''
HvRect=: y
HvOff=: y, glqpixels y
glpixels (HvRects i. y) pick HvOns
glpaint''
)
subhover=: 3 : 0
if. y -: HvRect do.
  clearhover''
end.
msk=. -. HvRects e. ,:y
HvOns=: msk # HvOns
HvRects=: msk # HvRects
)

drawborder=: 3 : 0
if. SBv *. SBh do.
  r=. <:+/ 0 2 { VSxywh
  s=. <:+/ 1 3 { HSxywh
elseif. SBv do.
  r=. <:+/ 0 2 { VSxywh
  s=. <:+/ 1 3 { VSxywh
elseif. SBh do.
  r=. <:+/ 0 2 { HSxywh
  s=. <:+/ 1 3 { HSxywh
elseif. 1 do.
  r=. Gx + Hw + +/Vcw
  s=. Gy + Hh + +/Vch
end.
select. HDRSTYLE
case. 1 do.
  glpen 1 0 [ glrgb 1 { GridColor
  gllines Gx,Gy,r,Gy,r,s,Gx,s,Gx,Gy
case. 2 do.
  glpen 1 0 [ glrgb 2 { GridColor
  gllines Gx,Gy,r,Gy
end.
if. GRIDBORDER do.
  glpen 1 0 [ glrgb 1 { GridColor
  glbrushnull''
  glrect Rxywh
end.
)
drawcelllines=: 3 : 0
glrgb 0 { GridColor
glpen 1 0
x=. Gx + +/\ Hw, Vcw
y=. Gy + +/\ Hh, Vch
h=. ({.GridLines) # ({.x),.y,.({:x),.y
v=. ({:GridLines) # x,.({.y),.x,.{:y
gllines v,h
)
drawhdrlight=: 3 : 0
glrgb 2 { GridColor
glpen 1 0
wid=. Hw + {:Vcx
hit=. Hh + {:Vcy
gllines 1 + (HDRSTYLE=2) }. Gx,.Hy,.(wid-1),.Hy
gllines 1 + Hx,.Gy,.Hx,.hit-1
)
drawhdrshadow=: 3 : 0
if. HDRSTYLE=2 do. return. end.
glrgb 3 { GridColor
glpen 1 0
wid=. Hw + {:Vcx
hit=. Hh + {:Vcy
x=. Hx,Gx + Hw
y=. Hy,Gy + Hh
gllines Gx,.y,.wid,.y
gllines x,.Gy,.x,.hit
)


drawmark=: 3 : 0

if. (State e. iEdit,iCombo) +. (0 = #CELLMARK) +. GRIDROWMODE >: CELLMARKER do. return. end.

'mark markx'=. _2 [\ 4 $ CELLMARK

rc=. mark <. markx
hw=. (mark >. markx) - rc

rc=. rc - Scrollrc
br=. rc + hw

if. 1 e. br < 0 do. return. end.
if. 1 e. rc >: Vrws,Vcls do. return. end.

'r c'=. rc
's t'=. 1 + rc + hw

x=. <: Hw + (c>.0) { Vcx
p=. <: Hw + (t<.Vcls) { Vcx

y=. <: Hh + (r>.0) { Vcy
q=. <: Hh + (s<.Vrws) { Vcy
if. State = iCheck do.
  glrgb 4 { GridColor
  glpen 1 0
  
  ndx=. Vcls #. rc
  'x y w h'=. |: ndx { Vrect
  t=. CBSize
  x=. _2 + x + <.-:w-t
  y=. _2 + y + <.-:h-t
  q=. y + t + 3
  p=. x + t + 3
  cbd=. CBDots
  'px pr'=. x + cbd
  'py ps'=. y + cbd
  gllines px,.y,.pr,.y
  gllines px,.q,.pr,.q
  gllines x,.py,.x,.ps
  gllines p,.py,.p,.ps
  
else.
  glbrush glrgb 4 { GridColor
  glpen 1 0
  
  if. c >: 0 do.
    glrect x,y,3,q-y
  end.
  
  if. r >: 0 do.
    glrect x,y,(p-x),3
  end.
  
  if. t <: Vcls do.
    glrect p,y,3,3+q-y
  end.
  
  if. s <: Vrws do.
    glrect x,q,(3+p-x),3
  end.
  
end.
)

drawpos=: 3 : 0

Gxs=: Gxy,Gxy
Gxs1=: Gxs + 1
Scrollrc=: Scrollr,Scrollc

if. GRIDFLIP do.
  cc=. Scrollc - Cy
  cr=. Scrollr - Cx
  fc=. Scrollc - Cy
  fr=. Scrollr - Cx
else.
  cc=. Scrollc - Cx
  cr=. Scrollr - Cy
  fc=. Scrollc - Cx
  fr=. Scrollr - Cy
end.
if. GRIDVIRTUALMODE do.
  cc=. fc
  cr=. fr
end.
dr=. MaxDataRows <. Crws - fr
dc=. MaxDataCols <. Ccls - fc
Srws=: (Gh >: Hh + +/\ (cr + i.dr) { Dh) i. 0
Scls=: (Gw >: Hw + +/\ (cc + i.dc) { Dw) i. 0
Vrws=: Srws + Crws > Srws + cr
Vcls=: Scls + Ccls > Scls + cc
Vlen=: Vrws * Vcls
Vxndx=: cc + i. Vcls
Vyndx=: cr + i. Vrws
Vrndx=: < rots Vyndx;Vxndx
Vcw=: Vxndx { Dw
Vch=: Vyndx { Dh
Vcx=: +/\Gx,Vcw
Vcy=: +/\Gy,Vch
Vcmw=: (-: Vcw) - Mx
Vcmh=: (-: Vch) - My
Vw=: Hw + +/Vcw
Vh=: Gh <. Hh + +/Vch
Vxywh=: Gxywh <. Gx,Gy,<:Vw,Vh
x=. Vlen $ }:Vcx
y=. Vcls # }:Vcy
w=. Vlen $ Vcw
h=. Vcls # Vch
Vrect=: ((Hwh+1) +"1 x,.y),.<:w,.h
Cxndx=: fc + i. Vcls
Cyndx=: fr + i. Vrws
)


drawscrollback=: 3 : 0

VSxywh=: HSxywh=: ''

if. SBv +: SBh do. return. end.
if. SBv *. SBh do.
  glbrush glrgb 1 { GridBackColor
  glpen 0 0
  glrect (Gx+Gw),(Gy+Gh),2$SBHit
end.

drawscrollh 1
drawscrollv 1
)
drawscrollbutton=: 3 : 0

if. SBv +: SBh do. return. end.

if. SBh do.
  
  'x y w t'=. HSxywh
  y1=. y + 1
  xm=. x + t
  
  glbrush glrgb 3 { ButtonColor
  glpen 1 0
  glrect (xm+1),y1,(w-1++:t),t-2
  glpen 1 0 [ glrgb 1 { ButtonColor
  
  if. -.IFWINCE do.
    gpixel ((xm+1),y1) +"1 makedots (w-1++:t),t-2
  end.
  
  'x y w h'=. HSSxywh
  x1=. x + 1
  y1=. y + 1
  r=. x + w
  s=. y + h
  
  glbrush glrgb 1 { ButtonColor
  glpen 1 0
  glrect HSSxywh
  glpen 1 0 [ glrgb 3 { ButtonColor
  gllines x1,y1,(r-1),y1
  gllines x1,y1,x1,s-1
  glpen 1 0 [ glrgb 2 { ButtonColor
  gllines x1,(s-1),r,s-1
  gllines (r-1),y1,(r-1),s-1
  glpen 1 0 [ glrgb 4 { ButtonColor
  gllines r,y,r,s
end.
if. SBv do.
  
  'x y t h'=. VSxywh
  x1=. x + 1
  ym=. y + t
  
  glbrush glrgb 3 { ButtonColor
  glpen 1 0
  glrect x1,(ym+1),(t-2),h-1++:t
  glpen 1 0 [ glrgb 1 { ButtonColor
  
  if. -.IFWINCE do.
    gpixel (x1,ym+1) +"1 makedots (t-2),h-1++:t
  end.
  
  'x y w h'=. VSSxywh
  x1=. x + 1
  y1=. y + 1
  r=. x + w
  s=. y + h
  glpen 1 0 [ glbrush glrgb 1 { ButtonColor
  glrect VSSxywh
  glpen 1 0 [ glrgb 3 { ButtonColor
  gllines x1,y1,x1,s-1
  gllines x1,y1,(r-1),y1
  glpen 1 0 [ glrgb 2 { ButtonColor
  gllines (r-1),y1,(r-1),s
  gllines x1,(s-1),r,s-1
  glpen 1 0 [ glrgb 4 { ButtonColor
  gllines x,s,r,s
end.
)
drawscrollh=: 3 : 0

if. -. SBh do. return. end.

redraw=. y

t=. SBHit
if. SBv do.
  y=. Sy + Sh - t
else.
  y=. Gy + Vh
end.
x=. Gx
w=. Sw - SBv * SBHit
s=. y + t - 1

HSxywh=: x,y,w,t
HSBxywh=: (x,y,t,t),((x+t+1),y,(w-+:t+1),t),:(x+w-t),y,t,t

x1=. x + 1
x2=. x + 2
y1=. y + 1
y2=. y + 2
xm=. x+t
xw=. x+w-t
glbrush glrgb 1 { ButtonColor
glpen 1 0 [ glrgb 0 { GridColor
glrect x,y,w,t
glpen 1 0 [ glrgb 3 { ButtonColor
gllines x2,y2,(xm-1),y2
gllines x2,y2,x2,s
gllines (xw+1),y2,(x+w-1),y2
gllines (xw+1),y2,(xw+1),s
glpen 1 0 [ glrgb 2 { ButtonColor
gllines (xm-1),y2,(xm-1),s
gllines x2,(s-1),xm,s-1
gllines (x+w-2),y2,(x+w-2),s
gllines (xw+1),(s-1),(x+w-2),s-1
glpen 1 0 [ glrgb 4 { ButtonColor
gllines xm,y1,xm,s
gllines (x+w-1),y1,(x+w-1),s
if. redraw > State = iHSlider do.
  h1=. w - +: t + 1
  cls=. Scls <. Tcls - 1
  len=. t >. <. h1 * cls % Tcls
  top=. (h1 - len) * Scrollc % MaxScrollc
  xt=. xm + top + 1
  HSSxywh=: roundint xt,y1,len,(s-y1)
end.
h=. <. 0.25 * _2 + t
x=. x + <. -: t - h
y=. y + >.-: t - +:h
glbrush glrgb 0 { ButtonColor
glpen 1 0
glpolygon (x+h),y,x,(y+h),(x+h),y++:h
x=. x + w - t
glpolygon x,y,(x+h),(y+h),x,y++:h
)
drawscrollv=: 3 : 0

if. -. SBv do. return. end.

redraw=. y

t=. SBHit
if. SBh do.
  x=. Sx + Sw - t
else.
  x=. Gx + Vw
end.
y=. Gy
h=. Sh - SBh * SBHit
r=. x + t - 1

VSxywh=: x,y,t,h
VSBxywh=: (x,y,t,t),(x,(y+t+1),t,h-+:t+1),:x,(y+h-t),t,t

x1=. x + 1
x2=. x + 2
y1=. y + 1
y2=. y + 2
ym=. y + t
yh=. y + h - t
glbrush glrgb 1 { ButtonColor
glpen 1 0 [ glrgb 0 { GridColor
glrect x,y,t,h
glpen 1 0 [ glrgb 3 { ButtonColor
gllines x2,y2,x2,ym-1
gllines x2,y2,r,y2
gllines x2,(yh+1),x2,y+h-1
gllines x2,(yh+1),r,(yh+1)
glpen 1 0 [ glrgb 2 { ButtonColor
gllines x2,(ym-1),r,(ym-1)
gllines (r-1),y2,(r-1),ym
gllines x2,(y+h-2),r,(y+h-2)
gllines (r-1),(yh+1),(r-1),(y+h-2)
glpen 1 0 [ glrgb 4 { ButtonColor
gllines x1,ym,r,ym
gllines x1,(y+h-1),r,y+h-1
if. redraw > State = iVSlider do.
  h1=. h - +: t + 1
  rws=. Srws <. Trws - 1
  len=. t >. <. h1 * rws % Trws
  top=. (h1 - len) * Scrollr % MaxScrollr
  yt=. ym + top + 1
  VSSxywh=: roundint x1,yt,(r-x1),len
end.
w=. <. 0.25 * _2 + t
x=. x + >.-: t - +:w
y=. y + 1 + <. -: t - w
glbrush glrgb 0 { ButtonColor
glpen 1 0
glpolygon x,(y+w),(x+w),y,(x++:w),y+w
y=. y + h - t + 1
glpolygon x,y,(x+w),(y+w),(x++:w),y
)



readsize=: 3 : 0
'rw rh'=. _2 {. Roff
th=. rh + +/ RowHeights
tw=. rw + +/ ColWidths
if. 0=#y do. tw,th return. end.
'mw mh'=. y
sv=. sh=. 0 
if. mh <: th do.
  sv=. 1
  sh=. mw <: SBHit + tw
elseif. mw <: tw do.
  sh=. 1
  sv=. mh <: SBHit + th
end.
tw=. mw <. tw + sv * SBHit
th=. mh <. th + sh * SBHit
(2{.Roff) + tw,th
)

drawsort=: ]
coclass 'jzgrid'

editx=: 3 : 0
showmark''

Eoldtext=: Text
State=: iEdit
'row col'=. (rots Cell) - Scrollr, Scrollc
ndx=. Vcls #. row,col
editmlinit ''
ind=. (4 rounddown ndx { Vclr) + i.4
EFclr=: ind { CellColorFore
EBclr=: ind { CellColorBack
if. # $ Valn do.
  Ealn=: ndx { Valn
else.-
  Ealn=: Valn
end.
Efont=: getcellfont Cell
if. Eml do.
  glfont Efont
  hit=. (2 * My) + qextenth 'X'
else.
  hit=. row{Vch
end.
Exywh=: (Hw+col{Vcx),(Hh+row{Vcy),1+(col{Vcw),hit
'Ex Ey Ew Eh'=: Exywh
Ecw=: Ew - 2 * Mx
Egw=: Hw + +/Vcw
Emw=: Egw - Hw + 2 * Mx
Epos=: # Text
Esel=: 0
Ecap=: 0
Emx=: Mx
Ebuf=: ,<Text;Ecap;Epos;Esel
Ebufndx=: 0
Capture=: 0
showit''
editshow''
)
editdelsel=: 3 : 0
editsnap''
'b e'=. /:~ Epos + 0, Esel
Text=: (b {. Text), e }. Text
Ecap=: Ecap + 0 <. Esel
Epos=: b
Esel=: 0
)
editgelsel=: 3 : 0
'b e'=. /:~ Epos + 0, Esel
b }. e {. Text
)
editstate=: 3 : 0
s=. (> , ': '"_ , 5!:5)"0
n=. 'Ecap Epos Esel Text'
s ;: n
)
iscelledit=: 3 : 0
if. 0 = # $ CellEdit do. CellEdit return. end.
(<y) { CellEdit
)
iseditable=: 3 : 0
if. CellEdit -: 0 do. 0 return. end.
if. -. CellEdit -: 1 do.
  if. -. (<y) { CellEdit do. 0 return. end.
end.
if. -. 0 -: CellType do.
  typ=. (<y) { CellType
  if. (ischeck typ) +. iscombolist typ do. 0 return. end.
end.
1
)


editsnap=: 3 : 0
Ebuf=: ~. (Text;Ecap;Epos;Esel) ; Ebuf
Ebuf=: (Ebufmax <. #Ebuf) {. Ebuf
Ebufndx=: 0
)
editredo=: 3 : 0
if. Ebufndx > 0 do.
  Ebufndx=: Ebufndx - 1
  'Text Ecap Epos Esel'=: Ebufndx pick Ebuf
  editshow 0
end.
)
editundo=: 3 : 0
if. Ebufndx < <: #Ebuf do.
  Ebufndx=: Ebufndx + 1
  'Text Ecap Epos Esel'=: Ebufndx pick Ebuf
  editshow 0
end.
)

kbEXIT1=: kbENTER,kbEND,kbHOME,kbLEFT,kbRIGHT,kbUP,kbDOWN
editchar=: 3 : 0

c=. sysdata__locP
d=. alfndx {. c
m=. 0 ". sysmodifiers__locP
if. d > 31 do.
  if. m e. 2 3 do. return. end.
  editdelsel''
  Text=: (Epos {. Text), (ucp c), Epos }. Text
  Epos=: Epos + 1
  editmlnew''
  editshow'' return.
end.
if. Type = 1 do.
  if. d e. kbEXIT1 do.
    editfini 2 return.
  end.
end.
Textold=. Text

select. d
  
case. kbBS do.
  if. Esel do.
    editdelsel ''
  else.
    if. m e. 2 3 do.
      Text=: Epos }. Text
      Epos=: 0
    else.
      Text=: (_1 }. Epos {. Text), Epos }. Text
      Epos=: 0 >. <: Epos
    end.
  end.
  
case. kbLF do.
  if. 0 = editmlsplit (Epos{.Text);Epos}.Text do. return. end.
  
case. kbENTER do.
  editfini 2 return.
  
case. kbESC do.
  editfini 0 return.
  
case. kbEND do.
  if. m e. 1 3 do.
    Esel=: Epos + (0 <. Esel) - # Text
  else.
    Esel=: 0
  end.
  Epos=: # Text
  
case. kbHOME do.
  if. m e. 1 3 do.
    Esel=: Epos + 0 >. Esel
  else.
    Esel=: 0
  end.
  Epos=: 0
  
case. kbLEFT do.
  select. m
  case. 0 do.
    Esel=: 0
    Epos=: 0 >. <: Epos
    Ecap=: Ecap <. Epos
  case. 1 do.
    Esel=: Esel + Epos > 0
    Epos=: 0 >. <: Epos
    Ecap=: Ecap <. Epos
  case. 2 do.
    Ecap=: Esel=: Epos=: 0
  case. 3 do.
    Esel=: Epos + 0 >. Esel
    Ecap=: Epos=: 0
  end.
  
case. kbRIGHT do.
  select. m
  case. 0 do.
    Esel=: 0
    Epos=: (# Text) <. >: Epos
  case. 1 do.
    Esel=: Esel - Epos < # Text
    Epos=: (# Text) <. >: Epos
  case. 2 do.
    Esel=: 0
    Epos=: # Text
  case. 3 do.
    Esel=: Epos + (0 <. Esel) - # Text
    Epos=: # Text
  end.
  
case. kbDEL do.
  if. Esel do.
    editdelsel''
  else.
    select. m
    case. 0 do.
      Text=: (Epos {. Text), 1 }. Epos }. Text
    case. 2 do.
      Text=: Epos {. Text
    end.
  end.
  
  
end.
editshow -. Text -: Textold
)

editcopy=: 3 : 0
wdclipwrite editgetsel''
)
editcut=: 3 : 0
wdclipwrite editgetsel''
editdelsel''
editshow''
)
editpaste=: 3 : 0
editdelsel''
Text=: (Epos {. Text),(ucp wdclipread''),Epos }. Text
editshow''
)


editfini=: 3 : 0
if. y do.
  'rc val'=. editvalidate''
  select. rc
  case. 0 do.
    val change Cell
    Show=: 2
  case. 2 do. return.
  end.
end.
glcaret 0 0 0 0
glcursor IDC_ARROW
State=: 0
if. y=2 do.
  0
else.
  showit''
end.
)
editvalidate=: 3 : 0

editmlfini''

old=. readcell Cell

if. ischar old do.
  txt=. utf8 Text
  (old -: txt);txt return.
end.

val=. {. NaN ". 1 u: Text

if. val = NaN do.
  info 'Not a number: ',Text
  2;'' return.
end.

if. isinteger old do.
  if. isinteger val do.
    val=. <. val
  end.
end.

(old-:val);val
)

editmouse=: 3 : 0

'x y w h l r ctrl shift middle xbutton1 xbutton2 wheel'=. 0 ". sysdata__locP

if. (x < Ex) +. x > Ex + Ew do. 1 return. end.
if. (y < Ey) +. y > Ey + Eh do. 1 return. end.

x=. x - Ex + Emx

txt=. Ecap }. Text
len=. # txt
wid=. qextentw16 txt
ndx=. >. x * len % wid

if. ndx <: 0 do. 0 0 return. end.
if. ndx >: len do. 0, len return. end.

act=. qextentw16 ndx {. txt
prv=. qextentw16 (ndx-1) {. txt
while. (prv > x) *. ndx > 0 do.
  act=. prv
  ndx=. ndx - 1
  prv=. qextentw16 (ndx-1) {. txt
end.

nxt=. qextentw16 (ndx+1) {. txt
while. (nxt <: x) *. ndx < # txt do.
  act=. nxt
  ndx=. ndx + 1
  nxt=. qextentw16 (ndx+1) {. txt
end.

0, ndx + Ecap
)


editmbldbl=: 3 : 0
Epos=: # Text
Esel=: -Epos
editshow 0
)
editmbldown=: 3 : 0
'rc pos'=. editmouse ''
if. rc do. editfini 1 return. end.
Epos=: pos
Esel=: 0
capture 1
editshow 0
)
editmblup=: 3 : 0
capture 0
)


editmmove=: 3 : 0
if. Capture do.
  'rc pos'=. editmouse ''
  if. rc do. 1 return. end. 
  Esel=: pos - Epos
  editshow 0
end.
)

EMLchars=: '/\|$#@~!%^&*+;:,.<>?'
editmlfini=: 3 : 0
if. -. Eml do. return. end.
Text=: }. LF (I. Text = Emld) } Text
Eml=: 0
)
editmlinit=: 3 : 0
if. 2 = #$Text do.
  Eml=: 1
  Text=: }. ,LF,.Text
else.
  Eml=: LF e. Text
end.
if. Eml do.
  Emld=: {. EMLchars -. Text
  if. Emld = ' ' do.
    info 'Cannot edit this multiline cell - no suitable line delimiter.'
    State=: 0 return.
  end.
  Text=: Emld, Emld (I. Text = LF) } Text
end.
)
editmlnew=: 3 : 0
if. -. Eml do. return. end.
if. Emld = {. Text do. return. end.
if. 0 = #Text do. Eml=: 0 return. end.
new=. {. Text
Text=: new (I. Text = Emld) } Text
Emld=: new
)
editmlsplit=: 3 : 0
'bgn end'=. y
bgn0=. (-' ' = {:bgn) }. bgn
end0=. (' ' = {.end) }. end
if. Eml do.
  Text=: bgn0,Emld,end0
  1 return.
end.
Emld=: {. EMLchars -. bgn, end
if. Emld = ' ' do.
  info 'Cannot create this multiline cell - no suitable line delimiter.'
  Text=: bgn,end
  0 return.
end.
Text=: Emld,bgn0,Emld,end0
Eml=: 1
)

editfit=: 3 : 0
if. Ecw >: Elen do.
  Ecap=: 0 return.
end.
if. Emw >: Elen do.
  pad=. Elen - Ecw
  Ecw=: Elen
  Ew=: Ecw + 2 * Mx
  Ex=: Hw >. Ex - <. -: pad
  Ex=: Ex - 0 >. (Ex + Ew) - Egw + 1
  Exywh=: Ex,Ey,Ew,Eh
  Ecap=: 0 return.
end.
if. Ecw >: qextentw16 Ecap }. Epos {. Text
do. return.
end.
while. 1 do.
  Ecap=: >: Ecap
  if. Ecw >: qextentw16 Ecap }. Epos {. Text
  do. return.
  end.
end.
)
editemx=: 3 : 0
select. Ealn
case. 1 do.
  Emx=: Mx + -: 0 >. Ecw - Elen
case. 2 do.
  Emx=: Mx + 0 >. Ecw - Elen
end.
)
editshow=: 3 : 0
glcursor IDC_IBEAM
glbrush glrgb {. EBclr
glfont Efont
glrgb {. EFclr
glpen 1 0
gltextcolor ''
Elen=: qextentw16 Text
editfit''
editemx''
glclipreset''
glclip Exywh
glrect Exywh
txt=. Ecap }. Text
pos=. Epos - Ecap
sel=. Esel + 0 >. Ecap - Epos + Esel
gltextxy (Ex,Ey) + Emx,My
gltext utf8 txt
if. sel do.
  b=. <./ pos + 0,sel
  n=. | sel
  x=. qextentw16 b {. txt
  s=. qextentw16 (b + n) {. txt
  w=. (s-x) <. Ew - 1 + x + Emx
  glbrush glrgb 1 { EBclr
  glrect (x + Ex + Emx),Ey,(s-x),Eh
  gltextcolor glrgb 1 { EFclr
  gltextxy (x + Ex + Emx),Ey + My
  gltext utf8 n {. b }. txt
end.
wid=. Emx + qextentw16 pos {. txt
glcaret (Ex+wid),(Ey+My2),1,Eh-4*My
glpaint''

if. y do. editsnap'' end.
1
)
coclass 'jzgrid'

change=: 4 : 0
Value=: x
Cell=: y
if. gridhandler 'change' do.
  changex''
  gridhandler 'changed'
end.
)
click=: 3 : 0
'Px Py Row Col Ctrl Shift'=: y
if. gridhandler 'click' do.
  clickx''
end.
)
dblclick=: 3 : 0
'Px Py Row Col Ctrl Shift'=: y
if. gridhandler 'dblclick' do.
  dblclickx''
end.
)
rclick=: 3 : 0
'Px Py Row Col Ctrl Shift'=: y
if. gridhandler 'rclick' do.
  rclickx''
end.
)
rdblclick=: 3 : 0
'Px Py Row Col Ctrl Shift'=: y
if. gridhandler 'rdblclick' do.
  rdblclickx''
end.
)

edit=: 3 : 0
'Type Text Cell'=: y
Text=: ucp Text
if. gridhandler 'edit' do.
  editx ''
end.
)
get=: 3 : 0
'Rws Cls'=: y
if. gridhandler 'get' do.
  getx ''
end.
)
gridsort=: 3 : 0
'Row Col Dim'=: y
if. gridhandler 'gridsort' do.
  gridsortx''
end.
)

key=: 3 : 0
'Char Ctrl Shift'=: y
if. gridhandler 'key' do.
  keyx ''
end.
)

mark=: 3 : 0
gridhandler 'mark'
)
runclick=: click
coclass 'jzgrid'

flat=: 3 : 0

if. 0 = L. y do. fmt y return. end.
if. 1 = L. y do.
  rnk=. #@$ S:0 y
  num=. -. (3!:0 S:0 y) e. CHARTYPE
  if. 2 > >./ rnk + num do. fmt y return. end.
  dat=. ,y
  ndx=. I. num *. rnk=1
  dat=. (": each ndx { dat) ndx } dat
else.
  dat=. ,y
  ndx=. I. 0 < L. S:_1 dat
  if. #ndx do.
    dat=. (": each ndx { dat) ndx } dat
  end.
  rnk=. #@$ S:0 dat
end.
ndx=. I. rnk < 2
dat=. (fmt ndx { dat) ndx } dat
ndx=. I. rnk = 2
dat=. (flat2 each ndx { dat) ndx } dat
ndx=. I. rnk > 2
dat=. (flatn each ndx { dat) ndx } dat

($y) $ dat
)
flat2=: }. @ , @ (LF&,.) @ ":
flatn=: 3 : 0
dat=. 1 1}. _1 _1}. ": < ": y
}: (,|."1 [ 1,.-. *./\"1 |."1 dat=' ')#,dat,.LF
)
getfmt=: 3 : 0
CellDFmtM=: ''
if. #CellFmt do.
  getfmtd''
else.
  getfmtm''
end.
Fshape=: $CellDFmt
)

getfmtd=: 3 : 0
if. 1 = rank CellData do.
  CellDFmt=: getfmtdv ''
else.
  CellDFmt=: getfmtdm ''
end.
EMPTY
)
getfmtdm=: 3 : 0
if. 0 e. $CellData do. CellData return. end.
if. 2 = #$CellFmt do.
  CellFmt fmt each CellData
else.
  CellFmt fmt CellData
end.
)
getfmtdv=: 3 : 0
select. #$CellFmt
  
case. 0 do.
  {. |: CellFmt fmt &> CellData
  
case. 1 do.
  {. |: CellFmt fmt &> CellData
  
case. 2 do.
  fm=. ('';1) <@,;.1 CellFmt
  {. |: fm fmt each CellData
end.

)

getfmtm=: 3 : 0

if. 0 e. $CellData do. 
  CellDFmt=: CellData return. 
end.

if. 1 = rank CellData do.
  CellDFmt=: {. |: flat &> CellData
else.
  CellDFmt=: flat CellData
end.

if. -. LF e. ;CellDFmt do. EMPTY return. end.

ndx=. I. LF e.S:0 CellDFmt
ind=. <"1 ($CellDFmt) #: ndx
if. 1 e. 0 ~: , ind getindex CellType do.
  info 'Only text cell types may have more than one line.'
  CellDFmt=: CellDFmt -. each LF return.
end.
if. 1 e. 0 ~: , ind getindex CellOverFlow do.
  info 'LF not permitted in overflow cells.'
  CellDFmt=: CellDFmt -. each LF return.
end.
CellDFmtM=: ndx
CellDFmtL=: (, ind { CellDFmt) ,each LF
top=. (CellDFmtL i.&> LF) {.each CellDFmtL
CellDFmt=: top ind } CellDFmt
EMPTY
)

fmtn=: 4 : 0
y=. ,. y
rws=. # y
val=. ('';1) <;.1 y
spcs=. <;._1 ';',x -. ' '
if. 1 e. b=. 'r' e. &> spcs do.
  ix=. spcs {~ ind=. I. b
  ndx=. i.&'r' &> ix
  len=. 0 ". &> ndx {. each ix
  spcs=. ((>:ndx) }. each ix) ind } spcs
  spcs=. spcs #~ len ind } >:b
end.

fm=. spcs
r=. (rws,0) $ ''
while. #val do.
  
  fm=. fm,(0=#fm)#spcs
  spc=. >{.fm
  fm=. }.fm
  
  if. 'x' = {.spc do.
    w=. {. (0 ". }.spc), 1
    r=. r ,"1 w # ' ' continue.
  end.
  
  dat=. , >{.val
  val=. }.val
  
  num=. spc -. 'bcmz'
  
  if. #num do.
    'wid dec'=. 0 1 #: {. 0 ". num
  else.
    if. dat -: <. dat do.
      dec=. 0
    else.
      dec=. 0.1 * >./ +/ * (10 ^ -i.9) |/ dat
    end.
    wid=. 0
  end.
  
  neg=. I. dat < 0
  min=. I. dat = __
  pin=. I. dat = _
  
  res=. dec ": &.> | dat
  
  if. 'c' e. spc do.
    msk=. (-wid){.(|. wid$1j1 1 1),(3+(10*dec)+*dec)$1
    exp=. #!.','~ ({.&msk)@-@#
    res=. exp &.> res
  end.
  
  if. 'b' e. spc do.
    res=. (<'') (I. 0=dat) } res
  end.
  
  if. 'z' e. spc do.
    res=. (-wid){.!.'0' &.> ,res
    res=. > ('-'&, @ }. &.> neg { res) neg } res
  else.
    res=. ('-' ,each neg { res) neg } res
    res=. (-wid){.!.' ' &> res
  end.
  
  r=. r ,. >res
end.
)


coclass 'jzgrid'


gridpinfo=: wdinfo @ ('Grid'&;)
gridpdefs=: 3 : 0
r=. gridpdefaults''

if. 2 < #$CELLDATA do.
  gridpdefs_cube''
  r=. r, ;:'AXISNAMES AXISLABELS AXISORDER COLMINWIDTH'
end.

if. 0=#y do. return. end.

locD=: {:y 
def=. > {.y
if. (L. def) *. 2 = #$def do.
  r, unpack def return.
end.
if. (ischar def) *. 1 < #def do.
  r, locD readloc def return.
end.
if. 2 < #$CELLDATA do.
  nms=. ;: 'AXISNAMES AXISLABELS AXISORDER'
  if. #def do.
    ((#def){.nms)=: def
  end.
else.
  'HDRROW HDRCOL'=: 2 $ def
  r=. r, ;:'HDRROW HDRCOL'
end.

r
)
gridpdefaults=: 3 : 0
if. isboxed CELLDATA do.
  typ=. 3!:0 &> CELLDATA
  rnk=. #@$ &> CELLDATA
  CELLFONT=: (1 e. ,rnk > 1) +. 1 e. ,typ e. BOXTYPE
  CELLALIGN=: +: -. (rnk=1) +. typ e. BOXTYPE,CHARTYPE
else.
  CELLALIGN=: 2
end.
CELLEDIT=: 0
nms=. ;: 'CELLALIGN CELLDATA CELLEDIT CELLFONT'
)
gridpdefs_cube=: 3 : 0
rnk=. #$CELLDATA
AXISNAMES=: 'Dim'&, each ": each i.rnk
AXISLABELS=: (": each @ i.) each $CELLDATA
select. rnk
case. 3 do. s=. 0 1;2;''
case. 4 do. s=. 0 1;2 3;''
case. do. s=. (2{.m);(_2{.m);2}._2}.m=. i.rnk
end.
AXISORDER=: s
COLMINWIDTH=: 50 
)
MinGrid=: 120 0
gridp=: 3 : 0
'' gridp y
:
a=. conew 'jzgrid'
x gridpshow__a y
)
gridpshow=: 4 : 0
CELLDATA=: y
cube=. 2 < #$CELLDATA
defs=. towords gridpdefs x
wd GRIDP
destroy=: gridpdestroy
formx=. 0 ". wd 'qformx'
wh=. _2 {. getxywhx''
grid=: '' conew 'jzgrid'
show__grid defs
twh=. MinGrid >. readsize__grid wh
del=. 0 <. twh - wh
if. -. IFJAVA do.
  wd 'setxywhx grid 0 0 ',":wh + del
end.
wd 'pmovex ',":formx + 0 0,0 <. del+1+4*IFJAVA
wd 'pshow;'
)

GRIDP=: 0 : 0
pc gridp;pn "Grid";
xywh 0 0 400 300;cc grid isigraph ws_border rightmove bottommove;
pas 0 0;pcenter;
rem form end;
)
gridpdestroy=: 3 : 0
wd 'pclose'
destroy__grid''
codestroy''
)
gridp_close=: gridp_cancel=: gridpdestroy
coclass 'jzgrid'

axmbldown=: 3 : 0
if. State = iACombo do.
  bcfini 0 return.
end.
if. y inrect ATrect do.
  bcinitaxis y inrectx ATrect
else.
  ndx=. y inrectx AXrect
  State=: iAMove
  capture 7,ndx{AXrect
  Pos=: ndx,Mxy
end.
)
axmblup=: 3 : 0
State=: 0
capture 0
m=. _1 ^ '0' = {. sysmodifiers__locP
'pos mx my'=. Pos
'rws cls sel slx'=. old=. AXISORDER
dim=. pos { rws,cls,sel
'px py'=. y
if. py > Sy+Sh do.
  px=. px - mx - {. pos{AXrect
  msk=. pos ~: i.#rws
  rws=. msk # rws
  pxs=. msk # {."1 ARrect
  ndx=. pxs I. px
  cls=. cls -. dim
  if. 0=#cls do.
    cls=. m {. rws
    rws=. m }. rws
    ndx=. ndx <. #rws
  end.
  rws=. (ndx{.rws),dim,ndx}.rws
  sel=. sel -. dim
elseif. px > Sx+Sw do.
  py=. py - my - 1 { pos{AXrect
  pos=. pos - #rws
  msk=. pos ~: i.#cls
  cls=. msk # cls
  pys=. msk # 1 {"1 ACrect
  ndx=. pys I. py
  rws=. rws -. dim
  if. 0=#rws do.
    rws=. m {. cls
    cls=. m }. cls
    ndx=. ndx <. #cls
  end.
  cls=. (ndx{.cls),dim,ndx}.cls
  sel=. sel -. dim
elseif. py <: Axhit + 5 do.
  px=. px - mx - {. pos{AXrect
  pos=. pos - #rws,cls
  msk=. pos ~: i.#sel
  sel=. msk # sel
  pxs=. msk # {."1 ASrect
  ndx=. pxs I. px
  cls=. cls -. dim
  rws=. rws -. dim
  if. 0=#cls do.
    cls=. m {. sel
    sel=. m }. sel
    ndx=. ndx <. #sel
  end.
  if. 0=#rws do.
    rws=. m {. sel
    sel=. m }. sel
    ndx=. ndx <. #sel
  end.
  sel=. (ndx{.sel),dim,ndx}.sel
end.
new=. rws;cls;sel;slx
if. -. old -: new do.
  AXISORDER=: new
  refresh''
end.
)
mbldbl=: 3 : 0
Mxy=: mousexy ''
if. State = iEdit do.
  if. editmbldbl '' do. return. end.
end.

State=: 0
if. Mxy inrect VSxywh do.
  vsmbldown Mxy return.
elseif. Mxy inrect HSxywh do.
  hsmbldown Mxy return.
elseif. Mxy inrect Vxywh do.
  dblclick mousepos ''
elseif. do.
  dblclick _1
end.
)
dblclickx=: 3 : 0

pos=. Row, Col
scr=. Row - Scrollr
scc=. Col - Scrollc

if. (scr e. i.Vrws) *. scc e. i.Vcls do.
  cell=. rots pos
  if. -. iseditable cell do. return. end.
  if. -. (scr e. i.Srws) *. scc e. i.Scls do.
    ShowMark=: 0
    moveto pos
    showit''
  end.
  txt=. readedit cell
  edit 2;txt;cell
  
end.
)
mbldown=: 3 : 0
gridfocus''
Mxy=: mousexy ''
select. State
case. iEdit do.
  if. editmbldown '' do. return. end.
case. iCombos do.
  if. bcmbldown '' do. return. end.
end.

State=: 0
if. Mxy inrect VSxywh do.
  vsmbldown Mxy return.
elseif. Mxy inrect HSxywh do.
  hsmbldown Mxy return.
elseif. Mxy inrect AXrect do.
  axmbldown Mxy return.
elseif. Mxy inrect LCrect do.
  lcmbldown Mxy return.
elseif. Mxy inrect LRrect do.
  lrmbldown Mxy return.
elseif. Mxy inrect Vxywh do.
  runclick mousepos ''
elseif. do.
  click _1
end.
)
clickx=: 3 : 0

pos=. Row, Col
scr=. Row - Scrollr
scc=. Col - Scrollc
if. *./ 0 <: pos do.
  
  if. 0 -: Vtyp do.
    typ=. 0
  else.
    typ=. (Vcls #. scr,scc) { Vtyp
  end.
  
  r=. moveto pos
  
  if. ischeck typ do.
    ndx=. rots pos
    new=. -. readcell ndx
    new change ndx
    State=: iCheck
    Show=: 2
    r=. 1
  else.
    if. iscombo typ do.
      if. (scr{Vch) > (Hw+(scc+1){Vcx) - {.Mxy do.
        bcinit rots pos return.
      end.
    end.
    if. -.GRIDROWMODE do.
      State=: iSelect
      Mousetime=: 6!:1 ''
    end.
  end.
  
  if. r do. showit'' end.
  return.
end.
if. ColResize *. Row e. - 1 + i. Hr do.
  mx=. {. Mxy
  dif=. | (mx - Gx + Hw) - +/\ Vcw
  min=. (i. <./) dif
  if. Mousetol >: min { dif do.
    glcursor IDC_SIZEWE
    capture 5    
    ResizeX=: min + Hc
    ResizeP=: mx
    State=: iCResize
  end.
  return.
end.
if. mbgridsort '' do. return. end.
)
mblup=: 3 : 0
select. State
case. iEdit do.
  editmblup''
case. iSelect do.
  State=: 0
case. iHSlider do.
  hsmblup''
case. iVSlider do.
  vsmblup''
case. iCResize do.
  colresize''
case. iRResize do.
  rowresize''
case. iCombos do.
  bcmblup''
case. iAMove do.
  axmblup mousexy''
end.
)


mouserc=: 3 : 0
'x y'=. 2 {. 0 ". sysdata__locP
col=. Hc -~ <: (x >: Hx,Hw+Vcx) i. 0
row=. Hr -~ <: (y >: Hy,Hh+Vcy) i. 0
row, col
)
mousexy=: 3 : '2 {. 0 ". sysdata__locP'
mousepos=: 3 : 0
'x y w h l r ctrl shift middle xbutton1 xbutton2 wheel'=. 0 ". sysdata__locP

xp=. Hx,Hw+Vcx
col=. <: (x >: xp) i. 0
x=. (x - col{xp) % -/(col+1 0){xp
col=. col - Hc
col=. col + Scrollc * col >: 0

yp=. Hy,Hh+Vcy
row=. <: (y >: yp) i. 0
y=. (y - row{yp) % -/(row+1 0){yp
row=. row - Hr
row=. row + Scrollr * row >: 0

x, y, row, col, ctrl, shift
)

mmove=: 3 : 0
select. State
case. iEdit do.
  if. editmmove '' do. return. end.
case. iSelect do.
  'row col'=. mouserc ''
  if. -. (row e. i.Srws) *. col e. i.Scls do.
    if. (Mousewait + Mousetime) > 6!:1 '' do. return. end.
  end.
  row=. 0 >. (Scrollr + row) <. <:Trws
  col=. 0 >. (Scrollc + col) <. <:Tcls
  Mousetime=: 6!:1''
  if. movexto row,col do. showit'' end.
case. iCombos do.
  if. bcmmove '' do. return. end.
case. iHSlider do.
  hsmmove '' return.
case. iVSlider do.
  vsmmove '' return.
case. do.
  xy=. mousexy''
  if. xy inrect HvRects do.
    sethover (xy inrectx HvRects) { HvRects
  else.
    clearhover''
  end.
end.
)

rowresize=: ]
colresize=: 3 : 0
'x y'=. mousexy ''
COLWIDTH=: (Hc + Ccls) $ COLWIDTH
new=. (x-ResizeP) + ResizeX { COLWIDTH
COLWIDTH=: new ResizeX } COLWIDTH
State=: 0
capture 0
glcursor IDC_ARROW
refresh''
)

mbrdbl=: 3 : 0
Mxy=: mousexy ''
if. Mxy inrect Vxywh do.
  rdblclick mousepos ''
end.
)
mbrdown=: 3 : 0
gridfocus''
Mxy=: mousexy ''
if. Mxy inrect Vxywh do.
  rclick mousepos ''
end.
)
mbrup=: 3 : 0
EMPTY
)
rdblclickx=: 3 : 0
EMPTY
)

rclickx=: 3 : 0
EMPTY
)



hsmbldown=: 3 : 0
pos=. {. y
if. pos inint 0 2 { HSSxywh do.
  State=: iHSlider
  capture 1
  Pos=: ({.HSSxywh), pos, pos return.
elseif. pos inint 0 2 { 0 { HSBxywh do.
  Scrollc=: Scrollc - 1
elseif. pos inint 0 2 { 1 { HSBxywh do.
  if. pos < {. HSSxywh do.
    Scrollc=: Scrollc + 1 - Scls
  else.
    Scrollc=: Scrollc + Scls - 1
  end.
elseif. pos inint 0 2 { 2 { HSBxywh do.
  Scrollc=: Scrollc + 1
end.
Scrollc=: 0 >. Scrollc <. MaxScrollc
ShowMark=: 0
showit 0
)
hsmblup=: 3 : 0
State=: 0
capture 0
hsmscroll''
)
hsmmove=: 3 : 0
'x y'=. mousexy ''
'mx my mw mh'=. 1 { HSBxywh
'sx sy sw sh'=. HSSxywh
sx=. mx >. (({.Pos) + x - 1 { Pos) <. mx + mw - sw
HSSxywh=: sx 0 } HSSxywh
if. IFWINCE do.
  drawscrollbutton''
  glpaint''
else.
  hsmscroll''
end.
)
hsmscroll=: 3 : 0
'mx my mw mh'=. 1 { HSBxywh
'sx sy sw sh'=. HSSxywh
pos=. (sx - mx) % mw - sw
os=. Scrollc
if. pos=1 do.
  Scrollc=: MaxScrollc
else.
  cs=. MaxScrollc <. <. 0.5 + pos * Tcls - Scls
  if. cs ~: Scrollc do.
    if. sx >: 2 { Pos do.
      Scrollc=: cs >. Scrollc
    else.
      Scrollc=: cs <. Scrollc
    end.
    Pos=. sx 2 } Pos
  end.
end.
if. os = Scrollc do.
  drawscrollbutton''
  glpaint''
else.
  ShowMark=: 0
  showit''
end.
)

vsmbldown=: 3 : 0
pos=. {: y
if. pos inint 1 3 { VSSxywh do.
  capture 1
  State=: iVSlider
  Pos=: (1{VSSxywh), pos, pos return.
elseif. pos inint 1 3 { 0 { VSBxywh do.
  Scrollr=: Scrollr - 1
elseif. pos inint 1 3 { 1 { VSBxywh do.
  if. pos < 1 { VSSxywh do.
    Scrollr=: Scrollr + 1 - Srws
  else.
    Scrollr=: Scrollr + Srws - 1
  end.
elseif. pos inint 1 3 { 2 { VSBxywh do.
  Scrollr=: Scrollr + 1
end.
Scrollr=: 0 >. Scrollr <. MaxScrollr
ShowMark=: 0
showit 0
)
vsmblup=: 3 : 0
State=: 0
capture 0
vsmscroll''
)
vsmmove=: 3 : 0
'x y'=. mousexy ''
'mx my mw mh'=. 1 { VSBxywh
'sx sy sw sh'=. VSSxywh
sy=. my >. (({.Pos) + y - 1 { Pos) <. my + mh - sh
VSSxywh=: sy 1 } VSSxywh
if. IFWINCE do.
  drawscrollbutton''
  glpaint''
else.
  vsmscroll''
end.
)
vsmscroll=: 3 : 0
'mx my mw mh'=. 1 { VSBxywh
'sx sy sw sh'=. VSSxywh
pos=. (sy - my) % mh - sh
os=. Scrollr
if. pos=1 do.
  Scrollr=: MaxScrollr
else.
  cs=. MaxScrollr <. <. 0.5 + pos * Trws - Srws
  if. cs ~: Scrollr do.
    if. sy >: 2 { Pos do.
      Scrollr=: cs >. Scrollr
    else.
      Scrollr=: cs <. Scrollr
    end.
    Pos=. sy 2 } Pos
  end.
end.
if. os = Scrollr do.
  drawscrollbutton''
  glpaint''
else.
  ShowMark=: 0
  showit''
end.
)

mbgridsort=: 3 : 0
if. GRIDFLIP do. 0 return. end.
ndx=. (Col,Row) i. _1
if. ndx = 2 do. 0 return. end.
if. (Cube = 0) *. ndx = 0 do. 0 return. end.
pos=. ((Row - Scrollr) e. i.Vrws),(Col - Scrollc) e. i.Vcls
if. -. ndx{pos do. 0 return. end.
if. Cube do.
  ndx=. {: ndx pick AXISORDER
end.
if. -. ndx{GridSort do. 0 return. end.
gridsort Row,Col,ndx
1
)
mwheel=: 3 : 0
Scrollr=: Scrollr - {: 0 ". sysdata__locP
Scrollr=: 0 >. Scrollr <. MaxScrollr
ShowMark=: 0
showit 0
)
coclass 'jzgrid'

getmark=: 3 : 0
2 {. CELLMARK,Scrollr,Scrollc
)
moveby=: 3 : 0
moveto 0 >. (<: Trws,Tcls) <. y + getmark''
)
movexto=: 3 : 0
select. #CELLMARK
case. 0 do.
  old=. ''
  CELLMARK=: y,y
case. 2 do.
  old=. CELLMARK
  CELLMARK=: y,old
case. 4 do.
  old=. 2 {. CELLMARK
  CELLMARK=: y, 2 }. CELLMARK
end.
NewMark=: -. old -: y
)
movexby=: 3 : 0
movexto 0 >. (<: Trws,Tcls) <. y + getmark''
)
movexall=: 3 : 0
m=. y
'x y r s'=. 4 {. CELLMARK,CELLMARK
select. m
case. 1 do.
  CELLMARK=: x,0,r,<:Tcls
case. 2 do.
  CELLMARK=: 0,y,(<:Trws),s
case. 3 do.
  CELLMARK=: 0 0,<:Trws,Tcls
end.
)
writemark=: 3 : 0
if. GRIDFLIP do.
  CELLMARK=: ((#y) {. 1 0 3 2) { y
else.
  CELLMARK=: y
end.
)
moveedge=: 3 : 0
'row col'=. getmark''
select. y 
case. 0 _1 do. col=. 0
case. 0 1 do. col=. <:Tcls
case. _1 0 do. row=. 0
case. 1 0 do. row=. <:Trws
end.
moveto row,col
)
movenext=: 3 : 0
'row col'=. getmark''
if. 1 < Crws do.
  row=. (<:Trws) <. row + 1
else.
  col=. (<:Tcls) <. col + 1
end.
moveto row,col
)
movepage=: 3 : 0
ShowMark=: 0
Scrollr=: 0 >. MaxScrollr <. Scrollr + 0 { y
Scrollc=: 0 >. MaxScrollc <. Scrollc + 1 { y
)
movetocell=: 3 : 0
if. #CELLMARK do.
  old=. 2 {. CELLMARK
else.
  old=. ''
end.
CELLMARK=: y
NewMark=: -. old -: y
)
moveto=: movetocell
readmark=: 3 : 0
if. GRIDFLIP do.
  ((#CELLMARK) {. 1 0 3 2) { CELLMARK
else.
  CELLMARK
end.
)
writemark=: 3 : 0
if. GRIDFLIP do.
  CELLMARK=: ((#y) {. 1 0 3 2) { y
else.
  CELLMARK=: y
end.
)

showmark=: 3 : 0

if. 0 e. Crws,Ccls do. CELLMARK=: $0 end.
if. 0 = #CELLMARK do. showscroll'' return. end.
'r c'=. 2 {. CELLMARK
Scrollr=: r <. Scrollr
Scrollc=: c <. Scrollc
if. showscrollmin'' do. 1 return. end.
if. GRIDVIRTUALMODE do.
  'tx ty'=. rots Cx,Cy
else.
  tx=. ty=. 0
end.

hit=. ((<:#Dh) <. r - ty + i. 1 + r - Scrollr) { Dh
Scrollr=: Scrollr >. r - 0 i:~ (Gh - Hh) < +/\ hit

wid=. ((<:#Dw) <. c - tx + i. 1 + c - Scrollc) { Dw
Scrollc=: Scrollc >. c - 0 i:~ (Gw - Hw) < +/\ wid

showscrollmax''
)
showscroll=: 3 : 0
if. showscrollmin'' do. 1 return. end.
showscrollmax''
)
showscrollmin=: 3 : 0
new=. 0
'sr sc'=. rots Scrollr,Scrollc
if. sr < Cy do.
  new=. 1
  Cy=: 0 >. sr - {.Slack
end.
if. sc < Cx do.
  new=. 1
  Cx=: 0 >. sc - {.Slack
end.

showscrollnew new
)
showscrollmax=: 3 : 0

new=. 0
'sr sc'=. rots Scrollr,Scrollc
'mt ms'=. rots <: (Scrollr + MaxDataRows),Scrollc + MaxDataCols

if. Ct < Tt <. mt do.
  new=. 1
  Cy=: Cy >. sr - {.Slack
end.

if. Cs < Ts <. ms do.
  new=. 1
  Cx=: Cx >. sc - {:Slack
end.

showscrollnew new
)
showscrollnew=: 3 : 0
if. y do.
  showit 4
end.
y
)

coclass 'jzgrid'


gridsortx=: 3 : 0
if. Cube do. 
  gridsortcube''
else.
  gridsorttable''
end.
)
gridsortcube=: 3 : 0

rnk=. #$CELLDATA

if. 0=#SortIndex do. SortIndex=: rnk$a: end.

ndx=. cubegetindex i.rnk
ind=. (Row,Col) i. _1
'sid bal'=. ind |. 2 {. AXISORDER
sdm=. {:sid
ndx=. 0 sid } ndx
psx=. (bal{$CELLDATA) #: (-.ind) { Row,Col
ndx=. psx bal } ndx
ndx=. <(<<'') sdm} <&> ndx
dat=. ndx { CELLDATA

srt=. /: dat
if. srt -: i.#dat do. srt=. \: dat end.
cubeputindex sdm,srt i. cubegetindex sdm
AXISLABELS=: (<srt{sdm pick AXISLABELS) sdm } AXISLABELS
CELLDATA=: srt{"(rnk-sdm) CELLDATA
if. 0=#old=. sdm pick SortIndex do.
  new=. srt
else.
  new=. srt{old
end.
SortIndex=: (<new) sdm } SortIndex
refresh''
)

SORTNOUNS=: <;._2 (0 : 0)
CellHex
CELLCOLOR
CELLEDIT
CELLFONT
CELLOVERFLOW
CELLMASK
CELLTYPE
CELLALIGN
HDRROW
HDRROWALIGN
)
gridsorttable=: 3 : 0
if. 0=#SortIndex do.
  SortIndex=: i.Crws
end.
if. #CELLDRAW do.
  if. 1=#$CELLDRAW do.
    col=. Col pick CELLDRAW
  else.
    col=. Col {"1 CELLDRAW
  end.
else.
  if. 1=#Cshape do.
    col=. Col pick CELLDATA
  else.
    col=. Col {"1 CELLDATA
  end.
end.
ndx=. /: col
if. ndx -: i.#ndx do. ndx=. \: col end.
if. #CELLDRAW do.
  if. 1=#$CELLDRAW do.
    CELLDRAW=: (<ndx) { each CELLDRAW
  else.
    CELLDRAW=: ndx { CELLDRAW
  end.
end.

if. 1=#Cshape do.
  CELLDATA=: (<ndx) { each CELLDATA
else.
  CELLDATA=: ndx { CELLDATA
end.
SortIndex=: ndx { SortIndex

(<ndx) gridsortmat &> SORTNOUNS

if. #CELLMARK do.
  CELLMARK=: 2 {. (ndx i. 0 { CELLMARK) 0 } CELLMARK
end.

refresh''
)
gridsortmat=: 4 : 0
val=. ". y
if. 2 > #$val do. 0 return. end.
(y)=: x { Crws $ val
1
)
coclass 'jzgrid'

initcube=: 3 : 0
if. -. Cube do. return. end.
cubevalid''
cubedefs''
cubeextents''
)
cubeputindex=: 3 : 0
new=. y, 3 pick AXISORDER
new=. new #~ ~:{."1 new
AXISORDER=: (<new) 3} AXISORDER
)
cubegetindex=: 3 : 0
'dim slx'=. |: 3 pick AXISORDER
(dim i. y) { slx,0
)
cubespan=: 3 : 0
len=. */ y
r=. s=. i.0,len
t=. {:y
y=. }:y
while. #y do.
  p=. {:y
  y=. }:y
  r=. (t#t*i.len%t),r
  s=. t,s
  t=. p*t
end.
r;s
)
cubevalid=: 3 : 0
rnk=. #$CELLDATA
if. 2 > rnk do.
  info 'Data is not a cube'
  0 return.
end.
AXISORDER=: 1 #each AXISORDER
select. #AXISORDER
case. 4 do.
  slx=. 3 pick AXISORDER
  if. 1 = #$slx do.
    dim=. 2 pick AXISORDER
    if. (#slx) ~: #dim do.
      info 'Slice selections and indices do not match'
      0 return.
    end.
    AXISORDER=: (<dim,.slx) 3} AXISORDER
  else.
    'dim slx'=. |: 3 pick AXISORDER
  end.
  if. 0 e. dim e. i.rnk do.
    info 'Slice axes do not match data'
    0 return.
  end.
  if. 0 e. slx e. &> }:@i: each dim{$CELLDATA do.
    info 'Slice indices do not match data'
    0 return.
  end.
case. 3 do.
  AXISORDER=: AXISORDER,<i.0 2
case. 2 do.
  AXISORDER=: AXISORDER,($0);i.0 2
case. do.
  info 'AXISORDER has invalid shape: ',":$AXISORDER
  0 return.
end.
1
)
initaxes=: 3 : 0
if. Cube do.
  ACrect=: Acxrect +"1 (Sx+Sw),0 0 0
  ARrect=: Arxrect +"1 [ 0,(Sy+Sh),0 0
  ASrect=: Asxrect
  AXrect=: ARrect,ACrect,ASrect
  ATrect=: Atxrect
else.  
  AXrect=: ATrect=: ''
end.
)


cubegetmatrix=: 3 : 0
'rws cls sel slx'=. AXISORDER
shp=. $CELLDATA
dat=. (sel,rws,cls) |: CELLDATA
dat=. ((sel{shp),(*/rws{shp),*/cls{shp) reshape dat
CellData=: (<cubegetindex sel) { dat
)
cubesetmatrix=: 3 : 0
'rws cls sel slx'=. AXISORDER
shp=. $CELLDATA
dat=. ((rws{shp),cls{shp) reshape CellData
dat=. (/: rws,cls) |: dat
if. #sel do.
  ndx=. <(<&>cubegetindex sel) sel } (#shp) $ <a:
  dat=. dat ndx } CELLDATA
end.
CELLDATA=: dat
)

cubedefs=: 3 : 0
GRIDBORDER=: 1  
GRIDFLIP=: 0
GRIDROWMODE=: 0
rws=. (0 pick AXISORDER) { AXISLABELS
HDRROW=: >,{ rws
ARspan=: cubespan # &> rws
cls=. (1 pick AXISORDER) { AXISLABELS
HDRCOL=: |:>,{ cls
ACspan=: cubespan # &> cls
)

cubeextents=: 3 : 0
'rws cls sel slx'=. AXISORDER
glfont HdrFont
sx=. Mw + Mx2           
rw=. sx + >./qextentwv cls { AXISNAMES 
rwm=. rw + +:CMx        
sy=. My2                
rh=. sy + HdrHit  
rhm=. rh + +:CMy        
rhm0=. rhm * 0 < #sel
Roff=: GridWindow + 0,rhm0,rwm,rhm+rhm0
Axhit=: rhm
Axwid=: qextentwv AXISNAMES
Axwids=: >./ &> qextentwv each AXISLABELS
wid=. sx + rws { Axwid
Arxrect=: (+/\CMx,}:wid),.CMy,.>:wid,.rh
cy=. +/\ }: (Axhit * 0<#sel),(#cls)$rh
Acxrect=: CMx,.cy,"0 1 >:rw,rh
if. #sel do.
  wid0=. sx + sel { Axwid
  wid1=. Mx2 + sel { Axwids
  wid=. wid0 + wid1
  Asxrect=: (+/\CMx+0,}:wid),.CMy,.>:wid,.rh
  Atxrect=: (wid0 + +/\CMx+0,}:wid),.CMy,.>:wid1,.rh
else.
  Asxrect=: Atxrect=: i.0 4
end.
)
coclass 'jzgrid'

LCbgn=: 0          
LCend=: 0          

LCWalks=: ,<''     
LCWalkx=: 0        
LCWalkn=: 0        
LCndx=: ''         

LRbgn=: 0
LRend=: 0
LRWalks=: <''
LRWalkx=: 0
LRWalkn=: 0
LRrect=: LCrect=: i.0 4  
inithier=: 3 : 0
if. -. Hier do. return. end.
LvlCol=: 0 < #LVLCOL
LvlRow=: 0 < #LVLROW
hiervalid''
hierdefs''
hierinit''
hiersort''
hierextents''
)
hierinit=: 3 : 0
if. LvlCol do. lcinit'' end.
if. LvlRow do. lrinit'' end.
)
lcinit=: 3 : 0
LCnms=: LVLCOLTOP }. LVLCOL
LCids=: LVLCOLTOP }. LVLCOLID
LCmsk=: LVLCOLTOP }. LVLCOLMASK
LCndx=: i. each #&> LCnms
if. LVLCOLLEN do.
  LCend=: (<: #LVLCOL) <. LCbgn + LVLCOLLEN-1
  LVLCOLLEN=: 0
end.
)
lcreset=: 3 : 0
LCbgn=: LCend=: 0
LCWalks=: ,<''
LCWalkx=: 0
LCWalkn=: 0
lcinit''
)
lrinit=: 3 : 0
LRnms=: LVLROWTOP }. LVLROW
LRids=: LVLROWTOP }. LVLROWID
LRmsk=: LVLROWTOP }. LVLROWMASK
LRndx=: i. each #&> LRnms
if. LVLROWLEN do.
  LRend=: (<:#LVLROW) <. LRbgn + LVLROWLEN-1
  LVLROWLEN=: 0
end.
)
lrreset=: 3 : 0
LRbgn=: LRend=: 0
LRWalks=: ,<''
LRWalkx=: 0
LRWalkn=: 0
lrinit''
)
selmaskndx=: 3 : 0
'ndx row sel msk'=. y
if. sel-:1 do. ndx return. end.
ind=. sel i. 1
inx=. row + i.#ndx
off=. <: ind {"1 +/\"1 inx { msk
ndx + off
)
statehier=: 3 : 0
s=. (> , ': '"_ , 5!:5)"0
n=. ''
if. LvlCol do.
  n=. n,' LCbgn LCend LCWalks LCWalkx LCWalkn'
  n=. n,' LCnms LCids LCmsk'
end.
if. LvlRow do.
  n=. n,' LRbgn LRend LRWalks LRWalkx LRWalkn'
  n=. n,' LRnms LRids LRmsk'
end.
s ;: n
)
hiergetdata=: 3 : 0
CellData=: CELLDATA
if. LvlCol do. hiergetcol'' end.
if. LvlRow do. hiergetrow'' end.
EMPTY
)
hiergetcol=: 3 : 0

dat=. (_1 pick LCndx) {"1 CellData
msk=. SLCmsk
nms=. SLCnms
sel=. 1
if. LCWalkn do.
  scn=. <: +/\"1 msk
  sel=. (LCWalkn{LCWalkx) = (<:LCWalkn){scn
  dat=. sel #"1 dat
  msk=. sel #"1 msk
  msk=. 1 (0)}"1 msk
  ndx=. <@~."1 sel #"1 scn
  nms=. ndx {each nms
end.
if. LCend < <:#nms do.
  dat=. (LCend { msk) +/;.1"1 dat
end.
nms=. LCbgn }. (LCend+1) {. nms
msk=. LCbgn }. (LCend+1) {. msk
msk=. ({:msk) #"1 msk
SLCMsel=: sel
SLCMmsk=: msk
SLCMnms=: nms
HDRCOL=: (<@lfp"1 msk) #&> nms
HDRCOLMERGE=: -. (-#nms) {. 1
if. COLTOTAL do.
  dat=. dat,.+/"1 dat
  HDRCOL=: HDRCOL,.(#HDRCOL){.HDRCOLTOTAL;''
end.
CellData=: dat
EMPTY
)
hiergetrow=: 3 : 0

dat=. CellData
msk=. LRmsk
nms=. LRnms
sel=. 1
if. LRWalkn do.
  scn=. <: +/\"1 msk
  sel=. (LRWalkn{LRWalkx) = (<:LRWalkn){scn
  dat=. sel # dat
  msk=. sel #"1 msk
  msk=. 1 (0)}"1 msk
  ndx=. <@~."1 sel #"1 scn
  nms=. ndx {each nms
end.
if. LRend < <:#nms do.
  dat=. (LRend { msk) +/;.1 dat
end.
nms=. LRbgn }. (LRend+1) {. nms
msk=. LRbgn }. (LRend+1) {. msk
msk=. ({:msk) #"1 msk
LRMsel=: sel
LRMmsk=: msk
LRMnms=: nms
HDRROW=: |: (<@lfp"1 msk) #&> nms
HDRROWMERGE=: -. (-#nms) {. 1
if. ROWTOTAL do.
  dat=. dat,+/dat
  HDRROW=: HDRROW,({:$HDRROW){.HDRROWTOTAL;''
end.
CellData=: dat
EMPTY
)

hierarrows=: 3 : 0
hit=. HdrHit + My2
ArrowColor=: 144 144 144,:80 80 80
ArrowRad=: 7   
ArrowHbox=: 11,hit   
ArrowVbox=: hit,11   
ArrowSep=: 3            
clr=. GridBackColor,"1 ArrowColor
clr=. clr,(2{ButtonColor),{:ArrowColor
'LeftArrow RightArrow'=: makearrowsLR (ArrowHbox,ArrowRad);clr
'UpArrow DownArrow'=: makearrowsUD (ArrowVbox,ArrowRad);clr
)
hierdefs=: 3 : 0
hierarrows''
runclick=: clickhier
GRIDBORDER=: 1  
GRIDFLIP=: 0
GRIDROWMODE=: 0
EMPTY
)


clickhier=: 3 : 0
'Px Py Row Col Ctrl Shift'=: y
if. LvlCol *. Row < 0 do.
  lcwalk''
elseif. LvlRow *. Col < 0 do.
  lrwalk''
elseif. do.
  click y
end.
)
lcmbldown=: 3 : 0
if. y inrect LCLrect do.
  bcinitextern LVLCOLID;LVLCOLTOP;({.LCWrect);'lcsettop'
elseif. y inrect LCWrect do.
  lcwalkpos y inrectx LCWrect
elseif. y inrect LCArect do.
  lclevel y inrectx LCArect
end.
)
lrmbldown=: 3 : 0
if. y inrect LRLrect do.
  bcinitextern LVLROWID;LVLROWTOP;({.LRWrect);'lrsettop'
elseif. y inrect LRWrect do.
  lrwalkpos y inrectx LRWrect
elseif. y inrect LRArect do.
  lrlevel y inrectx LRArect
end.
)


hierextents=: 3 : 0
if. -. LvlCol +. LvlRow do. return. end.
LCMx=: 6
LCMy=: 4
glfont HdrFont
hit=. qextenth 'X'
Lh=: hit + My2 + +:LCMy
Roff=: GridWindow + 0,Lh,0 0
)

lclevel=: 3 : 0
if. y do.
  LCend=: (<:#LCnms) <. >:LCend
else.
  LCend=: LCbgn >. <: LCend
end.
refresh''
)
lctoplevel=: 3 : 0
if. y do.
  lvl=. (<:#LVLCOL) <. >:LVLCOLTOP
else.
  lvl=. 0 >. <:LVLCOLTOP
end.
lcsettop lvl
)
lcsettop=: 3 : 0
LVLCOLTOP=: y
lcreset''
refresh''
)
lrlevel=: 3 : 0
if. y do.
  LRend=: (<:#LRnms) <. >:LRend
else.
  LRend=: LRbgn >. <: LRend
end.
refresh''
)
lrtoplevel=: 3 : 0
if. y do.
  lvl=. (<:#LVLROW) <. >:LVLROWTOP
else.
  lvl=. 0 >. <:LVLROWTOP
end.
lrsettop lvl
)
lrsettop=: 3 : 0
LVLROWTOP=: y
lrreset''
refresh''
)


hiersort=: 3 : 0
hiersortcol''
hiersortrow''
)
hiersortcol=: 3 : 0
if. 0=#LVLCOLSORTROW do.
  LCWalkx=: (/: each (#LCWalkx){.LCndx) i.&> LCWalkx
  LCndx=: i. each #&> LCnms
  SLCmsk=: LCmsk
  SLCnms=: LCnms
  LVLCOLSORTDIR=: 0
  return.
end.
dir=. LVLCOLSORTDIR
val=. LVLCOLSORTROW{CELLDATA
masks=. LCmsk
rws=. #masks
len=. {:$masks
ind=. len$0
sgn=. _1 ^ dir
sorts=. ''
for_i. i.rws do.
  msk=. i{masks
  if. 0 e. msk do.
    cnt=. #;.1 msk
    ndx=. dir sortfns (sgn*msk#ind),.msk +/;.1 val
    ind=. cnt # /:ndx
    inx=. /:ind
    masks=. (inx{i{masks) i} masks
  else.
    ndx=. dir sortfns (sgn*ind),.val
    ind=. /:ndx
    inx=. ndx
  end.
  sorts=. sorts,<ndx
end.
walkx=. }. LCWalkx
wln=. #walkx
walkx=. (/: each wln{.LCndx) i.&> walkx
walkx=. (wln{.sorts) i.&> walkx
LCWalkx=: 0,walkx
LCndx=: sorts
SLCmsk=: masks
SLCnms=: sorts {each LCnms
EMPTY
)
hiersortrow=: ]



hiervalid=: 3 : 0

'r c'=. $CELLDATA

if. LvlCol do.
  if. (#LVLCOLMASK)=<:#LVLCOL do.
    LVLCOLMASK=: LVLCOLMASK,1
  end.
  msg=. hiervalid1 c;LVLCOL;LVLCOLID;LVLCOLMASK;LVLCOLTOP
  if. #msg do.
    info 'Column levels: ',msg
    0 return.
  end.
end.

if. LvlRow do.
  if. (#LVLROWMASK)=<:#LVLROW do.
    LVLROWMASK=: LVLROWMASK,1
  end.
  msg=. hiervalid1 r;LVLROW;LVLROWID;LVLROWMASK;LVLROWTOP
  if. #msg do.
    info 'Row levels: ',msg
    0 return.
  end.
end.

1
)
hiervalid1=: 3 : 0
'len col id msk top'=. y
'r c'=. 2 {. $msk
lr=. #col
lcs=. # &> col
if. len ~: c do.
  'levels do not match data' return.
end.
if. lr ~: #id do.
  'identifiers do not match names' return.
end.
if. lr ~: r do.
  'names do not match mask' return.
end.
if. -. lcs -: +/"1 msk do.
  'names do not match mask' return.
end.
if. -. top e. i.lr do.
  'top index is out of range' return.
end.
''
)


lcwalk=: 3 : 0
row=. Row - (Row = _1) *. LCend = <:#LCnms
col=. Col
if. -. row e. <:-i.>: LCend-LCbgn do. 0 return. end.
if. -. col e. i.({:$CellData)-COLTOTAL do. 0 return. end.
oldwalks=. LCWalks
oldwalkx=. LCWalkx
msk=. (row+1) }. SLCMmsk
nms=. (row+1) }. SLCMnms
ndx=. col {"1 <:+/\"1 msk
nms=. ndx {&> nms
ndx=. selmaskndx ndx;LCWalkn;SLCMsel;LVLCOLMASK
LCWalks=: ((LCbgn+1){.LCWalks),nms
LCWalkx=: ((LCbgn+1){.LCWalkx),ndx
LCWalkn=: LCbgn=: LCend=: LCbgn + #nms
if. LCWalkx -: (#LCWalkx) {.!._1 oldwalkx do.
  LCWalkx=: oldwalkx
  LCWalks=: oldwalks
end.
refresh''
1
)
lcwalkpos=: 3 : 0
LCWalkn=: LCbgn=: LCend=: y
refresh''
)
lrwalk=: 3 : 0
row=. Col - (Col = _1) *. LRend = <:#LRnms
col=. Row
if. -. row e. <:-i.>: LRend-LRbgn do. 0 return. end.
if. -. col e. i.(#CellData)-ROWTOTAL do. 0 return. end.
oldwalks=. LRWalks
oldwalkx=. LRWalkx
msk=. (row+1) }. LRMmsk
nms=. (row+1) }. LRMnms
ndx=. col {"1 <:+/\"1 msk
nms=. ndx {&> nms
ndx=. selmaskndx ndx;LRWalkn;LRMsel;LVLROWMASK
LRWalks=: ((LRbgn+1){.LRWalks),nms
LRWalkx=: ((LRbgn+1){.LRWalkx),ndx
LRWalkn=: LRbgn=: LRend=: LRbgn + #nms
if. LRWalkx -: (#LRWalkx) {.!._1 oldwalkx do.
  LRWalkx=: oldwalkx
  LRWalks=: oldwalks
end.
refresh''
1
)
lrwalkpos=: 3 : 0
LRWalkn=: LRbgn=: LRend=: y
refresh''
)

cocurrent 'base'

NB. various conversion utilities

NB. av         convert between characters and indices
NB. detab      remove tab stops
NB. dfh        decimal from hex
NB. hex        create verb for hex calculation
NB. hfd        hex from decimal
NB. mfv        matrix from vector
NB. vfm        vector from matrix
NB. quote      quote text

cocurrent 'z'

NB. =========================================================
NB.*dfh v decimal from hex
NB.*hfd v hex from decimal
H=. '0123456789ABCDEF'
h=. '0123456789abcdef'
dfh=: 16 #. 16 | (H,h) i. ]
hfd=: H {~ 16 #.^:_1 ]

NB. =========================================================
NB.*hex a create verb for hex calculation
NB. e.g. 'FF' + hex '8'
hex=: &. (dfh :. hfd)

NB. =========================================================
NB.*av v convert between characters and indices
NB. e.g.   av 'abcde'
av=: 3 : '({&a.)`(a.&i.) @. (2&=@(3!:0)) y'

NB. =========================================================
NB.*mfv v matrix from vector
NB. [delimiter] mfv vector
NB. default delimiter is ' '
mfv=: 3 : 0
' ' mfv y
:
if. 2 <: #$y do. y
else. ];._2 y,x #~ x ~: _1{.x,y
end.
)

NB. =========================================================
NB.*quote v quote text
NB. quote 'Pete''s Place'
a=. ''''
quote=: (a&,@(,&a))@ (#~ >:@(=&a))

NB. =========================================================
NB.*detab v remove tab stops
NB. remove tabs from character string
NB. left argument is tab width, default 4
detab=: 3 : 0
4 detab y
:
tab=. 9{a.
r=. y
while.
  i=. >: r i. tab
  i <: #r
do.
  r=. ((x * >. i % x){.!.' ' }:i{.r) , i}.r
end.
r
)

NB. =========================================================
NB.*vfm v vector from matrix
NB. vector from matrix, lines separated by LF
vfm=: 3 : '}:(,|."1 [ 1,.-. *./\"1 |."1 y='' '')#,y,.LF'

NB. date and time utilities

NB.   calendar        calendar for year [months]
NB.   isotimestamp    ISO-formatted time stamp
NB.   getdate         get date from character string
NB.   todate          convert to date
NB.   todayno         convert to day number
NB.   tsdiff          differences between dates
NB.   tsrep           timestamp as a single number
NB.   timestamp       formatted timestamp
NB.   valdate         validate dates
NB.   weekday         weekday from date
NB.
NB.   tstamp          obsolete naming for timestamp

cocurrent 'z'

NB. =========================================================
NB.*calendar v formatted calendar for year [months]
NB. 
NB. returns calendar for year, as a list of months
NB.
NB. form: calendar year [months]
NB. 
NB. argument is one or more numbers: year, months
NB. If no months are given, it defaults to all months.
NB.
NB. example:
NB.   calendar 2007 11 12
NB. ┌─────────────────────┬─────────────────────┐
NB. │         Nov         │         Dec         │
NB. │ Su Mo Tu We Th Fr Sa│ Su Mo Tu We Th Fr Sa│
NB. │              1  2  3│                    1│
NB. │  4  5  6  7  8  9 10│  2  3  4  5  6  7  8│
NB. │ 11 12 13 14 15 16 17│  9 10 11 12 13 14 15│
NB. │ 18 19 20 21 22 23 24│ 16 17 18 19 20 21 22│
NB. │ 25 26 27 28 29 30   │ 23 24 25 26 27 28 29│
NB. │                     │ 30 31               │
NB. └─────────────────────┴─────────────────────┘

calendar=: 3 : 0
a=. ((j<100)*(-100&|){.6!:0'')+j=. {.y
b=. a+-/<.4 100 400%~<:a
r=. 28+3,(~:/0=4 100 400|a),10$5$3 2
r=. ,(-7|b+0,+/\}:r)|."0 1 r(]&:>:*"1>/)i.42
m=. m,(0=#m=. <:}.y)#i.12
h=. 'JanFebMarAprMayJunJulAugSepOctNovDec'
h=. ' Su Mo Tu We Th Fr Sa',:"1~_3(_12&{.)\h
<"2 m{h,"2[12 6 21$,>(<'') ((r=0)#i.#r)} <"1 [ 3":,.r
)

NB. =========================================================
NB.*getdate v get date from character string
NB. form: [opt] getdate string
NB.
NB. useful for input forms that have a date entry field
NB.
NB. date forms permitted:
NB.     1986 5 23
NB.     May 23 1986
NB.     23 May 1986
NB. 
NB. optional x:
NB.   0  = days first - default
NB.     23 5 1986
NB.   1  = months first
NB.     5 23 1986
NB.
NB. other characters allowed:  ,-/:
NB.
NB. if not given, century defaults to current
NB.
NB. only first 3 characters of month are tested.
NB.
NB. examples:  
NB. 23/5/86
NB. may 23, 1986
NB. 1986-5-23
getdate=: 3 : 0
0 getdate y
:
r=. ''
opt=. x
chr=. [: -. [: *./ e.&'0123456789 '
dat=. ' ' (I. y e.',-/:') } y

if. chr dat do.
  opt=. 0
  dat=. a: -.~ <;._1 ' ',dat
  if. 1=#dat do. r return. end.
  typ=. chr &> dat
  dat=. (2{.typ{dat),{:dat
  mth=. 3{.>1{dat
  uc=. 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
  lc=. 'abcdefghijklmnopqrstuvwxyz'
  mth=. (lc,a.) {~ mth i.~ uc,a.
  mos=. _3[\'janfebmaraprmayjunjulaugsepoctnovdec'
  mth=. <": >:mos i. mth
  dat=. ;' ',each mth 1 } dat
end.

dat=. ". :: (''"_) dat
if. 0 e. #dat do. return. end.

if. 3 ~: #dat do. r return. end.

if. 31 < {.dat do. 'y m d'=. dat
else. ((opt|.'d m '),' y')=. dat
end.

if. y<100 do.
  y=. y + (-100&|) {. 6!:0''
end.

(#~ valdate) y,m,d
)

NB. =========================================================
NB.*isotimestamp v format time stamps as:  2000-05-23 16:06:39.268
NB. y is one or more time stamps in 6!:0 format
isotimestamp=: 3 : 0
r=. }: $y
t=. _6 [\ , 6 {."1 y
d=. '--b::' 4 7 10 13 16 }"1 [ 4 3 3 3 3 3 ": <.t
d=. d ,. }."1 [ 0j3 ": ,. 1 | {:"1 t
c=. {: $d
d=. ,d
d=. '0' (I. d=' ')} d
d=. ' ' (I. d='b')} d
(r,c) $ d
)

NB. =========================================================
NB.*todate v converts day numbers to dates
NB. converts day numbers to dates, converse <todayno>
NB.
NB. This conversion is exact and provides a means of
NB. performing exact date arithmetic.
NB.
NB. y = day numbers
NB. x = optional:
NB.   0 - result in form <yyyy mm dd> (default)
NB.   1 - result in form <yyyymmdd>
NB.
NB. examples:
NB.    todate 72460
NB. 1998 5 23
NB.
NB.    todate 0 1 2 3 + todayno 1992 2 27
NB. 1992 2 27
NB. 1992 2 28
NB. 1992 2 29
NB. 1992 3  1

todate=: 3 : 0
0 todate y
:
s=. $y
a=. 657377.75 +, y
d=. <. a - 36524.25 * c=. <. a % 36524.25
d=. <.1.75 + d - 365.25 * y=. <. (d+0.75) % 365.25
r=. (1+12|m+2) ,: <. 0.41+d-30.6* m=. <. (d-0.59) % 30.6
r=. s $ |: ((c*100)+y+m >: 10) ,r
if. x do. r=. 100 #. r end.
r
)

NB. =========================================================
NB.*todayno v converts dates to day numbers
NB. converts dates to day numbers, converse <todate>
NB.
NB. y = dates
NB. 
NB. x = optional:
NB.   0 - dates in form <yyyy mm dd> (default)
NB.   1 - dates in form <yyyymmdd>
NB. 0 = todayno 1800 1 1, or earlier
NB.
NB. example:
NB.    todayno 1998 5 23
NB. 72460

todayno=: 3 : 0
0 todayno y
:
a=. y
if. x do. a=. 0 100 100 #: a end.
a=. ((*/r=. }: $a) , {:$a) $,a
'y m d'=. <"_1 |: a
y=. 0 100 #: y - m <: 2
n=. +/ |: <. 36524.25 365.25 *"1 y
n=. n + <. 0.41 + 0 30.6 #. (12 | m-3),"0 d
0 >. r $ n - 657378
)

NB. =========================================================
NB.*tsdiff v differences between pairs of dates.
NB.
NB. form:  
NB. end tsdiff begin
NB.   end, begin are vectors or matrices in form YYYY MM DD
NB.   end dates should be later than begin dates
NB.
NB. method is to subtract dates on a calendar basis to determine
NB. integral number of months plus the exact number of days remaining.
NB. This is converted to payment periods, where # days remaining are
NB. calculated as: (# days)%365
NB.
NB. example:
NB.    1994 10 1 tsdiff 1986 5 23
NB. 8.35799

tsdiff=: 4 : 0
r=. -/"2 d=. _6 (_3&([\)) \ ,x,"1 y
if. #i=. i#i.#i=. 0 > 2{"1 r do.
  j=. (-/0=4 100 400 |/ (<i;1;0){d)* 2=m=. (<i;1;1){d
  j=. _1,.j + m{0 31 28 31 30 31 30 31 31 30 31 30 31
  n=. <i;1 2
  r=. (j + n{r) n } r
end.
r +/ . % 1 12 365
)

NB. =========================================================
NB.*tsrep v timestamp representation as a single number
NB.
NB. form: 
NB. [opt] timerep times
NB.   opt=0  convert timestamps to numbers (default)
NB.       1  convert numbers to timestamps
NB.
NB. timestamps are in 6!:0 format, or matrix of same.
NB.
NB. examples:
NB.    tsrep 1800 1 1 0 0 0
NB. 0
NB.    ":!.13 tsrep 1995 5 23 10 24 57.24
NB. 6165887097240
tsrep=: 3 : 0
0 tsrep y
:
if. x do.
  r=. $y
  'w n t'=. |: 0 86400 1000 #: ,y
  w=. w + 657377.75
  d=. <. w - 36524.25 * c=. <. w % 36524.25
  d=. <.1.75 + d - 365.25 * w=. <. (d+0.75) % 365.25
  s=. (1+12|m+2) ,: <. 0.41+d-30.6* m=. <. (d-0.59) % 30.6
  s=. |: ((c*100)+w+m >: 10) ,s
  r $ s,. (_3{. &> t%1000) +"1 [ 0 60 60 #: n
else.
  a=. ((*/r=. }: $y) , {:$y) $, y
  'w m d'=. <"_1 |: 3{."1 a
  w=. 0 100 #: w - m <: 2
  n=. +/ |: <. 36524.25 365.25 *"1 w
  n=. n + <. 0.41 + 0 30.6 #. (12 | m-3),"0 d
  s=. 3600000 60000 1000 +/ .*"1 [ 3}."1 a
  r $ s+86400000 * n - 657378
end.
)

NB. =========================================================
NB.*timestamp v format time stamps as:  23 May 1998 16:06:39
NB. y is time stamp, if empty default to current time
timestamp=: 3 : 0
if. 0 = #y do. w=. 6!:0'' else. w=. y end.
r=. }: $ w
t=. 2 1 0 3 4 5 {"1 [ _6 [\ , 6 {."1 <. w
d=. '+++::' 2 6 11 14 17 }"1 [ 2 4 5 3 3 3 ": t
mth=. _3[\'   JanFebMarAprMayJunJulAugSepOctNovDec'
d=. ,((1 {"1 t) { mth) 3 4 5 }"1 d
d=. '0' (I. d=' ') } d
d=. ' ' (I. d='+') } d
(r,20) $ d
)

tstamp=: timestamp

NB. =========================================================
NB.*valdate v validate dates
NB. form: valdate dates
NB. dates is 3-element vector
NB.       or 3-column matrix
NB.       in form YYYY MM DD
NB. returns 1 if valid
valdate=: 3 : 0
s=. }:$y
'w m d'=. t=. |:((*/s),3)$,y
b=. *./(t=<.t),(_1 0 0<t),12>:m
day=. (13|m){0 31 28 31 30 31 30 31 31 30 31 30 31
day=. day+(m=2)*-/0=4 100 400|/w
s$b*d<:day
)

NB. =========================================================
NB.*weekday v returns weekday from date, 0=Sunday ... 6=Saturday
NB. arguments as for <todayno>
NB.
NB. examples:
NB.    weekday 1997 5 23 
NB. 5
NB.    1 weekday 19970523
NB. 5

weekday=: 7: | 3: + todayno

NB. utilities for calling DLLs

cocurrent 'z'

NB.*cd   v call DLL procedure
cd=: 15!:0

NB.*memr v memory read
NB.*memw v memory write
NB.*mema v memory allocate
NB.*memf v memory free
memr=: 15!:1
memw=: 15!:2
mema=: 15!:3
memf=: 15!:4

NB.*cdf v free DLLs
NB.*cder v error information
NB.*cderx v GetLastError information
cdf=: 15!:5
cder=: 15!:10
cderx=: 15!:11

NB.*gh v allocate header
NB.*fh v free header
NB.*symget v get address of locale entry for name
NB.*symget v set array as address
NB. 15!:6  - get address of locale entry for name
NB. 15!:7  - set array as address
NB. 15!:8  - allocate header
NB. 15!:9  - free header

gh=. 15!:8
fh=. 15!:9
symget=: 15!:6
symset=: 15!:7

NB.*cdcb v callback address
cdcb=: 15!:13

NB. =========================================================
JB01=: 1
JCHAR=: 2
JSTR=: _1,JCHAR
JINT=: 4
JPTR=: JINT
JFL=: 8
JCMPX=: 16
JBOXED=: 32
JTYPES=: JB01,JCHAR,JINT,JPTR,JFL,JCMPX,JBOXED
JSIZES=: >IF64{1 1 4 4 8 16 4;1 1 8 8 8 16 8

NB. =========================================================
NB.*ic   v integer conversion
NB. conversions
NB. e.g.
NB.    25185 25699  =  _1 ic 'abcd'
NB.    'abcd'  =  1 ic _1 ic 'abcd'
NB.    1684234849 1751606885  = _2 ic 'abcdefgh'
NB.    'abcdefgh'  =  2 ic _2 ic 'abcdefgh'
ic=: 3!:4

NB.*fc   v float conversion
fc=: 3!:5

NB.*bitwise a bitwise operations
NB. (monadic and dyadic)
NB. e.g.  7  =  1 OR 2 OR 4
NB.          =  OR 1 2 4
NB.*AND  v bitwise AND (&)
NB.*OR   v bitwise OR  (|)
NB.*XOR  v bitwise XOR (^)
AND=: $:/ : (17 b.)
OR=: $:/ : (23 b.)
XOR=: $:/ : (22 b.)

NB. file access utilities
NB.
NB. read verbs take a right argument of a filename, optionally
NB. linked with one or two numbers (as for 1!:11):
NB.   0 = start of read (may be negative)
NB.   1 = length of read (default rest of file)
NB.
NB. write verbs return number of characters written.
NB.
NB. filenames may be open or boxed character or unicode strings
NB.
NB. string verbs write out text delimited with the host OS delimiter,
NB. and read in text delimited by LF.
NB.
NB. on error, the result is _1,
NB. e.g. for file not found/file read error/file write error

NB.    dat fappend fl     append
NB.    dat fappends fl    append string
NB.   verb fapplylines fl apply verb to lines of file
NB.    to  fcopynew fls   copy files (if changed)
NB.    to  fcopynews fls  copy files as strings (if changed)
NB.        fdir           file directory
NB.        ferase fl      erase file
NB.        fexist fl      return 1 if file exists
NB.    opt fread fl       read file
NB.    opt freadblock fl  read lines of file in blocks
NB.        freadr fl      read records (flat file)
NB.        freads fl      read string
NB.    dat freplace fl    replace in file
NB.    opt fselect txt    select file
NB.        fsize fl       size of file
NB.    str fss fl         string search file
NB. oldnew fssrplc fl     search and replace in file
NB.        fstamp fl      file timestamp
NB.    dat fwrite fl      write file
NB.    dat fwrites fl     write string

NB. require 'strings'

cocurrent 'z'

fboxname=: ([: < 8 u: >) :: ]

NB. =========================================================
NB.*fappend v append text to file
NB.	The text is first ravelled. The file is created if necessary.
NB. Returns number of characters written, or an error message.
NB. form: text fappend filename
NB. example:
NB.   'chatham' fappend 'newfile.txt'
NB. 7
fappend=: 4 : 0
dat=. ,x
f=. #@[ [ 1!:3
dat f :: _1: fboxname y
)

NB. =========================================================
NB.*fappends v append string to file
NB. The text is first ravelled into a vector with each row
NB. terminated by the host delimiter.
NB. The file is created if necessary. Returns number of characters
NB. written, or an error message.
fappends=: 4 : 0
dat=. x
if. -. 0 e. $dat do.
  if. 1>:#$dat do.
    dat=. toHOST dat,(-.({:dat) e. CRLF) # LF
  else.
    dat=. dat,"1 toHOST LF
  end.
end.
dat=. ,dat
f=. #@[ [ 1!:3
dat f :: _1: fboxname y
)

NB. =========================================================
NB.*fapplylines a apply verb to lines in file delimited by LF
NB.
NB. form:
NB.     lineproc fapplylines file  NB. line terminators removed
NB.   1 lineproc fapplylines file  NB. line terminators preserved
fapplylines=: 1 : 0
0 u fapplylines y
:
y=. 8 u: y
s=. 1!:4 <y
if. s = _1 do. return. end.
p=. 0
dat=. ''
while. p < s do.
  b=. 1e6 <. s-p
  dat=. dat, 1!:11 y;p,b
  p=. p + b
  if. p = s do.
    len=. #dat=. dat, LF -. {:dat
  elseif. (#dat) < len=. 1 + dat i:LF do.
    'file not in LF-delimited lines' 13!:8[3
  end.
  if. x do.
    u ;.2 len {. dat
  else.
    u ;._2 CR -.~ len {. dat
  end.
  dat=. len }. dat
end.
)

NB. =========================================================
NB.*fcopynew v copies files if changed
NB. form: tofile fcopynew fromfiles
NB. returns: 0, size    not changed
NB.          1, size    changed
NB.          _1         failure
fcopynew=: 4 : 0
dat=. fread each boxopen y
if. (<_1) e. dat do. _1 return. end.
dat=. ; dat
if. dat -: fread :: 0: x do. 0,#dat else.
  if. _1=dat fwrite x do. _1 else. 1,#dat end.
end.
)

NB. =========================================================
NB.*fcopynews v copies files as strings if changed
NB. form: tofile fcopynews fromfiles
NB. returns: 0, size    not changed
NB.          1, size    changed
NB.          _1         failure
fcopynews=: 4 : 0
dat=. freads each boxopen y
if. (<_1) e. dat do. _1 return. end.
dat=. toHOST ; dat
if. dat -: fread :: 0: x do. 0,#dat else.
  if. _1=dat fwrite x do. _1 else. 1,#dat end.
end.
)

NB. =========================================================
NB.*fdir v file directory
NB. example:
NB.   fdir jpath '~system\main\s*.ijs'
fdir=: 1!:0@fboxname

NB. =========================================================
NB.*ferase v erases a file
NB. Returns 1 if successful, otherwise _1
ferase=: (1!:55 :: _1:) @ (fboxname &>) @ boxopen

NB. =========================================================
NB.*fexist v test if a file exists
NB. Returns 1 if the file exists, otherwise 0.
fexist=: (1:@(1!:4) :: 0:) @ (fboxname &>) @ boxopen

NB. =========================================================
NB.*fread v read file
NB. y is filename {;start size}
NB. x is optional:
NB.    = b    read as boxed vector
NB.    = m    read as matrix
NB.    = s    read as string (same as freads)
fread=: 3 : 0
'' fread y
:
if. 1 = #y=. boxopen y do.
  dat=. 1!:1 :: _1: fboxname y
else.
  dat=. 1!:11 :: _1: (fboxname {.y),{:y
end.
if. dat -: _1 do. return. end.
if. (0=#x) +. 0=#dat do. dat return. end.
dat=. (-(26{a.)={:dat) }. dat
dat=. toJ dat
if. 0=#dat do. '' $~ 0 $~ >:'m'e.x return. end.
dat=. dat,LF -. {:dat
if. 'b'e.x do. dat=. <;._2 dat
elseif. 'm'e.x do. dat=. ];._2 dat
end.
)

NB. =========================================================
NB.*freadblock v read block of lines from file
NB. lines are terminated by LF
NB. blocksize is ~1e6
NB. y is filename;start position
NB. returns: block;new start position
freadblock=: 3 : 0
'f p'=. y
f=. 8 u: f
s=. 1!:4 <f
if. s = _1 do. return. end.
if. (s = 0) +. p >: s do. '';p return. end.
if. 1e6 < s-p do.
  dat=. 1!:11 f;p,1e6
  len=. 1 + dat i: LF
  if. len > #dat do.
    'file not in LF-delimited lines' 13!:8[3
  end.
  p=. p + len
  dat=. len {. dat
else.
  dat=. 1!:11 f;p,s-p
  dat=. dat, LF -. {: dat
  p=. s
end.
(toJ dat);p
)

NB. =========================================================
NB.*freadr v read records from flat file
NB. y is filename {;record start, # of records}
NB. records are assumed of fixed length delimited by
NB. one (only) of CR, LF, or CRLF.
NB. the result is a matrix of records.
freadr=: 3 : 0
'f s'=. 2{.boxopen y
f=. fboxname f
max=. 1!:4 :: _1: f
if. max -: _1 do. return. end.
pos=. 0
step=. 10000
whilst. blk = cls
do.
  blk=. step<.max-pos
  if. 0=blk do. 'file not organized in records' return. end.
  dat=. 1!:11 f,<pos,blk
  cls=. <./dat i.CRLF
  pos=. pos+step
end.
len=. cls+pos-step
dat=. 1!:11 f,<len,2<.max-len
dlm=. +/CRLF e. dat
wid=. len+dlm
s=. wid*s,0 #~ 0=#s
dat=. 1!:11 f,<s
dat=. (-wid)[\dat
(-dlm)}."1 dat
)

NB. =========================================================
NB.*freads v read file as string
NB. y is filename {;start size}
NB. x is optional (b and m same as fread):
NB.    = b    read as boxed vector
NB.    = m    read as matrix
NB. freads
freads=: 3 : 0
'' freads y
:
if. 1 = #y=. boxopen y do.
  dat=. 1!:1 :: _1: fboxname y
else.
  dat=. 1!:11 :: _1: (fboxname {.y),{:y
end.
if. (dat -: _1) +. 0=#dat do. return. end.
dat=. (-(26{a.)={:dat) }. dat
dat=. dat,LF -. {:dat=. toJ dat
if. 'b'e.x do. dat=. <;._2 dat
elseif. 'm'e.x do. dat=. ];._2 dat
end.
)

NB. =========================================================
NB.*freplace v replace text in file
NB. form: dat freplace file;pos
freplace=: 4 : 0
y=. boxopen y
dat=. ,x
f=. #@[ [ 1!:12
dat f :: _1: (fboxname {.y),{:y
)

NB. =========================================================
NB.*fselect v file selection dialog
NB. y = DOS filespec or ''
NB. x = optional file type list
NB. returns user selection
fselect=: 'All Files (*.*)|*.*'&$: : (4 : 0)
y=. y,(0 e. #y)#'*'
path=. }: y #~ b=. +./\.y=PATHSEP_j_
def=. y #~ -. b
t=. 'mbopen "Select File" "',path,'" "',def,'" '
t=. t,'"',x,'"'
t=. t,' ofn_filemustexist ofn_pathmustexist;'
wd 8 u: t
)

NB. =========================================================
NB.*fsize v return file size
NB. returns file size or _1 if error
fsize=: (1!:4 :: _1:) @ (fboxname &>) @ boxopen

NB. =========================================================
NB.*fss v file string search
NB. form: str fss file
NB. search file for string, returning indices
fss=: 4 : 0
y=. fboxname y
size=. 1!:4 :: _1: y
if. size -: _1 do. return. end.
blk=. (#x) >. 100000 <. size
r=. i.pos=. 0
while. pos < size do.
  dat=. 1!:11 y,<pos,blk <. size-pos
  r=. r,pos+I. x E. dat
  pos=. pos+blk+1-#x
end.
r
)

NB. =========================================================
NB.*fssrplc v file string search and replace
NB. form: (old;new) fssrplc file
fssrplc=: fstringreplace

NB. =========================================================
NB.*fstamp v returns file timestamp
fstamp=: (1: >@{ , @ (1!:0) @ fboxname) :: _1:

NB. =========================================================
NB.*ftype v file type
NB.
NB. return 0 = not exist
NB.        1 = file
NB.        2 = directory (optionally ending in path separator)
ftype=: 3 : 0
d=. 1!:0 fboxname y
if. #d do.
  >: 'd' = 4 { > 4 { ,d
elseif. PATHSEP_j_ = {: ucp y do.
  d=. 1!:0 fboxname }: ucp y
  2 * 'd' = 4 { > 4 { ,d
elseif. do.
  0
end.
)

NB. =========================================================
NB.*fwrite v write text to file
fwrite=: 4 : 0
dat=. ,x
f=. #@[ [ 1!:2
dat f :: _1: fboxname y
)

NB. =========================================================
NB.*fwrites v write string to file
fwrites=: 4 : 0
dat=. ":x
if. -. 0 e. $dat do.
  if. 1>:#$dat do.
    dat=. toHOST dat,(-.({:dat) e. CRLF) # LF
  else.
    dat=. dat,"1 toHOST LF
  end.
end.
dat=. ,dat
f=. #@[ [ 1!:2
dat f :: _1: fboxname y
)

NB. font.ijs     utilities for fonts
NB.
NB. Fonts are specified as: fontname size [bold] [italic]
NB. The fontname should have "" delimiters if it contains blanks.
NB.
NB. Example:
NB.   "MS Sans Serif" 14 bold eom
NB.
NB. verbs:
NB.    getfont         - returns font spec as boxed list
NB.                      fontname;size;[bold;italic]
NB.
NB.    getfontsize     - get size of a font spec
NB.    setfontsize     - set size into a font spec
NB.
NB.    changefont      - change various elements of a font spec

cocurrent 'z'

NB. =========================================================
NB.*changefont v optlist changefont fontspec
NB.
NB. optlist may contain:  bold    nobold
NB.                       italic  noitalic
NB.                       size    fontsize
NB.
NB. font should be: fontname size [bold] [italic]
NB.
NB. e.g. ('bold';20) changefont '"Lucida Console" 20' 
changefont=: 4 : 0
font=. getfont y
opt=. x
if. 0=L. opt do. opt=. cutopen ":opt end.
opt=. a: -.~ (-.&' ' @ ":) each opt
num=. _1 ~: _1 ". &> opt
if. 1 e. num do.
  font=. ({.num#opt) 1} font
  opt=. (-.num)#opt
end.
ayes=. ;:'bold italic'
noes=. ;:'nobold noitalic'
font=. font , opt -. noes
font=. font -. (noes e. opt)#ayes
}: ; ,&' ' each ~. font
)

NB. =========================================================
NB.*getfont v getfont fontspec
getfont=: 3 : 0
font=. ' ',y
b=. (font=' ') > ~:/\font='"'
a: -.~ b <;._1 font
)

NB. =========================================================
NB.*getfontsize v getfontsize fontspec
getfontsize=: 13 : '{.1{._1 -.~ _1 ". y'

NB. =========================================================
NB.*setfontsize v size setfontsize fontspec
setfontsize=: 4 : 0
b=. ~: /\ y='"'
nam=. b#y
txt=. ;:(-.b)#y
ndx=. 1 i.~ ([: *./ e.&'0123456789.') &> txt
nam, }: ; ,&' ' &.> (<": x) ndx } txt
)

NB. 2D graphics definitions

coclass 'jgl2'

PS_DASH=: 1
PS_DASHDOT=: 3
PS_DASHDOTDOT=: 4
PS_DOT=: 2
PS_INSIDEFRAME=: 6
PS_NULL=: 5
PS_SOLID=: 0

IDC_ARROW=: 32512
IDC_IBEAM=: 32513
IDC_WAIT=: 32514
IDC_CROSS=: 32515
IDC_UPARROW=: 32516
IDC_SIZENWSE=: 32642
IDC_SIZENESW=: 32643
IDC_SIZEWE=: 32644
IDC_SIZENS=: 32645
IDC_SIZEALL=: 32646
IDC_NO=: 32648
IDC_APPSTARTING=: 32650
IDC_HELP=: 32651

glarc=: 11!:2001
glbrush=: 11!:2004
glbrushnull=: 11!:2005
glcapture=: 11!:2062
glcaret=: 11!:2065
glclear=: 11!:2007
glclip=: 11!:2078
glclipreset=: 11!:2079
glcmds=: 11!:2999
glcursor=: 11!:2069
glellipse=: 11!:2008
glemfopen=: 11!:2084
glemfclose=: 11!:2085
glemfplay=: 11!:2086
glfile=: 11!:2066
glfont=: 11!:2012
gllines=: 11!:2015
glnodblbuf=: 11!:2070
glpaint=: 11!:2020
glpen=: 11!:2022
glpie=: 11!:2023
glpixel=: 11!:2024
glpixelsx=: 11!:2075
glpixels=: 11!:2076
glprint=: 11!:2089
glprintmore=: 11!:2091
glpolygon=: 11!:2029
glqextent=: 11!:2057
glqextentw=: 11!:2083
glqpixels=: 11!:2077
glqprintpaper=: 11!:2092
glqprintwh=: 11!:2088
glqtextmetrics=: 11!:2058
glqwh=: 11!:2059
glqhandles=: 11!:2060
glrect=: 11!:2031
glrgb=: 11!:2032
glroundr=: 11!:2033
glsel=: 11!:2035
gltext=: 11!:2038
gltextcolor=: 11!:2040
gltextxy=: 11!:2056
glwindoworg=: 11!:2045


NB. session definitions for grid

NB. load 'jzgrid'

NB. =========================================================
NB.*grid v display noun in grid
grid_z_=: 3 : 0
gridp_jzgrid_ y
:
(x;coname'') gridp_jzgrid_ y
)

NB. package utilities
NB.
NB. a package is a 2-column matrix of:  name, value
NB. that can be used to store nouns, or otherwise
NB. associate names and values.
NB.
NB. A name is any character vector. pack and pdef work
NB. only when the names are proper J names.
NB.
NB. definitions for nouns only:
NB.   pk=.        pack nl         create package from namelist
NB.   nl=.        pdef pk         define package
NB.
NB. definitions for any names:
NB.   text=. pk1  pcompare pk2   compare packages
NB.   val=.  name pget pk        get value of name in package
NB.   pk=.   new  pset old       merge new and old packages
NB.   pk=.   nl   pex pk         remove namelist from package
NB.   pk=.   nl   psel pk        select namelist from package
NB.   res=.  packlocale locs     package all nouns in locales

cocurrent 'z'

NB. =========================================================
NB.*pack v package namelist
NB.
NB. form:  pack 'one two three'
NB.        pack 'one';'two';'three'
pack=: [: (, ,&< ".) &> [: /:~ ;: ::]

NB. =========================================================
NB.*packlocale v package locales
NB.
NB. form: packlocale locales
NB.
NB. example: packlocale 'base';'z';'j'
NB.
NB. each locale is packaged and forms one row of the result
packlocale=: 3 : 0
ids=. , ,each boxxopen y
res=. ''
for_i. ids do.
  cocurrent i
  res=. res,< 3 : '(, ,&< ".) &> (4!:1 [ 0) -. ;:''y y.''' ''
end.
ids,.res
)

NB. =========================================================
NB.*pdef v package define
NB. form: pdef pk
pdef=: 3 : 0
if. 0 e. $y do. empty'' return. end.
names=. {."1 y
(names)=: {:"1 y
names
)

NB. =========================================================
NB.*pcompare v compare two packages
NB. form: pk1 pcompare pk2
pcompare=: 4 : 0
n0=. {."1 x -. y
n1=. {."1 x
n2=. {."1 y
list=. ;:^:_1
r=. ''
r=. r,(*#d)#LF,'not in 1: ',list d=. n2 -. n1
r=. r,(*#d)#LF,'not in 2: ',list d=. n1 -. n2
r=. r,(*#n)#LF,'not same in both: ',list n=. n0 -. d
}.r,(0=#r)#LF,'no difference'
)

NB. =========================================================
NB.*pex v remove namelist from package
NB. form: namelist pex pk
pex=: ] -. psel

NB. =========================================================
NB.*pget v return value of name in package
NB. form: name pget pk        - return value of name in package
pget=: 13 : '> {: y {~ ({."1 y) i. {. boxopen,x'

NB. =========================================================
NB.*psel v select namelist from package
NB. form: namelist psel pk
psel=: 13 : 'y {~ ({."1 y) i. ;: ::] x'

NB. =========================================================
NB.*pset v merge new into old
NB. form: new pset old
NB. result has values in new, plus remaining values in old
pset=: (#~ [: ~: {."1) @ ,

coclass 'pcustidx'


TITLE=: 'Customised Indexes'

NB. DBFILE=: jpath '~user/projects/custidx/custidx_tst.sqlite'
DEVOPTS=: OPTIONS_jzgrid_

create=: 3 : 0
  dbcon=: db=: ''
  wd 'fontdef "MS Sans Serif" 10'
  wd F
  wd 'set tab Address Scenario Price_Profile REVs Index_List'
  wd 'setselect tab 0'
  showFlip 0
  editingTable 0
  chwsingProfile 0
  addingTable 1
  wd 'setenable btcalcREVs 0'
  connect DBFILE=: y
  wd 'pshow;'
)

destroy=: 3 : 0
  NB.   if. 0=checkDirty'' do. return. end.
  connect''
  wd'pclose'
  destroy__grid ''
  codestroy''
)

MBO_DB=: 'SQLite (*.sqlite)|*.sqlite|SQLite (*.db)|*.db|All files (*.*)|*.*'

openDb=: 3 : 0
  wd 'mbopen "Open Client database" "" "" "',MBO_DB,'" ofn_createprompt ofn_pathmustexist'
)

NB. =========================================================
NB. controller

connect=: 3 : 0
  if. #db do. destroy__db'' end.
  dbcon=: db=: ''
  if. 0=#y do. return. end.
  dbcon=: y
  db=: 'psqlite' conew~ dbcon
  setTitle dbcon
  viewClients getClients ''
  wd 'setselect lsObj 0'
  clid=: 0 { _1,CLIDS
  grid=: i.0  NB. otherwise crash cause gets grid_z_ when grid not defined in class
  viewTable i.0 0
)

'TAB_ADD TAB_SCN TAB_PRP TAB_REV TAB_IDX'=: i.5

redisplaygrd=: 3 : 0
  tab_select=: ".tab_select
  lsObj_select=. ".lsObj_select
  NB.   if. lsObj_select-: i.0 do. '' return. end.
  clid=: lsObj_select { _1,CLIDS
  viewTable tab getTable clid
  wd 'setenable btAdd ', ": -.(clid=_1) *. (-.tab-: 'Address')
  t=. (tab-: 'REVs') *. (+:/; a: -: each 2{._3}."1 chk) *. ((3$a:) -: _3{."1 chk=. {: 'chkoldREVs' getTable clid)
  wd 'setenable btcalcREVs ', ": t
  ''
)

setTitle=: 3 : 0
  wd 'pn *',y,' - ',TITLE
)

NB. checkDirty=: 3 : 0
NB.   if. CELLDATA -: CELLDATA__grid do.
NB.     1 return. end.
NB.   if. a=. 3 wdquery TITLE;'Data changed',LF,'Would you like to save?' do.
NB.     -.<:a return.end.
NB.   saveTable EDITTAB
NB. )


NB. =========================================================
NB. view

viewClients=: 3 : 0
  if. 0=#y do. return. end.
  CLIDS=: >{:"1 }.y
  dat=. (<'New Client'),}:"1 }.y
  wd 'set lsObj *',(TAB,LF) delim dat
)

viewTable=: 3 : 0
  'grddef' viewTable y
  :
  erase DEVOPTS
  if. 0=#y do.
    0!:100 grddefEmpty
  else.
    addingTable 0
    CELLDATA=: y
    CELLFONTS=: '"MS Sans Serif" 10';'Arial 12'
    CELLFONT=: 0
    GRIDFLIP=: *./ -.;('Price_Profile';'Index_List') -:each <tab
    0!:100 ". x,tab
  end.
  nms=. (0 = 4!:0 DEVOPTS) # DEVOPTS
  pkg=. nms,.".each nms
  if. #grid do.
    destroy__grid''
  end.
  grid=: ''conew'jzgrid'
  GRIDLOC=: grid
  show__grid pkg
)

saveTable=: 3 : 0
  if. CELLDATA -: CELLDATA__grid do. 1 return.
  else.
  NB. code to update/add data to DB
    CELLDATA=: CELLDATA__grid
    select. y
      case. 'Address' do.
        if. clid=_1 do. NB. new client
          clid=: y insertDBTable CELLDATA
          viewClients getClients ''
          wd 'setselect lsObj ', ": (_1,CLIDS) i. clid
        else.  NB. updating
          y updateDBTable CELLDATA,.<clid  NB. update edits to current clid
        end.
      case. 'Scenario' do.
        ('valid',y) updateDBTable (day=. 10{.isotimestamp 6!:0 '');clid NB. update validuntil of current scenario
        dat=. (day;clid)(,"1) }."1 CELLDATA
        scid=. y insertDBTable dat NB. insert edited scenario as new record with null validuntil
        y handlDBREVs scid NB. update REVs as req'd
      case. 'Price_Profile' do.
        if. HDRROW -: '' do.  NB. saving custom prices
          ppid=. ('new',y) insertDBTable (<10{.isotimestamp 6!:0 ''), <clid
          dat=. (I.((<0)~: val) *. a:~: val=. {:"1 CELLDATA) { CELLDATA NB. drop where price is zero or null
          'newPrices' insertDBTable (<ppid),.dat
        else.  NB. chosen existing profile
          colch=. (I. >{.CELLDATA)
          ppid=. colch { >PPids
        end.
        y handlDBREVs ppid NB. update REVs as req'd
      case. 'REVs' do.
        if. +./ ;a:-:each 1 2{"1 CELLDATA  do. NB. creating new one with manual REVs
          ('valid',y) updateDBTable (day=. 10{.isotimestamp 6!:0 '');clid NB. update current rev to no longer current ??OK for no current??
          dat=. (day;clid)(,"1) 3}."1 CELLDATA
          ('man',y) insertDBTable dat NB. insert new rev with new/old sc_id & old/new pp_id but NULL for rv_mfd rv_cfw & rv_value
        else.  NB. saving calculated client REVs
          ('clientcalc',y) updateDBTable 3}."1 CELLDATA,.<clid
        end.
    end.
    1
  end.
)

handlDBREVs=: 4 : 0
  oldrevs=. 'chkoldREVs' getTable clid
  fkeyids=. 2{.}.{:oldrevs
  try.
    fkeyids=. (('s';'p')-:each tolower {.": x) {"0 1 fkeyids,"0 <y
  catch.
  NB. no valid rev record for client ids, default to null
    fkeyids=. a:,a:
    fkeyids=. (('s';'p')-:each tolower {.": x) {"0 1 fkeyids,"0 <y
  end.
  if. (3$a:) -: _3{."1 {: oldrevs do. NB. if new rev already created
    'fkeysREVs' updateDBTable fkeyids,{.{:oldrevs NB. update current rev with new id
  else.
    'validREVs' updateDBTable (day=. 10{.isotimestamp 6!:0 '');clid NB. update current rev to no longer current ??OK for no current??
    dat=. day;clid;fkeyids
    'newREVs' insertDBTable dat NB. insert new rev with new/old sc_id & old/new pp_id but NULL for rv_mfd rv_cfw & rv_value
  end.
)

chooseProfile=: 3 : 0
  if. CELLDATA-:i.0 0 do.  NB. no current profile
    crPrf=. 23  NB. use ID of Custom profile
  else.
    crPrf=. ;}.'currentPrice_Profile' getTable y
  end.
  tbl=. |: cast 'choosePrice_Profile' getTable crPrf
  PPids=: }. {. tbl
  tbl=. }.tbl
  ndx=. ({.tbl) i. <'Custom'
  tbl=. (<'Custom') (<0;ndx)} (<i.0) (ndx)}"1 tbl NB. replace zeros with empty cell
  sel=. '';<&>  1 ((>PPids) i. crPrf)}(<:{:$tbl)$0
  tbl=. _1|. sel, 1|.tbl NB. insert boolean 2nd row for checkboxes
  NB.   tbl=. (<'MFD') (<0;0)}tbl
  'grddefch' viewTable tbl
  chwsingProfile 1
)

editCustom=: 3 : 0
  'grddefcust' viewTable  ;:'dummy data'
  wd 'setfocus grid'
)

NB. =========================================================
NB. model

getClients=: 3 : 0
  query__db sqlsel_Clients
)

getTable=: 4 : 0
  y query__db ".'sqlsel_',x
)

updateDBTable=: 4 : 0
  y apply__db ". 'sqlupd_',x
)

insertDBTable=: 4 : 0
  if. (L.=0:) x do.
    sql=. ". 'sqlins_',x
  else.
    'x blb'=. x
    sql=. (". 'sqlins_',x);blb
  end.
  y apply__db sql
)

NB. =========================================================
NB. interface

showFlip=: 3 : 0
  wd 'setshow btFlip ',": y
)

editingTable=: 3 : 0
  wd 'setenable btEdit ', ":-.y
  wd 'setenable btSave ', ": y
  wd 'setenable btCancel ', ": y
  wd 'setenable lsObj ', ":-.y
  wd 'setenable tab ', ":-.y
  wd 'setfocus grid'
  if. y do.
    CELLEDIT__grid=: (". 'celledit',tab) mkmask CELLDATA NB. get appropriate array for current tab
  else.
    try. CELLEDIT__grid=: 0 catch. end.
  end.
)

addingTable=: 3 : 0
  wd 'setshow btAdd ', ": y
  wd 'setshow btEdit ', ": -.y
)
chwsingProfile=: 3 : 0
  wd 'setshow btSave ', ": -.y
  wd 'setshow btChoose ', ": y
)


NB. =========================================================
NB. utils

NB. ---------------------------------------------------------
getColumns=: 3 : 0
  NB. getColNames v gets boxed names of fields in table
  strquery__db 'PRAGMA table_info(',y,');'
)

NB. ---------------------------------------------------------
NB.*getColNames v gets boxed names of fields in table
getColNames=: 3 : 0
  }. 1 {"1 getColumns y
)

NB. ---------------------------------------------------------
NB.*delim v delimits 1d or 2d array
NB.  y is 1d or 2d array
NB.  x is optional 1 or 2 element vector of intra-line and end-of-line delimiters
NB.    default intra-line delimiter is ','
NB.    default end-of-line delimiter is LF if x not given or 1=#x
NB.  eg. ',;' delim i.4 5
NB.  eg. delim i.4 5
delim=: 3 : 0
  (',',LF) delim y
  :
  select. #x
    case. 1 do. NB. assume only intra-line delimiter specified
      (x,LF) delim y
    case. 2 do.
      if. 2<L. x do. NB. report arg error
      elseif. 2>L. x do.
        x=. <each x
      end.
      'il eol'=. x
      y=. 8!:0 y
      b=. 0>._1+2*{:$y
      b=. b$1 0      NB. calc boolean
      ;eol,"1~ b &#^:_1!.il"1 y
    case. do.
    NB. report arg error
  end.
)

NB. =========================================================
NB. Customised Indexes form definition

F=: 0 : 0
pc f nomax;
menupop "&File";
menu con "&Connect" "" "" "";
menusep;
menu exit "E&xit" "" "" "";
menupopz;
menupop "&Tools";
menu updAllREVs "&Update All REVs" "" "" "";
menusep;
menu impCat "&Import Sale Catalogue" "" "" "";
menu viewCat "&View Sale Catalogue" "" "" "";
menupopz;
menupop "&Help";
menu about "&About" "" "" "";
menupopz;
xywh 21 10 50 10;cc ccstatic static;cn "Clients";
xywh 17 22 64 149;cc lsObj listbox ws_vscroll es_autovscroll es_autohscroll bottommove;
xywh 90 8 205 188;cc tab tab bottommove rightmove;
xywh 96 23 195 172;cc grid isigraph bottommove rightmove;
xywh 300 21 57 16;cc btEdit button leftmove rightmove;cn "&Edit";
xywh 300 41 57 16;cc btSave button leftmove rightmove;cn "&Save Changes";
xywh 300 61 57 16;cc btCancel button leftmove rightmove;cn "&Cancel Changes";
xywh 300 81 57 16;cc btcalcREVs button leftmove rightmove;cn "Calculate &REVs";
xywh 300 101 57 16;cc btFlip button leftmove rightmove;cn "&Flip";
xywh 312 177 44 12;cc btClose button leftmove rightmove;cn "Close";
xywh 300 41 57 16;cc btChoose button leftmove rightmove;cn "C&hoose Profile";
xywh 300 21 57 16;cc btAdd button leftmove rightmove;cn "&Add";
pas 6 6;pcenter;
rem form end;
)

f_close=: destroy
f_btClose_button=: destroy
f_exit_button=: destroy

f_lsObj_select=: redisplaygrd
f_tab_button=: redisplaygrd

f_btFlip_button=: 3 : 0
  if. (i.0 0) -: CELLDATA do. return. end.
  flip__grid ''
)

f_con_button=: 3 : 0
  if. 0=#f=. openDb'' do. return. end.
  connect DBFILE=. f
)

f_btEdit_button=: 3 : 0
  editingTable 1
  select. tab
    case. 'Price_Profile' do.
      chooseProfile clid
      return.
    case. 'REVs' do.
      'grddefnew' viewTable ;:'dummy data'
      return.
  end.
  show__grid ''
)

f_btAdd_button=: 3 : 0
  select. tab
    case. 'Address';'Scenario';'REVs' do.
      'grddefnew' viewTable ;: 'dummy data'
    case. 'Price_Profile' do.
      f_btEdit_button ''
      return.
  end.
  editingTable 1
  show__grid ''
)

f_btSave_button=: 3 : 0
  editingTable 0
  saveTable tab
  redisplaygrd ''
)

f_btChoose_button=: 3 : 0
  colch=. (I. >{.CELLDATA__grid)
  chwsingProfile 0
  if. 'Custom'-: colch{:: ,}.HDRCOL do.  NB. define custom prices
    editCustom ''
  else.
    f_btSave_button ''
  end.
)

f_btCancel_button=: 3 : 0
  chwsingProfile 0
  editingTable 0
  redisplaygrd ''
)

f_btcalcREVs_button=: 3 : 0
  NB. calc REVs for client based on rv_pp & rv_scenario
  NB. leave in editingTable mode so can save or cancel change
  revs=. clid getNewREVs 'updateclientREVs'
  CELLDATA__grid=: ( _3}."1 CELLDATA__grid),. <&> (3{."1 revs)
  editingTable 1  NB. enable save/cancel buttons
  CELLEDIT__grid=: 0  NB. but no editing
  show__grid ''
)

f_updAllREVs_button=: 3 : 0
  NB. calc REVs for all clients that need updated REVs based on their rv_pp & rv_scenario
  NB. update to database
  revs=. '' getNewREVs 'all2updateREVs'
  nupd=. 'calcREVs' updateDBTable revs
  redisplaygrd ''
  wdinfo 'REVs calculated';(": #nupd), ' client REVs recalculated.'
)

f_impCat_button=: 3 : 0
  importCatalog ''
)

f_viewCat_button=: 3 : 0
  viewCatalog ''
)

NB. IDEAS for event handlers
NB. would like to let F2 start edit of cell in grid
NB. would like LeftArrow, RightArrow while in listbox to cycle through tabs

grid_gridhandler=: 3 : 0
  if. y -: 'change' do.
    changex__grid''
    if. (tab-:'Price_Profile') *. (0 = Row__grid) do.
      CELLDATA__grid=: (<&>1 (Col__grid)} Ccls__grid#0) (0)}CELLDATA__grid
    end.
  end.
)

custidx_z_=: conew&'pcustidx'

NB. =========================================================
NB. SQL commands for Customised indexes application

sqlsel_Clients=: 0 : 0
  SELECT cl_lname,cl_initial,cl_id
  FROM clients
  WHERE cl_status=1
  ORDER BY cl_lname;
)

sqlsel_Address=: 0 : 0
  SELECT cl_lname,cl_fname,cl_title,cl_initial,
         cl_addr,cl_city,cl_email,cl_ph,cl_fax,cl_mob
  FROM clients
  WHERE cl_id=?;
)

sqlupd_Address=: 0 : 0
  UPDATE clients
  SET cl_lname=?,cl_fname=?,cl_title=?,cl_initial=?,
      cl_addr=?,cl_city=?,cl_email=?,cl_ph=?,cl_fax=?,cl_mob=?
  WHERE cl_id=?;
)

sqlins_Address=: 0 : 0
  INSERT INTO clients (cl_lname,cl_fname,cl_title,cl_initial,cl_addr,cl_city,cl_email,cl_ph,cl_fax,cl_mob)
  VALUES(?,?,?,?,?,?,?,?,?,?);
)

sqlsel_Scenario=: 0 : 0
  SELECT sc_year,sc_ewes2ram,sc_yrs_ram,sc_pct_lmb,
     sc_ret_elmb,sc_ret_ehog,sc_yrs_ewe,
     sc_cfw_ehog,sc_mfd_ehog,sc_cfw_ewe,sc_mfd_ewe,
     sc_ret_wlmb,sc_ret_whog,sc_yrs_weth,
     sc_cfw_whog,sc_mfd_whog,sc_cfw_weth,sc_mfd_weth
  FROM scenarios
  WHERE sc_client=?
  AND sc_validuntil IS NULL;
)
sqlsel_calcrevsScenario=: 0 : 0
  SELECT sc_ewes2ram, sc_yrs_ram, sc_pct_lmb, 
     sc_ret_elmb,sc_ret_wlmb,sc_ret_ehog,sc_ret_whog,
     sc_yrs_ewe,sc_yrs_weth,
     sc_cfw_ehog,sc_cfw_whog,sc_cfw_ewe,sc_cfw_weth,
     sc_mfd_ehog,sc_mfd_whog,sc_mfd_ewe,sc_mfd_weth
  FROM scenarios
  WHERE sc_id=?;
)

sqlupd_validScenario=: 0 : 0
  UPDATE scenarios
  SET sc_validuntil = ?
  WHERE sc_validuntil IS NULL AND sc_client=? ;
)

sqlins_Scenario=: 0 : 0
  INSERT INTO scenarios (sc_year,sc_client,sc_ewes2ram,sc_yrs_ram,sc_pct_lmb,sc_ret_elmb,sc_ret_ehog,sc_yrs_ewe,sc_cfw_ehog,sc_mfd_ehog,sc_cfw_ewe,sc_mfd_ewe,sc_ret_wlmb,sc_ret_whog,sc_yrs_weth,sc_cfw_whog,sc_mfd_whog,sc_cfw_weth,sc_mfd_weth)
  VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) ;
)

sqlsel_Price_Profile=: 0 : 0
  SELECT pp_year, pr_mfd, pr_price
  FROM (price_profiles INNER JOIN prices ON pp_id = pr_pp) 
       INNER JOIN revs ON pp_id = rv_pp
  WHERE rv_client=? AND rv_validuntil IS Null
  ORDER BY pr_mfd;
)

sqlsel_calcpricePrice_Profiles=: 0 : 0
  SELECT rv_id, pr_mfd, pr_price
  FROM (price_profiles INNER JOIN prices ON pp_id = pr_pp) 
       INNER JOIN revs ON pp_id = rv_pp
  WHERE rv_id=?
  ORDER BY rv_id,pr_mfd;
)

NB. sqlsel_choosePrice_Profile=: 0 : 0
NB. SELECT pr_pp, pp_year, pr_mfd, pr_price
NB. FROM (price_profiles INNER JOIN prices ON pp_id = pr_pp) LEFT JOIN revs ON pp_id = rv_pp
NB. WHERE (rv_validuntil Is Null AND rv_client=?) OR (pp_client Is Null)
NB. ORDER BY pp_client DESC, pp_year DESC, pr_mfd;
NB. )
sqlsel_choosePrice_Profile=: 0 : 0
SELECT pr_pp, pp_year, pr_mfd, pr_price
FROM (price_profiles INNER JOIN prices ON pp_id = pr_pp)
WHERE (pp_id=?) OR (pp_client Is Null)
ORDER BY pp_client DESC, pp_year DESC, pr_mfd;
)

sqlsel_currentPrice_Profile=: 0 : 0
SELECT rv_pp
FROM revs
WHERE rv_validuntil IS NULL AND rv_client=? ;
)

sqlins_newPrice_Profile=: 0 : 0
  INSERT INTO price_profiles (pp_year,pp_client)
  VALUES(?,?) ;
)
sqlins_newPrices=: 0 : 0
  INSERT INTO prices (pr_pp,pr_mfd,pr_price)
  VALUES(?,?,?) ;
)
sqlsel_REVs=: 0 : 0
  SELECT rv_year,rv_scenario,rv_pp,rv_cfw,rv_mfd,rv_value
  FROM revs
  WHERE rv_client=?
  AND rv_validuntil IS NULL;
)

sqlsel_chkoldREVs=: 0 : 0
  SELECT rv_id,rv_scenario,rv_pp,rv_cfw,rv_mfd,rv_value
  FROM revs
  WHERE rv_client=?
  AND rv_validuntil IS NULL;
)

sqlsel_all2updateREVs =: 0 : 0
  SELECT rv_id, rv_pp, rv_scenario
  FROM revs
  WHERE rv_validuntil IS NULL AND rv_mfd IS NULL
        AND rv_pp IS NOT NULL AND rv_scenario IS NOT NULL;
)

sqlsel_updateclientREVs =: 0 : 0
  SELECT rv_id, rv_pp, rv_scenario
  FROM revs
  WHERE rv_client=? AND rv_validuntil IS NULL;
)

sqlupd_fkeysREVs=: 0 : 0
  UPDATE revs
  SET rv_scenario=?,rv_pp=?
  WHERE rv_id=?;
)

sqlupd_validREVs=: 0 : 0
  UPDATE revs
  SET rv_validuntil = ?
  WHERE rv_validuntil IS NULL AND rv_client=? ;
)

sqlupd_clientcalcREVs=: 0 : 0
  UPDATE revs 
  SET rv_cfw=?,rv_mfd=?,rv_value=?
  WHERE rv_client=? AND rv_validuntil IS NULL;
)

sqlupd_calcREVs=: 0 : 0
  UPDATE revs 
  SET rv_cfw=?,rv_mfd=?,rv_value=?
  WHERE rv_id=? ;
)

sqlins_newREVs=: 0 : 0
  INSERT INTO revs (rv_year,rv_client,rv_scenario,rv_pp)
  VALUES(?,?,?,?) ;
)

sqlins_manREVs=: 0 : 0
  INSERT INTO revs (rv_year,rv_client,rv_cfw,rv_mfd,rv_value)
  VALUES(?,?,?,?,?) ;
)

sqlsel_Index_List=: 0 : 0
  SELECT rv_id,rv_client,rv_cfw,rv_mfd,rv_value
  FROM revs
  WHERE rv_client=? AND rv_validuntil IS NULL;
)

sqlsel_yrsCatalog=: 0 : 0
  SELECT ct_year
  FROM catalogs;
)

sqlsel_viewCatalog=: 0 : 0
  SELECT ct_catalog
  FROM catalogs
  WHERE ct_year=? ;
)

sqlins_impCatalog=: 0 : 0
  INSERT INTO catalogs (ct_year,ct_catalog)
  VALUES (?,?);
)



NB. =========================================================
NB. Definitions for Grid control in Customised Index application
grddefEmpty=: 0 : 0
  CELLDATA=: i.0 0
  HDRCOL=: ''
  HDRROW=: ''
  addingTable 1
)

grddefAddress=: 0 : 0
  CELLDATA=: }.CELLDATA
  CELLCOLOR=: 2|i.{:$CELLDATA
  CELLEDIT=: 0
  COLMINWIDTH=: 0 100
  HDRCOL=: ;: 'Lastname Firstname Title Initial Address City Email Phone Fax Mobile'
  HDRCOLALIGN=: 2
  HDRROW=: ''
)
grddefnewAddress=: 0 : 0
  CELLCOLOR=: 2|i.{:$CELLDATA
  HDRCOL=: ;: 'Lastname Firstname Title Initial Address City Email Phone Fax Mobile'
  HDRCOLALIGN=: 2
  HDRROW=: ''
  CELLDATA=: |:,.($HDRCOL)$<''
  COLMINWIDTH=: 0 200
)
grddefScenario=: 0 : 0
  CELLDATA=: }.CELLDATA
  CELLCOLOR=: 2|i.{:$CELLDATA
  CELLEDIT=: 0
  CELLFMT=: <;._2 '0 0 0 0.1 0.1 0.1 0 0.2 0.2 0.2 0.2 0.1 0.1 0 0.2 0.2 0.2 0.2 '
  hc=. 'Created;Ewes to Ram;Years Ram Used;Lambing %;'
  hc=. hc,'% of Ewe lambs retained;% of Ewe hoggets retained;'
  hc=. hc,'Years Ewes kept;Ewe hogget CFW;Ewe hogget MFD;Ewe CFW;Ewe MFD;'
  hc=. hc,'% Wether lambs retained;% Wether hoggets retained;'
  hc=. hc,'Years Wethers kept;Wether hogget CFW;Wether hogget MFD;Wether CFW;Wether MFD;'
  HDRCOL=: <;._2 hc
  HDRCOLALIGN=: 2
  HDRROW=: ''
)
grddefnewScenario=: 0 : 0
  CELLFMT=: <;._2 '0 0 0 0.1 0.1 0.1 0 0.2 0.2 0.2 0.2 0.1 0.1 0 0.2 0.2 0.2 0.2 '
  hc=. 'Created;Ewes to Ram;Years Ram Used;Lambing %;'
  hc=. hc,'% of Ewe lambs retained;% of Ewe hoggets retained;'
  hc=. hc,'Years Ewes kept;Ewe hogget CFW;Ewe hogget MFD;Ewe CFW;Ewe MFD;'
  hc=. hc,'% Wether lambs retained;% Wether hoggets retained;'
  hc=. hc,'Years Wethers kept;Wether hogget CFW;Wether hogget MFD;Wether CFW;Wether MFD;'
  HDRCOL=: <;._2 hc
  HDRCOLALIGN=: 2
  HDRROW=: ''
  CELLDATA=: |:,. ({.6!:0 '');(<:$HDRCOL)$a:
  CELLCOLOR=: 2|i.{:$CELLDATA
)

grddefPrice_Profile=: 0 : 0
  CELLDATA=: }.CELLDATA
  CELLEDIT=: 0
  CELLFMT=: <;._2 '0.0 0.1 0.2 '
NB.   COLSCALE=: 1
  HDRCOL=: <;._2 'Created;MFD;Price/kg;'
  HDRCOLALIGN=: 2
  HDRROW=:''
)
grddefchPrice_Profile=: 0 : 0
  HDRTOP=: <'MFD'
  hc=. 8!:0 }.{.CELLDATA
  HDRCOL=: hc,:~(<'Client Defined') (i.>: hc i. <'Custom')}($hc)$<'     Industry Averages'
  HDRCOLMERGE=:1 0
  HDRROW=: 8!:0 {."1 }.y
  CELLDATA=: }."1 }. CELLDATA
  CELLTYPE=: 100 (0)}($CELLDATA)$0
NB.   CELLEDIT=: 1
  CELLEDIT=: 1 (0)}($CELLDATA)$0
NB.   GRIDFLIP=: -.GRIDFLIP
  HDRCOLALIGN=:2,:~0=i.~{.HDRCOL    NB. (#hc)$"1,.0 2
)
grddefcustPrice_Profile=: 0 : 0
  CELLDATA=: (<&>13 + i.12),.12$a:
  CELLEDIT=: 1
NB.   GRIDFLIP=: -.GRIDFLIP
  HDRROW=: ''
  HDRCOL=: 'MFD';'Price/kg'
)

grddefREVs=: 0 : 0
  CELLDATA=: }.CELLDATA
  CELLEDIT=: 0
  CELLCOLOR=: 2|i.{:$CELLDATA
  CELLFMT=: <;._2 '0.0 0.0 0.0 0.2 0.2 c0.2 '
  HDRCOL=: <;._2 'Created;Scenario ID;Price Profile ID;CFW REV;MFD REV;Index Unit value;'
  HDRROW=: ''
)

grddefnewREVs=: 0 : 0
  CELLDATA=: |:,. ({. 6!:0 '');a:,a:, <&> 1 1 1  NB. yr,null,null,default,default,default
  CELLCOLOR=: 2|i.{:$CELLDATA
  CELLFMT=: <;._2 '0.0 0.0 0.0 0.2 0.2 c0.2 '
  CELLEDIT=: celleditREVs mkmask CELLDATA
  HDRCOL=: <;._2 'Created;Scenario ID;Price Profile ID;CFW REV;MFD REV;Index Unit value;'
  HDRROW=: ''
)

grddefIndex_List=: 0 : 0
  defIndexList ''
)

NB.   verb because can't have if.else. in noun script
defIndexList=: 3 : 0
  if. +./ >a: -:each _3{.{:CELLDATA do. NB. check that none of rv_mfd, rv_cfw or rv_value is empty
    0!:100 grddefEmpty
  else.
    CELLDATA=: calcIndexList CELLDATA
    HDRTOP=:  1{.{.CELLDATA
    HDRCOL=:  1}.{.CELLDATA
    CELLFMT=: <;._2 '0 m<$->p<$>c0.2 0 0.2 0.1 0.1 0.2 0.1 0.1 0.2 0.1 0.1 0.1 0.1 0.1 0.1 0 0.1 '
    HDRROW=:  (8!:0) 1{."1 }.CELLDATA
    CELLDATA=: 1}."1 }.CELLDATA
    CELLDRAW=: CELLDATA
    GRIDSORT=: 1
    CELLEDIT=: 0
  end.
)

mkmask=: 4 : '({:$y) ($!.1) x# 0'  NB. x is number of non-editable cells at start, y is matrix

celleditAddress=: 0   NB. number of non-editable columns from start
celleditScenario=: 1
celleditPrice_Profile=: 1
celleditREVs=: 3
celleditIndex_List=: 18

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

NB. =========================================================
NB.Calculates REVs for Forest Range Station clients

NB. ---------------------------------------------------------
NB.*getNewREVs v finds revs that need calculating, calculates them and updates database
NB.   z is 4-col matrix (rv_cfw,rv_mfd,rv_value,rv_id)
NB.   y is string indicating the SQL command to run 
NB.   x is optional vector of client ids
getNewREVs=: 3 : 0
  '' getNewREVs y
  :
  rvs=.   > }. y getTable x
  'scslbls scs'=. getScenarios {:"1 rvs
  wvg=. (3}.each scslbls) calcWoolValueGrid |: scs
  rvids=. 0{"1 rvs
  'twvs sumry'=. rvids calcTotWoolValues wvg
  revs=. (|: >2{.sumry) calcREVs twvs
  revs,. rvids
)

NB. =========================================================
NB.  Determine $/kg sale price

NB. ---------------------------------------------------------
NB.*getPrices v gets 1 or more prices for 1 or more price profiles
NB. x is vector of rv_ids to get prices for
NB. y is boxed vector of mfds to get prices for, for each rv_id
NB. output is vectors of prices boxed by rv_id
getPrices=: 4 : 0
  y=. <^:(L. = 0:) y  NB. box if not boxed (1 profile)
  profiles=. getProfiles x   NB. get profile for each rvid
  profiles calcPrices y
)

NB. ---------------------------------------------------------
NB.*getProfiles v gets 1 or more price profiles
NB.   z is vector of boxed price profile matrices. One box for each rv_id
NB.   y is vector of rv_ids to get price profiles for
getProfiles=: 3 : 0
  profs=. > }. 'calcpricePrice_Profiles' getTable y 
  if. -.profs-: 0 3$'' do.
    pp=. {."1 profs
    ((_1}.pp~:1|.pp),1) <;.2 profs NB. box profiles by profile
  end.
)

NB. ---------------------------------------------------------
NB.*calcPrices v calculates prices for fibre diameters based on 1 or more price profiles
NB. x is boxed tables of price profiles
NB. y is vectors of mfds to get prices for boxed by price profile
NB. output is vectors of prices boxed by price profiles
NB. when price is out of profile range extrapolates slope
calcPrices=: 4 : 0
  mfds=. 1{"1 each x
  prices=. _1{."1 each x
  idxs=. 0 >.each <:each +/each mfds (<:"0 1) each y
  NB.   idxs=. <:each mfds I. each x
  diffs=. 2-/\each prices
  diffs=. diffs,each _1{.each diffs NB. handle mfds bigger that profile
  diffs=. (y-each idxs{each mfds) * each idxs{each diffs
  ,each(idxs{each prices) -each diffs
)

NB. =========================================================
NB.  Calculating Profit function and sensitivity

NB. ---------------------------------------------------------
NB.*getScenarios v Gets scenario data given vector of sc_id's
NB.   returns 2-element boxed vector
NB.       0{z is boxed vector of column labels from scenarios table
NB.       1{z is boxed matrix of rows from scenarios table with requested sc_ids
NB.   y is vector of sc_ids
getScenarios=: 3 : 0
  scs=. 'calcrevsScenario' getTable y
  ({. ,&< >&}.) scs
)

NB. ---------------------------------------------------------
NB.*calcWoolValueGrid v calculates stock profile and massages fleece data
NB.   returns a 3d array:3 planes (nanims, cfw, mfd)
NB.                      1 row for each id
NB.                      4 columns of stock classes (ewe hogs, weth hogs, ewes, weths)
NB.   x is boxed vector of column labels of scenarios table with first 3 characters dropped
NB.   y is matrix with col for each sc_id and row for each column of scenarios
NB. form: (3{.each tablelabels) CalcWoolValueGrid (|: }. scenarios)
calcWoolValueGrid=: 4 : 0
  ewes2ram=. (x i. <'ewes2ram') { y
  yrs_ram=. (x i. <'yrs_ram') { y
  pct_lmb=. (x i. <'pct_lmb') { y
  nlmbs=. ewes2ram*yrs_ram*pct_lmb%100
  colsstarting=. ] {~ [: I. [: > (3{. each x) -:&.> [
  pct_retnd=. (<'ret') colsstarting y
  yrs_kept=. }. (<'yrs') colsstarting y NB. drop yrs_ram
  cfw=. (<'cfw') colsstarting y
  mfd=. (<'mfd') colsstarting y
  nanims=. 0.5* nlmbs *"1 (2{. pct_retnd%100) NB. hogget numbers
  nanims=. nanims, yrs_kept * nanims * _2{. pct_retnd%100 NB. append adult numbers
  |:(nanims),"0 1 cfw,"0 mfd
)

NB. ---------------------------------------------------------
NB.*calcTotWoolValues v calculates sensitivity table of Total Wool Value to MFD and CFW
NB. returns boxed vector 2=#z
NB.   0{z is array of sensitivity data.
NB.                planes for each price_profile_id.
NB.                25 rows for each plane
NB.                7 cols (mu,cfw,mfd,cfw*cfw,mfd*mfd,cfw*mfd,profit)
NB.   1{z is 5-element boxed vector of (#x)-element vectors
NB.                avgCFW,avgMFD,avgPrice,totAnimsShorn,totWoolShorn
NB. x is vector of price_profile_ids
NB. y is an array with 3 planes (nanims, cfw, mfd)
NB.                    1 row for each id
NB.                    4 columns of stock classes (ewe hogs, weth hogs, ewes, weths)
NB. form: price_profile_ids CalcTotWoolValues wool_value_grid
calcTotWoolValues=: 4 : 0
  nanims=. {.y
  delta=. ,"2 |: > { 2 # <0.1*i:2 NB. sensitivity table for delta_CFW & delta_MFD
  flc=. (}. y) +/"1 delta NB. array of alternative mfd & cfw vals for each scenario
  cfw=. {. flc
  mfd=. {: flc
  prc=. x getPrices (,each <"2 mfd)
  prc=. (}.$mfd)$"1 >prc
  totanims=. +/"1 nanims
  totwool=. +/"1 nanims * 1{y
  avgcfw=. totwool%totanims
  avgmfd=. (+/"1 nanims * (1{y) * 2{y)% totwool
  avgprc=. (+/"1 nanims * (1{y) * (<. 0.5* #|:prc){"1 prc)%totwool
  totvalue=. +/"2 nanims * cfw * prc NB. col7 ("profit")
  am=. avgmfd +/ {:delta
  ac=. avgcfw +/ {.delta
  acm=. ac ,"0 am
  totvalue=. 1,"1 totvalue,"1 0~ }:"1 acm,"1 (acm * acm),"1 acm * |."1 acm
  totvalue;<(avgcfw;avgmfd;avgprc;totanims;totwool)
)

NB. =========================================================
NB.  Deriving REVs & index value

NB. ---------------------------------------------------------
NB.*calcREVs v calculates REVs for 1 or more rev_id
NB. returns 3-col matrix (rv_cfw,rv_mfd,rv_value) with row for each rv_id
NB. x is 2-col matrix of avgcfw avgmfd with row for each rv_id
NB. y is array of sensitivity data. planes for each rv_id.
NB.   25 rows for each plane, 7 cols (mu,cfw,mfd,cfw*cfw,mfd*mfd,cfw*mfd,profit)
NB. Profit=f+gCFW+hMFD+iCFW^2+jMFD^2+kCFW.MFD
NB. the partial derivative of the Profit function with respect to CFW. is
NB. dProft/dCFW=g+2iCFW+kMFD
NB. the partial derivative of the Profit function with respect to MFD. is
NB. dProft/dMFD=h+2jMFD+kCFW
NB. @@@ could calculate R-sq as (xTATb)/(bTb)
calcREVs=: 4 : 0
  split=. ({:"1 ,&< }:"1) NB. split last column and rest
  'b A'=. split y
  'avgcfw avgmfd'=. |: x NB. cols are avgcfw & avgmfd
  coeffs=. |: b %."1 2 A
  dPrftdCFW=. (1{coeffs)+(avgcfw*2*3{coeffs)+(avgmfd*5{coeffs)
  dPrftdMFD=. (2{coeffs)+(avgmfd*2*4{coeffs)+(avgcfw*5{coeffs)
  revs=. dPrftdMFD % dPrftdCFW
  1,.revs,. dPrftdCFW
)

NB. =========================================================
NB. Import Sale Catalogue and Create Customised Index matricies for Clients

NB. ---------------------------------------------------------
NB.*importCatalog v Import Excel file of Sale Catalog
importCatalog=: 3 : 0
  fnme=. wd 'mbopen  "Import Sale Catalogue"  ""  ""  "Excel;(*.xls)|*.xls" ofn_filemustexist'
  NB. handle cancel by return.
  cat=. readexcel fnme
  cat=. (({."1 cat) i. <i.0) {. cat NB. drop summary rows
  hdrcol=. <;._2 'Lot No;Tag;Index;MFD1;Yld1;MFD(EBV);GFW1;CFW1;CFW(EBV);MFD2;Yld2;MFD3;Yld3;GFW2;CFW2;SIRE;CV%;'
  cat=. hdrcol,}.cat NB. Standardize column headings so can find impt columns later
  yrs=. ({.6!:0 '')+i:5  NB. Prompt for Sale year default 1+curr year
  yr=. 6 wdselect 'Which year is the Ram Sale catalogue for?';<8!:0 <&>yrs
  if. -. 0{::yr do. return. end.
  yr=. (1{::yr) { yrs
  ('impCatalog';0 1) insertDBTable yr;<3!:1 cat NB. Save Array in database as Blob
)

NB. ---------------------------------------------------------
NB.*viewCatalog v Displays chosen year's catalog in Grid
viewCatalog=: 3 : 0
  yrs=. ,>}.'yrsCatalog' getTable ''
  yr=. (<:#yrs) wdselect 'Which year''s Ram Sale catalogue?';<8!:0 <&>yrs
  if. -. 0{::yr do. return. end.
  yr=. (1{::yr) { yrs
  cat=. 3!:2 ;}.'viewCatalog' getTable yr NB. retrieve latest catalog from database
  grid_z_ cat
)

NB. ---------------------------------------------------------

NB.*calcIndexList v Create client Index list
NB.   y is matrix (rv_id,rv_client,rv_cfw,rv_mfd,rv_value) with hdr row & row for each client
NB.   z is ??vector of boxed matrices or planes of matrices
NB.   ability to choose sale year?(drop down) default to most recent
calcIndexList=: 3 : 0
  NB. retrieve latest catalog from database
  yrs=. ,>}.'yrsCatalog' getTable ''
  yr=. {: yrs
  cat=. 3!:2 ;}. 'viewCatalog' getTable yr
  NB. Calc index column
  hdr=. {.cat
  cat=. }.cat
  ndxBV=. hdr i. 'CFW(EBV)';'MFD(EBV)'
  index=. |:(>2 3{"1 }. y) +/ . * >|: ndxBV {"1 cat
  rank=. /:@\: index NB. Calc rank column 
  NB. Menu option to change minimum price to other than 450
  value=. 450+(>{:"1 }.y)*"1 index-"1 <./ index   NB. Calc Value column
  ilist=. _2|."1 (<&>value,.rank,.index),. (}."1) 2|."1 cat
  hdr=. _2|.  ('$Value';'Your Ranking';'Your Index') ,}.2|.hdr
  hdr,ilist
)



NB. =========================================================
NB. Format & Output Reports to Clients using Excel & Tara

NB. ---------------------------------------------------------
NB. PDFs/Excel files/Print
NB. Can write one Excel workbook with 2 sheets per client List & details
NB.  -could then create PDFs or print from that
NB.  -might be able to set up header & footer so that printing all
NB.   automatically has individual client info
NB.  -print sheets for each client by selecting both and File/Print
NB.  -Quick but no page numbers would be to change footer to have 
NB.   no page numbers, could then print whole workbook at once
NB. It is not easier to create one workbook per client

NB. Could Format in Grid & print directly from there?
NB.  -not sure if possible or easy ** possible but not easy yet
NB. Could also use printn which says it prints characters as columns
NB.  -would print directly to printer
NB.  -colours & formating might be difficult?

NB. Use the Publish framework (ex JAL package) for creating PDFs from HTML
NB.  -so could create HTML & then PDFs
NB.  -sounds complicated but might be useful if go web way at some stage

NB. ---------------------------------------------------------

NB.   wdinfo 'fnme';fnme

NB. RETRIEVE INFO (same for all output methods)
NB. Which client(s) to export reports for?
NB. Prompt for excel file name (xx.xls) to create 
NB. Use sqlsel_Index_List to get current revs & value
NB. calculate Index Lists for each client 
NB. sort each Index_List by Ranking
NB. Handle clients without current revs & value 
NB.  -(Error & Return? or disable export for individual)

NB. Get Scenario info for each client
NB. Get PriceProfile info for each client
NB. Handle clients with manually specified revs & value (no profile or scenario)

NB. Get Address info for each client

NB. OUPUT INFO
NB. Write Info to Excel using Tara

NB.   bi=: ('Arial' ; 200) conew 'biffbook'
NB.    writestring__bi 1 3 ; 'hello world'    NB. write text in a cell: rowcol ; text (rowcol is 0-based)
NB.    writestring__bi 'C4' ; 'hello Tara'    NB. cell in "A1" mode
NB.    writenumber__bi 'C3' ; o.1
NB.    save__bi jpath '~temp/tara1.xls'       NB. save to a file
NB.    destroy__bi ''                         NB. destriy workbook object, NOT the Excel file
NB.    l=: 0{sheet__bi              NB. worksheet object
NB.    defaultcolwidth__l=: 5       NB. number of characters of first predefined font
NB.    NB. set default row height
NB.    defaultrowheight__l=: 400    NB. twip
NB.    NB. set individual column width
NB.    NB. y. is firstcol lastcol width(in 1/256 character)
NB.    addcolinfo__bi 2 6, 256*10
NB.    NB. set individual row height
NB.    NB. y. is rownumber firstcol lastcol+1 usedefaultheight rowheight(in twip) heightnotmatch ...
NB.    addrowinfo__bi 1 0 256 0 1000 1
NB. The xf object is the equivalent of "format cell dialog", so
NB. you know why xf is useful but complicated.
NB. Tara will create a xf object called 'cxf' (current xf) when
NB. initializing a workbook.  Using cxf, you can set various cell
NB. formats.
NB. First create a workbook and get its cxf.  Note xf is just an
NB. alias of cxf__bi not a new object.

NB.  bi=: ('Courier New' ; 220) conew 'biffbook'  NB. default font
NB.  xf=: cxf__bi            NB. current workbook xf object
NB.  xf1=: addxfobj__bi xf   NB. clone xf for later use
NB.  horzalign__xf=: 3
NB.  xf1 writestring__bi 2 3 ; 'xf1'   NB. xf1 object as left argument

NB. Formats
NB. ============
NB. ?!?Forget about borders?!?

NB. Indexes page
NB. ------------
NB. Base format (MFD? Yld? GFW? CFW? CV%)
NB. fontname__xf=: 'Arial'  NB. no need to use double quotes (")
NB. fontheight__xf=: 200  NB. twip (points=twip%20)
NB. fontweight__xf=: 400  NB. 400 normal, 700 bold
NB. fontitalic__xf=: 0    NB. italic
NB. fontcolor__xf=: rgbcolor__bi 0 0 0  NB. black
NB. horzalign__xf=: 3  NB. right
NB. vertalign__xf=: 2  NB. bottom
NB. format__xf=: '0.0'  NB. format string
NB.NB. patterncolor__xf=: rgbcolor__bi 16bff 16bff 16b99 NB. light yellow
NB.
NB. Lot No
NB. - Font Arial 10 Black
NB. fontheight__xf=: 200
NB. fontweight__xf=: 400  NB. 400 normal, 700 bold
NB. fontitalic__xf=: 0
NB. fontcolor__xf=: rgbcolor__bi 0 0 0 NB. black
NB. horzalign__xf=: 3  NB. right
NB. vertalign__xf=: 2  NB. bottom
NB. format__xf=: '0'  NB. 0 decimal places
NB. rightlinestyle__xf=: cellborder_light_biff_ NB. right border light
NB.
NB. EBV
NB. - Font Arial 10 Bold Black 
NB. fontheight__xf=: 200
NB. fontweight__xf=: 700  NB. 400 normal, 700 bold
NB. fontitalic__xf=: 0
NB. fontcolor__xf=: rgbcolor__bi 0 0 0 NB. black
NB. horzalign__xf=: 3  NB. right
NB. vertalign__xf=: 2  NB. bottom
NB. format__xf=: '0.00'  NB. 2 decimal places
NB. rightlinestyle__xf=: cellborder_light_biff_ NB. right border light
NB.
NB. Index
NB. - Font Arial 10 Bold Italics Black 
NB. fontheight__xf=: 200
NB. fontweight__xf=: 700  NB. 400 normal, 700 bold
NB. fontitalic__xf=: 1
NB. fontcolor__xf=: rgbcolor__bi 0 0 0 NB. black
NB. horzalign__xf=: 2  NB. center
NB. vertalign__xf=: 2  NB. bottom
NB. format__xf=: '0.00'  NB. 2 decimal places
NB. rightlinestyle__xf=: cellborder_light_biff_ NB. right border light
NB.
NB. Ranking
NB. - Font Arial 10 Bold Black
NB. fontheight__xf=: 200
NB. fontweight__xf=: 700  NB. 400 normal, 700 bold
NB. fontitalic__xf=: 0
NB. fontcolor__xf=: rgbcolor__bi 0 0 0 NB. black
NB. horzalign__xf=: 2  NB. center
NB. vertalign__xf=: 2  NB. bottom
NB. format__xf=: '0'  NB. 0 decimal places
NB.
NB. Sire
NB. patterncolor__xf=: rgbcolor__bi 16bcc 16b99 16bff NB. Lavender
NB. - Font Arial 10 Bold Black
NB. fontheight__xf=: 200
NB. fontweight__xf=: 700  NB. 400 normal, 700 bold
NB. fontitalic__xf=: 0
NB. fontcolor__xf=: rgbcolor__bi 0 0 0 NB. black
NB. horzalign__xf=: 3  NB. right
NB. vertalign__xf=: 2  NB. bottom
NB. format__xf=: 'Text'  NB.  Text
NB. rightlinestyle__xf=: cellborder_light_biff_ NB. right border light
NB. leftlinestyle__xf=: cellborder_light_biff_ NB. right border light
NB.
NB. Tag
NB. patterncolor__xf=: rgbcolor__bi 16bcc 16bff 16bff NB. light turquoise
NB. - Font Arial 10 Black
NB. fontheight__xf=: 200
NB. fontweight__xf=: 400  NB. 400 normal, 700 bold
NB. fontitalic__xf=: 0
NB. fontcolor__xf=: rgbcolor__bi 0 0 0 NB. black
NB. horzalign__xf=: 3  NB. right
NB. vertalign__xf=: 2  NB. bottom
NB. format__xf=: 'Text'  NB.  Text
NB.
NB. Value
NB. - Font Arial 10 Black
NB. fontheight__xf=: 200
NB. fontweight__xf=: 400  NB. 400 normal, 700 bold
NB. fontitalic__xf=: 0
NB. fontcolor__xf=: rgbcolor__bi 0 0 0 NB. black
NB. horzalign__xf=: 3  NB. right
NB. vertalign__xf=: 2  NB. bottom
NB. format__xf=: '$#,##0'  NB. Currency, 0 decimal places

NB. Details page
NB. ------------
NB.
NB. Heading Section
NB. patterncolor__xf=: rgbcolor__bi 3#16bff NB. white
NB. - Font Arial 14 Bold Italics Black
NB. fontheight__xf=: 280
NB. fontweight__xf=: 700  NB. 400 normal, 700 bold
NB. fontitalic__xf=: 1
NB. fontcolor__xf=: rgbcolor__bi 0 0 0  NB. black
NB. horzalign__xf=: 1  NB. left
NB. vertalign__xf=: 2  NB. bottom
NB.
NB. Heading Column
NB. patterncolor__xf=: rgbcolor__bi 16b00 16b00 16b80 NB. dark blue
NB. - Font Arial 10 Bold Italic White
NB. fontheight__xf=: 200
NB. fontweight__xf=: 700  NB. 400 normal, 700 bold
NB. fontitalic__xf=: 1
NB. fontcolor__xf=: rgbcolor__bi 255 255 255  NB. white
NB. horzalign__xf=: 2  NB. center
NB. vertalign__xf=: 2  NB. bottom

NB.
NB. Heading Row
NB. patterncolor__xf=: rgbcolor__bi 3#16bff NB. white
NB. - Font Arial 10 Bold Black
NB. fontheight__xf=: 200
NB. fontweight__xf=: 700  NB. 400 normal, 700 bold
NB. fontitalic__xf=: 0
NB. fontcolor__xf=: rgbcolor__bi 0 0 0 NB. black
NB. horzalign__xf=: 3  NB. right
NB. vertalign__xf=: 2  NB. bottom

NB.
NB. Heading Summary
NB. patterncolor__xf=: rgbcolor__bi 3#16bcc NB. light grey
NB. - Font Arial 11 Bold Black
NB. fontheight__xf=: 220
NB. fontweight__xf=: 700  NB. 400 normal, 700 bold
NB. fontitalic__xf=: 0
NB. fontcolor__xf=: rgbcolor__bi 0 0 0 NB. black
NB. horzalign__xf=: 2  NB. center
NB. vertalign__xf=: 0  NB. top

NB.
NB. Value Supplied
NB. patterncolor__xf=: rgbcolor__bi 16bcc 16bcc 16bff NB. light blue
NB. - Font Arial 10 Black
NB. fontheight__xf=: 200
NB. fontweight__xf=: 400  NB. 400 normal, 700 bold
NB. fontitalic__xf=: 0
NB. fontcolor__xf=: rgbcolor__bi 0 0 0 NB. black
NB. horzalign__xf=: 2  NB. center
NB. vertalign__xf=: 2  NB. bottom

NB.
NB. Value Calculated
NB. patterncolor__xf=: rgbcolor__bi 3#16bcc NB. light grey
NB. - Font Arial 10 Black
NB. fontheight__xf=: 200
NB. fontweight__xf=: 400  NB. 400 normal, 700 bold
NB. fontitalic__xf=: 0
NB. fontcolor__xf=: rgbcolor__bi 0 0 0 NB. black
NB. horzalign__xf=: 2  NB. center
NB. vertalign__xf=: 2  NB. bottom

NB. Value Summary
NB. patterncolor__xf=: rgbcolor__bi 3#16bcc NB. light grey
NB. - Font Arial 11 Black
NB. fontheight__xf=: 220
NB. fontweight__xf=: 400  NB. 400 normal, 700 bold
NB. fontitalic__xf=: 0
NB. fontcolor__xf=: rgbcolor__bi 0 0 0 NB. black
NB. horzalign__xf=: 2  NB. center
NB. vertalign__xf=: 2  NB. bottom

NB. REVs
NB. patterncolor__xf=: rgbcolor__bi 16bff 16b99 16bcc NB. rose
NB. - Font Arial 11 Bold Black
NB. fontheight__xf=: 220
NB. fontweight__xf=: 700  NB. 400 normal, 700 bold
NB. fontitalic__xf=: 0
NB. fontcolor__xf=: rgbcolor__bi 0 0 0 NB. black
NB. horzalign__xf=: 2  NB. center
NB. vertalign__xf=: 0  NB. top

NB. Percent
NB. format__xf=: '0'  NB. 0 decimal places

NB. kg
NB. format__xf=: '0'  NB. 0 decimal places

NB. $/kg

NB. 

NB. sqlite -- sqlite enhanced API for J
NB.    based on sqlite 3.3.7
NB.    http://www.sqlite.org/
NB.
NB. Sql is SQL test with optional parameters as ?
NB. Params is a list or matrix of atomic SQL parameters
NB.    if matrix, operation is repeated for each row
NB. ParamTypes indicate 0=normal and 1=BLOB parameter
NB.
NB. Errors are raised as J signal with error message
NB.
NB. Copyright 2006 (C) Oleg Kobchenko
NB. Provided AS IS. No warrantiles or liabilities extended.
NB.
NB. 11/28/05 Oleg Kobchenko
NB. 09/25/06 Oleg Kobchenko - j601
NB. 10/04/06 Oleg Kobchenko - blobsize, optional transaction; strtbl, double bind fix
NB. 10/05/06 Oleg Kobchenko - extran, bulkins

require 'files'
require '~addons/data/sqlite/def.ijs'

coclass 'psqlite'

MAXROWS=: 1000
COMMITROWS=: 1000

trc=: [ smoutput  NB. trace

chrr=: _1&$: : ([: memr ] , 0 , [)
intr=: 1&$: : ([: memr ] , 0 , JINT ,~ [)

NB.*create v opens a database connection
NB.   db=: 'psqlite'conew~ 'path/to/file.sqlite'
create=: 3 : 0
  limit''
  ignore''   NB. don't ignore errors
  blobsize'' NB. normal blob results
  r=. sqlite_open y;c1=. ,_1
  con=: {.c1
  check r
)

destroy=: 3 : 0
  check sqlite_close con
  codestroy''
)

NB.*strtbl v returns unrestricted number of rows of strings
NB.   sqltbl Sql
strtbl=: 3 : 0
  'rp rn cn ep'=. (,_1);(,_1);(,_1);(,_1)
  if. sqlite_get_table con;y;rp;rn;cn;ep do.
    es=. chrr {.ep
    sqlite_free {.ep
    sqlite_free_table {.rp
    sqlerr es
    return.
  end.
  tbl=. ((1+rn),cn)$ chrr@intr &.> ({.rp)+4*i.(1+rn)*cn
  sqlite_free_table {.rp
  tbl
)

NB.*exec v excutes one or more SQL statements
NB.   exec Sql
exec=: 3 : 0
  if. rc=. sqlite_exec con;y;0;0;ep=. ,_1 do.
    es=. chrr {.ep
    sqlite_free {.ep
    sqlerr es
    return.
  end.
  affected''
)

affected=: 3 : '(sqlite_changes , sqlite_total_changes) con'

NB.*extran v excute under optional transaction
NB.   extran Sql    See bulkins 
extran=: 3 : 0
  trans=. 1
  try. exec 'begin transaction;'
  catch. trans=. 0 end.
  try.
    r=. exec y
  catch.
    smoutput 13!:12''
    if. trans do. exec 'rollback;' end.
    sqlerr 'exec failed'
  end.
  if. trans do. exec 'commit;' end.
  r
)

NB.*apply v bulk insert/update/delete
NB.   Params apply Sql;[ParamTypes]
apply=: 4 : 0
  trans=. 1
  try. exec 'begin;'
  catch. trans=. 0 end.
  'sql pt'=. 2{.(boxopen y),<0
  trans prepare sql
  nrows=. #x=. trans normalize x
  tbl=. ''
  for_r. i.1>.nrows do.
    if. nrows do. pt bind r { x end.
    select. rc=. step''
    case. SQLITE_DONE do.
      tbl=. tbl,sqlite_last_insert_rowid con
    case. SQLITE_ERROR do.
      err=. -sqlite_reset st
      if. (0~:ignerr)+.err=0 do.
        tbl=. tbl,err
      else.
        msg=. errmsg''
        finalize''
        exec 'rollback;'
        sqlerr msg
      end.
    case. do.
      tbl=. tbl,SQLITE_E_RESULT
      if. 0=ignerr do. break. end.
    end.
    if. trans*.(r>0)*.0=COMMITROWS|r do.
      trc 'autocommit ', ":r
      exec 'commit;'
      exec 'begin;'
    end.
    sqlite_reset st
  end.
  finalize''
  if. trans do. exec 'commit;' end.
  ignore''
  tbl
)

NB.*limit v pagination for next query statement
NB.   limit [[skip],maxrows]
limit=: 3 : 0  NB. limit [[skip],maxrows]
  maxrows=: {:MAXROWS,y
  skip=: _2{0 0,y
)

ignore=: 3 : 0
  ignerr=: {.y,0
)

blobsize=: 3 : 0
  BLOBSIZE=: {.y,0
)

queryloop=: 1 : 0
  :
  prepare y
  nrows=. #x=. normalize x
  i=. 0
  for_r. i.1>.nrows do.
    if. nrows do. bind r { x end.
    done=. 0
    while. -.done do.
      rc=. step''
      select. rc
      case. SQLITE_ERROR do.
        finalize''
        check rc
        break.
      case. SQLITE_ROW do.
        done=. u i=. i + 1
      case. SQLITE_DONE do.
        done=. 1
      case. do.
        break.
      end.
    end.
    sqlite_reset st
  end.
  finalize''
  limit''
)

query_aux=: 3 : 0
  if. y<:skip do. 0 return. end.
  if. 0=#tbl do. tbl=: tbl,head'' end.
  maxrows < #tbl=: tbl,vrow''
)

NB.*query v select with boxed valued results
NB.   Params query Sql
query=: ''&$: : (4 : 0)
  tbl=: empty''
  x query_aux queryloop y
  tbl
)

strquery_aux=: 3 : 0
  if. y<:skip do. 0 return. end.
  if. 0=#tbl do. tbl=: tbl,head'' end.
  maxrows < #tbl=: tbl,srow''
)

NB.*strquery v select with boxed string results
NB.   Params strquery Sql
strquery=: ''&$: : (4 : 0)
  tbl=: empty''
  x strquery_aux queryloop y
  tbl
)

NB.*colquery v select with column string results
NB.   Params colquery Sql
colquery=: ''&$: : (4 : 0)
  if. 0=# r=. x strquery y do. r return. end.
  ({. ,: <@:>"1@|:@}.) r
)

prepare=: 0&$: : (4 : 0)
  'st tail'=: (,_1);(,_1)
  r=. sqlite_prepare con;y;(#y);st;tail
  tail=: {.tail
  st=: {.st
  if. r do.
    msg=. errmsg''
    if. x do. exec 'rollback;' end.
    sqlerr msg
  end.
)

finalize=: 3 : 'check sqlite_finalize st'

step=: 3 : '>{. sqlite_step st'

normalize=: 0&$: : (4 : 0)
  sharg=. $y
  try.
    select. npar=. sqlite3_bind_parameter_count st
    case. 0 do.
    case. 1 do.
      assert -.0 e. sharg
      ,y return.
    case. do.
      assert -.0 e. sharg
      assert 2 >: #sharg
      select. #sharg
      case. 0 do.
        (1,npar) $ y return.
      case. 1 do.
        assert npar = {.sharg
        (1,npar) $ y return.
      case. 2 do.
        assert npar = {:sharg
        y return.
      end.
    end.
  catch.
    smoutput 13!:12''
    finalize ''
    if. x do. exec 'rollback;' end.
    sqlerr 'argument error'
  end.
  ''
)

JB01INT=: JB01;JINT
bind=: 0&$: : (4 : 0)
  x=. x $~ #y
  for_c. 1+i.#y do.
    v=. >(c-1){y
    select. 3!:0 v
    case. JCHAR do.
      v=. ,v
      if. 0<#v do.
        f=. sqlite_bind_text`sqlite_bind_blob@.(*(c-1){x)
        rc=. f st;c;v;(#v);SQLITE_TRANSIENT
      else.
        rc=. sqlite_bind_null st;c
      end.
    case. JB01INT do.
      rc=. sqlite_bind_int st;c;{.v
    case. JFL do.
      rc=. sqlite_bind_double st;c;{.v
    case. do.  NB. SQLITE_NULL, etc
      v=. ''
    end.
    check rc
  end.
)

srow=: 3 : 0
  row=. ''
  cn=. sqlite_column_count st
  for_c. i.cn do.
    len=. sqlite_column_bytes st;c
    row=. row,<len chrr sqlite_column_text st;c
  end.
  row
)

vrow=: 3 : 0
  row=. ''
  cn=. sqlite_column_count st
  for_c. i.cn do.
    select. sqlite_column_type st;c
    case. SQLITE_INTEGER do.
      v=. sqlite_column_int st;c
    case. SQLITE_FLOAT do.
      v=. sqlite_column_double st;c
    case. SQLITE_TEXT do.
      len=. sqlite_column_bytes st;c
      v=. len chrr sqlite_column_text st;c
    case. SQLITE_BLOB do.
      len=. sqlite_column_bytes st;c
      if. BLOBSIZE do. v=. len else.
        v=. len chrr sqlite_column_blob st;c end.
    case. do.  NB. SQLITE_NULL, etc
      v=. ''
    end.
    row=. row,<v
  end.
  row
)

head=: 3 : 0
  row=. ''
  cn=. >{.sqlite_column_count st
  for_c. i.cn do.
    row=. row,<chrr sqlite_column_name st;c
  end.
  row
)

sqlerr=: (13!:8)&101
errmsg=: 3 : 'chrr sqlite_errmsg con'
check=: sqlerr@errmsg^:(*@])

strjoin=: ":&.>@] ;@}:@,@,. boxopen@[
strquot=:(([:''''&, ,&'''')@(([:>:(''''&=))#]))^:(2=3!:0) NB. DM.  2006 11 19

NB.*bulkins v forms string of inserts
NB.   extran__db 'table1 (col1,col2)' bulkins i.4 2
bulkins=: 4 : 0
  x=. 'insert into ',x,' values('
  ; <@(x , ');',~ [:; ','strjoin ":@strquot&.>)"1 y
)


NB. def -- sqlite library binding for J
NB.    based on sqlite 3.3.7
NB.    http://www.sqlite.org/
NB.
NB. 11/28/05 Oleg Kobchenko
NB. 09/25/06 Oleg Kobchenko - j601

require 'dll strings'

coclass 'psqlite'

ADDONDIR=: jpath '~addons/data/sqlite/'
d=. (<jhostpath ADDONDIR,'lib/') ,&.> cut 'sqlite-3.3.7.so sqlite3.dll '
d=. ({.d),('/usr/lib/libsqlite3.dylib');{:d
LIBSQLITE=: '"','" ',~ (#.IFWIN32,'Darwin'-:UNAME){::d
cdsq=: 1 : '(deb LIBSQLITE,m)&cd'

sqlite_errmsg=:        'sqlite3_errmsg  >+ i  i' cdsq
sqlite_errcode=:       'sqlite3_errcode >+ i  i' cdsq
sqlite_open=:          'sqlite3_open    >+ i  *c *i' cdsq
sqlite_close=:         'sqlite3_close   >+ i  i' cdsq

sqlite_exec=:          'sqlite3_exec          >+ i  i *c  i i  *i' cdsq
sqlite_get_table=:     'sqlite3_get_table     >+ i  i *c *i  *i *i  *i' cdsq
sqlite_free_table=:    'sqlite3_free_table    >+ i  i' cdsq
sqlite_free=:          'sqlite3_free          >+ i  i' cdsq
sqlite_changes=:       'sqlite3_changes       >+ i  i' cdsq
sqlite_total_changes=: 'sqlite3_total_changes >+ i  i' cdsq

sqlite_prepare=:       'sqlite3_prepare  >+ i  i *c i *i *i' cdsq
sqlite_step=:          'sqlite3_step     >+ i  i' cdsq
sqlite_reset=:         'sqlite3_reset    >+ i  i' cdsq
sqlite_finalize=:      'sqlite3_finalize >+ i  i' cdsq

sqlite_column_count=:  'sqlite3_column_count  >+ i  i' cdsq
sqlite_column_type=:   'sqlite3_column_type   >+ i  i i' cdsq
sqlite_column_name=:   'sqlite3_column_name   >+ i  i i' cdsq
sqlite_column_bytes=:  'sqlite3_column_bytes  >+ i  i i' cdsq
sqlite_column_text=:   'sqlite3_column_text   >+ i  i i' cdsq
sqlite_column_blob=:   'sqlite3_column_blob   >+ i  i i' cdsq
sqlite_column_int=:    'sqlite3_column_int    >+ i  i i' cdsq
sqlite_column_double=: 'sqlite3_column_double >+ d  i i' cdsq

sqlite_last_insert_rowid=:     'sqlite3_last_insert_rowid    >+ i  i' cdsq
sqlite3_bind_parameter_count=: 'sqlite3_bind_parameter_count >+ i  i' cdsq

sqlite_bind_blob=:     'sqlite3_bind_blob   >+ i  i i *c i i' cdsq
sqlite_bind_int=:      'sqlite3_bind_int    >+ i  i i i' cdsq
sqlite_bind_double=:   'sqlite3_bind_double >+ i  i i d' cdsq
sqlite_bind_text=:     'sqlite3_bind_text   >+ i  i i *c i i' cdsq
sqlite_bind_null=:     'sqlite3_bind_null   >+ i  i i' cdsq


s=.  'SQLITE_OK SQLITE_ERROR SQLITE_INTERNAL SQLITE_PERM SQLITE_ABORT SQLITE_BUSY '
s=.s,'SQLITE_LOCKED SQLITE_NOMEM SQLITE_READONLY SQLITE_INTERRUPT SQLITE_IOERR '
s=.s,'SQLITE_CORRUPT SQLITE_NOTFOUND SQLITE_FULL SQLITE_CANTOPEN SQLITE_PROTOCOL '
s=.s,'SQLITE_EMPTY SQLITE_SCHEMA SQLITE_TOOBIG SQLITE_CONSTRAINT SQLITE_MISMATCH '
s=.s,'SQLITE_MISUSE SQLITE_NOLFS SQLITE_AUTH SQLITE_FORMAT SQLITE_RANGE SQLITE_NOTADB'
(s)=: i.#;:s
'SQLITE_ROW SQLITE_DONE'=: 100 101

s=. 'SQLITE_INTEGER SQLITE_FLOAT SQLITE_TEXT SQLITE_BLOB SQLITE_NULL'
(s)=: 1+i.#;:s

'SQLITE_STATIC SQLITE_TRANSIENT'=: 0 _1

SQLITE_E_RESULT=: _999  NB. unexpected result code


NB. display notice when loading
smoutput 0 : 0
'dd/mm/yyyy' in the following line is locale specific
if. 2=#y do. y=. y, <'dd/mm/yyyy' end. NB. default date format
change it to 'mm/dd/yyyy' for US, or other value for your own locale
)

NB. ---------------------------------------------------------
NB. package for reading and writing ole2 storage
NB.  based on the ole::storage_lite 0.14 perl package
NB.  ported by bill lam, bill_lam@myrealbox.com
NB.  ole::storage_lite was written by kawai takanori, kwitknr@cpan.org
NB. utility function for olew
cocurrent 'oleutlfcn'
NB. return datetime in j timestamp format
oledate2local=: 3 : 0
86400000* _72682+86400%~10000000%~(8#256)#. a.i.y
)

NB. y datetime in j timestamp format
localdate2ole=: 3 : 0
a.{~(8#256)#: 10000000*x:86400*(y%86400000)+72682
)

NB. followings also defined in z locale
NB. ---------------------------------------------------------
NB. followings bit op require j5
bitand=: 17 b.
bitxor=: 22 b.
bitor=: 23 b.
bitrot=: 32 b.
bitshl=: 33 b.
bitsha=: 34 b.
ltrim=: }.~ +/@(*./\)@(' '&=)
rtrim=: }.~ -@(+/)@(*./\.)@(' '&=)
trim=: ltrim@:rtrim f.
NB. binary strings
bigendian=: ({.a.)={. 1&(3!:4) 1  NB. 0 little endian   1 big endian
toBYTE=: {&a.@(256&|)
fromBYTE=: a.&i.
toWORDm=: 1&(3!:4)@:<.
toDWORDm=: 2&(3!:4)@:<.
toucodem=: ''&,@(1&(3!:4))@(3&u:)@u:
toDoublem=: 2&(3!:5)
fromWORDm=: _1&(3!:4)
fromDWORDm=: _2&(3!:4)
fromucodem=: 6&u:
fromDoublem=: _2&(3!:5)
toWORDr=: ,@:(|."1)@(_2: ]\ 1&(3!:4)@:<.)
toDWORDr=: ,@:(|."1)@(_4: ]\ 2&(3!:4)@:<.)
toucoder=: ''&,@:,@:(|."1@(_2: ]\ 1&(3!:4)))@(3&u:)@u:
toDoubler=: ,@:(|."1)@(_8: ]\ 2&(3!:5))
fromWORDr=: _1&(3!:4)@:,@:(|."1)@(_2&(]\))
fromDWORDr=: _2&(3!:4)@:,@:(|."1)@(_4&(]\))
fromucoder=: 6&u:@:,@:(|."1)@(_2&(]\))
fromDoubler=: _2&(3!:5)@:,@:(|."1)@(_8&(]\))
NB. always little endian conversion
toWORD0=: toWORDm`toWORDr@.bigendian f.
toDWORD0=: toDWORDm`toDWORDr@.bigendian f.
toucode0=: toucodem`toucoder@.bigendian f.
toDouble0=: toDoublem`toDoubler@.bigendian f.
fromWORD0=: fromWORDm`fromWORDr@.bigendian f.
fromDWORD0=: fromDWORDm`fromDWORDr@.bigendian f.
fromucode0=: fromucodem`fromucoder@.bigendian f.
fromDouble0=: fromDoublem`fromDoubler@.bigendian f.
NB. always big endian conversion
toWORD1=: toWORDm`toWORDr@.(-.bigendian) f.
toDWORD1=: toDWORDm`toDWORDr@.(-.bigendian) f.
toucode1=: toucodem`toucoder@.(-.bigendian) f.
toDouble1=: toDoublem`toDoubler@.(-.bigendian) f.
fromWORD1=: fromWORDm`fromWORDr@.(-.bigendian) f.
fromDWORD1=: fromDWORDm`fromDWORDr@.(-.bigendian) f.
fromucode1=: fromucodem`fromucoder@.(-.bigendian) f.
fromDouble1=: fromDoublem`fromDoubler@.(-.bigendian) f.
NB. decimal from hex string, always return integer
dfhs=: 3 : 0
z=. 0
for_bit. , {&(#: i.16) @ ('0123456789abcdef'&i.) y do.
  z=. bit (23 b.) 1 (33 b.) z
end.
z
)

NB. for biff8 RGB values
RGB=: 3 : 0"1
(0{y) (23 b.) 8 (33 b.) (1{y) (23 b.) 8 (33 b.) (2{y)
)

RGBtuple=: 3 : 0"0
(16bff (17 b.) y), (_8 (33 b.) 16bff00 (17 b.) y), (_16 (33 b.) 16bff0000 (17 b.) y)
)

fboxname=: ([: < 8 u: >) :: ]
toupperw=: u:@(7&u:)@toupper@(8&u: ::])

fread=: (1!:1 :: _1:) @ fboxname
fdir=: 1!:0@fboxname
freadx=: (1!:11 :: _1:)@(fboxname@{., }.)`(1!:11)@.(0: = L.)
fwritex=: ([ (1!:12) (fboxname@{., }.)@])`(1!:12)@.((0: = L.)@])
fopen=: (1!:21 :: _1:) @ (fboxname &>) @ boxopen
fclose=: (1!:22 :: _1:) @ (fboxname &>) @ boxopen
fwrite=: [ (1!:2) fboxname@]
fappend=: [ (1!:3) fboxname@]
fexist=: (1:@(1!:4) :: 0:) @ (fboxname &>) @ boxopen
ferase=: (1!:55 :: _1:) @ (fboxname &>) @ boxopen
maxpp=: 15 [ 16   NB. max print precision for ieee 8-byte double (52 + 1 implied mantissa)
NB. ---------------------------------------------------------

coclass 'oleheaderinfo'
coinsert 'olepps'
create=: 3 : 0
smallsize=: 16b1000
ppssize=: 16b80
bigblocksize=: 16b200
smallblocksize=: 16b0040
bdbcount=: 0
rootstart=: 0
sbdstart=: 0
sbdcount=: 0
extrabbdstart=: 0
extrabbdcount=: 0
bbdinfo=: 0 2$''
sbstart=: 0
sbsize=: 0
data=: ''
fileh=: ''
ppsfile=: ''
)

destroy=: codestroy

coclass 'olestorage'
coinsert 'oleutlfcn'
ppstyperoot=: 5
ppstypedir=: 1
ppstypefile=: 2
datasizesmall=: 16b1000
longintsize=: 4
ppssize=: 16b80
create=: 3 : 0
sfile=: y
openfilenum=: ''
headerinfo=: ''
)

destroy=: 3 : 0
if. -. ''-:openfilenum do. fclose"0 openfilenum end.
if. #headerinfo do. destroy__headerinfo '' end.
codestroy ''
)

NB.  getppstree:
getppstree=: 3 : 0
bdata=. y
NB. 0.init
rhinfo=. initparse sfile
if. ''-:rhinfo do. '' return. end.
NB. 1. get data
(0&{ :: (''"_)) >@{: ugetppstree 0 ; rhinfo ; <bdata
)

NB.  getsearch:
getppssearch=: 3 : 0
'raname bdata icase'=. y
NB. 0.init
rhinfo=. initparse sfile
if. ''-:rhinfo do. '' return. end.
NB. 1. get data
(0&{ :: (''"_)) >@{: ugetppssearch 0 ; rhinfo ; raname ; bdata ; <icase
)

NB.  ugetnthpps:
getnthpps=: 3 : 0
'ino bdata'=. y
NB. 0.init
rhinfo=. initparse sfile
if. ''-:rhinfo do. '' return. end.
NB. 1. get data
ugetnthpps ino ; rhinfo ; <bdata
)

NB.  initparse:
initparse=: 3 : 0
if. #headerinfo do. headerinfo return. end.
NB. 1. sfile is a resource  hopefully a file resource
if. 1 4 e.~ 3!:0 y do.
  oio=. y
else.
NB. 2. sfile is a filename string
  openfilenum=: ~. openfilenum, oio=. fopen <y   NB. ~. workaround J504's 1!:21 bug
end.
if. '' -.@-: p=. getheaderinfo oio do. headerinfo=: p end.
p
)

NB.  ugetppstree:
ugetppstree=: 3 : 0
'ino rhinfo bdata radone'=. 4{.y
if. '' -.@-: radone do.
  if. ino e. radone do. radone ; <'' return. end.
end.
radone=. radone, ino
irootblock=. rootstart__rhinfo
NB. 1. get information about itself
opps=. ugetnthpps ino ; rhinfo ; <bdata
NB. 2. child
if. dirpps__opps ~: _1 do.
  radone=. >@{. ra=. ugetppstree dirpps__opps ; rhinfo ; bdata ; <radone
  achildl=. >@{: ra
  child__opps=: child__opps, achildl
else.
  child__opps=: ''
end.
NB. 3. previous, next ppss
alist=. ''
if. prevpps__opps ~: _1 do.
  radone=. >@{. ra=. ugetppstree prevpps__opps ; rhinfo ; bdata ; <radone
  alist=. >@{: ra
end.
alist=. alist, opps
if. nextpps__opps ~: _1 do.
  radone=. >@{. ra=. ugetppstree nextpps__opps ; rhinfo ; bdata ; <radone
  alist=. alist, >@{: ra
end.
radone ; <alist
)

NB.  ugetppssearch:
ugetppssearch=: 3 : 0
'ino rhinfo raname bdata icase radone'=. 6{.y
irootblock=. rootstart__rhinfo
NB. 1. check it self
if. '' -.@-: radone do.
  if. ino e. radone do. radone ; <'' return. end.
end.
radone=. radone, ino
opps=. ugetnthpps ino ; rhinfo ; <0
found=. 0
NB. for_cmp. raname do.
NB.   if. ((icase *. name__opps -:&toupperw >cmp) +. name__opps-:>cmp) do.
NB.     found=. 1 break.
NB.   end.
NB. end.
if. ((icase *. name__opps -:&toupperw raname) +. name__opps-:raname) do.
  found=. 1
end.
if. found do.
  if. 1=bdata do.
    opps=. ugetnthpps ino ; rhinfo ; <bdata
  end.
  ares=. opps
else.
  ares=. ''
end.
NB. 2. check child, previous, next ppss
if. dirpps__opps ~: _1 do.
  radone=. >@{. ra=. ugetppssearch dirpps__opps ; rhinfo ; raname ; bdata ; icase ; <radone
  ares=. ares, >@{: ra
end.
if. prevpps__opps ~: _1 do.
  radone=. >@{. ra=. ugetppssearch prevpps__opps ; rhinfo ; raname ; bdata ; icase ; <radone
  ares=. ares, >@{: ra
end.
if. nextpps__opps ~: _1 do.
  radone=. >@{. ra=. ugetppssearch nextpps__opps ; rhinfo ; raname ; bdata ; icase ; <radone
  ares=. ares, >@{: ra
end.
radone ; <ares
)

NB.  get header info  base informain about that file
getheaderinfo=: 3 : 0
NB. 0. check id
fp=. 0
if. -. (freadx y, fp, 8)-:16bd0 16bcf 16b11 16be0 16ba1 16bb1 16b1a 16be1{a. do. '' return. end.
rhinfo=. '' conew 'oleheaderinfo'
fileh__rhinfo=: y
NB. big block size
if. ''-:iwk=. getinfofromfile fileh__rhinfo ; 16b1e ; 2 do. '' [ destroy__rhinfo '' return. end.
bigblocksize__rhinfo=: <. 2&^ iwk
NB. small block size
if. ''-:iwk=. getinfofromfile fileh__rhinfo ; 16b20 ; 2 do. '' [ destroy__rhinfo '' return. end.
smallblocksize__rhinfo=: <. 2&^ iwk
NB. bdb count
if. ''-:iwk=. getinfofromfile fileh__rhinfo ; 16b2c ; 4 do. '' [ destroy__rhinfo '' return. end.
bdbcount__rhinfo=: iwk
NB. start block
if. ''-:iwk=. getinfofromfile fileh__rhinfo ; 16b30 ; 4 do. '' [ destroy__rhinfo '' return. end.
rootstart__rhinfo=: iwk
if. ''-:iwk=. getinfofromfile fileh__rhinfo ; 16b3c ; 4 do. '' [ destroy__rhinfo '' return. end.
sbdstart__rhinfo=: iwk
NB. small bd count
if. ''-:iwk=. getinfofromfile fileh__rhinfo ; 16b40 ; 4 do. '' [ destroy__rhinfo '' return. end.
sbdcount__rhinfo=: iwk
NB. extra bbd start
if. ''-:iwk=. getinfofromfile fileh__rhinfo ; 16b44 ; 4 do. '' [ destroy__rhinfo '' return. end.
extrabbdstart__rhinfo=: iwk
NB. extra bd count
if. ''-:iwk=. getinfofromfile fileh__rhinfo ; 16b48 ; 4 do. '' [ destroy__rhinfo '' return. end.
extrabbdcount__rhinfo=: iwk
NB. get bbd info
bbdinfo__rhinfo=: getbbdinfo rhinfo
NB. get root pps
oroot=. ugetnthpps 0 ; rhinfo ; <0
sbstart__rhinfo=: startblock__oroot
sbsize__rhinfo=: size__oroot
rhinfo
)

NB.  getinfofromfile
getinfofromfile=: 3 : 0
'file ipos ilen'=. y
if. ''-:file do. '' return. end.
if. 2=ilen do.
  fromWORD0 freadx file, ipos, ilen
else.
  fromDWORD0 freadx file, ipos, ilen
end.
)

NB.  getbbdinfo
getbbdinfo=: 3 : 0
rhinfo=. y
abdlist=. ''
ibdbcnt=. bdbcount__rhinfo
i1stcnt=. <.(bigblocksize__rhinfo - 16b4c) % longintsize
ibdlcnt=. (<.bigblocksize__rhinfo % longintsize) - 1
NB. 1. 1st bdlist
fp=. 16b4c
igetcnt=. ibdbcnt <. i1stcnt
abdlist=. abdlist, fromDWORD0 freadx fileh__rhinfo, fp, longintsize*igetcnt
ibdbcnt=. ibdbcnt - igetcnt
NB. 2. extra bdlist
iblock=. extrabbdstart__rhinfo
while. ((ibdbcnt> 0) *. isnormalblock iblock) do.
  fp=. setfilepos iblock ; 0 ; <rhinfo
  igetcnt=. ibdbcnt <. ibdlcnt
  abdlist=. abdlist, fromDWORD0 freadx fileh__rhinfo, fp, longintsize*igetcnt
  ibdbcnt=. ibdbcnt - igetcnt
  iblock=. fromDWORD0 freadx fileh__rhinfo, (fp=. fp+longintsize*igetcnt), longintsize
end.
NB. 3.get bds
iblkno=. 0
ibdcnt=. <.bigblocksize__rhinfo % longintsize
hbd=. 0 2$''
for_ibdl. abdlist do.
  fp=. setfilepos ibdl ; 0 ; <rhinfo
  awk=. fromDWORD0 freadx fileh__rhinfo, fp, bigblocksize__rhinfo
  for_i. i.ibdcnt do.
    if. ((i{awk) ~: iblkno+1) do.
      hbd=. hbd, iblkno, i{awk
    end.
    iblkno=. >:iblkno
  end.
end.
hbd
)

NB.  ugetnthpps
ugetnthpps=: 3 : 0
'ipos rhinfo bdata'=. y
ippsstart=. rootstart__rhinfo
ibasecnt=. <.bigblocksize__rhinfo % ppssize
ippsblock=. <.ipos % ibasecnt
ippspos=. ipos |~ ibasecnt
iblock=. getnthblockno ippsstart ; ippsblock ; <rhinfo
if. ''-:iblock do. '' return. end.
fp=. setfilepos iblock ; (ppssize*ippspos) ; <rhinfo
inmsize=. fromWORD0 (16b40+i.2){swk=. freadx fileh__rhinfo, fp, ppssize
inmsize=. 0 >. inmsize - 2
snm=. inmsize{.swk
sname=. fromucode0 (i.inmsize){swk
itype=. 256|fromWORD0 (16b42+i.2){swk
'lppsprev lppsnext ldirpps'=. fromDWORD0 (16b44+i.12){swk
ratime1st=: ((itype = ppstyperoot) +. (itype = ppstypedir)) { 0, oledate2local (16b64+i.8){swk
ratime2nd=: ((itype = ppstyperoot) +. (itype = ppstypedir)) { 0, oledate2local (16b6c+i.8){swk
'istart isize'=. fromDWORD0 (16b74+i.8){swk
if. 1=bdata do.
  sdata=. getdata itype ; istart ; isize ; <rhinfo
  pps=. createpps ipos ; sname ; itype ; lppsprev ; lppsnext ; ldirpps ; ratime1st ; ratime2nd ; istart ; isize ; sdata
else.
  pps=. createpps ipos ; sname ; itype ; lppsprev ; lppsnext ; ldirpps ; ratime1st ; ratime2nd ; istart ; isize
end.
pps
)

NB.  setfilepos
setfilepos=: 3 : 0
'iblock ipos rhinfo'=. y
ipos + (iblock+1)*bigblocksize__rhinfo
)

NB.  getnthblockno
getnthblockno=: 3 : 0
'istblock inth rhinfo'=. y
inext=. istblock
for_i. i.inth do.
  isv=. inext
  inext=. getnextblockno isv ; <rhinfo
  if. 0= isnormalblock inext do. '' return. end.
end.
inext
)

NB.  getdata
getdata=: 3 : 0
'itype iblock isize rhinfo'=. y
if. itype = ppstypefile do.
  if. isize < datasizesmall do.
    getsmalldata iblock ; isize ; <rhinfo
  else.
    getbigdata iblock ; isize ; <rhinfo
  end.
elseif. itype = ppstyperoot do.  NB. root
  getbigdata iblock ; isize ; <rhinfo
elseif. itype = ppstypedir do.  NB.  directory
  0
end.
)

NB.  getbigdata
getbigdata=: 3 : 0
'iblock isize rhinfo'=. y
if. 0= isnormalblock iblock do. '' return. end.
irest=. isize
sres=. ''
akeys=. /:~ {."1 bbdinfo__rhinfo
while. irest > 0 do.
  ares=. (akeys>:iblock)#akeys
  inkey=. {.ares
  i=. inkey - iblock
  inext=. ({:"1 bbdinfo__rhinfo){~({."1 bbdinfo__rhinfo)i.inkey
  fp=. setfilepos iblock ; 0 ; <rhinfo
  igetsize=. irest <. bigblocksize__rhinfo * (i+1)
  sres=. sres, freadx fileh__rhinfo, fp, igetsize
  irest=. irest-igetsize
  iblock=. inext
end.
sres
)

NB.  getnextblockno
getnextblockno=: 3 : 0
'iblockno rhinfo'=. y
if. iblockno e. {."1 bbdinfo__rhinfo do.
  ({:"1 bbdinfo__rhinfo){~({."1 bbdinfo__rhinfo)i.iblockno
else.
  iblockno+1
end.
)

NB.  isnormalblock
NB. _4 : bdlist, _3 : bbd,
NB. _2: end of chain _1 : unused
isnormalblock=: 3 : 0
y -.@e. _4 _3 _2 _1
)

NB.  getsmalldata
getsmalldata=: 3 : 0
'ismblock isize rhinfo'=. y
irest=. isize
sres=. ''
while. irest > 0 do.
  fp=. setfilepossmall ismblock ; <rhinfo
  sres=. sres, freadx fileh__rhinfo, fp, irest <. smallblocksize__rhinfo
  irest=. irest - smallblocksize__rhinfo
  ismblock=. getnextsmallblockno ismblock ; <rhinfo
end.
sres
)

NB.  setfilepossmall
setfilepossmall=: 3 : 0
'ismblock rhinfo'=. y
ismstart=. sbstart__rhinfo
ibasecnt=. <.bigblocksize__rhinfo % smallblocksize__rhinfo
inth=. <.ismblock%ibasecnt
ipos=. ismblock |~ ibasecnt
iblk=. getnthblockno ismstart ; inth ; <rhinfo
setfilepos iblk ; (ipos * smallblocksize__rhinfo) ; <rhinfo
)

NB.  getnextsmallblockno
getnextsmallblockno=: 3 : 0
'ismblock rhinfo'=. y
ibasecnt=. <.bigblocksize__rhinfo % longintsize
inth=. <.ismblock%ibasecnt
ipos=. ismblock |~ ibasecnt
iblk=. getnthblockno sbdstart__rhinfo ; inth ; <rhinfo
fp=. setfilepos iblk ; (ipos * longintsize) ; <rhinfo
fromDWORD0 freadx fileh__rhinfo, fp, longintsize
)

createpps=: 3 : 0
'ipos sname itype lppsprev lppsnext ldirpps ratime1st ratime2nd istart isize sdata'=. 11{.y
select. {.itype
case. ppstyperoot do.
  p=. conew 'oleppsroot'
  create__p ratime1st ; ratime2nd ; ''
case. ppstypedir do.
  p=. conew 'oleppsdir'
  create__p sname ; ratime1st ; ratime2nd ; ''
case. ppstypefile do.
  p=. conew 'oleppsfile'
  create__p sname ; sdata ; ''
case. do.
  assert. 0
end.
no__p=: ipos
name__p=: u: sname
type__p=: {.itype
prevpps__p=: lppsprev
nextpps__p=: lppsnext
dirpps__p=: ldirpps
time1st__p=: ratime1st
time2nd__p=: ratime2nd
startblock__p=: istart
size__p=: isize
data__p=: sdata
p
)

cocurrent 'olepps'
coinsert 'oleutlfcn'
ppstyperoot=: 5
ppstypedir=: 1
ppstypefile=: 2
datasizesmall=: 16b1000
longintsize=: 4
ppssize=: 16b80
NB.  no
NB.  name
NB.  type
NB.  prevpps
NB.  nextpps
NB.  dirpps
NB.  time1st
NB.  time2nd
NB.  startblock
NB.  size
NB.  data
NB.  child
NB.  ppsfile
fputs=: 3 : 0
if. fileh-:'' do. data=: data, y else. fileh fappend~ y end.
)

NB. ---------------------------------------------------------
NB.  datalen
NB.  check for update
NB. ---------------------------------------------------------
datalen=: 3 : 0
if. '' -.@-: ppsfile do. fsize ppsfile return. end.
#data
)

NB. ---------------------------------------------------------
NB.  makesmalldata
NB. ---------------------------------------------------------
makesmalldata=: 3 : 0
'alist rhinfo'=. y
sres=. ''
ismblk=. 0
for_opps. alist do.
NB. 1. make sbd, small data string
  if. type__opps=ppstypefile do.
    if. size__opps <: 0 do. continue. end.
    if. size__opps < smallsize__rhinfo do.
      ismbcnt=. >. size__opps % smallblocksize__rhinfo
NB. 1.1 add to sbd
      for_i. i.ismbcnt-1 do.
        fputs__rhinfo toDWORD0 i+ismblk+1
      end.
      fputs__rhinfo toDWORD0 _2
NB. 1.2 add to data string  will be written for rootentry
NB. check for update
      if. '' -.@-: ppsfile__opps do.
        sres=. sres, ]`(''"_)@.(_1&-:)@:fread ppsfile__opps
      else.
        sres=. sres, data__opps
      end.
      if. size__opps |~ smallblocksize__rhinfo do.
        sres=. sres, ({.a.) #~ smallblocksize__rhinfo ([ - |) size__opps
      end.
NB. 1.3 set for pps
      startblock__opps=: ismblk
      ismblk=. ismblk + ismbcnt
    end.
  end.
end.
isbcnt=. <. bigblocksize__rhinfo % longintsize
if. ismblk |~ isbcnt do.
  fputs__rhinfo, (,:toDWORD0 _1) #~ isbcnt ([ - |) ismblk
end.
NB. 2. write sbd with adjusting length for block
sres
)

NB. ---------------------------------------------------------
NB.  saveppswk
NB. ---------------------------------------------------------
saveppswk=: 3 : 0
rhinfo=. y
NB. 1. write pps
z=. toucode0 name
z=. z, ({.a.)#~ 64-2*#name                         NB.   64
z=. z, toWORD0 2*1+#name                     NB.   66
z=. z, toBYTE type                                 NB.   67
z=. z, toBYTE 16b00 NB. uk                         NB.   68
z=. z, toDWORD0 prevpps NB. prev             NB.   72
z=. z, toDWORD0 nextpps NB. next             NB.   76
z=. z, toDWORD0 dirpps  NB. dir              NB.   80
z=. z, 0 9 2 0{a.                                  NB.   84
z=. z, 0 0 0 0{a.                                  NB.   88
z=. z, 16bc0 0 0 0{a.                              NB.   92
z=. z, 0 0 0 16b46{a.                              NB.   96
z=. z, 0 0 0 0{a.                                  NB.  100
z=. z, localdate2ole time1st                       NB.  108
z=. z, localdate2ole time2nd                       NB.  116
z=. z, toDWORD0 startblock                   NB.  120
z=. z, toDWORD0 size                         NB.  124
z=. z, toDWORD0 0                            NB.  128
fputs__rhinfo z
z
)

coclass 'oleppsdir'
coinsert 'oleutlfcn'
coinsert 'olepps'
create=: 3 : 0
'sname ratime1st ratime2nd rachild'=. y
no=: 0
name=: u: sname
type=: ppstypedir
prevpps=: 0
nextpps=: 0
dirpps=: 0
time1st=: ratime1st
time2nd=: ratime2nd
startblock=: 0
size=: 0
data=: ''
child=: rachild
fileh=: ''
ppsfile=: ''
)

destroy=: codestroy

coclass 'oleppsfile'
coinsert 'oleutlfcn'
coinsert 'olepps'
create=: 3 : 0
'snm sdata sfile'=. y
no=: 0
name=: u: snm
type=: ppstypefile
prevpps=: 0
nextpps=: 0
dirpps=: 0
time1st=: 0
time2nd=: 0
startblock=: 0
size=: 0
data=: >(''-:sfile) { sdata ; ''
child=: ''
ppsfile=: ''
fileh=: ''
ppsfile=: ''
if. '' -.@-: sfile do.
  if. 1 4 e.~ 3!:0 sfile do.
    ppsfile=: sfile
  elseif. do.
    fname=. sfile
    ferase <fname
    ppsfile=: fopen <fname
  end.
  if. #sdata do.
    ppsfile fappend~ sdata
  end.
end.
)

append=: 3 : 0
if. '' -.@-: ppsfile do.
  ppsfile fappend~ y
else.
  data=: data, y
end.
)

destroy=: codestroy

coclass 'oleppsroot'
coinsert 'oleutlfcn'
coinsert 'olepps'
create=: 3 : 0
'ratime1st ratime2nd rachild'=. y
no=: 0
name=: u: 'Root Entry'
type=: ppstyperoot
prevpps=: 0
nextpps=: 0
dirpps=: 0
time1st=: ratime1st
time2nd=: ratime2nd
startblock=: 0
size=: 0
data=: ''
child=: rachild
fileh=: ''
ppsfile=: ''
)

destroy=: codestroy
NB.  save  ole:
save=: 3 : 0
'sfile bnoas rhinfo'=. y
if. ''-:rhinfo do.
  rhinfo=. '' conew 'oleheaderinfo'
end.
bigblocksize__rhinfo=: <. 2&^ (0= bigblocksize__rhinfo) { (adjust2 bigblocksize__rhinfo), 9
smallblocksize__rhinfo=: <. 2&^ (0= smallblocksize__rhinfo) { (adjust2 smallblocksize__rhinfo), 6
smallsize__rhinfo=: 16b1000
ppssize__rhinfo=: 16b80
NB. 1.open file
NB. 1.1 sfile is ref of scalar
if. ''-:sfile do.
  fileh__rhinfo=: ''
elseif. 1 4 e.~ 3!:0 sfile do.
  fileh__rhinfo=: sfile
NB. 1.2 sfile is a simple filename string
elseif. do.
  ferase <sfile
  fileh__rhinfo=: fopen <sfile
end.
iblk=. 0
NB. 1. make an array of pps  for save
alist=. ''
list=. 18!:5 ''
if. bnoas do.
  alist=. >@{. saveppssetpnt2 list ; alist ; <rhinfo
else.
  alist=. >@{. saveppssetpnt list ; alist ; <rhinfo
end.
'isbdcnt ibbcnt ippscnt'=. calcsize alist ; <rhinfo
NB. 2.save header
saveheader rhinfo ; isbdcnt ; ibbcnt ; <ippscnt
NB. 3.make small data string  write sbd
ssmwk=. makesmalldata alist ; <rhinfo
data=: ssmwk  NB. small datas become rootentry data
NB. 4. write bb
ibblk=. isbdcnt
ibblk=. savebigdata ibblk ; alist ; <rhinfo
NB. 5. write pps
savepps alist ; <rhinfo
NB. 6. write bd and bdlist and adding header informations
savebbd isbdcnt ; ibbcnt ; ippscnt ; <rhinfo
NB. 7.close file
if. (''-.@-:sfile) *. -. 1 4 e.~ 3!:0 sfile do.
  fclose fileh__rhinfo
end.
if. ''-:sfile do.
  rc=. data__rhinfo
else.
  rc=. ''
end.
destroy__rhinfo ''
rc
)

NB.  calcsize
calcsize=: 3 : 0
'ralist rhinfo'=. y
NB. 0. calculate basic setting
isbdcnt=. 0
ibbcnt=. 0
ippscnt=. 0
ismalllen=. 0
isbcnt=. 0
for_opps. ralist do.
  if. type__opps=ppstypefile do.
    size__opps=: datalen__opps''  NB. mod
    if. size__opps < smallsize__rhinfo do.
      isbcnt=. isbcnt + >.size__opps % smallblocksize__rhinfo
    else.
      ibbcnt=. ibbcnt + >.size__opps % bigblocksize__rhinfo
    end.
  end.
end.
ismalllen=. isbcnt * smallblocksize__rhinfo
islcnt=. <. bigblocksize__rhinfo % longintsize
isbdcnt=. >.isbcnt % islcnt
ibbcnt=. ibbcnt + >.ismalllen % bigblocksize__rhinfo
icnt=. #ralist
ibdcnt=. <.bigblocksize__rhinfo % ppssize
ippscnt=. >.icnt % ibdcnt
isbdcnt ; ibbcnt ; <ippscnt
)

NB.  adjust2
adjust2=: 3 : 0
>. 2^.y
)

NB.  saveheader
saveheader=: 3 : 0
'rhinfo isbdcnt ibbcnt ippscnt'=. y
NB. 0. calculate basic setting
iblcnt=. <.bigblocksize__rhinfo % longintsize
i1stbdl=. <.(bigblocksize__rhinfo - 16b4c) % longintsize
ibdexl=. 0
iall=. ibbcnt + ippscnt + isbdcnt
iallw=. iall
ibdcntw=. >.iallw % iblcnt
ibdcnt=. >.(iall + ibdcntw) % iblcnt
NB. 0.1 calculate bd count
if. ibdcnt > i1stbdl do.
NB.  todo: is do-while correct here?
  whilst. ibdcnt > i1stbdl + ibdexl*iblcnt do.
    ibdexl=. >:ibdexl
    iallw=. >:iallw
    ibdcntw=. >.iallw % iblcnt
    ibdcnt=. >.(iallw + ibdcntw) % iblcnt
  end.
end.
NB. 1.save header
z=. 16bd0 16bcf 16b11 16be0 16ba1 16bb1 16b1a 16be1{a.
z=. z, 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0{a.
z=. z, toWORD0 16b3b
z=. z, toWORD0 16b03
z=. z, toWORD0 _2
z=. z, toWORD0 9
z=. z, toWORD0 6
z=. z, toWORD0 0
z=. z, 0 0 0 0 0 0 0 0 {a.
z=. z, toDWORD0 ibdcnt
z=. z, toDWORD0 ibbcnt+isbdcnt NB. root start
z=. z, toDWORD0 0
z=. z, toDWORD0 16b1000
z=. z, toDWORD0 0                   NB. small block depot
z=. z, toDWORD0 1
NB. 2. extra bdlist start, count
if. ibdcnt < i1stbdl do.
  z=. z, toDWORD0 _2       NB. extra bdlist start
  z=. z, toDWORD0 0        NB. extra bdlist count
else.
  z=. z, toDWORD0 iall+ibdcnt
  z=. z, toDWORD0 ibdexl
end.
fputs__rhinfo z
NB. 3. bdlist
i=. 0
while. (i<i1stbdl) *. (i < ibdcnt) do.
  fputs__rhinfo toDWORD0 iall+i
  i=. >:i
end.
if. i<i1stbdl do.
  fputs__rhinfo, (,:toDWORD0 _1) #~ i1stbdl-i
end.
)

NB.  savebigdata
savebigdata=: 3 : 0
'istblk ralist rhinfo'=. y
ires=. 0
NB. 1.write big (ge 16b1000)  data into block
for_opps. ralist do.
  if. type__opps ~: ppstypedir do.
    size__opps=: datalen__opps''   NB. mod
    if. ((size__opps >: smallsize__rhinfo) +. ((type__opps = ppstyperoot) *. 0~:#data__opps)) do.
NB. 1.1 write data
NB. check for update
      if. '' -.@-: ppsfile__opps do.
NB. check for update
        ilen=. #sbuff=. ]`(''"_)@.(_1&-:)@:fread ppsfile__opps
        fputs__rhinfo sbuff
      else.
        fputs__rhinfo data__opps
      end.
      if. size__opps |~ bigblocksize__rhinfo do.
NB.  todo: check, if strrepeat()  is binary safe
        fputs__rhinfo ({.a.) #~ bigblocksize__rhinfo ([ - |) size__opps
      end.
NB. 1.2 set for pps
      startblock__opps=: istblk
      istblk=. istblk + >.size__opps % bigblocksize__rhinfo
    end.
  end.
end.
istblk
)

NB.  savepps
savepps=: 3 : 0
'ralist rhinfo'=. y
NB. 0. initial
NB. 2. save pps
for_oitem. ralist do.
  saveppswk__oitem rhinfo
end.
NB. 3. adjust for block
icnt=. #ralist
ibcnt=. <.bigblocksize__rhinfo % ppssize__rhinfo
if. (icnt |~ ibcnt) do.
  fputs__rhinfo ({.a.) #~ (ibcnt ([ - |) icnt) * ppssize__rhinfo
end.
>.icnt % ibcnt
)

NB.  saveppssetpnt2
NB.   for test
saveppssetpnt2=: 3 : 0
'athis ralist rhinfo'=. y
NB. 1. make array as children-relations
NB. 1.1 if no children
if. ''-:athis do. ralist ; _1 return.
elseif. 1=#athis do.
NB. 1.2 just only one
  ralist=. ralist, l=. 0{athis
  no__l=: (#ralist) -1
  prevpps__l=: _1
  nextpps__l=: _1
  ralist=. >@{. ra=. saveppssetpnt2 child__l ; ralist ; <rhinfo
  dirpps__l=: >@{: ra
  ralist ; no__l return.
elseif. do.
NB. 1.3 array
  icnt=. #athis
NB. 1.3.1 define center
  ipos=. 0 NB. int(icnt% 2)
  awk=. athis
  if. (#athis) > 2 do.
    aprev=. 1{awk
    anext=. 2}.awk
  else.
    aprev=. ''
    anext=. }.awk
  end.
  l=. ipos{athis
  ralist=. >@{. ra=. saveppssetpnt2 aprev ; ralist ; <rhinfo
  prevpps__l=: >@{: ra
  ralist= ralist, l
  no__l=: (#ralist) -1
NB. 1.3.2 devide a array into previous, next
  ralist=. >@{. ra=. saveppssetpnt2 anext ; ralist ; <rhinfo
  nextpps__l=: >@{: ra
  ralist=. >@{. ra=. saveppssetpnt2 child__l ; ralist ; <rhinfo
  dirpps__l=: >@{: ra
  ralist ; no__l return.
end.
)

NB.  saveppssetpnt2
NB.   for test
saveppssetpnt2s=: 3 : 0
'athis ralist rhinfo'=. y
NB. 1. make array as children-relations
NB. 1.1 if no children
if. (0:=#) athis do. ralist ; _1 return.
elseif. (#athis) =1 do.
NB. 1.2 just only one
  ralist=. ralist, l=. 0{athis
  no__l=: (#ralist) -1
  prevpps__l=: _1
  nextpps__l=: _1
  ralist=. >@{. ra=. saveppssetpnt2 child__l ; ralist ; <rhinfo
  dirpps__l=: >@{: ra
  ralist ; no__l return.
elseif. do.
NB. 1.3 array
  icnt=. #athis
NB. 1.3.1 define center
  ipos=. 0 NB. int(icnt% 2)
  ralist=. ralist, l=. ipos{athis
  no__l=: (#ralist) -1
  awk=. athis
NB. 1.3.2 devide a array into previous, next
  aprev=. ipos{.awk
  anext=. (1+ipos)}.awk
  ralist=. >@{. ra=. saveppssetpnt2 aprev ; ralist ; <rhinfo
  prevpps__l=: >@{: ra
  ralist=. >@{. ra=. saveppssetpnt2 anext ; ralist ; <rhinfo
  nextpps__l=: >@{: ra
  ralist=. >@{. ra=. saveppssetpnt2 child__l ; ralist ; <rhinfo
  dirpps__l=: >@{: ra
  ralist ; no__l return.
end.
)

NB.  saveppssetpnt
saveppssetpnt=: 3 : 0
'athis ralist rhinfo'=. y
NB. 1. make array as children-relations
NB. 1.1 if no children
if. (0:=#) athis do. ralist ; _1 return.
elseif. (#athis) =1 do.
NB. 1.2 just only one
  ralist=. ralist, l=. 0{athis
  no__l=: (#ralist) -1
  prevpps__l=: _1
  nextpps__l=: _1
  ralist=. >@{. ra=. saveppssetpnt child__l ; ralist ; <rhinfo
  dirpps__l=: >@{: ra
  ralist ; no__l return.
elseif. do.
NB. 1.3 array
  icnt=. #athis
NB. 1.3.1 define center
  ipos=. <.icnt % 2
  ralist=. ralist, l=. ipos{athis
  no__l=: (#ralist) -1
  awk=. athis
NB. 1.3.2 devide a array into previous, next
  aprev=. ipos{.awk
  anext=. (1+ipos)}.awk
  ralist=. >@{. ra=. saveppssetpnt aprev ; ralist ; <rhinfo
  prevpps__l=: >@{: ra
  ralist=. >@{. ra=. saveppssetpnt anext ; ralist ; <rhinfo
  nextpps__l=: >@{: ra
  ralist=. >@{. ra=. saveppssetpnt child__l ; ralist ; <rhinfo
  dirpps__l=: >@{: ra
  ralist ; no__l return.
end.
)

NB.  saveppssetpnt
saveppssetpnt1=: 3 : 0
'athis ralist rhinfo'=. y
NB. 1. make array as children-relations
NB. 1.1 if no children
if. (0:=#) athis do. ralist ; _1 return.
elseif. (#athis) =1 do.
NB. 1.2 just only one
  ralist=. ralist, l=. 0{athis
  no__l=: (#ralist) -1
  prevpps__l=: _1
  nextpps__l=: _1
  ralist=. >@{. ra=. saveppssetpnt child__l ; ralist ; <rhinfo
  dirpps__l=: >@{: ra
  ralist ; no__l return.
elseif. do.
NB. 1.3 array
  icnt=. #athis
NB. 1.3.1 define center
  ipos=. <.icnt % 2
  ralist=. ralist, l=. ipos{athis
  no__l=: (#ralist) -1
  awk=. athis
NB. 1.3.2 devide a array into previous, next
  aprev=. ipos{.awk
  anext=. (1+ipos)}.awk
  ralist=. >@{. ra=. saveppssetpnt aprev ; ralist ; <rhinfo
  prevpps__l=: >@{: ra
  ralist=. >@{. ra=. saveppssetpnt anext ; ralist ; <rhinfo
  nextpps__l=: >@{: ra
  ralist=. >@{. ra=. saveppssetpnt child__l ; ralist ; <rhinfo
  dirpps__l=: >@{: ra
  ralist ; no__l return.
end.
)

NB.  savebbd
savebbd=: 3 : 0
'isbdsize ibsize ippscnt rhinfo'=. y
NB. 0. calculate basic setting
ibbcnt=. <.bigblocksize__rhinfo % longintsize
i1stbdl=. <.(bigblocksize__rhinfo - 16b4c) % longintsize
ibdexl=. 0
iall=. ibsize + ippscnt + isbdsize
iallw=. iall
ibdcntw=. >.iallw % ibbcnt
ibdcnt=. >.(iall + ibdcntw) % ibbcnt
NB. 0.1 calculate bd count
if. ibdcnt >i1stbdl do.
NB.  todo: do-while correct here?
  whilst. ibdcnt > i1stbdl+ibdexl*ibbcnt do.
    ibdexl=. >:ibdexl
    iallw=. >:iallw
    ibdcntw=. >.iallw % ibbcnt
    ibdcnt=. >.(iallw + ibdcntw) % ibbcnt
  end.
end.
NB. 1. making bd
NB. 1.1 set for sbd
if. isbdsize > 0 do.
  for_i. i.(isbdsize-1) do.
    fputs__rhinfo toDWORD0 i+1
  end.
  fputs__rhinfo toDWORD0 _2
end.
NB. 1.2 set for b
for_i. i.(ibsize-1) do.
  fputs__rhinfo toDWORD0 i+isbdsize+1
end.
fputs__rhinfo toDWORD0 _2
NB. 1.3 set for pps
for_i. i.(ippscnt-1) do.
  fputs__rhinfo toDWORD0 i+isbdsize+ibsize+1
end.
fputs__rhinfo toDWORD0 _2
NB. 1.4 set for bbd itself  _3 : bbd
for_i. i.ibdcnt do.
  fputs__rhinfo toDWORD0 _3
end.
NB. 1.5 set for extrabdlist
for_i. i.ibdexl do.
  fputs__rhinfo toDWORD0 _4
end.
NB. 1.6 adjust for block
if. ((iallw + ibdcnt) |~ ibbcnt) do.
  fputs__rhinfo, (,:toDWORD0 _1) #~ ibbcnt ([ - |) (iallw + ibdcnt)
end.
NB. 2.extra bdlist
if. (ibdcnt > i1stbdl) do.
  in=. 0
  inb=. 0
  i=. i1stbdl
  while. i<ibdcnt do.
    if. (in>: (ibbcnt-1)) do.
      in=. 0
      inb=. >:inb
      fputs__rhinfo toDWORD0 iall+ibdcnt+inb
    end.
    fputs__rhinfo toDWORD0 ibsize+isbdsize+ippscnt+i
    i=. >:i
    in=. >:in
  end.
  if. ((ibdcnt-i1stbdl) |~ (ibbcnt-1)) do.
    fputs__rhinfo, (,:toDWORD0 _1) #~ (ibbcnt-1) ([ - |) (ibdcnt-i1stbdl)
  end.
  fputs__rhinfo toDWORD0 _2
end.
)

NB. ---------------------------------------------------------
NB. package for biff format
cocurrent 'biff'
RECORDLEN=: 8224   NB. BIFF5: 2080 bytes, BIFF8: 8224 bytes
NB. Excel version BIFF version Document type File type
NB. Excel 2.1 BIFF2 Worksheet Stream
NB. Excel 3.0 BIFF3 Worksheet Stream
NB. Excel 4.0 BIFF4S Worksheet Stream
NB. Excel 4.0 BIFF4W Workbook Stream
NB. Excel 5.0 BIFF5 Workbook Compound Document
NB. Excel 7.0 (Excel 95) BIFF7 Workbook Compound Document
NB. Excel 8.0 (Excel 97) BIFF8 Workbook Compound Document
NB. Excel 9.0 (Excel 2000) BIFF8 Workbook Compound Document
NB. Excel 10.0 (Excel XP) BIFF8X Workbook Compound Document
NB. Excel 11.0 (Excel 2003) BIFF8X Workbook Compound Document
NB. Index     Format String
NB. ---------------------------------------------------------
NB. 0 General General
NB. 1 Decimal 0
NB. 2 Decimal 0.00
NB. 3 Decimal #,##0
NB. 4 Decimal #,##0.00
NB. 5 Currency "$"#,##0_); ("$"#,##0)
NB. 6 Currency "$"#,##0_);[Red] ("$"#,##0)
NB. 7 Currency "$"#,##0.00_); ("$"#,##0.00)
NB. 8 Currency "$"#,##0.00_);[Red] ("$"#,##0.00)
NB. 9 Percent 0%
NB. 10 Percent 0.00%
NB. 11 Scientific 0.00E+00
NB. 12 Fraction # ?/?
NB. 13 Fraction # ??/??
NB. 14 Date M/D/YY
NB. 15 Date D-MMM-YY
NB. 16 Date D-MMM
NB. 17 Date MMM-YY
NB. 18 Time h:mm AM/PM
NB. 19 Time h:mm:ss AM/PM
NB. 20 Time h:mm
NB. 21 Time h:mm:ss
NB. 22 Date/Time M/D/YY h:mm
NB. 37 Account. _(#,##0_);(#,##0)
NB. 38 Account. _(#,##0_);[Red](#,##0)
NB. 39 Account. _(#,##0.00_);(#,##0.00)
NB. 40 Account. _(#,##0.00_);[Red](#,##0.00)
NB. 41 Currency _ ("$"* #,##0_);_ ("$"* (#,##0);_ ("$"* "-"_);_(@_)
NB. 42 Currency _(* #,##0_);_(* (#,##0);_(* "-"_);_(@_)
NB. 43 Currency _ ("$"* #,##0.00_);_ ("$"* (#,##0.00);_ ("$"* "-"??_);_(@_)
NB. 44 Currency _(* #,##0.00_);_(* (#,##0.00);_(* "-"??_);_(@_)
NB. 45 Time mm:ss
NB. 46 Time [h]:mm:ss
NB. 47 Time mm:ss.0
NB. 48 Scientific ##0.0E+0
NB. 49 Text @
format0n=: 164  NB. reserved by excel
colorset0n=: 8   NB. reserved by excel
colorborder=: 16b40
colorpattern=: 16b41
colorfont=: 16b7fff
NB. cell ref 'AA5' => 4 26
A1toRC=: 3 : 0
assert. y e. '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'
(26 #. (0 _1)+ _2&{. ' ABCDEFGHIJKLMNOPQRSTUVWXYZ'&i. c),~ <: 1&". y -. c=. y -. '0123456789'
)

toHeader=: toWORD0
UString=: 3 : 0
toucode0 u: y
)

SString=: 3 : 0
(1&u: ::]) y
)

toString=: 3 : 0
if. 131072= 3!:0 y do.
  toucode0 y
else.
  y
end.
)

toUString8=: 3 : 0
if. 131072= 3!:0 y do.
  (a.{~#y), (1{a.), toucode0 y
else.
  (a.{~#y), (0{a.), y
end.
)

toUString16=: 3 : 0
if. 131072= 3!:0 y do.
  (toWORD0 #y), (1{a.), toucode0 y
else.
  (toWORD0 #y), (0{a.), y
end.
)

toUString=: 3 : 0
if. 131072= 3!:0 y do.
  (1{a.), toucode0 y
else.
  (0{a.), y
end.
)

toStream=: 4 : 0
x fappend~ y
)

sulen8=: 3 : 0
if. 131072= 3!:0 y do.
  2+2*#y
else.
  2+#y
end.
)

sulen16=: 3 : 0
if. 131072= 3!:0 y do.
  3+2*#y
else.
  3+#y
end.
)

NB. enum constants
cellborder_no_line=: 0
cellborder_thin=: 1
cellborder_medium=: 2
cellborder_dashed=: 3
cellborder_dotted=: 4
cellborder_thick=: 5
cellborder_double=: 6
cellborder_hair=: 7
cellborder_medium_dashed=: 8
cellborder_thin_dash_dotted=: 9
cellborder_medium_dash_dotted=: 10
cellborder_thin_dash_dot_dotted=: 11
cellborder_medium_dash_dot_dotted=: 12
cellborder_slanted_medium_dash_dotted=: 13
NB. biff record
NB. a formula which was array-entered into a range of cells
biff_array=: 3 : 0
'range recalc parsedexpr'=. y
'firstrow lastrow firstcol lastcol'=. range
recordtype=. 16b0221
z=. ''
z=. z, toWORD0 firstrow
z=. z, toWORD0 lastrow
z=. z, toBYTE firstcol
z=. z, toBYTE lastcol
z=. z, toWORD0 recalc
z=. z, toDWORD0 0
z=. z, toWORD0 #parsedexpr
z=. z, SString parsedexpr
z=. (,~ toHeader@:(recordtype , #)) z
)

NB. Should Excel make a backup of this XLS sheet?
biff_backup=: 3 : 0
recordtype=. 16b0040
z=. ''
z=. z, toWORD0 0~:y
z=. (,~ toHeader@:(recordtype , #)) z
)

NB. a cell with no formula or value
biff_blank=: 4 : 0
recordtype=. 16b0201
y=. >y
assert. 2=#y
z=. ''
z=. z, toWORD0 y
z=. z, toWORD0 x
z=. (,~ toHeader@:(recordtype , #)) z
)

NB. set the Beginning of File marker
NB.  version = Excel version   default is biff8 (97-2003)
NB.  docn = Excel document type   default is worksheet
biff_bof=: 3 : 0
'version docn'=. y
recordtype=. 16b809
z=. ''
z=. z, toWORD0 version
z=. z, toWORD0 docn
z=. z, toWORD0 8111   NB. built id
z=. z, toWORD0 1997   NB. built year
z=. z, toDWORD0 16b40c1
z=. z, toDWORD0 16b106
z=. (,~ toHeader@:(recordtype , #)) z
)

biff_bookbool=: 3 : 0
recordtype=. 16b00da
z=. ''
z=. z, toWORD0 0~:y
z=. (,~ toHeader@:(recordtype , #)) z
)

NB. a cell with a constant boolean OR error
NB. boolerrvalue = boolean or error value
NB. boolORerr = specifies a boolean or error   1 =. error, 0 =. boolean
biff_boolerr=: 4 : 0
'rowcol boolerrvalue boolORerr'=. y
recordtype=. 16b0205
z=. ''
z=. z, toWORD0 rowcol
z=. z, toWORD0 x
z=. z, toBYTE boolerrvalue
z=. z, toBYTE boolORerr
z=. (,~ toHeader@:(recordtype , #)) z
)

NB. set the bottom margin, used when printing, in inches
NB. 8-byte IEEE floating point format
biff_bottommargin=: 3 : 0
recordtype=. 16b0029
z=. ''
z=. z, toDouble0 y
z=. (,~ toHeader@:(recordtype , #)) z
)

biff_boundsheet=: 3 : 0
'offset visible type sheetname'=. y
recordtype=. 16b85
z=. ''
z=. z, toDWORD0 offset
z=. z, toBYTE visible
z=. z, toBYTE type
z=. z, toUString8 sheetname
z=. (,~ toHeader@:(recordtype , #)) z
)

NB. set the iteration count as set in Options->Calculation
biff_calccount=: 3 : 0
recordtype=. 16b000c
z=. ''
z=. z, toWORD0 y
z=. (,~ toHeader@:(recordtype , #)) z
)

NB. set the calculation mode
biff_calcmode=: 3 : 0
recordtype=. 13
z=. ''
z=. z, toWORD0 y
z=. (,~ toHeader@:(recordtype , #)) z
)

biff_codepage=: 3 : 0
recordtype=. 16b0042
z=. ''
z=. z, toWORD0 y
z=. (,~ toHeader@:(recordtype , #)) z
)

biff_colinfo=: 4 : 0
'col1 col2 width hide level collapse'=. y
recordtype=. 16b007d
z=. ''
z=. z, toWORD0 col1, col2, width, x
z=. z, toWORD0 hide bitor 8 bitshl level bitor 4 bitshl collapse
z=. z, toWORD0 0
z=. (,~ toHeader@:(recordtype , #)) z
)

NB. set the default cell attributes for those cells which aren't
NB. defined
biff_columndefault=: 3 : 0
recordtype=. 16b0020
z=. ''
z=. z, toWORD0 y
z=. (,~ toHeader@:(recordtype , #)) z
)

NB. a continuation of a formula too long to fit into one cell
biff_continue=: 3 : 0
recordtype=. 16b003c
z=. ''
z=. z, toString y
z=. (,~ toHeader@:(recordtype , #)) z
)

biff_country=: 3 : 0
recordtype=. 16b008c
z=. ''
z=. z, toWORD0 y
z=. (,~ toHeader@:(recordtype , #)) z
)

biff_crn=: 3 : 0
recordtype=. 16b005a
z=. ''
z=. z, SString y
z=. (,~ toHeader@:(recordtype , #)) z
)

NB. Specify the date system used in the XLS worksheet
biff_date1904=: 3 : 0
recordtype=. 16b0022
z=. ''
z=. z, toWORD0 0~:y
z=. (,~ toHeader@:(recordtype , #)) z
)

NB. width is in character
biff_defaultcolwidth=: 3 : 0
recordtype=. 16b0055
z=. ''
z=. z, toWORD0 y
z=. (,~ toHeader@:(recordtype , #)) z
)

NB. the row height of all undefined rows
NB. does not affect explicitly defined rows
NB. height is in increments of 1/20th of a point
biff_defaultrowheight=: 3 : 0
'notmatch hidden spaceabove spacebelow height'=. y
recordtype=. 16b0225
z=. ''
z=. z, toWORD0 bitor (0~:notmatch) bitor 1 bitshl (0~:hidden) bitor 1 bitshl (0~:spaceabove) bitor 1 bitshl (0~:spacebelow)
z=. z, toWORD0 height
z=. (,~ toHeader@:(recordtype , #)) z
)

NB. set the maximum change for an interative record
biff_delta=: 3 : 0
recordtype=. 16b0010
z=. ''
z=. z, toDouble0 y
z=. (,~ toHeader@:(recordtype , #)) z
)

NB. the minimum and maximum bounds of the worksheet
NB. the last row and column are numbered one higher than
NB. the last occupied row/column
biff_dimensions=: 3 : 0
recordtype=. 16b0200
z=. ''
z=. z, toDWORD0 0 1+0 1{y
z=. z, toWORD0 0 1+2 3{y
z=. z, toWORD0 0
z=. (,~ toHeader@:(recordtype , #)) z
)

NB. set the EOF record
biff_eof=: 3 : 0
recordtype=. 16b000a
z=. ''
z=. (,~ toHeader@:(recordtype , #)) z
)

biff_externname=: 4 : 0
recordtype=. 16b0023
z=. ''
if. 'external'-:x do.
  'builtin sheetidx name formula'
  z=. z, toWORD0 0~:builtin
  z=. z, toWORD0 >:sheetidx
  z=. z, toWORD0 0
  z=. z, toUString8 name
  z=. z, SString formula
elseif. 'internal'-:x do.
  'unhandled exception' 13!:8 (3)
elseif. 'addin'-:x do.
  z=. z, toWORD0 0
  z=. z, toDWORD0 0
  z=. z, toUString8 y
  z=. z, SString a.{~2 0 16b1c 16b17
elseif. 'dde'-:x do.
  'automatic stddoc clip item'=. y
  if. 0~:stddoc do. clip=. 16bfff end.
  z=. z, toWORD0 1 bitshl (0~:automatic) bitand 1 bitshl (0~:stddoc) bitand 2 bitshl clip
  z=. z, toDWORD0 0
  z=. z, toUString8 item
elseif. 'ole'-:x do.
  'automatic storage'=. y
  z=. z, toWORD0 1 bitshl (0~:automatic)
  z=. z, toDWORD0 storage
  z=. z, SString a.{~1 0 16b27
elseif. do.
  'unhandled exception' 13!:8 (3)
end.
z=. (,~ toHeader@:(recordtype , #)) z
)

biff_externsheet=: 3 : 0
recordtype=. 16b0017
z=. ''
z=. z, toWORD0 #y
for_yi. y do.
  z=. z, toWORD0 yi
end.
z=. (,~ toHeader@:(recordtype , #)) z
)

NB. describes an entry in Excels font table
NB.  height of the font in 1/20 of a point increments
biff_font=: 3 : 0
recordtype=. 16b0031
z=. ''
'height italic strikeout color weight script underline family charset fontname'=. y
z=. z, toWORD0 height
z=. z, toWORD0 (1 bitshl 0~:italic) bitor (3 bitshl 0~:strikeout)
z=. z, toWORD0 color
z=. z, toWORD0 weight
z=. z, toWORD0 script
z=. z, toBYTE underline
z=. z, toBYTE family
z=. z, toBYTE charset
z=. z, toBYTE 0
z=. z, toUString8 fontname
z=. (,~ toHeader@:(recordtype , #)) z
)

NB. sepcify the footer for the worksheet
biff_footer=: 3 : 0
recordtype=. 16b0015
z=. ''
if. #y do.
  z=. z, toUString16 y
end.
z=. (,~ toHeader@:(recordtype , #)) z
)

NB. describes a cell format
biff_format=: 3 : 0
'num str'=. y
recordtype=. 16b041e
z=. ''
z=. z, toWORD0 num
z=. z, toUString16 str
z=. (,~ toHeader@:(recordtype , #)) z
)

NB. a cell with a formula
NB.  value = current value of the formula
NB.  recalc = should the cell be recalculated on XLS load?
NB.  exprlength = length of parsed expression
NB.  pasedexpr = parsed expression
biff_formula=: 4 : 0
'rowcol value recalc calcopen shared parsedexpr'=. y
recordtype=. 16b0006
z=. ''
z=. z, toWORD0 rowcol
z=. z, toWORD0 x
z=. z, SString 8{.value
z=. z, toWORD0 (0~:recalc) bitor 1 bitshl 1 (0~:calcopen) bitor 1 bitshl 1 (0~:shared)
z=. z, toDWORD0 0
z=. z, toWORD0 #parsedexpr
z=. z, SString parsedexpr
z=. (,~ toHeader@:(recordtype , #)) z
)

biff_gridset=: 3 : 0
recordtype=. 16b0082
z=. ''
z=. z, toWORD0 0~:y
z=. (,~ toHeader@:(recordtype , #)) z
)

biff_guts=: 3 : 0
recordtype=. 16b0080
z=. ''
z=. z, toWORD0 y
z=. (,~ toHeader@:(recordtype , #)) z
)

biff_hcenter=: 3 : 0
recordtype=. 16b008d
z=. ''
z=. z, toWORD0 0~:y
z=. (,~ toHeader@:(recordtype , #)) z
)

NB. specify the header for the worksheet
biff_header=: 3 : 0
recordtype=. 16b0014
z=. ''
if. #y do.
  z=. z, toUString16 y
end.
z=. (,~ toHeader@:(recordtype , #)) z
)

biff_hideobj=: 3 : 0
recordtype=. 16b008d
z=. ''
z=. z, toWORD0 y
z=. (,~ toHeader@:(recordtype , #)) z
)

biff_hlink=: 4 : 0
recordtype=. 16b01b8
z=. ''
linktype=. x
if. 'url'-:linktype do. 'rowcols link textmark target description'=. y
elseif. 'local'-:linktype do. 'rowcols link elink uplevel textmark target description'=. y
elseif. 'unc'-:linktype do. 'rowcols link textmark target description'=. y
elseif. 'worksheet'-:linktype do. 'rowcols textmark target description'=. y
elseif. do. 'unhandled exception' 13!:8 (3)
end.
bit8=. bit7=. bit6=. bit5=. bit4=. bit3=. bit2=. bit1=. bit0=. 0
if. #target do. bit7=. 1 end.
if. #description do. bit2=. bit4=. 1 end.
if. #textmark do. bit3=. 1
elseif. 'worksheet'-:linktype do.
  'unhandled exception' 13!:8 (3)
end.
if. ('worksheet'-:linktype) *. (':'e.link) do. bit1=. 1 end.
if. 'url'-:linktype do. bit0=. bit1=. 1
elseif. 'local'-:linktype do. bit0=. 1
elseif. 'unc'-:linktype do. bit0=. bit1=. bit8=. 1
elseif. 'worksheet'-:linktype do. bit3=. 1
end.
flag=. #. bit8, bit7, bit6, bit5, bit4, bit3, bit2, bit1, bit0
z=. z, toWORD0 rowcols  NB. rowcols is row1 row2 col1 col2
z=. z, SString 16bd0 a.{~16bc9 16bea 16b79 16bf9 16bba 16bce 16b11 16b8c 16b82 16b00 16baa 16b00 16b4b 16ba9 16b0b
z=. z, toDWORD0 2
z=. z, toDWORD0 flag
if. #description do.
  z=. z, toDWORD0 1+#description
  z=. z, UString description+{.a.
end.
if. #target do.
  z=. z, toDWORD0 1+#target
  z=. z, UString target+{.a.
end.
if. 'url'-:linktype do.
  z=. z, SString a.{~16be0 16bc9 16bea 16b79 16bf9 16bba 16bce 16b11 16b8c 16b82 16b00 16baa 16b00 16b4b 16ba9 16b0b
  z=. z, toDWORD0 2*1+#link
  z=. z, UString link+{.a.
elseif. 'local'-:linktype do.
  z=. z, SString a.{~16b03 16b03 16b00 16b00 16b00 16b00 16b00 16b00 16bc0 16b00 16b00 16b00 16b00 16b00 16b00 16b46
  z=. z, toWORD0 uplevel
  z=. z, toDWORD0 1+#link
  z=. z, SString link+{.a.
  z=. z, SString a.{~16bff 16bff 16bad 16bde, 20#0
  if. #elink do.
    z=. z, toDWORD0 10+2*#elink
    z=. z, toDWORD0 2*#elink
    z=. z, SString a.{~16b03 16b00
    z=. z, UString elink
  else.
    z=. z, toDWORD0 0
  end.
elseif. 'unc'-:linktype do.
  z=. z, SString a.{~16be0 16bc9 16bea 16b79 16bf9 16bba 16bce 16b11 16b8c 16b82 16b00 16baa 16b00 16b4b 16ba9 16b0b
  z=. z, toDWORD0 1+#link
  z=. z, UString link+{.a.
elseif. 'worksheet'-:linktype do.
  ''  NB. only textmark present
end.
if. #textmark do.
  z=. z, toDWORD0 1+#textmark
  z=. z, UString textmark+{.a.
end.
z=. (,~ toHeader@:(recordtype , #)) z
)

NB. a list of explicit row page breaks
biff_horizontalpagebreaks=: 3 : 0
recordtype=. 16b001b
z=. ''
z=. z, toWORD0 #y
for_iy. y do. z=. z, toWORD0 iy end.
z=. (,~ toHeader@:(recordtype , #)) z
)

biff_index=: 3 : 0
recordtype=. 16b020b
z=. ''
z=. z, toDWORD0 0
z=. z, toDWORD0 y
z=. (,~ toHeader@:(recordtype , #)) z
)

NB. a cell containing a 14-bit signed integer, biff8 use RK value to store integer
NB. negative numbers and those outside this range are to
NB. be held in a NUMBER cell
biff_integer=: 4 : 0
assert. 2=#y
assert. 2=#>@{.y
assert. 1 4 8 e.~ 3!:0 >1{y
recordtype=. 16b027e
z=. ''
z=. z, toWORD0 >@{.y
z=. z, toWORD0 x
z=. z, toDWORD0 2b10 bitor 2 bitshl <. >1{y
z=. (,~ toHeader@:(recordtype , #)) z
)

NB. set the state of iteration
biff_iteration=: 3 : 0
recordtype=. 16b0011
z=. ''
z=. z, toWORD0 y
z=. (,~ toHeader@:(recordtype , #)) z
)

NB. cell with a constant string of length
biff_label=: 4 : 0
assert. 2=#y
assert. 2=#>@{.y
assert. 2 131072 e.~ 3!:0 >1{y
if. ''-:, >1{y do.
  x biff_blank {.y
else.
  recordtype=. 16b00fd
  z=. ''
  z=. z, toWORD0 >@{.y
  z=. z, toWORD0 x
  z=. z, toDWORD0 add2sst ,&.> 1{y
  z=. (,~ toHeader@:(recordtype , #)) z
end.
)

biff_labelranges=: 3 : 0
'row col'=. y
if. 0=(#row)+#col do. '' return. end.
recordtype=. 16b015f
z=. ''
z=. z, toWORD0 #row
for_iy. row do. z=. z, toWORD0 iy end.
z=. z, toWORD0 #col
for_iy. col do. z=. z, toWORD0 iy end.
z=. (,~ toHeader@:(recordtype , #)) z
)

NB. set the left margin, used when printing, in inches
NB. 8-byte IEEE floating point format
biff_leftmargin=: 3 : 0
recordtype=. 16b0026
z=. ''
z=. z, toDouble0 y
z=. (,~ toHeader@:(recordtype , #)) z
)

biff_mergedcells=: 3 : 0
if. (0:=#) y do. '' return. end.
recordtype=. 16b00e5
z=. ''
z=. z, toWORD0 #y
for_iy. y do. z=. z, toWORD0 iy end.
z=. (,~ toHeader@:(recordtype , #)) z
)

biff_name=: 3 : 0
recordtype=. 16b0018
z=. ''
'hidden function command macro complex builtin functiongroup binaryname keybd name formula sheet menu description helptopic statusbar'=. y
flag=. (0~:hidden) bitor 1 bitshl (0~:function) bitor 1 bitshl (0~:command) bitor 1 bitshl (0~:macro) bitor 1 bitshl (0~:complex) bitor 1 bitshl (0~:builtin) bitor 1 bitshl functiongroup bitor 6 bitshl binaryname
z=. z, toWORD0 flag
z=. z, toBYTE keybd
z=. z, toBYTE #name
z=. z, toWORD0 #formula
z=. z, toWORD0 0
z=. z, toWORD0 >:sheet
z=. z, toBYTE #menu
z=. z, toBYTE #description
z=. z, toBYTE #helptopic
z=. z, toBYTE #statusbar
z=. z, toUString name
z=. z, SString formula
if. #menu do. z=. z, toUString menu end.
if. #description do. z=. z, toUString description end.
if. #helptopic do. z=. z, toUString helptopic end.
if. #statusbar do. z=. z, toUString statusbar end.
z=. (,~ toHeader@:(recordtype , #)) z
)

NB. a cell containing a constant floating point number
NB. IEEE 8-byte floating point format
biff_number=: 4 : 0
assert. 2=#y
assert. 2=#>@{.y
assert. 1 4 8 e.~ 3!:0 >1{y
recordtype=. 16b0203
z=. ''
z=. z, toWORD0 >@{.y
z=. z, toWORD0 x
z=. z, toDouble0 >1{y
z=. (,~ toHeader@:(recordtype , #)) z
)

NB. workbook/worksheet object protection
biff_objectprotect=: 3 : 0
recordtype=. 16b0063
z=. ''
z=. z, toWORD0 0~:y
z=. (,~ toHeader@:(recordtype , #)) z
)

biff_palette=: 3 : 0
recordtype=. 16b0092
z=. ''
z=. z, toWORD0 #y
z=. z, toDWORD0 y
z=. (,~ toHeader@:(recordtype , #)) z
)

NB. number and position of panes in a window
biff_pane=: 3 : 0
recordtype=. 16b0041
z=. ''
'split vis activepane'=. y
z=. z, toWORD0 split   NB. xsplit ysplit
z=. z, toWORD0 vis     NB. topvis leftvis
for_pane. activepane do. z=. z, toWORD0 pane end.
z=. (,~ toHeader@:(recordtype , #)) z
)

NB. worksheet/workbook protection (.5.18). It stores a 16-bit hash value,
biff_password=: 3 : 0
recordtype=. 16b0013
z=. ''
z=. z, toWORD0 y
z=. (,~ toHeader@:(recordtype , #)) z
)

NB. set the precision as set in Option->Calculation
biff_precision=: 3 : 0
recordtype=. 16b000e
z=. ''
z=. z, toWORD0 0~:y
z=. (,~ toHeader@:(recordtype , #)) z
)

NB. Print Gridlines when printing?
biff_printgridlines=: 3 : 0
recordtype=. 16b002b
z=. ''
z=. z, toWORD0 0~:y
z=. (,~ toHeader@:(recordtype , #)) z
)

NB. Shall Excel print the row 'n column headers
biff_printheaders=: 3 : 0
recordtype=. 16b002a
z=. ''
z=. z, toWORD0 0~:y
z=. (,~ toHeader@:(recordtype , #)) z
)

NB. workbook/worksheet cell content protection
biff_protect=: 3 : 0
recordtype=. 16b0012
z=. ''
z=. z, toWORD0 0~:y
z=. (,~ toHeader@:(recordtype , #)) z
)

NB. set the cell reference mode as in Options->Desktop
NB. sets the cell reference mode to
NB. <letter><number>   like A1 or C3 -- you sank my battleship
NB.    OR
NB. R<number>C<number>   y'know R1C1 = row 1 col 1
biff_refmode=: 3 : 0
recordtype=. 16b000f
z=. ''
z=. z, toWORD0 0~:y
z=. (,~ toHeader@:(recordtype , #)) z
)

NB. set the right margin, used when printing, in inches
NB. 8-byte IEEE floating point format
biff_rightmargin=: 3 : 0
recordtype=. 16b0027
z=. ''
z=. z, toDouble0 y
z=. (,~ toHeader@:(recordtype , #)) z
)

NB. a row descriptor needs the follwing ingredients
biff_row=: 4 : 0
xf=. x
'rownumber firstcol lastcol usedefaultheight rowheight heightnotmatch spaceabove spacebelow hidden explicitformat outlinelevel outlinegroup'=. y
recordtype=. 16b0208
z=. ''
z=. z, toWORD0 rownumber
z=. z, toWORD0 firstcol
z=. z, toWORD0 lastcol
z=. z, toWORD0 (16b7fff bitand rowheight) bitor 15 bitshl 0~:usedefaultheight
z=. z, toWORD0 0
z=. z, toWORD0 0
z=. z, toDWORD0 (16b7 bitand outlinelevel) bitor 4 bitshl (0~:outlinegroup) bitor 1 bitshl (0~:hidden) bitor 1 bitshl (0~:heightnotmatch) bitor 1 bitshl (0~:explicitformat) bitor 1 bitshl 1 bitor 8 bitshl (16bfff bitand xf) bitor 12 bitshl (0~:spaceabove) bitor 1 bitshl 0~:spacebelow
z=. (,~ toHeader@:(recordtype , #)) z
)

NB. workbook/worksheet scenarios protection
biff_scenprotect=: 3 : 0
recordtype=. 16b00dd
z=. ''
z=. z, toWORD0 0~:y
z=. (,~ toHeader@:(recordtype , #)) z
)

biff_scl=: 3 : 0
recordtype=. 16b00a0
z=. ''
z=. z, toWORD0 y
z=. (,~ toHeader@:(recordtype , #)) z
)

NB. sets the cells which are selected in a pane
NB. not implemented yet
biff_selection=: 3 : 0
recordtype=. 16b001d
z=. ''
'panenum row col refnum refs'=. y
z=. z, toBYTE panenum
z=. z, toWORD0 row
z=. z, toWORD0 col
z=. z, toWORD0 refnum
z=. z, toWORD0 #refs
for_i. i.#refs do.
  z=. z, toWORD0 2{.>i{refs
  z=. z, toBYTE 2}.>i{refs
end.
z=. (,~ toHeader@:(recordtype , #)) z
)

biff_setup=: 3 : 0
recordtype=. 16b00a1
z=. ''
'setuppapersize setupscaling setupstartpage setupfitwidth setupfitheight setuprowmajor setupportrait setupinvalid setupblackwhite setupdraft setupcellnote setuporientinvalid setupusestartpage setupnoteatend setupprinterror setupdpi setupvdpi setupheadermargin setupfootermargin setupnumcopy'=. y
z=. z, toWORD0 setuppapersize
z=. z, toWORD0 setupscaling
z=. z, toWORD0 setupstartpage
z=. z, toWORD0 setupfitwidth
z=. z, toWORD0 setupfitheight
z=. z, toWORD0 setuprowmajor bitor 1 bitshl setupportrait bitor 1 bitshl setupinvalid bitor 1 bitshl setupblackwhite bitor 1 bitshl setupdraft bitor 1 bitshl setupcellnote bitor 1 bitshl setuporientinvalid bitor 1 bitshl setupusestartpage bitor 2 bitshl setupnoteatend bitor 1 bitshl setupprinterror
z=. z, toWORD0 setupdpi
z=. z, toWORD0 setupvdpi
z=. z, toDouble0 setupheadermargin
z=. z, toDouble0 setupfootermargin
z=. z, toWORD0 setupnumcopy
z=. (,~ toHeader@:(recordtype , #)) z
)

biff_standardwidth=: 3 : 0
recordtype=. 16b0099
z=. ''
z=. z, toWORD0 y
z=. (,~ toHeader@:(recordtype , #)) z
)

NB. the string value of a formula
NB. the value of all formulas outside of this record are held in
NB. Excels formula format
biff_string=: 3 : 0
if. #y do.
  recordtype=. 16b0207
  z=. ''
  z=. z, toUString16 y
  z=. (,~ toHeader@:(recordtype , #)) z
else.
  z=. ''
end.
)

biff_style=: 4 : 0
recordtype=. 16b0293
z=. ''
'builtin id level name'=. y
if. 0=builtin do.
  z=. z, toWORD0 16bfff bitand x
  z=. z, toUString16 name
else.
  z=. z, toWORD0 16b8000 bitor 16bfff bitand x
  z=. z, toBYTE id
  z=. z, toBYTE level
end.
z=. (,~ toHeader@:(recordtype , #)) z
)

biff_supbook=: 4 : 0
recordtype=. 16b01ae
z=. ''
if. 'external'-:x do.
  z=. z, toWORD0 #>{:y
  z=. z, toUString16 >{.y
  for_yi. >{:y do.
    z=. z, toUString16 >yi
  end.
elseif. 'internal'-:x do.
  z=. z, toWORD0 y
  z=. z, SString 1 4{a.
elseif. 'addin'-:x do.
  z=. z, toWORD0 1
  z=. z, SString 1 3{a.
elseif. ('ole'-:x)+.('dde'-:x) do.
  z=. z, toWORD0 0
  z=. z, toUString16 y
elseif. do.
  'unhandled exception' 13!:8 (3)
end.
z=. (,~ toHeader@:(recordtype , #)) z
)

NB. a one-input row or column table created with the Data Table command
biff_table=: 3 : 0
recordtype=. 16b0036
z=. ''
'firstrow lastrow firstcol lastcol recalc rowinput colinput row col'=. y
z=. z, toWORD0 firstrow
z=. z, toWORD0 lastrow
z=. z, toBYTE firstcol
z=. z, toBYTE lastcol
z=. z, toWORD0 recalc
z=. z, toWORD0 rowinput
z=. z, toWORD0 colinput
z=. z, toWORD0 row
z=. z, toWORD0 col
z=. (,~ toHeader@:(recordtype , #)) z
)

NB. set the top margin, used when printing, in inches
NB. 8-byte IEEE floating point format
biff_topmargin=: 3 : 0
recordtype=. 16b0028
z=. ''
z=. z, toDouble0 y
z=. (,~ toHeader@:(recordtype , #)) z
)

biff_vcenter=: 3 : 0
recordtype=. 16b0084
z=. ''
z=. z, toWORD0 0~:y
z=. (,~ toHeader@:(recordtype , #)) z
)

NB. a list of explicit column page breaks
biff_verticalpagebreaks=: 3 : 0
recordtype=. 16b001a
z=. ''
z=. z, toWORD0 #y
for_iy. y do. z=. z, toWORD0 iy end.
z=. (,~ toHeader@:(recordtype , #)) z
)

NB. basic Excel window information
biff_window1=: 3 : 0
recordtype=. 16b003d
z=. ''
'x y width height hidden'=. y
z=. z, toWORD0 x
z=. z, toWORD0 y
z=. z, toWORD0 width
z=. z, toWORD0 height
z=. z, toWORD0 hidden
z=. z, toWORD0 0
z=. z, toWORD0 0
z=. z, toWORD0 1
z=. z, toWORD0 250
z=. (,~ toHeader@:(recordtype , #)) z
)

NB. advanced window information
biff_window2=: 3 : 0
recordtype=. 16b023e
z=. ''
'flag topvisiblerow leftvisiblecol RGBcolor'=. y
z=. z, toWORD0 flag
z=. z, toWORD0 topvisiblerow
z=. z, toWORD0 leftvisiblecol
z=. z, toWORD0 RGBcolor
z=. z, toWORD0 0
z=. z, toWORD0 0
z=. z, toWORD0 0
z=. z, toDWORD0 0
z=. (,~ toHeader@:(recordtype , #)) z
)

NB. workbook/worksheet window configuration protection
biff_windowprotect=: 3 : 0
recordtype=. 16b0019
z=. ''
z=. z, toWORD0 0~:y
z=. (,~ toHeader@:(recordtype , #)) z
)

biff_wsbool=: 3 : 0
recordtype=. 16b0081
z=. ''
z=. z, toWORD0 y
z=. (,~ toHeader@:(recordtype , #)) z
)

biff_xct=: 3 : 0
recordtype=. 16b0059
z=. ''
z=. z, toWORD0 y
z=. (,~ toHeader@:(recordtype , #)) z
)

biff_xf=: 3 : 0
recordtype=. 16b00e0
'font format typeprot align rotate indent used border linecolor color'=. y
z=. ''
z=. z, toWORD0 font
z=. z, toWORD0 format
z=. z, toWORD0 typeprot
z=. z, toBYTE align
z=. z, toBYTE rotate
z=. z, toBYTE indent
z=. z, toBYTE used
z=. z, toDWORD0 border
z=. z, toDWORD0 linecolor
z=. z, toWORD0 color
z=. (,~ toHeader@:(recordtype , #)) z
)

coclass 'biffrefname'
coinsert 'oleutlfcn'
coinsert 'biff'
create=: 3 : 0
'hidden function command macro complex builtin functiongroup binaryname keybd sheetidx'=: 0
'name formula menu description helptopic statusbar'=: 6#a:
)

destroy=: codestroy
writestream=: 3 : 0
z=. biff_name hidden ; function ; command ; macro ; complex ; builtin ; functiongroup ; binaryname ; keybd ; name ; formula ; sheetidx ; menu ; description ; helptopic ; statusbar
)

coclass 'biffsupbook'
coinsert 'oleutlfcn'
coinsert 'biff'
newextname=: 3 : 0
extname=: extname, <y
)

create=: 3 : 0
'type sheetn source sheetname'=: 4{.y
if. -. (<type) e. 'external' ; 'internal' ; 'addin' ; 'ole' ; 'dde' do.
  'unhandled exception' 13!:8 (3)
end.
extname=: ''
crn=: ''  NB. not yet implemented
)

destroy=: codestroy
writestream=: 3 : 0
z=. ''
if. 'external'-:type do. z=. z, type biff_supbook source ,&< sheetname
elseif. 'internal'-:type do. z=. z, type biff_supbook y
elseif. 'addin'-:type do. z=. z, type biff_supbook ''
elseif. 'ole'-:type do. z=. z, type biff_supbook source
elseif. 'dde'-:type do. z=. z, type biff_supbook source
end.
for_ni. extname do.
  z=. z, type biff_externname >ni
end.
for_ni. crn do.
  z=. z, type biff_crn >ni
end.
z
)

coclass 'biffxf'
coinsert 'oleutlfcn'
coinsert 'biff'
NB. merely create biffxf will not result in a new biff xf record in excel file
NB. each biffxf object must be getxfidx
NB. getcolor=: 3 : 0
NB. y=. y.
NB. if. y e. colorborder, colorpattern, colorfont do. y return. end.
NB. if. (#colorset__COCREATOR)= n=. colorset__COCREATOR i. y do.
NB.   colorset__COCREATOR=: colorset__COCREATOR, y
NB. end.
NB. n
NB. )
getcolor=: ]
getfont=: 3 : 0
'fontheight fontitalic fontstrike fontcolor fontweight fontscript fontunderline fontfamily fontcharset fontname'=. y
y=. fontheight ; fontitalic ; fontstrike ; (getcolor fontcolor) ; fontweight ; fontscript ; fontunderline ; fontfamily ; fontcharset ; trim fontname
if. (#fontset__COCREATOR)= n=. fontset__COCREATOR i. y do.
  fontset__COCREATOR=: fontset__COCREATOR, y
end.
n
)

getformat=: 3 : 0
if. (#formatset__COCREATOR)= n=. formatset__COCREATOR i. <y=. trim y do.
  formatset__COCREATOR=: formatset__COCREATOR, <y
end.
n
)

NB. return xf in xfset row for an biffxf object
NB. usage: getxfrow__xfo''
NB. font format typeprotparent align rotate indent used border linecolor color
getxfrow=: 3 : 0
font=. getfont fontheight ; fontitalic ; fontstrike ; fontcolor ; fontweight ; fontscript ; fontunderline ; fontfamily ; fontcharset ; fontname
formatn=. getformat format
NB. see 6.70, otherwise excel cannot use cell format edit
if. (0=leftlinecolor) *. leftlinestyle do. leftlinecolor=. 16b40 end.
if. (0=rightlinecolor) *. rightlinestyle do. rightlinecolor=. 16b40 end.
if. (0=toplinecolor) *. toplinestyle do. toplinecolor=. 16b40 end.
if. (0=bottomlinecolor) *. bottomlinestyle do. bottomlinecolor=. 16b40 end.
if. (0=diagonalcolor) *. diagonalstyle do. diagonalcolor=. 16b40 end.
if. (0=patternbgcolor) *. pattern do. patternbgcolor=. 16b41 end.
typeprotparent=. lock bitor 1 bitshl hideformula bitor 1 bitshl type bitor 2 bitshl parentxf
align=. horzalign bitor 3 bitshl textwrap bitor 1 bitshl vertalign
indentshrink=. indent bitor 4 bitshl shrink
used=. 2 bitshl usedformat bitor 1 bitshl usedfont bitor 1 bitshl usedalign bitor 1 bitshl usedborder bitor 1 bitshl usedbackground bitor 1 bitshl usedprotect
border=. leftlinestyle bitor 4 bitshl rightlinestyle bitor 4 bitshl toplinestyle bitor 4 bitshl bottomlinestyle bitor 4 bitshl (getcolor leftlinecolor) bitor 7 bitshl (getcolor rightlinecolor) bitor 7 bitshl diagonaltopleft bitor 1 bitshl diagonalbottomleft
linecolor=. (getcolor toplinecolor) bitor 7 bitshl (getcolor bottomlinecolor) bitor 7 bitshl (getcolor diagonalcolor) bitor 7 bitshl diagonalstyle bitor 5 bitshl pattern
color=. (getcolor patterncolor) bitor 7 bitshl (getcolor patternbgcolor)
font, formatn, typeprotparent, align, rotation, indentshrink, used, border, linecolor, color
)

NB. set biffxf object to an xfset row
NB. font format typeprotparent align rotate indent used border linecolor color
copyxfrow=: 3 : 0
'font formatn typeprotparent align rotate indentshrink used border linecolor color'=. y
'fontheight fontitalic fontstrike fontcolor fontweight fontscript fontunderline fontfamily fontcharset fontname'=: font{fontset__COCREATOR
NB. if. -. fontcolor e. colorborder, colorpattern, colorfont do.
NB.   fontcolor=: fontcolor{.colorset__COCREATOR
NB. end.
format=: >formatn{formatset__COCREATOR
lock=: 1 bitand typeprotparent
hideformula=: _1 bitshl 2b10 bitand typeprotparent
type=: _2 bitshl 2b100 bitand typeprotparent
parentxf=: _4 bitshl 16bfff0 bitand typeprotparent
rotation=: rotate
horzalign=: 7 bitand align
textwrap=: _3 bitshl 8 bitand align
vertalign=: _4 bitshl 16b70 bitand align
indent=: 16bf bitand indentshrink
shrink=: _4 bitshl 16b10 bitand indentshrink
'usedformat usedfont usedalign usedborder usedbackground usedprotect'=: |. _2}. _8{. (8#0), #: used
leftlinestyle=: 16bf bitand border
rightlinestyle=: _4 bitshl 16bf0 bitand border
toplinestyle=: _8 bitshl 16bf00 bitand border
bottomlinestyle=: _12 bitshl 16bf000 bitand border
leftlinecolor=: _16 bitshl 16b7f0000 bitand border
rightlinecolor=: _23 bitshl 16b3f800000 bitand border
diagonaltopleft=: _30 bitshl 16b40000000 bitand border
diagonalbottomleft=: _31 bitshl (dfhs '80000000') bitand border
toplinecolor=: 16b7f bitand linecolor
bottomlinecolor=: _7 bitshl 16b3f80 bitand linecolor
diagonalcolor=: _14 bitshl 16b1fc000 bitand linecolor
diagonalstyle=: _21 bitshl 16b1e00000 bitand linecolor
pattern=: _26 bitshl (dfhs 'fc000000') bitand linecolor
patterncolor=: 16b7f bitand color
patternbgcolor=: _7 bitshl 16b3f80 bitand color
)

NB. copy content from an another biffxf object
copyxfobj=: 3 : 0
l=. y
nm=. nl__l 0
for_nmi. nm do. (>nmi)=: ((>nmi), '__l')~ end.
)

create=: 3 : 0
NB. read section 5.113 XF Extended Format and 5.43 FONT
'fontheight fontitalic fontstrike fontcolor fontweight fontscript fontunderline fontfamily fontcharset fontname'=: {.fontset_COCREATOR
format=: 'General'
lock=: 0
hideformula=: 1
type=: 0  NB. 0: cell 1:style
parentxf=: 0
horzalign=: 0  NB. 0 general  1 left  2 center  3 right
textwrap=: 0
vertalign=: 2  NB. 0 top  1 centre  2 bottom
rotation=: 0
indent=: 0
shrink=: 0
usedformat=: 0
usedfont=: 0
usedalign=: 0
usedborder=: 0
usedbackground=: 0
usedprotect=: 0
leftlinestyle=: 0
rightlinestyle=: 0
toplinestyle=: 0
bottomlinestyle=: 0
leftlinecolor=: 0
rightlinecolor=: 0
diagonaltopleft=: 0
diagonalbottomleft=: 0
toplinecolor=: 0
bottomlinecolor=: 0
diagonalcolor=: 0
diagonalstyle=: 0
pattern=: 0
patterncolor=: colorborder
patternbgcolor=: colorpattern
xfindex=: _1   NB. undefined
if. ''-.@-:y do.
  if. (3!:0 y) e. 1 4 do.
    copyxfrow y
  elseif. (3!:0 y) e. 32 do.
    copyxfobj y
  end.
end.
)

destroy=: codestroy

coclass 'biffsheet'
coinsert 'oleutlfcn'
coinsert 'biff'
NB. This verb use IMDATA record which has been obsoleted, only MS Excel can display it correct.
NB. other Excel compatible program (open office calc, gnumeric can not display it.
NB.   Insert a 24bit bitmap image in a worksheet.
NB. x
NB.   row     The row we are going to insert the bitmap into
NB.   col     The column we are going to insert the bitmap into
NB.   x       The horizontal position (offset) of the image inside the cell.
NB.   y       The vertical position (offset) of the image inside the cell.
NB.   scale_x The horizontal scale
NB.   scale_y The vertical scale
NB. y
NB.   bitmap  The bitmap filename
insertpicture=: 4 : 0
img=. y
'rowcol xy scalexy'=. x
if. 2 131072 e.~ 3!:0 rowcol do. rowcol=. A1toRC rowcol end.
'row col'=. rowcol
'x y'=. xy
'scalex scaley'=. scalexy
z=. processbitmap img
if. _1=>@{.z do. z return. end.
'width height size data'=. }.z
NB. Scale the frame of the image.
width=. width * scalex
height=. height * scaley
NB. Calculate the vertices of the image and write the OBJ record
positionImage col ; row ; x ; y ; width ; height
NB. Write the IMDATA record to store the bitmap data
record=. 16b007f
if. RECORDLEN>:8 + size do.
  length=. 8 + size
  cf=. 16b09
  env=. 16b01
  lcb=. size
  header=. toWORD0 record, length, cf, env
  header=. header, toDWORD0 lcb
  imdata=: imdata, header, data
else.
  length=. RECORDLEN
  cf=. 16b09
  env=. 16b01
  lcb=. size
  header=. toWORD0 record, length, cf, env
  header=. header, toDWORD0 lcb
  imdata=: imdata, header, (RECORDLEN-8){.data
  data=. (RECORDLEN-8)}.data
  a=. <.(#data) % RECORDLEN
  b=. RECORDLEN | #data
  if. #a do.
    imdata=: imdata,, (toHeader 16b003c, RECORDLEN), "1 (a, RECORDLEN)$(a*RECORDLEN){.data
  end.
  if. #b do.
    imdata=: imdata, (toHeader 16b003c, b), (-b){.data
  end.
end.
0 ; ''
)

NB.
NB.   Calculate the vertices that define the position of the image as required by
NB.   the OBJ record.
NB.
NB.           +------------+------------+
NB.           |     A      |      B     |
NB.     +-----+------------+------------+
NB.     |     |(x1, y1)     |            |
NB.     |  1  |(A1)._______|______      |
NB.     |     |    |              |     |
NB.     |     |    |              |     |
NB.     +-----+----|    BITMAP    |-----+
NB.     |     |    |              |     |
NB.     |  2  |    |______________.     |
NB.     |     |            |        (B2)|
NB.     |     |            |     (x2, y2)|
NB.     +---- +------------+------------+
NB.
NB.   Example of a bitmap that covers some of the area from cell A1 to cell B2.
NB.
NB.   Based on the width and height of the bitmap we need to calculate 8 vars:
NB.       $col_start, $row_start, $col_end, $row_end, $x1, $y1, $x2, $y2.
NB.   The width and height of the cells are also variable and have to be taken into
NB.   account.
NB.   The values of $col_start and $row_start are passed in from the calling
NB.   function. The values of $col_end and $row_end are calculated by subtracting
NB.   the width and height of the bitmap from the width and height of the
NB.   underlying cells.
NB.   The vertices are expressed as a percentage of the underlying cell width as
NB.   follows (rhs values are in pixels):
NB.
NB.         x1 = X / W *1024
NB.         y1 = Y / H *256
NB.         x2 = (X-1) / W *1024
NB.         y2 = (Y-1) / H *256
NB.
NB.         Where:  X is distance from the left side of the underlying cell
NB.                 Y is distance from the top of the underlying cell
NB.                 W is the width of the cell
NB.                 H is the height of the cell
NB.
NB.   the SDK incorrectly states that the height should be expressed as a percentage of 1024.
NB.
NB.   col_start Col containing upper left corner of object
NB.   row_start Row containing top left corner of object
NB.   x1        Distance to left side of object
NB.   y1        Distance to top of object
NB.   width     Width of image frame
NB.   height    Height of image frame
NB.
positionImage=: 3 : 0
'colstart rowstart x1 y1 width height'=. y
NB. Initialise end cell to the same as the start cell
colend=. colstart  NB. Col containing lower right corner of object
rowend=. rowstart  NB. Row containing bottom right corner of object
NB. Zero the specified offset if greater than the cell dimensions
if. x1 >: sizeCol colstart do. x1=. 0 end.
if. y1 >: sizeRow rowstart do. y1=. 0 end.
width=. width + x1 -1
height=. height + y1 -1
NB. Subtract the underlying cell widths to find the end cell of the image
while. width >: sizeCol colend do.
  width=. width - sizeCol colend
  colend=. >:colend
end.
NB. Subtract the underlying cell heights to find the end cell of the image
while. height >: sizeRow rowend do.
  height=. height - sizeRow rowend
  rowend=. >:rowend
end.
NB. Bitmap isn't allowed to start or finish in a hidden cell, i.e. a cell
NB. with zero height or width.
NB.
if. 0= sizeCol colstart do. return. end.
if. 0= sizeCol colend do. return. end.
if. 0= sizeRow rowstart do. return. end.
if. 0= sizeRow rowend do. return. end.
NB. Convert the pixel values to the percentage value expected by Excel
x1=. <. 1024 * x1 % sizeCol colstart
y1=. <. 256 * y1 % sizeRow rowstart
x2=. <. 1024 * width % sizeCol colend NB. Distance to right side of object
y2=. <. 256 * height % sizeRow rowend NB. Distance to bottom of object
storeobjpicture colstart ; x1 ; rowstart ; y1 ; colend ; x2 ; rowend ; y2
)

getcolsizes=: 3 : 0
if. (#colsizes)= i=. y i.~ {."1 colsizes do.
  _1
else.
  {: i{colsizes
end.
)

getrowsizes=: 3 : 0
if. (#rowsizes)= i=. y i.~ {."1 rowsizes do.
  _1
else.
  {: i{rowsizes
end.
)

NB.
NB.   Convert the width of a cell from user's units to pixels. By interpolation
NB.   the relationship is: y = 7x +5. If the width hasn't been set by the user we
NB.   use the default value. If the col is hidden we use a value of zero.
NB.
NB.   return The width in pixels
NB.
sizeCol=: 3 : 0
NB. Look up the cell value to see if it has been changed
if. _1~: getcolsizes y do.
  if. 0= getcolsizes y do.
    0 return.
  else.
NB. user unit is 0.38 + number of character
NB. y = 8x +5  seem correct on my 800X600 screen
    <. 5 + 8 * 0.38 + 256%~ getcolsizes y return.
  end.
else.
  <. 5 + 8 * 0.38 + 256%~ defaultcolwidth * 256 return.
end.
)

NB.
NB.   Convert the height of a cell from user's units to pixels. By interpolation
NB.   the relationship is: y = 4/3x. If the height hasn't been set by the user we
NB.   use the default value. If the row is hidden we use a value of zero. (Not
NB.   possible to hide row yet).
NB.
NB.   return The width in pixels
NB.
sizeRow=: 3 : 0
NB. Look up the cell value to see if it has been changed
if. _1~: getrowsizes y do.
  if. 0= getrowsizes y do.
    0 return.
  else.
NB. user unit is point (=1/72")
    <. (4%3) * 20%~ getrowsizes y return.
  end.
else.
  <. (4%3) * 20%~ defaultrowheight return.
end.
)

NB.
NB.   Store the OBJ record that precedes an IMDATA record. This could be generalise
NB.   to support other Excel objects.
NB.
NB.   colL Column containing upper left corner of object
NB.   dxL  Distance from left side of cell
NB.   rwT  Row containing top left corner of object
NB.   dyT  Distance from top of cell
NB.   colR Column containing lower right corner of object
NB.   dxR  Distance from right of cell
NB.   rwB  Row containing bottom right corner of object
NB.   dyB  Distance from bottom of cell
NB.
storeobjpicture=: 3 : 0
'colL dxL rwT dyT colR dxR rwB dyB'=. y
record=. 16b005d   NB. Record identifier
length=. 16b003c   NB. Bytes to follow
cObj=. 16b0001   NB. Count of objects in file (set to 1)
OT=. 16b0008   NB. Object type. 8 =. Picture
id=. 16b0001   NB. Object ID
grbit=. 16b0614   NB. Option flags
cbMacro=. 16b0000   NB. Length of FMLA structure
Reserved1=. 16b0000   NB. Reserved
Reserved2=. 16b0000   NB. Reserved
icvBack=. 16b09     NB. Background colour
icvFore=. 16b09     NB. Foreground colour
fls=. 16b00     NB. Fill pattern
fAuto=. 16b00     NB. Automatic fill
icv=. 16b08     NB. Line colour
lns=. 16bff     NB. Line style
lnw=. 16b01     NB. Line weight
fAutoB=. 16b00     NB. Automatic border
frs=. 16b0000   NB. Frame style
cf=. 16b0009   NB. Image format, 9 =. bitmap
Reserved3=. 16b0000   NB. Reserved
cbPictFmla=. 16b0000   NB. Length of FMLA structure
Reserved4=. 16b0000   NB. Reserved
grbit2=. 16b0001   NB. Option flags
Reserved5=. 16b0000   NB. Reserved
header=. toWORD0 record, length
data=. toDWORD0 cObj
data=. data, toWORD0 OT
data=. data, toWORD0 id
data=. data, toWORD0 grbit
data=. data, toWORD0 colL
data=. data, toWORD0 dxL
data=. data, toWORD0 rwT
data=. data, toWORD0 dyT
data=. data, toWORD0 colR
data=. data, toWORD0 dxR
data=. data, toWORD0 rwB
data=. data, toWORD0 dyB
data=. data, toWORD0 cbMacro
data=. data, toDWORD0 Reserved1
data=. data, toWORD0 Reserved2
data=. data, toBYTE icvBack
data=. data, toBYTE icvFore
data=. data, toBYTE fls
data=. data, toBYTE fAuto
data=. data, toBYTE icv
data=. data, toBYTE lns
data=. data, toBYTE lnw
data=. data, toBYTE fAutoB
data=. data, toWORD0 frs
data=. data, toDWORD0 cf
data=. data, toWORD0 Reserved3
data=. data, toWORD0 cbPictFmla
data=. data, toWORD0 Reserved4
data=. data, toWORD0 grbit2
data=. data, toDWORD0 Reserved5
imdata=: imdata, header, data
)

NB.
NB.   Convert a 24 bit bitmap into the modified internal format used by Windows.
NB.   This is described in BITMAPCOREHEADER and BITMAPCOREINFO structures in the
NB.   MSDN library.
NB.
NB.   return Array with data and properties of the bitmap
NB.
processbitmap=: 3 : 0
raiseError=. ''
NB. Open file.
if. 32=3!:0 y do.
  data=. ]`(''"_)@.(_1&-:)@:fread y
else.
  data=. y
end.
NB. Check that the file is big enough to be a bitmap.
if. ((#data) <: 16b36) do.
  raiseError=. 'size error'
  goto_error.
end.
NB. The first 2 bytes are used to identify the bitmap.
identity=. 2{.data
if. (identity -.@-: 'BM') do.
  raiseError=. 'signiture error'
  goto_error.
end.
NB. Remove bitmap data: ID.
data=. 2}.data
NB. Read and remove the bitmap size. This is more reliable than reading
NB. the data size at offset 16b22.
NB.
size=. fromDWORD0 4{.data
data=. 4}.data
size=. size - 16b36 NB. Subtract size of bitmap header.
size=. size + 16b0c NB. Add size of BIFF header.
NB. Remove bitmap data: reserved, offset, header length.
data=. 12}.data
NB. Read and remove the bitmap width and height. Verify the sizes.
'width height'=. fromDWORD0 8{.data
data=. 8}.data
if. (width > 16bffff) do.
  raiseError=. 'bitmap width greater than 65535'
  goto_error.
end.
if. (height > 16bffff) do.
  raiseError=. 'bitmap height greater than 65535'
  goto_error.
end.
NB. Read and remove the bitmap planes and bpp data. Verify them.
planesandbitcount=. fromWORD0 4{.data
data=. 4}.data
if. (24 ~: 1{planesandbitcount) do.  NB. Bitcount
  raiseError=. 'not 24 bit color'
  goto_error.
end.
if. (1 ~: 0{planesandbitcount) do.
  raiseError=. 'contain more than 1 plane'
  goto_error.
end.
NB. Read and remove the bitmap compression. Verify compression.
compression=. fromDWORD0 4{.data
data=. 4}.data
if. (compression ~: 0) do.
  raiseError=. 'compression not supported'
  goto_error.
end.
NB. Remove bitmap data: data size, hres, vres, colours, imp. colours.
data=. 20}.data
NB. Add the BITMAPCOREHEADER data
header=. toDWORD0 16b000c
header=. header, toWORD0 width, height, 16b01, 16b18
data=. header, data
0 ; width ; height ; size ; data
return.
label_error.
_1 ; raiseError
)

insertbackground=: 3 : 0
z=. processbitmap y
if. _1=>@{.z do. z return. end.
'width height size data'=. }.z
NB. Write the BITMAP record to store the bitmap data
record=. 16b00e9
if. RECORDLEN>:8 + size do.
  length=. 8 + size
  cf=. 16b09
  env=. 16b01
  lcb=. size
  header=. toWORD0 record, length, cf, env
  header=. header, toDWORD0 lcb
  imdata=: imdata, header, data
else.
  length=. RECORDLEN
  cf=. 16b09
  env=. 16b01
  lcb=. size
  header=. toWORD0 record, length, cf, env
  header=. header, toDWORD0 lcb
  imdata=: imdata, header, (RECORDLEN-8){.data
  data=. (RECORDLEN-8)}.data
  a=. <.(#data) % RECORDLEN
  b=. RECORDLEN | #data
  if. #a do.
    imdata=: imdata,, (toHeader 16b003c, RECORDLEN), "1 (a, RECORDLEN)$(a*RECORDLEN){.data
  end.
  if. #b do.
    imdata=: imdata, (toHeader 16b003c, b), (-b){.data
  end.
end.
0 ; ''
)

adjdim=: 3 : 0
dimensions=: ((1 3{dimensions)>. y) 1 3}dimensions
)

initsheet=: 3 : 0
NB. read section 4.2.6 Record Order in BIFF8
sheetname=: y
NB. = calculation setting block
calccount=: 100
calcmode=: 1
refmode=: 1
delta=: 0.001000
iteration=: 0
NB. = calculation setting block
printheaders=: 0
printgridlines=: 0
defaultrowheightnotmatch=: 1
defaultrowheighthidden=: 0
defaultrowheightspaceabove=: 0
defaultrowheightspacebelow=: 0
defaultrowheight=: 315  NB. flag, 1/20 point
wsbool=: 0
NB. = page setting block
horizontalpagebreaks=: 0 3$''         NB. row after pagebreak, 0, _1
verticalpagebreaks=: 0 3$''           NB. col after pagebreak, 0, _1
NB. command used in header and footer
NB. && The "&" character itself
NB. &L Start of the left section
NB. &C Start of the centred section
NB. &R Start of the right section
NB. &P Current page number
NB. &N Page count
NB. &D Current date
NB. &T Current time
NB. &A Sheet name (BIFF5-BIFF8)
NB. &F File name without path
NB. &Z File path without file name (BIFF8X)
NB. &G Picture (BIFF8X)
NB. &U Underlining on/off
NB. &E Double underlining on/off (BIFF5-BIFF8)
NB. &S Strikeout on/off
NB. &X Superscript on/off (BIFF5-BIFF8)
NB. &Y Subscript on/off (BIFF5-BIFF8)
NB. &"<fontname>" Set new font <fontname>
NB. &"<fontname>, <fontstyle>"
NB.     Set new font with specified style <fontstyle>. The style <fontstyle> is in most cases
NB.     one of Regular, Bold, Italic, or Bold Italic. But this setting is dependent on the
NB.     used font, it may differ (localised style names, or Standard, Oblique,...). (BIFF5-
NB.     BIFF8)
NB. &<fontheight>
NB.     Set font height in points (<fontheight> is a decimal value). If this command is followed
NB.     by a plain number to be printed in the header, it will be separated from the font height
NB.     with a space character.
header=: ''  NB. '&A'
footer=: 'Page &P of &N'
hcenter=: 0
vcenter=: 0
leftmargin=: 0.5
rightmargin=: 0.5
topmargin=: 0.5
bottommargin=: 0.75
NB. setup
NB. read section 5.87 SETUP
'setuppapersize setupscaling setupstartpage setupfitwidth setupfitheight setuprowmajor setupportrait setupinvalid setupblackwhite setupdraft setupcellnote setuporientinvalid setupusestartpage setupnoteatend setupprinterror setupdpi setupvdpi setupheadermargin setupfootermargin setupnumcopy'=: 0
setuprowmajor=: 1
setupportrait=: 1
setupinvalid=: 1
setupheadermargin=: 0.75
setupfootermargin=: 0.75
backgroundbitmap=: ''
NB. = page setting block
protect=: 1
windowprotect=: 1
objectprotect=: 1
scenprotect=: 1
password=: ''
NB.
defaultcolwidth=: 8
colinfoset=: 0 7$''
dimensions=: 0 0 0 0
NB. cell table
window2=: 16b6b6 0 0 10
sclnum=: sclden=: 1
'xsplit ysplit topvis leftvis'=: 0
activepane=: ''
NB.  standardwidth=: 8*256            NB. appear buggy
mergedcell=: 0 4$''               NB. row1 row2 col1 col2
rowlabelrange=: collabelrange=: 0 4$''
condformatstream=: ''
selection=: 0 5$''
hlink=: ''
imdata=: ''
dvstream=: ''
colsizes=: 0 2$''
rowsizes=: 0 2$''
)

writestream=: 3 : 0
z=. biff_bof 16b600, 16
NB. = calculation setting block
p1=. #z
z=. z, biff_index (0 1+2{.dimensions), 0
z=. z, biff_calccount calccount
z=. z, biff_calcmode calcmode
z=. z, biff_refmode refmode
z=. z, biff_delta delta
z=. z, biff_iteration iteration
NB. = calculation setting block
z=. z, biff_printheaders printheaders
z=. z, biff_printgridlines printgridlines
z=. z, biff_defaultrowheight defaultrowheightnotmatch, defaultrowheighthidden, defaultrowheightspaceabove, defaultrowheightspacebelow, defaultrowheight
z=. z, biff_wsbool wsbool
NB. = page setting block
z=. z, biff_horizontalpagebreaks horizontalpagebreaks
z=. z, biff_verticalpagebreaks verticalpagebreaks
z=. z, biff_header header
z=. z, biff_footer footer
z=. z, biff_hcenter hcenter
z=. z, biff_vcenter vcenter
z=. z, biff_leftmargin leftmargin
z=. z, biff_rightmargin rightmargin
z=. z, biff_topmargin topmargin
z=. z, biff_bottommargin bottommargin
z=. z, biff_setup setuppapersize ; setupscaling ; setupstartpage ; setupfitwidth ; setupfitheight ; setuprowmajor ; setupportrait ; setupinvalid ; setupblackwhite ; setupdraft ; setupcellnote ; setuporientinvalid ; setupusestartpage ; setupnoteatend ; setupprinterror ; setupdpi ; setupvdpi ; setupheadermargin ; setupfootermargin ; setupnumcopy
z=. z, backgroundbitmap
NB. = page setting block
if. (#password) *. protect +. windowprotect +. objectprotect +. scenprotect do.
  if. protect do. z=. z, biff_protect protect end.
  if. windowprotect do. z=. z, biff_windowprotect windowprotect end.
  if. objectprotect do. z=. z, biff_objectprotect objectprotect end.
  if. scenprotect do. z=. z, biff_scenprotect scenprotect end.
  z=. z, biff_password passwordhash password
end.
NB. amend INDEX record, set Absolute stream position of the DEFCOLWIDTH record
p2=. #z
z=. (toDWORD0 p2+y) (p1+16+i.4)}z
z=. z, biff_defaultcolwidth defaultcolwidth
for_item. colinfoset do. z=. z, ({.item) biff_colinfo }.item end.
z=. z, biff_dimensions dimensions
z=. z, stream, imdata
z=. z, biff_window2 window2
z=. z, biff_scl sclnum, sclden
if. #activepane do. z=. z, biff_pane (xsplit, ysplit) ; (topvis, leftvis) ; activepane end.
if. #selection do. z=. z, biff_selection selection end.
NB. standardwidth broken
NB. z=. z, biff_standardwidth standardwidth
if. (2:~:$$) mergedcell do. mergedcell=: _4]\, mergedcell end.
z=. z, biff_mergedcells mergedcell
z=. z, biff_labelranges rowlabelrange ; collabelrange
z=. z, condformatstream
for_item. hlink do. z=. z, (>{.item) biff_hlink }.item end.
z=. z, dvstream
z=. z, biff_eof ''
)

NB. 16 bit hash value for worksheet password (5.18.4)
passwordhash=: 3 : 0
pw=. (15<.#y){.y
hash=. 0 [ i=. 0
while. i<#pw do.
  c=. 3&u: u: i{pw
  i=. >:i
  hash=. hash bitxor #. i&|. _15{.#: c
end.
hash=. 16bce4b bitxor (#pw) bitxor hash
)

create=: 3 : 0
stream=: ''
initsheet y
)

destroy=: codestroy

coclass 'biffbook'
coinsert 'oleutlfcn'
coinsert 'biff'
getxfobj=: 3 : 0
z=. _1  NB. error
if. ''-:y do.
  z=. cxf
else.
  if. (3!:0 y) e. 32 do.
    z=. y
  elseif. (3!:0 y) e. 1 4 do.
    if. 1=#y do.
      z=. addxfobj ({.y){xfset
    elseif. (}.$xfset)-:$y do.
      if. (#xfset)= n=. xfset i. y do.
        xfset=: xfset, y
      end.
      z=. addxfobj n{xfset
    end.
  end.
end.
z
)

getxfidx=: 3 : 0
rc=. 0
if. ''-:y do. y=. cxf end.
if. (3!:0 y) e. 32 do.
  l=. y
  if. (#xfset)= n=. xfset i. a=. getxfrow__l '' do.
    xfset=: xfset, a
    xfindex__l=: n
  end.
  rc=. n
elseif. (3!:0 y) e. 1 4 do.
  if. 1=#y do.
    rc=. {.y
  elseif. (}.$xfset)-:$y do.
    if. (#xfset)= n=. xfset i. y do.
      xfset=: xfset, y
    end.
    rc=. n
  end.
end.
rc
)

add2sst=: 3 : 0
sstn=: >:sstn
if. (#sst) = b=. sst i. y do. sst=: sst, y end.
b
)

WriteSST=: 3 : 0
sstbuf=: (toWORD0 16b00fc, 0), toDWORD0 sstn, #sst
wrtp=: 0 [ bufn=: RECORDLEN-8
for_ix. sst do.
  oix=. >ix
  if. 131072= 3!:0 oix do.
    if. bufn<5 do. wrtcont'' end.
    wrtn #oix
    wrtw oix
  else.
    if. bufn<4 do. wrtcont'' end.
    wrtn #oix
    wrt oix
  end.
end.
sstbuf=: (toWORD0 RECORDLEN-bufn) (wrtp+2+i.2)}sstbuf
)

wrtn=: 3 : 0
sstbuf=: sstbuf, toWORD0 y
bufn=: bufn-2
)

wrtw=: 3 : 0
while. #y do.
  if. bufn<1+2*#y do.
    sstbuf=: sstbuf, (1{a.), toucode0 (<.-:bufn-1){.y
    y=. (<.-:bufn-1)}.y
    bufn=: bufn - 1+ 2*(<.-:bufn-1)
    wrtcont''
  else.
    sstbuf=: sstbuf, (1{a.), toucode0 y
    bufn=: bufn - 1+2*#y
    y=. ''
  end.
end.
)

wrt=: 3 : 0
while. #y do.
  if. bufn<1+#y do.
    sstbuf=: sstbuf, (0{a.), (bufn-1){.y
    y=. (bufn-1)}.y
    bufn=: bufn - 1+ bufn-1
    wrtcont''
  else.
    sstbuf=: sstbuf, (0{a.), y
    bufn=: bufn - 1+#y
    y=. ''
  end.
end.
)

wrtcont=: 3 : 0
sstbuf=: (toWORD0 RECORDLEN-bufn) (wrtp+2+i.2)}sstbuf
wrtp=: #sstbuf
sstbuf=: sstbuf, toWORD0 16b003c, 0
bufn=: RECORDLEN
)

initbook=: 3 : 0
NB. read section 4.2.6 Record Order in BIFF8
fileprotectionstream=: ''
workbookprotectionstream=: ''
codepage=: 1200
window1=: 672 192 11004 6636 16b38
backup=: 0
hideobj=: 0
date1904=: 0
precision=: 1
bookbool=: 1
NB. height italic strike color weight script underline family charset fontname
fontset=: 0 10$''
fontset=: fontset, fontsize ; 0 ; 0 ; colorfont ; 400 ; 0 ; 0 ; 0 ; 0 ; fontname     NB. 0
fontset=: fontset, fontsize ; 0 ; 0 ; colorfont ; 400 ; 0 ; 0 ; 0 ; 0 ; fontname     NB. 1
fontset=: fontset, fontsize ; 0 ; 0 ; colorfont ; 400 ; 0 ; 0 ; 0 ; 0 ; fontname     NB. 2
fontset=: fontset, fontsize ; 0 ; 0 ; colorfont ; 400 ; 0 ; 0 ; 0 ; 0 ; fontname     NB. 3
fontset=: fontset, fontsize ; 0 ; 0 ; colorfont ; 400 ; 0 ; 0 ; 0 ; 0 ; fontname     NB. 4 (missing)
fontset=: fontset, fontsize ; 0 ; 0 ; colorfont ; 400 ; 0 ; 0 ; 0 ; 0 ; fontname     NB. 5
formatset=: format0n#a:
NB. format 0-22
formatset=: ('General';'0';'0.00';'#,##0';'#,##0.00';'"$"#,##0_); ("$"#,##0)';'"$"#,##0_);[Red] ("$"#,##0)';'"$"#,##0.00_); ("$"#,##0.00)';'"$"#,##0.00_);[Red] ("$"#,##0.00)';'0%';'0.00%';'0.00E+00';'# ?/?';'# ??/??';'M/D/YY';'D-MMM-YY';'D-MMM';'MMM-YY';'h:mm AM/PM';'h:mm:ss AM/PM';'h:mm';'h:mm:ss';'M/D/YY h:mm') (i.23) } formatset
NB. format 37-49
formatset=: ('_(#,##0_);(#,##0)';'_(#,##0_);[Red](#,##0)';'_(#,##0.00_);(#,##0.00)';'_(#,##0.00_);[Red](#,##0.00)';'_ ("$"* #,##0_);_ ("$"* (#,##0);_ ("$"* "-"_);_(@_)';'_(* #,##0_);_(* (#,##0);_(* "-"_);_(@_)';'_ ("$"* #,##0.00_);_ ("$"* (#,##0.00);_ ("$"* "-"??_);_(@_)';'_(* #,##0.00_);_(* (#,##0.00);_(* "-"??_);_(@_)';'mm:ss';'[h]:mm:ss';'mm:ss.0';'##0.0E+0';'@') (37+i.13)}formatset
NB. user-defined
formatset=: formatset, 'd/m/yyyy';'#,##0.000';'#,##0.0000';'#,##0.000000000'
NB. font format typeprot align rotate indent used border linecolor color
xfset=: 0 10$''
NB. style XF
xfset=: xfset, 0 0 16bfff5 16b20 0 0 0 0 0 16b20c0 NB. all valid
xfset=: xfset, 1 0 16bfff5 16b20 0 0 16bf4 0 0 16b20c0 NB. only font valid
xfset=: xfset, 1 0 16bfff5 16b20 0 0 16bf4 0 0 16b20c0
xfset=: xfset, 2 0 16bfff5 16b20 0 0 16bf4 0 0 16b20c0
xfset=: xfset, 2 0 16bfff5 16b20 0 0 16bf4 0 0 16b20c0
xfset=: xfset, 0 0 16bfff5 16b20 0 0 16bf4 0 0 16b20c0
xfset=: xfset, 0 0 16bfff5 16b20 0 0 16bf4 0 0 16b20c0
xfset=: xfset, 0 0 16bfff5 16b20 0 0 16bf4 0 0 16b20c0
xfset=: xfset, 0 0 16bfff5 16b20 0 0 16bf4 0 0 16b20c0
xfset=: xfset, 0 0 16bfff5 16b20 0 0 16bf4 0 0 16b20c0
xfset=: xfset, 0 0 16bfff5 16b20 0 0 16bf4 0 0 16b20c0
xfset=: xfset, 0 0 16bfff5 16b20 0 0 16bf4 0 0 16b20c0
xfset=: xfset, 0 0 16bfff5 16b20 0 0 16bf4 0 0 16b20c0
xfset=: xfset, 0 0 16bfff5 16b20 0 0 16bf4 0 0 16b20c0
xfset=: xfset, 0 0 16bfff5 16b20 0 0 16bf4 0 0 16b20c0
NB. cell XF (15) will become default current xf (21)
xfset=: xfset, 0 0 1 16b20 0 0 0 0 0 16b20c0 NB. all valid
NB. Excel written XF, must include because they are referred by styleset
NB. (16)
xfset=: xfset, 1 16b2b 16bfff5 16b20 0 0 16bf8 0 0 16b20c0 NB. only format valid
xfset=: xfset, 1 16b29 16bfff5 16b20 0 0 16bf8 0 0 16b20c0
xfset=: xfset, 1 16b2c 16bfff5 16b20 0 0 16bf8 0 0 16b20c0
xfset=: xfset, 1 16b2a 16bfff5 16b20 0 0 16bf8 0 0 16b20c0
xfset=: xfset, 1 9 16bfff5 16b20 0 0 16bf8 0 0 16b20c0
NB. user-defined XF start here
NB. (21)
biffxfset=: ''
NB. xf builtin id level name
styleset=: 0 5$''
styleset=: styleset, 16b10 ; 1 ; 3 ; 16bff ; ''
styleset=: styleset, 16b11 ; 1 ; 6 ; 16bff ; ''
styleset=: styleset, 16b12 ; 1 ; 4 ; 16bff ; ''
styleset=: styleset, 16b13 ; 1 ; 7 ; 16bff ; ''
styleset=: styleset, 16b00 ; 1 ; 0 ; 16bff ; ''
styleset=: styleset, 16b14 ; 1 ; 5 ; 16bff ; ''
NB. predefine    black white red green blue yellow magenta cyan
colorset=: 0 16bffffff 16bff 16bff00 16bff0000 16bffff 16bff00ff 16bffff00
NB. Sets extra colour palette to the Excel 97+ default.
colorset=: colorset, RGB 16b00 16b00 16b00  NB. 8
colorset=: colorset, RGB 16bff 16bff 16bff  NB. 9
colorset=: colorset, RGB 16bff 16b00 16b00  NB. 10
colorset=: colorset, RGB 16b00 16bff 16b00  NB. 11
colorset=: colorset, RGB 16b00 16b00 16bff  NB. 12
colorset=: colorset, RGB 16bff 16bff 16b00  NB. 13
colorset=: colorset, RGB 16bff 16b00 16bff  NB. 14
colorset=: colorset, RGB 16b00 16bff 16bff  NB. 15
colorset=: colorset, RGB 16b80 16b00 16b00  NB. 16
colorset=: colorset, RGB 16b00 16b80 16b00  NB. 17
colorset=: colorset, RGB 16b00 16b00 16b80  NB. 18
colorset=: colorset, RGB 16b80 16b80 16b00  NB. 19
colorset=: colorset, RGB 16b80 16b00 16b80  NB. 20
colorset=: colorset, RGB 16b00 16b80 16b80  NB. 21
colorset=: colorset, RGB 16bc0 16bc0 16bc0  NB. 22
colorset=: colorset, RGB 16b80 16b80 16b80  NB. 23
colorset=: colorset, RGB 16b99 16b99 16bff  NB. 24
colorset=: colorset, RGB 16b99 16b33 16b66  NB. 25
colorset=: colorset, RGB 16bff 16bff 16bcc  NB. 26
colorset=: colorset, RGB 16bcc 16bff 16bff  NB. 27
colorset=: colorset, RGB 16b66 16b00 16b66  NB. 28
colorset=: colorset, RGB 16bff 16b80 16b80  NB. 29
colorset=: colorset, RGB 16b00 16b66 16bcc  NB. 30
colorset=: colorset, RGB 16bcc 16bcc 16bff  NB. 31
colorset=: colorset, RGB 16b00 16b00 16b80  NB. 32
colorset=: colorset, RGB 16bff 16b00 16bff  NB. 33
colorset=: colorset, RGB 16bff 16bff 16b00  NB. 34
colorset=: colorset, RGB 16b00 16bff 16bff  NB. 35
colorset=: colorset, RGB 16b80 16b00 16b80  NB. 36
colorset=: colorset, RGB 16b80 16b00 16b00  NB. 37
colorset=: colorset, RGB 16b00 16b80 16b80  NB. 38
colorset=: colorset, RGB 16b00 16b00 16bff  NB. 39
colorset=: colorset, RGB 16b00 16bcc 16bff  NB. 40
colorset=: colorset, RGB 16bcc 16bff 16bff  NB. 41
colorset=: colorset, RGB 16bcc 16bff 16bcc  NB. 42
colorset=: colorset, RGB 16bff 16bff 16b99  NB. 43
colorset=: colorset, RGB 16b99 16bcc 16bff  NB. 44
colorset=: colorset, RGB 16bff 16b99 16bcc  NB. 45
colorset=: colorset, RGB 16bcc 16b99 16bff  NB. 46
colorset=: colorset, RGB 16bff 16bcc 16b99  NB. 47
colorset=: colorset, RGB 16b33 16b66 16bff  NB. 48
colorset=: colorset, RGB 16b33 16bcc 16bcc  NB. 49
colorset=: colorset, RGB 16b99 16bcc 16b00  NB. 50
colorset=: colorset, RGB 16bff 16bcc 16b00  NB. 51
colorset=: colorset, RGB 16bff 16b99 16b00  NB. 52
colorset=: colorset, RGB 16bff 16b66 16b00  NB. 53
colorset=: colorset, RGB 16b66 16b66 16b99  NB. 54
colorset=: colorset, RGB 16b96 16b96 16b96  NB. 55
colorset=: colorset, RGB 16b00 16b33 16b66  NB. 56
colorset=: colorset, RGB 16b33 16b99 16b66  NB. 57
colorset=: colorset, RGB 16b00 16b33 16b00  NB. 58
colorset=: colorset, RGB 16b33 16b33 16b00  NB. 59
colorset=: colorset, RGB 16b99 16b33 16b00  NB. 60
colorset=: colorset, RGB 16b99 16b33 16b66  NB. 61
colorset=: colorset, RGB 16b33 16b33 16b99  NB. 62
colorset=: colorset, RGB 16b33 16b33 16b33  NB. 63
country=: 1 1
supbook=: ''
externsheet=: 0 3$''
extname=: ''
refname=: ''
)

addhlink=: 3 : 0
l=. sheeti{sheet
hlink__l=: hlink__l, y
)

writefileprotection=: 3 : 0
fileprotectionstream=: y
)

writeworkbookprotection=: 3 : 0
workbookprotectionstream=: y
)

writecelltable=: 3 : 0
l=. sheeti{sheet
stream__l=: stream__l, y
)

writecondformattable=: 3 : 0
l=. sheeti{sheet
condformatstream__l=: y
)

writedvtable=: 3 : 0
l=. sheeti{sheet
dvstream__l=: y
)

celladr=: 4 : 0
'relrow relcol'=. x
'row col'=. y
z=. toWORD0 row
z=. z, toWORD0 (16bff bitand col) bitor 14 bitshl (0~:relcol) bitor 1 bitshl 0~:relrow
)

cellrangeadr=: 4 : 0
'relrow1 relrow2 relcol1 relcol2'=. x
'row1 row2 col1 col2'=. y
z=. toWORD0 row1, row2
z=. z, toWORD0 (16bff bitand col1) bitor 14 bitshl (0~:relcol1) bitor 1 bitshl 0~:relrow1
z=. z, toWORD0 (16bff bitand col2) bitor 14 bitshl (0~:relcol2) bitor 1 bitshl 0~:relrow2
)

newsupbook=: 3 : 0
supbook=: supbook, y conew 'biffsupbook'
supbooki=: <:#supbook
)

newrefname=: 3 : 0
refname=: refname, '' conew 'biffrefname'
{:refname
)

newextname=: 3 : 0
l=. supbooki{supbook
newextname__l y
)

newcrn=: 3 : 0
l=. supbooki{supbook
newcrn__l y
)

create=: 3 : 0
if. ''-:y do.
  'fontname fontsize'=: 'Courier New' ; 220
  sheetname=. 'Sheet1'
else.
  'fontname fontsize'=: 2{.y
  sheetname=. ('' -: sheetname) >@{ (sheetname=. >{.2}.y) ; 'Sheet1'
end.
sstn=: #sst=: ''
xfset=: sheet=: ''
initbook ''
addsheet sheetname  NB. create worksheet object
cxf=: addxfobj 15{xfset  NB. predefined cell style
)

destroy=: 3 : 0
for_l. sheet do. destroy__l '' end.
for_l. biffxfset do. destroy__l '' end.
for_l. supbook do. destroy__l '' end.
for_l. refname do. destroy__l '' end.
codestroy ''
)

NB. match color (red, green, blue) to internal color palette table
NB. return color index
rgbcolor=: 3 : 0
(i: <./) +/"1 | y -"1 RGBtuple colorset
)

NB. add new extended format
NB. return xf object
addxfobj=: 3 : 0
biffxfset=: biffxfset, z=. y conew 'biffxf'
z
)

NB. add new worksheet
NB. return worksheet index
NB. y sheet name or ''
addsheet=: 3 : 0
sheet=: sheet, ((y-:'') >@{ y ; 'Sheet', ": >:#sheet) conew 'biffsheet'
sheeti=: <:#sheet
)

NB. save to file
NB. y  filename ('' if return character data)
save=: 3 : 0
fn=. >y
z=. biff_bof 16b600, 5
z=. z, fileprotectionstream
z=. z, biff_codepage codepage
z=. z, workbookprotectionstream
z=. z, biff_window1 window1
z=. z, biff_backup backup
z=. z, biff_hideobj hideobj
z=. z, biff_date1904 date1904
z=. z, biff_precision precision
z=. z, biff_bookbool bookbool
NB. excel peculiar, 4 is missing
fontset1=. (4{.fontset), 5}.fontset
for_item. fontset1 do. z=. z, biff_font item end.
if. 164<#formatset do.
  for_i. i.164-~#formatset do. z=. z, biff_format (i+164) ; (i+164){formatset end.
end.
for_item. xfset do. z=. z, biff_xf item end.
for_item. styleset do. z=. z, (>{.item) biff_style }.item end.
if. 8<#colorset do.
  z=. z, biff_palette 8}.colorset
end.
olesheet=. ''
olehead=. z
seekpoint=. #z
z=. ''
for_item. sheet do.
  z=. z, a=. biff_boundsheet 0 ; 0 ; 0 ; sheetname__item
  seekpoint=. seekpoint, #a
end.
z=. z, biff_country country
z=. z, WriteSST ''
if. #supbook do.
  for_item. supbook do.
    z=. z, writestream__item #sheet
  end.
  z=. z, biff_externsheet externsheet
  for_item. refname do.
    z=. z, writestream__item ''
  end.
end.
z=. z, biff_eof ''
olehead=. olehead, z
sheetoffset=. ({.seekpoint)+ #z
for_item. sheet do.
  z=. writestream__item {:sheetoffset
  olesheet=. olesheet, z
  sheetoffset=. sheetoffset, #z
end.
seekpoint=. }:+/\seekpoint
sheetoffset=. }:+/\sheetoffset
for_i. i.#seekpoint do.
  p1=. 4+i{seekpoint
  p2=. 0
  z=. toDWORD0 i{sheetoffset
  olehead=. z (p1+i.4)}olehead
end.
stream=. ('Workbook' ; '' ; '') conew 'oleppsfile'
append__stream olehead
append__stream olesheet
root=. (0 ; 0 ; <stream) conew 'oleppsroot'
rc=. save__root fn ; 0 ; ''
destroy__root ''
destroy__stream ''
rc
)

NB. set column width of current worksheet
NB. x xf
NB. y col1 col2 width hide level collapse
NB.    eg. 2 5 400  to set (col 2 3 4 5) 400 twip hight
addcolinfo=: 3 : 0
cxf addcolinfo y
:
'col1 col2 width hide level collapse'=. 6{.y
l=. sheeti{sheet
colsizes__l=: ~. colsizes__l, (col1 + i.>:col2-col1), "0 (0~:hide){width, 0
colinfoset__l=: colinfoset__l, (getxfidx x), col1, col2, width, hide, level, collapse
''
)

NB. set row height of current worksheet
NB. x xf
NB. y rownumber firstcol_lastcol usedefaultheight rowheight heightnotmatch spaceabove spacebelow hidden explicitformat outlinelevel outlinegroup
NB.    eg. 3 0 256 0 12*256  to set (row 3) 12 character wide
addrowinfo=: 3 : 0
cxf addrowinfo y
:
'rownumber firstcol lastcols usedefaultheight rowheight'=. 5{. y=. 12{.y
l=. sheeti{sheet
if. 0=usedefaultheight do.
  rowsizes__l=: ~. rowsizes__l, rownumber, rowheight
end.
stream__l=: stream__l, (getxfidx x) biff_row y
''
)

NB. write string to the current worksheet
NB. x xf
NB. y row col ; text         (where 3>$$text)
NB.    row col ; boxed text   (where 3>$$boxed text)
NB.                           (always box last argument to make 2=#y)
writestring=: 3 : 0
cxf writestring y
:
assert. 2=#y
assert. 1 2 4 8 131072 e.~ 3!:0 >@{.y
assert. 2 32 131072 e.~ 3!:0 >1{y
if. 2 131072 e.~ 3!:0 rc=. >@{.y do. y=. (<A1toRC rc) 0}y end.
l=. sheeti{sheet
xf=. getxfidx x
if. (0=#@, yn) +. 2 131072 e.~ 3!:0 yn=. >1{y do.
  if. 2> $$yn do.
    adjdim__l >@{.y
    stream__l=: stream__l, xf biff_label y
  elseif. 2=$$yn do.
    'r c'=. >@{.y
    'nrow len'=. $yn
    adjdim__l >@{.y
    adjdim__l (nrow, 0)+>@{.y
    if. 0=len do.
      stream__l=: stream__l,, (toHeader 16b0201, 6), "1 (_2]\ toWORD0 r+i.nrow), "1 (_2]\ toWORD0 nrow#c), "1 (toWORD0 xf)
    else.
      yn=. <"1 yn
      sst=: sst, (~.yn) -. sst
      sstn=: sstn + #yn
      stream__l=: stream__l,, (toHeader 16b00fd, 10), "1 (_2]\ toWORD0 r+i.nrow), "1 (_2]\ toWORD0 nrow#c), "1 (toWORD0 xf), "1 (_4]\ toDWORD0 sst i. yn)
    end.
  elseif. do. 'unhandled exception' 13!:8 (3)
  end.
elseif. 32 e.~ 3!:0 yn do.
  if. (0:=#), yn do. '' return.  NB. ignore null
  elseif. 1=#@, yn do.  NB. singleton
    adjdim__l >@{.y
    stream__l=: stream__l, xf biff_label ({.y), <, >yn
  elseif. 3>$$yn do.
    if. 1=$$yn do. yn=. ,:yn end.
    'r c'=. >@{.y
    adjdim__l >@{.y
    adjdim__l (s=. $yn)+>@{.y
    if. #a=. bx > ''&-:&.> yn=. , yn do.
      yn=. ((#a)#<, ' ') a}yn   NB. biff8 cannot store empty string
    end.
    sst=: sst, (~.yn) -. sst
    sstn=: sstn + #yn
    stream__l=: stream__l,, (toHeader 16b00fd, 10), "1 (_2]\ toWORD0 ({:s)#r+i.{.s), "1 (_2]\ toWORD0, ({.s)#,:c+i.{:s), "1 (toWORD0 xf), "1 (_4]\ toDWORD0 sst i. yn)
  elseif. do. 'unhandled exception' 13!:8 (3)
  end.
elseif. do. 'unhandled exception' 13!:8 (3)
end.
''
)

NB. write integer to the current worksheet
NB. x xf
NB. y row col ; integer   (where 3>$$integer)
writeinteger=: 3 : 0
cxf writeinteger y
:
assert. 2=#y
assert. 1 2 4 8 131072 e.~ 3!:0 >@{.y
assert. 1 4 8 e.~ 3!:0 >1{y
if. 2 131072 e.~ 3!:0 rc=. >@{.y do. y=. (<A1toRC rc) 0}y end.
l=. sheeti{sheet
xf=. getxfidx x
NB. only 30 bit is used 536870911 = <:2^29
if. 536870911 < >./ |, >1{y do. x writenumber y end.
if. (0:=#), yn=. 2b10 bitor 2 bitshl <. >1{y do. '' return. end.  NB. ignore null
if. 1=#@, yn do.  NB. singleton
  adjdim__l >@{.y
  stream__l=: stream__l, xf biff_integer ({.y), < {., >1{y
elseif. 3>$$yn do.
  if. 1=$$yn do. yn=. ,:yn end.
  'r c'=. >@{.y
  adjdim__l >@{.y
  adjdim__l (s=. $yn)+>@{.y
  stream__l=: stream__l,, (toHeader 16b027e, 10), "1 (_2]\ toWORD0 ({:s)#r+i.{.s), "1 (_2]\ toWORD0, ({.s)#,:c+i.{:s), "1 (toWORD0 xf), "1 (_4]\ toDWORD0, yn)
elseif. do. 'unhandled exception' 13!:8 (3)
end.
''
)

NB. write number to the current worksheet
NB. x xf
NB. y row col ; number   (where 3>$$number)
writenumber=: 3 : 0
cxf writenumber y
:
assert. 2=#y
assert. 1 2 4 8 131072 e.~ 3!:0 >@{.y
assert. 1 4 8 e.~ 3!:0 >1{y
if. 2 131072 e.~ 3!:0 rc=. >@{.y do. y=. (<A1toRC rc) 0}y end.
l=. sheeti{sheet
xf=. getxfidx x
if. (0:=#), yn=. >1{y do. '' return. end.  NB. ignore null
if. 1=#@, yn do.  NB. singleton
  adjdim__l >@{.y
  stream__l=: stream__l, xf biff_number ({.y), < {., yn
elseif. 3>$$yn do.
  if. 1=$$yn do. yn=. ,:yn end.
  'r c'=. >@{.y
  adjdim__l >@{.y
  adjdim__l (s=. $yn)+>@{.y
  stream__l=: stream__l,, (toHeader 16b0203, 14), "1 (_2]\ toWORD0 ({:s)#r+i.{.s), "1 (_2]\ toWORD0, ({.s)#,:c+i.{:s), "1 (toWORD0 xf), "1 (_8]\ toDouble0, yn)
elseif. do. 'unhandled exception' 13!:8 (3)
end.
''
)

NB. write number to the current worksheet with format
NB. x xf
NB. y row col ; number ; format   (where 3>$$number)
writenumber2=: 3 : 0
cxf writenumber2 y
:
assert. 3=#y
assert. 1 2 4 8 131072 e.~ 3!:0 >@{.y
assert. 1 4 8 e.~ 3!:0 >1{y
assert. 2 131072 e.~ 3!:0 >2{y
if. 2 131072 e.~ 3!:0 rc=. >@{.y do. y=. (<A1toRC rc) 0}y end.
l=. getxfobj x
t=. format__l
format__l=: >{:y
if. 8= 3!:0 >1{y do.
  l writenumber 2{.y
else.
  l writeinteger 2{.y
end.
format__l=: t
''
)

NB. write date to the current worksheet with format
NB. x xf
NB. y row col ; datenumber ; format   (where 3>$$datenumber)
writedate=: 3 : 0
cxf writedate y
:
assert. 2 3 e.~ #y
assert. 1 2 4 8 131072 e.~ 3!:0 >@{.y
assert. 1 4 8 e.~ 3!:0 >1{y
if. 2 131072 e.~ 3!:0 rc=. >@{.y do. y=. (<A1toRC rc) 0}y end.
l=. getxfobj x
t=. format__l
if. 2=#y do. y=. y, <'dd/mm/yyyy' end. NB. default date format
assert. 2 131072 e.~ 3!:0 >2{y
format__l=: >2{y
l writenumber ({.y), <36522-~ >1{y
format__l=: t
''
)

NB. insert bitmap to the current worksheet
NB. x (row, col) ; (offsetx(in point, 1/72"), offsety(in character)) ; scalex, scaley
NB. y boxed bitmap file name or charachar data of bitmap
NB. return if success   0 ; ''
NB.        if fail     _1 ; 'reason for failure'
insertpicture=: 4 : 0
l=. sheeti{sheet
x insertpicture__l y
)

NB. insert bitmap as background for the current worksheet
NB. y boxed bitmap file name or charachar data of bitmap
NB. return if success   0 ; ''
NB.        if fail     _1 ; 'reson for failure'
insertbackground=: 3 : 0
l=. sheeti{sheet
insertbackground__l y
)

NB. builtin name
NB. 00H Consolidate_Area
NB. 01H Auto_Open
NB. 02H Auto_Close
NB. 03H Extract
NB. 04H Database
NB. 05H Criteria
NB. 06H Print_Area
NB. 07H Pint_Titles
NB. 08H Recorder
NB. 09H Data_Form
NB. 0AH Auto_Activate (BIFF5-BIFF8)
NB. 0BH Auto_Deactivate (BIFF5-BIFF8)
NB. 0CH Sheet_Title (BIFF5-BIFF8)
NB. 0DH _FilterDatabase (BIFF8)
NB. tmem 16b29
NB. tArea 16b3b
NB. tCellrangelist 16b10
NB. x supbook
NB.    _1 first call printarea, rowrepeat, colrepeat, rowcolrepeat
NB. y row1 row2 col1 col2
NB. return  supbook
printarea=: 4 : 0
if. _1=x do.
  x=. newsupbook 'internal' ; #sheet
end.
externsheet=: externsheet, x, 0 0
r=. newrefname ''
builtin__r=: 1
name__r=: 16b06{a.
sheet__r=: 0
formula__r=: (a.{~16b3b 0 0), (0 0 0 0 cellrangeadr y)
x
)

NB. x supbook
NB.    _1 first call printarea, rowrepeat, colrepeat, rowcolrepeat
NB. y sheetidx row1 row2
NB. return  supbook
rowrepeat=: 4 : 0
if. _1=x do.
  x=. newsupbook 'internal' ; #sheet
end.
externsheet=: externsheet, x, 0 0
r=. newrefname ''
builtin__r=: 1
name__r=: 16b07{a.
sheet__r=: {.y
formula__r=: (a.{~16b3b 0 0), 0 0 0 0 cellrangeadr, (}.y), 0 255
x
)

NB. x supbook
NB.    _1 first call printarea, rowrepeat, colrepeat, rowcolrepeat
NB. y sheetidx col1 col2
NB. return  supbook
colrepeat=: 4 : 0
if. _1=x do.
  x=. newsupbook 'internal' ; #sheet
end.
externsheet=: externsheet, x, 0 0
r=. newrefname ''
builtin__r=: 1
name__r=: 16b07{a.
sheet__r=: {.y
formula__r=: (a.{~16b3b 0 0), 0 0 0 0 cellrangeadr 0 16bffff, (}.y)
x
)

NB. x supbook
NB.    _1 first call printarea, rowrepeat, colrepeat, rowcolrepeat
NB. y sheetidx row1 row2 col1 col2
NB. return  supbook
rowcolrepeat=: 4 : 0
if. _1=x do.
  x=. newsupbook 'internal' ; #sheet
end.
externsheet=: externsheet, x, 0 0
r=. newrefname ''
builtin__r=: 1
name__r=: 16b07{a.
sheet__r=: {.y
formula__r=: (16b29{a.), (toWORD0@# , ]) ((a.{~16b3b 0 0), 0 0 0 0 cellrangeadr 0 16bffff, (>_2{.}.y)), ((a.{~16b3b 0 0), 0 0 0 0 cellrangeadr, (>2{.}.y), 0 255), (16b10{a.)
x
)

NB. ---------------------------------------------------------
NB. read numeric and string data from excel files
NB. written by bill lam
NB. ---------------------------------------------------------

coclass 'biffread'
coinsert 'oleutlfcn'
NB. x 0 normal  1 debug
NB. y stream data
create=: 4 : 0
debug=: x
stream=: y
biffver=: 0        NB. biff5/7 16b500   biff8 16b600
NB. biff2 16b200 biff3 16b300  biff4 16b400  (there is in fact no biffver stored)
streamtype=: 16    NB. worksheet 16
filepos=: 0
worksheets=: 0 2$''
bkrecords=: 0 3$'' [ bkbytes=: ''   NB. dump workbook for debug mode
records=: 0 3$'' [ bytes=: ''       NB. dump worksheet for debug mode
sst=: ''
bnsst=: nsst=: 0  NB. number of strings
sstchar=: 0
sstrtffe=: 0
insst=. 0
type=. _1
newptr=. 0
while. (type~:10)*.filepos<#stream do.
  'type ptr len'=. nextrecord ''
NB. dump records of workbook global to [bkbytes] with index held in [bkrecords]
  if. debug do.
    bkbytes=: bkbytes, (ptr+i.len){stream
    newptr=. newptr+len [ bkrecords=: bkrecords, type, newptr, len
  end.
  if. 16b9=type do.        NB. BOF record biff2
    biffver=: 16b200 break.
  elseif. 16b209=type do.  NB. BOF record biff3
    biffver=: 16b300 break.
  elseif. 16b409=type do.  NB. BOF record biff4
    biffver=: 16b400 break.
  elseif. 16b809=type do.  NB. BOF record
    if. 0=biffver do.  NB. only read the 1st BOF record in workbook
      'biffver streamtype'=: fromWORD0 4{.data=. (ptr+i.len){stream
    end.
  elseif. 16b0085=type do.  NB. boundsheet record
    if. 0={.fromBYTE 5{data=. (ptr+i.len){stream do.
      if. 16b500=biffver do.
        worksheets=: worksheets, (>@{. 0 decodestring8 6}.data) ; {.(fromDWORD0 4{.data)
      else.
        worksheets=: worksheets, (>@{. 0 decodeustring8 6}.data) ; {.(fromDWORD0 4{.data)
      end.
    end.
  elseif. 16b00fc=type do.  NB. sst record
    'bnsst nsst'=: fromDWORD0 8{.data=. (ptr+i.len){stream
    readsst 8}.data
    insst=. 1
  elseif. insst *. 16b003c=type do. NB. continue record after sst
    readsst data=. (ptr+i.len){stream
  elseif. do.
    insst=. 0
  end.
end.
if. #sst do. sst=: <;._2 sst end.
assert. nsst=#sst
assert. 0~:biffver
)

destroy=: codestroy
NB. parse string from sst record
readsst=: 3 : 0
fp=. 0
while. fp<#y do.
  if. 0=sstchar+sstrtffe do.
    't t1'=. fp decodeustring16 y
    sst=: sst, t, {.a.
    fp=. fp + a [ 'a b c'=. t1
    sstchar=: b-#t
    sstrtffe=: c
  else.
    't t1'=. (fp, sstchar, sstrtffe) decodeustring16a y
    sst=: (}:sst), t, {.a.
    fp=. fp + a [ 'a b c'=. t1
    sstchar=: sstchar-#t
    sstrtffe=: c
  end.
end.
)

NB. return record type, pointer to data buffer, length of data buffer
nextrecord=: 3 : 0
'type len'=. fromWORD0 (filepos+i.4){stream
filepos=: +/data=. (4+filepos), len
type, data
)

NB. byte string used in biff2/3/4/5/7
NB. assume no continue record
decodestring8=: 4 : 0
len=. {.fromBYTE (x+0){y
< len (([ <. #@]) {. ]) (x+1)}.y
)

decodestring16=: 4 : 0
len=. {.fromWORD0 (x+i.2){y
< len (([ <. #@]) {. ]) (x+2)}.y
)

NB. assume no continue record
decodeustring8=: 4 : 0
len=. {.fromBYTE (x+0){y
uc=. 0~:1 bitand op=. {.fromBYTE (x+1){y
fe=. 0~:4 bitand op
rtf=. 0~:8 bitand op
if. uc do.
  < fromucode0 (2*len) (([ <. #@]) {. ]) (x+2+(fe*4)+(rtf*2))}.y
else.
  < len (([ <. #@]) {. ]) (x+2+(fe*4)+(rtf*2))}.y
end.
)

decodeustring16=: 4 : 0
NB. len number of (unicode) character in string
NB. z decoded string
NB. p point to rtf/fe block
NB. p1 byte length of decoded string segment
NB. p2 number of pending bytes to be read in next record
NB. lenrtf rtf size in byte (4 bytes per block)
NB. lenfe  fe size in byte
len=. {.fromWORD0 (x+i.2){y
uc=. 0~:1 bitand op=. {.fromBYTE (x+2){y  NB. uncompress unicode
fe=. 0~:4 bitand op                         NB. #far east phonetic (4 byte)
rtf=. 0~:8 bitand op                        NB. #rtf format run (2 byte)
lenrtffe=. 0
if. rtf do. lenrtffe=. 4* {.fromWORD0 ((x+3)+i.2){y end.
if. fe do. lenrtffe=. lenrtffe + {.fromDWORD0 ((x+3+(rtf*2))+i.4){y end.
NB. p point to position of fe/rtf block if read
NB. p2 #byte in character array not yet read
l=. (3+(fe*4)+(rtf*2)) + (len*uc{1 2) + lenrtffe  NB. expect length if no further continue record need
if. uc do.
  z=. fromucode0 z1=. (2*len) (([ <. #@]) {. ]) (x+3+(fe*4)+(rtf*2))}.y
  z2=. (2*len)-#z1  NB. byte length of remaining character array
else.
  z=. z1=. len (([ <. #@]) {. ]) (x+3+(fe*4)+(rtf*2))}.y
  z2=. len-#z1  NB. byte length of remaining character array
end.
if. (#y)<x+l do.
  z ; (#y), len, (x+l)-z2+#y
else.
  z ; l, len, 0
end.
)

NB. the first splitted string in continue record
decodeustring16a=: 4 : 0
'x len lenrtffe'=. x
NB. there is no len for the first splitted string in continue record
NB. there is option byte the first splitted string in continue record
NB. but if length of remaining character array is zero, ie rtf/fe portion only
NB. then there will be no option byte
if. len do.
  uc=. 0~:1 bitand op=. {.fromBYTE (x+0){y
  l=. 1 + (len*uc{1 2) + lenrtffe  NB. expect length if no further continue record need
  if. uc do.
    z=. fromucode0 z1=. (2*len) (([ <. #@]) {. ]) (x+1)}.y
    z2=. (2*len)-#z1    NB. byte length of remaining character array
  else.
    z=. z1=. len (([ <. #@]) {. ]) (x+1)}.y
    z2=. len-#z1  NB. byte length of remaining character array
  end.
else.
  l=. lenrtffe  NB. expect length if no further continue record need
  z=. ''
  z2=. 0
end.
if. (#y)<x+l do.
  z ; (#y), len, (x+l)-z2+#y
else.
  z ; l, len, 0
end.
)

NB. x 1 convert all number to string
readsheet=: 0&$: : (4 : 0)
if. 16b200 16b300 16b400 e.~ biffver do.  NB. biff2/3/4
  filepos=: 0
  scnt=. _1
  sheetfound=. 0
else.
  filepos=: y
  sheetfound=. 1
end.
rowcolss=. rowcol=. rowcol4=. rowcol8=. rowcolc=. 0 2$''
cellvalss=. cellval=. cellval4=. cellval8=. cellvalc=. ''
null=. {.a.
type=. _1
records=: 0 3$'' [ bytes=: ''       NB. dump worksheet for debug mode
newptr=. 0
lookstr=. 0
while. filepos<#stream do.
  'type ptr len'=. nextrecord ''
NB. dump records of worksheet to [bytes] with index held in [records]
  if. debug do.
    bytes=: bytes, (ptr+i.len){stream
    newptr=. newptr+len [ records=: records, type, newptr, len
  end.
  if. 0=sheetfound do.  NB. biff2/3/4
    if. 16b0009 16b0209 16b0409 e.~ type do.  NB. biff2/3/4  BOF
      if. 16b10= fromWORD0 (2+ptr+i.2){stream do.  NB. worksheet stream
        if. y = scnt=. >:scnt do.         NB. test worksheet index wanted
          sheetfound=. 1
        end.
      end.
    end.
    continue.
  end.
  select. type
  case. 16b000a do. NB. EOF
    break.
  case. 16b027e do. NB. rk
    if. 0=x do.
      if. 8=3!:0 a=. >getrk 4}.data=. (ptr+i.len){stream do.
        rowcol8=. rowcol8, fromWORD0 4{.data
        cellval8=. cellval8, a
      else.
        rowcol4=. rowcol4, fromWORD0 4{.data
        cellval4=. cellval4, a
      end.
    else.
      rowcol=. rowcol, fromWORD0 4{.data=. (ptr+i.len){stream
      cellval=. cellval, ; null&,@ (":(!.maxpp))&.> getrk 4}.data   NB. ieee double have at most 16 sig. digits
    end.
  case. 16b0002 do. NB. unsigned 16-bit integer biff2
    if. 0=x do.
      rowcol4=. rowcol4, fromWORD0 4{.data=. (ptr+i.len){stream
      cellval4=. cellval4, {.fromDWORD0 (2#{.a.),~ (7+i.2){data
    else.
      rowcol=. rowcol, fromWORD0 4{.data=. (ptr+i.len){stream
      cellval=. cellval, null&,@ (":(!.maxpp)) {.fromDWORD0 (2#{.a.),~ (7+i.2){data
    end.
  case. 16b0003 do. NB. number biff2
    if. 0=x do.
      rowcol8=. rowcol8, fromWORD0 4{.data=. (ptr+i.len){stream
      cellval8=. cellval8, {.fromDouble0 (7+i.8){data
    else.
      rowcol=. rowcol, fromWORD0 4{.data=. (ptr+i.len){stream
      cellval=. cellval, null&,@ (":(!.maxpp)) {.fromDouble0 (7+i.8){data
    end.
  case. 16b0203 do. NB. number
    if. 0=x do.
      rowcol8=. rowcol8, fromWORD0 4{.data=. (ptr+i.len){stream
      cellval8=. cellval8, {.fromDouble0 (6+i.8){data
    else.
      rowcol=. rowcol, fromWORD0 4{.data=. (ptr+i.len){stream
      cellval=. cellval, null&,@ (":(!.maxpp)) {.fromDouble0 (6+i.8){data
    end.
  case. 16b00fd do. NB. labelss
    rowcolss=. rowcolss, fromWORD0 4{.data=. (ptr+i.len){stream
    cellvalss=. cellvalss, fromDWORD0 (6+i.4){data
  case. 16b0005 do. NB. boolerr biff2
    if. ({.a.)=(8+ptr){stream do. NB. error code ignored
      if. 0=x do.
        rowcol4=. rowcol4, fromWORD0 4{.data=. (ptr+i.len){stream
        cellval4=. cellval4, ({.a.)~:7{data
      else.
        rowcol=. rowcol, fromWORD0 4{.data=. (ptr+i.len){stream
        cellval=. cellval, null&,@ (":(!.maxpp)) ({.a.)~:7{data
      end.
    end.
  case. 16b0205 do. NB. boolerr
    if. ({.a.)=(7+ptr){stream do. NB. error code ignored
      if. 0=x do.
        rowcol4=. rowcol4, fromWORD0 4{.data=. (ptr+i.len){stream
        cellval4=. cellval4, ({.a.)~:6{data
      else.
        rowcol=. rowcol, fromWORD0 4{.data=. (ptr+i.len){stream
        cellval=. cellval, null&,@ (":(!.maxpp)) ({.a.)~:6{data
      end.
    end.
  case. 16b00bd do. NB. multrk
    rocol=. fromWORD0 4{.data=. (ptr+i.len){stream
    lc=. fromWORD0 _2{.data
    nc=. >:lc-{:rocol
    if. 0=x do.
      v=. getrk ("1) _6]\ _2}.4}.data
      for_rcl. rocol + ("1) 0, "0 i.nc do.
        if. 8=3!:0 a=. >rcl_index{v do.
          rowcol8=. rowcol8, rcl
          cellval8=. cellval8, a
        else.
          rowcol4=. rowcol4, rcl
          cellval4=. cellval4, a
        end.
      end.
    else.
      rowcol=. rowcol, rocol + ("1) 0, "0 i.nc
      cellval=. cellval, ; null&,@ (":(!.maxpp))&.> getrk ("1) _6]\ _2}.4}.data
    end.
  case. 16b0006 do. NB. formula, only cached result read
    data=. (ptr+i.len){stream
    if. 16b200 = biffver do. NB. biff2
      if. (255 255{a.)-:13 14{data do.
        if. (0{a.)=7{data do. NB. string result
          lookrowcol=. fromWORD0 4{.data
          lookstr=. 2
        elseif. (1{a.)=7{data do. NB. boolerr
          if. 0=x do.
            rowcol4=. rowcol4, fromWORD0 4{.data
            cellval4=. cellval4, ({.a.)~:9{data
          else.
            rowcol=. rowcol, fromWORD0 4{.data
            cellval=. cellval, null&,@ (":(!.maxpp)) ({.a.)~:9{data
          end.
        end.
      else.  NB. double
        if. 0=x do.
          rowcol8=. rowcol8, fromWORD0 4{.data
          cellval8=. cellval8, {.fromDouble0 (7+i.8){data
        else.
          rowcol=. rowcol, fromWORD0 4{.data
          cellval=. cellval, null&,@ (":(!.maxpp)) {.fromDouble0 (7+i.8){data
        end.
      end.
    else.
      if. (255 255{a.)-:12 13{data do.
        if. (0{a.)=6{data do. NB. string result
          lookrowcol=. fromWORD0 4{.data
          lookstr=. 2
        elseif. (1{a.)=6{data do. NB. boolerr
          if. 0=x do.
            rowcol4=. rowcol4, fromWORD0 4{.data
            cellval4=. cellval4, ({.a.)~:8{data
          else.
            rowcol=. rowcol, fromWORD0 4{.data
            cellval=. cellval, null&,@ (":(!.maxpp)) ({.a.)~:8{data
          end.
NB. blank and multblank records may be ignore
NB.       elseif. (3{a.)=6{data do.  NB. blank
NB.         if. 0=x do.
NB.           rowcolc=. rowcolc, fromWORD0 4{.data
NB.           cellvalc=. cellvalc, null
NB.         else.
NB.           rowcol=. rowcol, fromWORD0 4{.data
NB.           cellval=. cellval, null
NB.         end.
        end.
      else.  NB. double
        if. 0=x do.
          rowcol8=. rowcol8, fromWORD0 4{.data
          cellval8=. cellval8, {.fromDouble0 (6+i.8){data
        else.
          rowcol=. rowcol, fromWORD0 4{.data
          cellval=. cellval, null&,@ (":(!.maxpp)) {.fromDouble0 (6+i.8){data
        end.
      end.
    end.
NB. string for formula result, assume no continue record
  case. 16b0007 do. NB. biff2
    if. 1=lookstr do.
      if. 0=x do.
        rowcolc=. rowcolc, lookrowcol
        cellvalc=. cellvalc, null&,@> {.0 decodestring8 data=. (ptr+i.len){stream
      else.
        rowcol=. rowcol, lookrowcol
        cellval=. cellval, null&,@> {.0 decodestring8 data=. (ptr+i.len){stream
      end.
    end.
NB. string for formula result, assume no continue record
  case. 16b0207 do.
    if. 1=lookstr do.
      if. 16b300 16b400 16b500 e.~ biffver do.  NB. biff3/4/5/7
        if. 0=x do.
          rowcolc=. rowcolc, lookrowcol
          cellvalc=. cellvalc, null&,@> {.0 decodestring16 data=. (ptr+i.len){stream
        else.
          rowcol=. rowcol, lookrowcol
          cellval=. cellval, null&,@> {.0 decodestring16 data=. (ptr+i.len){stream
        end.
      else.
        if. 0=x do.
          rowcolc=. rowcolc, lookrowcol
          cellvalc=. cellvalc, null&,@> {.0 decodeustring16 data=. (ptr+i.len){stream
        else.
          rowcol=. rowcol, lookrowcol
          cellval=. cellval, null&,@> {.0 decodeustring16 data=. (ptr+i.len){stream
        end.
      end.
    end.
NB. blank and multblank records may be ignore
NB.   case. 16b0201 do. NB. blank
NB.     if. 0=x do.
NB.       rowcolc=. rowcolc, fromWORD0 4{.data=. (ptr+i.len){stream
NB.       cellvalc=. cellvalc, null
NB.     else.
NB.       rowcol=. rowcol, fromWORD0 4{.data=. (ptr+i.len){stream
NB.       cellval=. cellval, null
NB.     end.
NB.   case. 16b00be do. NB. multblank
NB.     rocol=. fromWORD0 4{.data=. (ptr+i.len){stream
NB.     lc=. fromWORD0 _2{.data
NB.     nc=. >:lc-{:rocol
NB.     if. 0=x do.
NB.       rowcolc=. rowcolc, rocol + ("1) 0, "0 i.nc
NB.       cellvalc=. cellvalc, nc#null
NB.     else.
NB.       rowcol=. rowcol, rocol + ("1) 0, "0 i.nc
NB.       cellval=. cellval, nc#null
NB.     end.
  case. 16b0004 do. NB. biff2 label, assume no continue record
    if. 0=x do.
      rowcolc=. rowcolc, fromWORD0 4{.data=. (ptr+i.len){stream
      cellvalc=. cellvalc, null&,@> {.0 decodestring8 7}.data
    else.
      rowcol=. rowcol, fromWORD0 4{.data=. (ptr+i.len){stream
      cellval=. cellval, null&,@> {.0 decodestring8 7}.data
    end.
NB. biff8 does not use label record, but excel will read it
  case. 16b0204 do. NB. label, assume no continue record
    if. 16b300 16b400 16b500 e.~ biffver do.  NB. biff3/4/5/7
      if. 0=x do.
        rowcolc=. rowcolc, fromWORD0 4{.data=. (ptr+i.len){stream
        cellvalc=. cellvalc, null&,@> {.0 decodestring16 6}.data
      else.
        rowcol=. rowcol, fromWORD0 4{.data=. (ptr+i.len){stream
        cellval=. cellval, null&,@> {.0 decodestring16 6}.data
      end.
    else.
      if. 0=x do.
        rowcolc=. rowcolc, fromWORD0 4{.data=. (ptr+i.len){stream
        cellvalc=. cellvalc, null&,@> {.0 decodeustring16 6}.data
      else.
        rowcol=. rowcol, fromWORD0 4{.data=. (ptr+i.len){stream
        cellval=. cellval, null&,@> {.0 decodeustring16 6}.data
      end.
    end.
NB. biff8 does not use rstring record, but excel will read it
  case. 16b00d6 do. NB. rstring, assume no continue record
    if. 16b300 16b400 16b500 e.~ biffver do.  NB. biff3/4/5/7
      if. 0=x do.
        rowcolc=. rowcolc, fromWORD0 4{.data=. (ptr+i.len){stream
        cellvalc=. cellvalc, null&,@> {.0 decodestring16 6}.data
      else.
        rowcol=. rowcol, fromWORD0 4{.data=. (ptr+i.len){stream
        cellval=. cellval, null&,@> {.0 decodestring16 6}.data
      end.
    else.
      if. 0=x do.
        rowcolc=. rowcolc, fromWORD0 4{.data=. (ptr+i.len){stream
        cellvalc=. cellvalc, null&,@> {.0 decodeustring16 6}.data
      else.
        rowcol=. rowcol, fromWORD0 4{.data=. (ptr+i.len){stream
        cellval=. cellval, null&,@> {.0 decodeustring16 6}.data
      end.
    end.
  end.
  lookstr=. 0>.<:lookstr
end.
if. 0=x do.
  (rowcol4, rowcol8, rowcolc, rowcolss) ; < (<"0 cellval4), (<"0 cellval8), ( <;._1 cellvalc), sst{~cellvalss
else.
  (rowcol, rowcolss) ; < ( <;._1 cellval), sst{~cellvalss
end.
)

NB. decode rk value
getrk=: 3 : 0
if. 0=2 bitand d=. fromDWORD0 2}.y do. NB. double
  bigendian=: ({.a.)={. 1&(3!:4) 1  NB. 0 little endian   1 big endian
  if. 0=bigendian do.
    rk=. fromDouble0 toDWORD0 0, d bitand dfhs 'fffffffc'
  else.
    rk=. fromDouble0 toDWORD0 0,~ d bitand dfhs 'fffffffc'
  end.
else.  NB. integer
  rk=. _2 bitsha d bitand dfhs 'fffffffc'
end.
if. 1 bitand d do.  NB. scale factor
  rk=. rk%100
end.
<{.rk
)

NB. ---------------------------------------------------------
NB. static verb for reading Excel file
NB. read Excel Versions 5, 95, 97, 2000, XP, 2003
NB. biff5  excel 5  biff7 excel 97   biff8 excel 97, xp, 2003
NB. cover function to read worksheet
NB. x sheet index or name
NB. y Excel file name
NB. 0 readexcel 'test.xls'
readexcel=: 0&$: : (4 : 0)
assert. fexist y
ole=. (>y) conew 'olestorage'
if. '' -: wk=: getppssearch__ole 'Workbook' ; 1 ; 0 do.              NB. biff8
  if. '' -: wk=: getppssearch__ole 'Book' ; 1 ; 0 do.                NB. biff5/7
    assert. 16b40009 16b60209 16b60409 e.~ fromDWORD0 freadx y;0 4  NB. biff2/3/4
  end.
end.
ex=. conew 'biffread'
if. ''-.@-:wk do.
  0&create__ex data__wk
NB. get worksheet location
  if. 2 131072 e.~ 3!:0 x do. x=. (<x) i.~ {."1 worksheets__ex end.
  assert. x<#worksheets__ex
  'name location'=. x{worksheets__ex
else.
  0&create__ex fread y
  location=. x
end.
NB. read worksheet
'ix cell'=. 0&readsheet__ex location
NB. housekeeping
destroy__ex ''
if. ''-.@-:wk do. destroy__wk '' end.
destroy__ole ''
NB. transform cell records to matrix
rcs=. (>./ >:@- <./) ix
off=. <./ ix
m=. cell (<"1 ix-"1 off)}m=. rcs$a:
NB. convert excel date
NB. todate (+&36522) 38335 --> 2004 12 14
)

NB. cover function to read worksheet, convert all number to string
NB. x sheet index or name
NB. y Excel file name
NB. 0 readexcelstring 'test.xls'
readexcelstring=: 0&$: : (4 : 0)
assert. fexist y
ole=. (>y) conew 'olestorage'
if. '' -: wk=: getppssearch__ole 'Workbook' ; 1 ; 0 do.              NB. biff8
  if. '' -: wk=: getppssearch__ole 'Book' ; 1 ; 0 do.                NB. biff5/7
    assert. 16b40009 16b60209 16b60409 e.~ fromDWORD0 freadx y;0 4  NB. biff2/3/4
  end.
end.
ex=. conew 'biffread'
if. ''-.@-:wk do.
  0&create__ex data__wk
NB. get worksheet location
  if. 2 131072 e.~ 3!:0 x do. x=. (<x) i.~ {."1 worksheets__ex end.
  assert. x<#worksheets__ex
  'name location'=. x{worksheets__ex
else.
  0&create__ex fread y
  location=. x
end.
NB. read worksheet
'ix cell'=. 1&readsheet__ex location
NB. housekeeping
destroy__ex ''
if. ''-.@-:wk do. destroy__wk '' end.
destroy__ole ''
NB. transform cell records to matrix
rcs=. (>./ >:@- <./) ix
off=. <./ ix
m=. cell (<"1 ix-"1 off)}m=. rcs$a:
NB. convert excel date
NB. todate (+&36522) 38335 --> 2004 12 14
)

NB. cover function to dump worksheet
NB. sst shared string
NB. (bk)records= type index length
NB. (bk)bytes= byte stream for records
NB. x sheet index or name
NB. y Excel file name
NB. 0 dumpexcel 'test.xls'
dumpexcel=: 0&$: : (4 : 0)
assert. fexist y
ole=. (>y) conew 'olestorage'
if. '' -: wk=: getppssearch__ole 'Workbook' ; 1 ; 0 do.              NB. biff8
  if. '' -: wk=: getppssearch__ole 'Book' ; 1 ; 0 do.                NB. biff5/7
    assert. 16b40009 16b60209 16b60409 e.~ fromDWORD0 freadx y;0 4  NB. biff2/3/4
  end.
end.
ex=. conew 'biffread'
if. ''-.@-:wk do.
  1&create__ex data__wk       NB. 1=debug mode
NB. get worksheet location
  if. 2 131072 e.~ 3!:0 x do. x=. (<x) i.~ {."1 worksheets__ex end.
  assert. x<#worksheets__ex
  'name location'=. x{worksheets__ex
else.
  1&create__ex fread y
  location=. x
end.
NB. get worksheet location
NB. read worksheet
'ix cell'=. 0&readsheet__ex location
NB. workbook global
sst__=: sst__ex
bkrecords__=: bkrecords__ex
bkbytes__=: bkbytes__ex
NB. worksheet
records__=: records__ex
bytes__=: bytes__ex
NB. housekeeping
destroy__ex ''
if. ''-.@-:wk do. destroy__wk '' end.
destroy__ole ''
''
)

cocurrent 'base'
NB.  populate z locale
readexcel_z_=: readexcel_biffread_
readexcelstring_z_=: readexcelstring_biffread_
dumpexcel_z_=: dumpexcel_biffread_


require 'dll convert'
coclass 'wincrypt'

or=: 23 b.
sh=: 33 b.
hexhash=: ,@:hfd@:(a.&i.)@:(>@(4&{) {. >@(3&{))

PROV_RSA_FULL=: 1
ALG_CLASS=: 13
ALG_TYPE=: 9
ALG_CLASS_HASH=: ALG_CLASS sh 4
ALG_TYPE_ANY=: ALG_TYPE sh 0
ALG_SID_MD5=: 3
CALG_MD5=: ALG_CLASS_HASH or ALG_TYPE_ANY or ALG_SID_MD5
HP_HASHVAL=: 2

AcquireContext=: {.@>@(1&{)@:('advapi32 CryptAcquireContextA i *i i i i i'&cd)
ReleaseContext=: >@{.@:('advapi32 CryptReleaseContext i i i'&cd)
CreateHash=: {.@>@{:@:('advapi32 CryptCreateHash i i i i i *i'&cd)
DestroyHash=: >@{.@:('advapi32 CryptDestroyHash i i'&cd)
HashData=: >@{.@:('advapi32 CryptHashData i i *c i i'&cd)
GetHashParam=: hexhash@:('advapi32 CryptGetHashParam i i i *c *i i'&cd)

md5=: 3 : 0
CC=. AcquireContext_wincrypt_ (,_1);0;0;PROV_RSA_FULL_wincrypt_;0
H=. CreateHash_wincrypt_ CC;CALG_MD5_wincrypt_;0;0;(,_1)
HashData_wincrypt_ H;y;(#y);0
P=. GetHashParam_wincrypt_ H;HP_HASHVAL_wincrypt_;(20#'z');(,20);0
DestroyHash_wincrypt_ H
ReleaseContext_wincrypt_ CC;0
P
)

NB. Run with Ctrl+R
NB. 0 : 0
NB. md5_wincrypt_ 'test'
NB. )

custidx 'd:/jprg/user/Projects/custidx/custidx_tst.sqlite'
