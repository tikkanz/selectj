NB. read/write comma-separated value data (*.csv) files

require 'files strings'
cocurrent 'z'

NB. =========================================================
NB. extcsv v adds '.csv' extension if none present
extcsv=: , #&'.csv' @ (0: = '.'"_ e. (# | i:&PATHSEP_j_) }. ])

NB. =========================================================
NB.*appendcsv v Appends an array to a csv file
NB. result: number of bytes appended or _1 if unsuccessful
NB. form: dat appendcsv file[;delim]
NB. y is: literal or 2-item list of boxed literals
NB.       1{ filename of file to append dat to
NB.       2{ optional delimiter. Default is ','
NB. x is: Numeric or boxed J array of rank 2
appendcsv=: 4 : 0
  'fln delim'=. 2{.!.(<',') boxopen y
  dat=. delim makecsv x
  dat fappends extcsv fln
)

NB.*quote v Enclose string(s) in quotes (doubling internal quotes as needed).
NB. returns:
NB. form: [qtyp] quote strng(s)
NB. y is: string or boxed strings to quote
NB. x is: optional quote type. Default is ''''''
NB.
quote=: 3 : 0
  '''''' quote y
  :
  if. 0<L. y do. x&quote &.> y return. end.
  if. 1=(#x) do. x=. 2$x end.
  NB. if. #x=. x -. ' ' do. x=. 2$x end.
  (}:x),((1+(y e. x)*. +./'''"'e. x)#y),}.x
  NB. (}:x),((1+(y e. x))#y),}.x
)

ischar=: ] e. 2 131072"_
isreal=: ] e. 1 4 8 64 128"_

NB.*makecsv v Makes a CSV string from an array
NB. returns: CSV string
NB. form: [delims] makecsv array
NB. y is: a numeric or boxed array
NB. x is: optional delimiters. Default is ',""'
NB.       1{<delims> is the field delimiter
NB.       2{<delims> is the starting string delimiter
NB.       3{<delims> is the ending string delimiter
makecsv=: 3 : 0
  ',""' makecsv y
  :
  dat=. y
  if. 1=#x do. sd=. '""'
  else. sd=. 2$}.x end.
  fd=. 1{.x
  delim=. fd ; (fd,{.sd) ; (({:sd),fd) ; (({:sd),fd,{.sd) ; '' ; ({.sd) ; {:sd
  NB. delim=. ',';',"';'",';'","';'';'"';'"'
  if. 2>#$dat do. arry=. ,:dat end. NB. handle vector
  
  NB. check column datatype
  try. type=. ischar 3!:0@:>"1 |: dat
    if. ({.sd) e. ;(<a:;I. type){dat do. assert.0 end. NB. sd in field
    if. -. +./ type do. NB. all columns numeric
      dat=. 8!:0 dat NB. ,each 8!:2 each dat
      delim=. 0{ delim
    else. NB. columns either numeric or literal
      idx=. I. -. type
      if. #idx do. NB. format numeric cols
        dat=. (8!:0 tmp{dat) (tmp=. <a:;idx)}dat
      end.
      dlmidx=. 2#.\ type
      dlmidx=. _1|.dlmidx, 4&+@(2 1&*) ({:,{.) type
      delim=. (#dat)# ,: dlmidx { delim
    end.
  catch.  NB. handle mixed-type columns
    dat=. ,dat
    t=. (+:@:isreal + ischar) 3!:0&> dat
    dat=. (sd quote idx{dat)(idx=. I. 1=t)}dat NB. quote char
    dat=. (8!:0 idx{dat) (idx=. I. 2=t)}dat NB. format numeric
    dat=. (":@>@{. &.> idx{dat)(idx=. I. 0=t)}dat NB. handle other (complex or boxed).
    dat=. ($y)$dat
    delim=. 0{ delim
  end.
  NB. make an expansion vector and open space between cols
  d=. 0= 4!:0 <'dlmidx' NB. are there char cols that need quoting
  c=. 0>. (2*d)+ <:+: {:$dat NB. total num columns incl delims
  b=. c $d=0 1 NB. insert empty odd cols if d else even
  dat=. b #^:_1"1 dat  NB. expand dat
  dat=. delim (<a:;I.-.b)}dat  NB. amend with delims
  ;,dat,.<LF  NB. add EOL & vectorise
)

chopcsv=: 3 : 0
  ',""' chopcsv y
  :
  dat=. y
  NB. assert. (0<#x), 0=L.x
  if. 1=#x do. sd=. '""'
  else. sd=. 2$}.x end.
  fd=. 1{.x
  if. =/sd do.
    sd=. {.sd
  else.
    dat=. dat rplc ({.sd);'|';({:sd);'|'
    sd=. '|'
  end.
  dat=. dat,fd
  b=. dat e. fd
  c=. ~:/\dat=sd
  fmsk=. b>c
  smsk=. sd ([: (> (0: , }:)) =) dat
  smsk=. -. smsk +. (sd,fd) E. dat
  dat=. smsk#dat
  fmsk=. smsk#fmsk
  fmsk <;._2 dat
)

NB. =========================================================
NB.*fixcsv v Convert csv data into J array
NB. form: [delim] fixcsv dat
NB. result: array of boxed literals
NB. y is: delimited string
NB. x is: optional delimiter. Default is ','
fixcsv=: 3 : 0
  ',' fixcsv y
  :
  if. 1=#x do. sd=. '""'
  else. sd=. 2$}.x end.
  if. =/sd do.
    x=. x,{.sd
  else.
    y=. y rplc ({.sd);'|';({:sd);'|'
    x=. x,'|'
  end.
  b=. y e. LF
  c=. ~:/\y=1{x
  msk=. b > c
  > msk <@(x&chopcsv) ;._2 y
)

NB. =========================================================
NB.*readcsv v Reads csv file into a boxed array
NB. form: [delim] readcsv file
NB. result: array of boxed literals
NB. y is: filename of file to read from
NB. x is: optional delimiter. Default is ','
readcsv=: 3 : 0
  ',' readcsv y
  :
  dat=. freads extcsv y
  if. dat -: _1 do. return. end.
  x fixcsv dat
)


NB. =========================================================
NB.*writecsv v Writes an array to a csv file
NB. form: dat  writecsv file[;delim]
NB. result: number of bytes written (_1 if write error)
NB. form: dat appendcsv file[;delim]
NB. y is: literal or 2-item list of boxed literals
NB.       1{ filename of file to write dat to
NB.       2{ optional delimiter. Default is ',""'
NB. x is: numeric or boxed array of rank 2
NB. An existing file will be written over.
writecsv=: 4 : 0
  'fln delim'=. 2{.!.(<',') boxopen y
  dat=. delim makecsv x
  dat fwrites extcsv fln
)