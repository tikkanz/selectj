NB. HTML-generating utilities
NB. based on web.ijs from system library
NB. 'c:\program files\j601\system\packages\publish\web.ijs'
addpath_z_=: adverb def '(copath~ ~.@(x&;)@copath)@(coname^:(0:=#)) :. ((copath~ copath -. (<x)"_)@(coname^:(0:=#)))'
webdefs_z_=: 'jweb' addpath
webdefs ''      NB. add jweb to start of path for current locale

cocurrent 'jweb'   NB. populate jweb locale

NB. HTML defines, among other things, Elements and Attributes
NB.   The name an element immediately follows the opening
NB.   angle bracket, eg   <img ...  or  <h1 ...
NB.   Some elements stand-alone in a document, others have
NB.   closing tags, eg   </h1>
NB.
NB.   Attributes are included in an opening tag, with or
NB.   without a value, eg   <img src="foo.gif" ismap />
NB.
NB.   In the following, four adverbs are created to create
NB.   the following elements and attributes:
NB.      tag   - Element with a closing tag, eg  <h1>...</h1>
NB.      point - Element with no closing tag, eg <img ... />
NB.      parm  - Attribute with a value, eg  size="3"
NB.      parm0 - Attribute with no value, eg  compact

NB. In the definitions below, element verbs take text to
NB. enclose in tags as a right argument.  For elements
NB. with no closing tag, the right argument is ignored.
NB.
NB. The left argument specifies attributes for the element.
NB.
NB. Eg:
NB.    H1 'This is the title'
NB. <h1>This is the title'
NB.    'align=center' H1 'This is the title'
NB. <h1 align=center>This is the title</h1>
NB.
NB. The attributes can be specified directly as the left
NB. arguments, but are more easily supplied with the set
NB. of adverbs and conjunctions constructed with the parm
NB. and parm0 definitions.  A conjunction is created for
NB. every attribute which takes a value, and an adverb for
NB. every attribute which takes none.  The result of the
NB. adverbs and conjunctions are verbs which are semantically
NB. identical to the element verbs, yet which include the
NB. specified attribute.
NB.
NB. Eg:
NB.    H1 align 'center'  'This is the title'
NB. <h1 align="center">This is the title</h1>
NB.    font color 'Blue' size '+1' 'this is some text'
NB. <font color="Blue" size="+1">this is some text</font>

NB. ELEMENT: with closing tag
NB. Create tag verbs of the form:
NB.    h1=: verb define
NB. '<h1>',y,'</h1>'
NB. :
NB. '<h1 ',x,'>',y,'</h1>'
NB. )

tag=: adverb def 'verb def ((''''''<'',x,''>'''',y,''''</'',x,''>'''''');'':'';(''''''<'',x,'' '''',x,''''>'''',y,''''</'',x,''>''''''))'
maketag=: verb def 'empty ".y,''=: '''''',(tolower y),'''''' tag'''
maketag@> ;:noun define-.LF
   HTML HEAD TITLE BODY LINK
   P PRE BLOCKQUOTE BASE
   STYLE SPAN DIV ADDRESS
   A OBJECT APPLET AREA
   H1 H2 H3 H4 H5 H6 DEL INS
   FONT BASEFONT TT B I BIG SMALL STRIKE U
   XMP CODE SAMP EM STRONG Q CITE
   KBD VAR ABBR ACRONYM DFN SUB SUP
   UL OL LI DIR MENU DL DT DD
   TABLE CAPTION THEAD TFOOT TBODY
   COLGROUP COL TH TR TD
   FRAMESET NOFRAMES IFRAME
   FORM BUTTON SELECT FIELDSET LEGEND
   OPTGROUP OPTION TEXTAREA LABEL
   SCRIPT NOSCRIPT
)

NB. ATTRIBUTE: with value
NB. Create parm conjunctions of the form:
NB.    href=: conjunction define
NB. ('href=' glue v) u y
NB. :
NB. (('href=' glue v),' ',x) u y
NB. )

