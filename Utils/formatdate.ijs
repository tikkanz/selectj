require '~Projects/utils/dcdates.ijs'
require 'strings dates numeric dll'

coclass 'rgsdates'

NB. TO DO...
NB. Extend J's getdate to handle converting more string representations 
NB. to numeric

NB.*TimeDiff v dayno x - dayno y in <YYYY MM DD hh mm ss.sss> format
NB. result: numeric time difference of x-y in <YYYY MM DD hh mm ss.sss> format
NB. y is: end date,time as DayNumber
NB. x is: start date,time as DayNumber

NB.*fmtTimeDiff v Formated time difference
NB. y is: time difference in <YYYY MM DD hh mm ss.sss> format
NB. x is: format string
NB. eg: 'Y year\s, M \months DDD days' fmtTimeDiff y
NB. eg: 'D day\s' fmtTimeDiff y
NB. Handle part units for smallest specified unit in format string:
NB. How to specify? separate option to format string or eg
NB.    * decimal: YYY, MMM, DDD, hhh, mmm, sss
NB.    * round (to nearest unit): YY, MM, DD, hh, mm, ss
NB.    * truncate (only complete units): Y, M, D, h, m, s

NB.*fmtDateTime v Formats date and time together


NB. =========================================================
NB. Utility verbs

NB.*escaped v process an escaped string
NB. result: 2-item list of boxed mask & string:
NB.          0{:: boolean mask of escaped characters
NB.          1{:: string with escape character compressed out
NB. y is: An escaped string
NB. x is: character used to escape string
NB. eg: ('\' escaped '\Date is: D\\MM\\YYYY') dSpell dJulian 6!:0 ''
escaped=: 3 : 0
  '\' escaped y                         NB. default escape char
:
  mskesc=. y = x
  mskfo=. 2 < /\ 0&, mskesc             NB. 1st occurences of x
  mskesc=. mskesc ([ ~: *.) 0,}: mskfo  NB. unescaped 1st occurences of x
  mskunescaped=. -. 0,}: mskesc         NB. unescaped characters
  (-.mskesc)&# &.> mskunescaped;y       NB. compress out unescaped x
)

NB.*eachunderv c Applies verb in gerund to corresponding item of y.
NB. Provided by Henry Rich in J programming forum August 2009.
NB. based on idea from Raul Miller and adverb by Ric Sherlock.
NB. [x] (k{u)`:0 &. v is applied to cell k of y
NB. u is gerund, v is a verb.  
NB. eachunderv has the same spec as 'respectively', but looks neater.
NB. Henry prefers `:6 to @.0, but it's a matter of taste.
NB. eg: *:`+:`-: eachunderv] 4 5 6
NB. eg: *:`+:`-: eachunderv> <4 5 6
eachunderv=: 2 : 0
   m v 1 :(':';'x`:6&.u y')"_1 y
:
   m v 1 :(':';'x`:6&.u&>/ y')"_1 x ,&<"_1 y
)

NB.*eachv a Applies verbs in gerund to corresponding atom of y [and x]
NB. based on idea from Raul Miller on J programming forum August 2009.
NB. eg: [x] mygerund eachv y
eachv =: eachunderv >

fmt=: 8!:0

NB. =========================================================
NB. Constants
MS0Date=: 2415019  NB. add to Microsoft date to get a Julian dayno
Linux0DateTime=: 2440588  NB. add to Linux-style date to get a Julian dayno
J0Date=: 2378497   NB. add to the result of J's todayno verb to get Julian dayno

WKDAYS=: ;:'Sunday Monday Tuesday Wednesday Thursday Friday Saturday'
MONTHS=: ''; ;:'January February March April May June July August September October November December'

NB. =========================================================
NB. Verbs for converting between dates and daynumbers

NB.*toDayNumber v Extends verb "todayno" to handle time
NB. Dates before 1800 1 1 are not supported
toDayNumber=: 3 : 0
  0 toDayNumber y
:
  ymd=. y
  if. x do.                      NB. form <yyyymmdd.hhmmss>
    hms=. 0 100 100 #: 1e_2 round 1e6 * 1||ymd
    ymd=. 0 100 100 #: <.ymd
  else.                          NB. form <yyyy mm dd hh mm ss.sss>
    hms=. 3({."1) 3}."1 ymd
    ymd=. 3{."1 |ymd
  end.
  hms=. 86400 %~ 0 60 60 #. hms  NB. to proportion of a day
  dayn=. 0 todayno ymd
  dayn+hms
)

NB.*toDateTime v Extends verb "todate" to handle time
NB. result: numeric array in date/time format specified by x
NB. y is: array of J day numbers
NB. x is: optional boolean specifying output format. Default 0.
NB.      0 : date/time format <yyyy mm dd hh mm ss.sss>
NB.      1 : date/time format <yyyymmdd.hhmmss.sss>
NB. eg: 1 toDateTime toDayNumber 6!:0 ''
NB. Dates before 1800 1 1 are not supported
toDateTime=: 3 : 0
  0 toDateTime y
:
  dayno=. y
  hms=. 1e_3 round 86400 * 1||dayno NB. get any decimal component
  dayno=. <.|dayno        NB. drop any decimal
  ymd=. x todate dayno    NB. get date component from todate
  if. x do.               NB. yyyymmdd.hhmmsssss
    hms=. 1e_6 * 0 100 100#. 0 60 60#: hms  NB. convert to 0.hhmmsssss
    ymd=. ymd + hms
  else.                   NB. yyyy mm dd hh mm ss.sss
    hms=. 0 60 60 #: hms  NB. convert to hh mm ss.sss
    ymd=. ymd ,"1 hms
  end.
  ymd
)

NB.*toJulian v converts J day number to Julian day number
NB. Dates before 1800 1 1 are not supported
NB. Add another 0.5 to get true Julian Day number where noon is
NB. regarded as the "start" of the day.
toJulian=: J0Date + ]