parm=: adverb def 'conjunction def ((''('''''',x,''='''' glue v) u y'');'':'';(''(('''''',x,''='''' glue v),'''' '''',x) u y''))'
makeparm=: verb def 'empty ".y,''=: '''''',y,'''''' parm'''
makeparm@> ;:noun define-.LF
   size width height align href face bgcolor
   text alink vlink border color src alt
   longdesc span hspace vspace usemap clear
   classid codebase codetype archive standby
   start value summary rowspan colspan rows cols
   char charoff headers scope abbr axis
   frame rules cellspacing cellpadding
   name content rel type id class title
   lang dir style datetime onload onunload
   onclick ondblclick onmousedown onmouseup
   onmouseover onmousemove onmouseout
   onkeypress onkeydown onkeyup cite data
   link rel rev charset hreflang accesskey
   tabindex onfocus onblur shape coords media
   valuetype object scrolling frameborder
   marginwidth marginheight target for
   action method enctype onsubmit accept
   maxlength onselect onchange prompt
   language onreset checked readonly multiple
   selected
)

enquote=: ('"'&,)@(,&'"')^:('"'&~:@{.@(1&{.))
glue=: , enquote@":

NB. ATTRIBUTE: without value
NB. Create parm adverb of the form:
NB.    ismap=: adverb define
NB. ('ismap') u y
NB. :
NB. (('ismap'),' ',x) u y
NB. )

parm0=: adverb def 'adverb def (('''''''',x,'''''' u y'');'':'';(''('''''',x,'' '''',x) u y''))'
makeparm0=: verb def 'empty ".y,''=: '''''',y,'''''' parm0'''
makeparm0@> ;:noun define-.LF
   ismap compact nowrap declare nohref noshade
   noresize disabled
)

NB. ELEMENT: with no closing tag
NB. Create point verbs of the form:
NB.    img=: verb define
NB. '<img />'
NB. :
NB. '<img ',x,' />'
NB. )

point=: adverb def 'verb def ((''''''<'',x,'' />'''''');'':'';(''''''<'',x,'' '''',x,'''' />''''''))'
makepoint=: verb def 'empty ".y,''=: '''''',(tolower y),'''''' point'''
makepoint@> ;:noun define-.LF
  IMG BR HR PARAM MAP ISINDEX META INPUT
)

NB. Standard default colors recognized by HTML
makecolor=: verb def 'empty ".y,''=: '''''',y,'''''''''
makecolor@> ;:noun define-.LF
   Black  Silver Gray   White
   Maroon Red    Purple Fuchsia
   Green  Lime   Olive  Yellow
   Navy   Blue   Teal   Aqua
)

NB. Utilities