NB.*fromJulian v converts Julian day number to J day number
NB. Dates before 1800 1 1 are not supported
toJdayno=: J0Date -~ ]

NB. =========================================================
NB. Verbs for formating string reprentations of Dates and Times
 
NB.*fmtDate v Format a date (given as a Day Number) in a given format
NB. Specify the date format to be used with the following codes:
NB.      D: 1   DD: 01   DDD: Sun   DDDD: Sunday
NB.      M: 1   MM: 01   MMM: Jan   MMMM: January
NB.             YY: 99              YYYY: 1999
NB. To display any of the letters that are codes, "escape" them with '\'
NB. Any rank & shape array accepted.  See "Describe" for more details.
NB. Based on dSpell by Davin Church
fmtDate=: 3 : 0
  'MMMM D, YYYY' fmtDate y
  :
  codes=. ;:'D DD DDD DDDD M MM MMM MMMM YY YYYY'
  pic=. x

  'unesc pic'=. '\' escaped pic
  pic=. (1 , 2 ~:/\unesc *. pic e. 'DMY') <;.1 pic  NB. Cut into tokens
  var=. pic e. codes                                NB. mark sections as vars
  
  ymd=. |: todate <.,y

  t=. 2{ymd                                         NB. Days
  values=. ('';'r<0>2.0') fmt"0 1 t
  t=. (7|3+<.,y){WKDAYS                             NB. Day names
  values=. values,(3&{.&.> ,: ]) t
  t=. 1{ymd                                         NB. Months
  values=. values, ('';'r<0>2.0') fmt"0 1 t
  t=. (0>.t){MONTHS                                 NB. Month names
  values=. values, (3&{.&.> ,: ]) t
  t=. 0{ymd                                         NB. Years
  values=. values, (2&}.&.> ,: ]) fmt t

  res=. <@;"1 (|:(codes i. var#pic){values) (I. var)}"1 pic
  if. 0=#$y do. res=. ,>res else.  res=. ($y)$ res end.
  res
)

NB.*fmtTime v Format a time (in seconds) in a given format.
NB. y is: time in seconds since start of the day (86400 seconds in a day)
NB. eg: fmtTime 86400 * 1|toDayNumber 6!:0 ''
NB. Specify the time format to be used with the following codes:
NB. (either upper or lower case) to specify the formatting of days ("d"),
NB. hours ("h"), minutes ("m"), seconds ("s"), fractions of a second ("c"),
NB. or AM/PM designator ("p"):
NB.    d: 1    h: 1    m: 1    s: 1      c: 1       p: a
NB.           hh: 01  mm: 01  ss: 01    cc: 01     pp: am
NB.                          sss: 1.2  ccc: 001
NB.                                   cccc: 0001
NB. If no "p" designator is present, 24 hour format is used.
NB. To display any of the letters that are codes, "escape" them with '\'
NB. Any rank & shape array accepted.  See "Describe" for more details.
NB. Based on tSpell by Davin Church
fmtTime=: 3 : 0
  'h:mm:ss pp' fmtTime y
  :
  codes=. ;:'d h hh m mm s ss sss c cc ccc p pp'
  pic=. x
  'unesc pic'=. '\' escaped pic
  dcp=. 'dcp' e. pic                                     NB. are days, millisecs, am/pm present
  pic=. (1 , 2 ~:/\unesc *. pic e. 'dhmscp') <;.1 pic    NB. Cut into tokens
  var=. pic e. codes                                     NB. mark sections as vars
  
  dhms=. |:(0,(24*0{dcp),60 60) #: <. 0 >. , y           NB. to lists of D,H,M,:S
  ccc=.  1e_3 round 1 | 0 >. , y                         NB. milliseconds
  values=. ,:fmt 0{dhms                                  NB. Days
  t=. (1{dhms) (] + 12&*@] | -) 2{dcp                    NB. Hours, 12/24 hour formats
  values=. values,('';'r<0>2.0') fmt"0 1 t
  t=. 2{dhms                                             NB. Minutes
  values=. values,('';'r<0>2.0') fmt"0 1 t
  t=. 3{dhms                                             NB. Seconds
  values=. values,('';'r<0>2.0') fmt"0 1 t
  values=. values, fmt t+ccc                             NB. sss
  t=. 100 10 1 round"0 1 ccc * 1000                      NB. c, cc, ccc
  values=. values, 1 2 3 {.&.> 'r<0>3.0' fmt t
  t=. (12<:24|1{dhms){ ;:'am pm'                         NB. am/pm
  values=. values,(1&{.&.> ,: ]) t

  res=. <@;"1 (|:(codes i. var#pic){values)   (I. var)}"1 pic
  if. 0=#$y do. res=. ,>res else.  res=. ($y)$ res end.
  res
)

NB. =========================================================
NB. verbs for working with time zones

NB.*getTimeZoneInfo v function to return Windows time zone info
NB. result: 3-item list of boxed info
NB.    0{:: Daylight saving status (0 unknown, 1 standarddate, 2 daylightdate)
NB.    1{:: Bias (offset of local zone from UTC in minutes)
NB.    2{:: 2 by 3 boxed table: Standard,Daylight by Name,StartDate,Bias
NB. eg: getTimeZoneInfo ''
NB. Based on APL+Win func written by Davin Church of Creative Software Design
NB. Written May 2007 by Ric Sherlock
NB. kernel32 GetTimeZoneInformation i *i
getTimeZoneInfo=: 3 : 0
  'tzstatus tzinfo'=. 'kernel32 GetTimeZoneInformation i *i'&cd <(,43#0)
  NB. read TIME_ZONE_INFORMATION structure
  tzinfo=. (1 (<:+/\ 1 16 4 1 16 4 1)}43#0) <;.2 tzinfo    NB. 4 byte J integers
  tzbias=. 0{:: tzinfo
  tzinfo=. _3]\ }. tzinfo                  NB. Standard info ,: Daylight info
  'name date bias'=. i. 3                  NB. column labels for tzinfo
  tmp=. (6&u:)@(2&ic)&.> name {"1 tzinfo   NB. read names as unicode text
  tmp=. (0{a.)&taketo&.> tmp               NB. take to first NUL
  tzinfo=. tmp (<a:;name)}tzinfo           NB. amend TZ names
  tmp=. _1&ic@(2&ic)&.> date{"1 tzinfo     NB. read SYSTEMTIME structures
  tzinfo=. tmp (<a:;date)}tzinfo           NB. amend TZ dates

  tzstatus;tzbias;<tzinfo
)

NB. =========================================================
NB. Export to z locale
fmtTime_z_ =: fmtTime_rgsdates_
fmtDate_z_ =: fmtDate_rgsdates_
toDayNumber_z_ =: toDayNumber_rgsdates_
toDateTime_z_ =: toDateTime_rgsdates_
toJulian_z_ =: toJulian_rgsdates_
toJdayno_z_=: toJdayno_rgsdates_

NB. =========================================================
NB. Example usage and Testing

Note 'Examples/Tests'
 ]now=: 6!:0 ''
 toDayNumber now
 J0Date_rgsdates_ + toDayNumber now
 toJulian toDayNumber now
 (1e_10 > ] - toDateTime@toJdayno@toJulian@toDayNumber) now
 toDayNumber 3# ,: now
 1 dJulian 20090907.133031267
 1 toDayNumber 20090907.133031267
 1 toDayNumber 3# 20090907.133031267
 toDateTime toDayNumber now
 1 toDateTime toDayNumber now
 assert (toDayNumber now)(0.01 > |@:-)  1 toDayNumber 1&toDateTime toDayNumber now
 fmtDate toDayNumber now
 'DDDD, D MMMM YYYY' fmtDate toDayNumber now
 '\Day: D, \Month: M, Year: YY' fmtDate toDayNumber now
 'DDD, MMM DD, YYYY' fmtDate toDayNumber now
 'DD/MM/YYYY' fmtDate toDayNumber now
 'D/M/YY' fmtDate toDayNumber now
 fmtTime 0 60 60#. _3{. now
 'hh:mm:ss' fmtTime 0 60 60#. _3{. now
 fmtTime 65101.201 16542.081 85421.246
 'Ti\me\s: hh\\mm\\ss' fmtTime 65101.201 16542.081 85421.246
 'hh:mm:ss:ccc' fmtTime 65101.201 16542.081 85421.246
 'h:m:s:c' (fmtTime -: tSpell) 65101.201 16542.081 85421.246 16542.081
 'h:m:s:c' (fmtTime -: tSpell) 65101.201
)

Note ' proposal'
NB. Given Day number (Julian or J equivalent)
NB. create a set of short verbs to retrieve individual formats
2 4 getYear
1 2 3 4 getMonth
1 2 3 4 getDay
1 2 getHour  (0 1 2 getAM)
1 2 getMinute
1 2 3 getSeconds
1 2 3 getMSeconds

Check fmtDate/fmtTime for codes, retreive matching verbs from gerund and apply to y
using eachunderv or eachv.
)