NB. decorate --  general text formatter adverb.
NB. Arg is a gerund of verbs to apply.  The args of the resulting
NB. verb are:   x - sepchar followed by fmt codes, eg  '_*'
NB.                  elements correspond to elements of gerund
NB.             y - text, demarkated by {.y followed by the fmt code
NB.                  eg, '`_normal text with a `*bold`_ word.'
NB.                  two delims in a row are treated as plain text
NB. splice conjunction is utility.
NB. ftext is verb covering decorate with standard fmt codes and verbs.
NB. fdecor is adv like decorate -- arg and deriv. l.arg are more standards


splice=: 2 : '; @ (<@u ;. n)'

decorate=: adverb define
:
c=. <;._1 y [ d=. {.y            NB. cut along delims
g=. (+: 0: , }:) mt=. (0: = #@>) c  NB. mask over groups to be merged.
c=. g <@; ;. 1 c,&.>mt<@#"0 d      NB. merge groups and add plain delim
(1#~#c) (u{~x i. {.@>c)@> splice 1 }.&.>c
)

NB.! (the following should really use more abstract elements)
NB. Standard formatting:    _ normal    ]
NB.                         * bold      b
NB.                         % italic    i
NB.                         ~ code      code
NB.                         @ link      link

ftext=: verb def '''_*%~@'' (]`B`I`CODE`link) decorate y'
fdecor=: adverb def (':';'(''_*%~@'',x) (]`B`I`CODE`LINE`U) decorate y')

NB.!why does the following fail?
NB. '$!' B@jsite`(I@FONT color 'Blue') fdecor '`_the `*site`_ `!is`_ `$here\this`_ and running.'
NB. >>bug in rep of explicit adv/conj
NB. workaround is to replace I@FONT color 'Blue' with a named verb.

NB. secondary verbs:
link=: verb define
i=. y i. PATHSEP_j_
A href (i{.y) (}.i}.y)
)

image=: verb def ('IMG src y 0';':';'x IMG src y 0')
jsite=: link@('http://www.jsoftware.com/'&,)
NB.  splice - cut; assemble along items
NB.  spread - return cut mask for sets of columns

spread=: ;@({.&.>&1)   NB.  (spread 2 1 1) u;._1 y

NB.  composition:   f@g for monad,   (f g) for dyad
NB.  allows  (FONT upon I) color Blue
NB.  (root verb in composition is the one applied dyadically)
NB. upon=: @: : (`(`:6))
upon=: 2 : '(u@:v) : (u v)'

NB. table verb.  Convert matrix of boxed elements into
NB. an HTML representation.
by=: ,&LF : (, LF&,)
onbox=: ;@:(by&.>) :.<

table=: TABLE upon (onbox@:(TR&.onbox"1)@:(TD@by&.>))

NB. Apply formatting verbs to all boxes, words, lines,
NB. or paragraphs of the right argument.
NB.   f all [boxes|lines|paras|words]
NB.  eg  P@ftext all paras noun define
NB.     ...

all=: 2 : '; @ (((by@x)&.>) @ y)'
boxes=: ]
lines=: <;._2
paras=: (_1&|.&((2#LF)&E.) <;._2 ])@by
words=: (#~ *@#@>) @ (<;._1) @ (' '&,)

NB. entities - converts from &entities to plain text
NB.            inverse converts back.

'ents plain'=: <"0 |: (({. ; }.@}.)~ i.&' ');._2 noun define
lt <
gt >
amp &
quot "
)

pfe=. ;@(((entcvt@{. , }.@}.)~ i.&';')&.>@(<;._1)) &. ('&amp;'&, :. }.)
entcvt=. (ents"_ i. <) >@{ plain"_ , <
entcvt=. (entcvt f.) :. ((plain"_ i. <@,) >@{ (('&'&,@(,&';')&.>ents)"_ , <))
efp=. ; @: (entcvt^:_1&.>)
entities=: pfe :. efp f.

NB. asciibox - convert box drawing characters to ascii

asciibox=: (,(179 180 191 192 193 194 195 196 197 217 218{a.),.'|++++++-+++')&charsub

NB. Paragraph formatting:  Format paragraphs according to
NB. leading character.
NB.   pdecorate - general.  Argument to adverb are the formatting
NB.               verbs, x is leading characters, y is text.
NB.   fparas - standard use:
NB.             > title   ] raw   " text   ' prefmt    - list
NB.   fpdecor- like, pdecorate, but augment standard use.
NB.
NB.  eg:
NB.      fparas noun define
NB.   >1This is header 1 (ftitle)
NB.
NB.   "`_This is just
NB.   some `*formatted`_ text.
NB.
NB.   -and
NB.   an
NB.   unordered
NB.   list
NB.   )

pdecorate=: adverb def (':';'u@}.@.(x"_ i. {.) all paras y')
fparas=: '>]"''-'&(ftitle`fraw`(P@ftext)`fpre`(P@flist) pdecorate)
fpdecor=: adverb def (':';'(''>]"''''-'',x) (ftitle`fraw`(p@ftext)`fpre`(p@flist)`u) pdecorate y')

NB.   ftext  (from above)
fpre=: PRE@(LF&,)
ftitle=: verb def '(''H'',{.y)tag }.}:y'
fraw=: ]
flist=: UL@(LI all lines)
