NB. built from project: ~user/projects/selectj/selectj

IFJIJX_j_=: 1
script_z_ '~system/main/convert.ijs'
script_z_ '~system/packages/files/csv.ijs'
script_z_ '~system/main/dates.ijs'
script_z_ '~system/main/dir.ijs'
script_z_ '~system/main/dll.ijs'
script_z_ '~system/main/files.ijs'
script_z_ '~addons/general/inifiles/inifiles.ijs'
script_z_ '~system/packages/files/keyfiles.ijs'
script_z_ '~addons/convert/misc/md5.ijs'
script_z_ '~addons/media/platimg/platimg.ijs'
script_z_ '~system/classes/plot/plot.ijs'
script_z_ '~system/packages/stats/random.ijs'
script_z_ '~addons/data/sqlite/sqlite.ijs'
script_z_ '~addons/data/sqlite/def.ijs'
script_z_ '~system/main/strings.ijs'
script_z_ '~addons/tables/tara/tara.ijs'
script_z_ '~system/packages/misc/task.ijs'
script_z_ '~system/packages/winapi/winapi.ijs'
script_z_ '~addons/arc/zip/zfiles.ijs'

coclass 'rgsselectj'

require 'files'
COBASE_z_=. coname ''  
(COBASE,<'z') copath 'base' 

coclass 'z'  
ContentDisp=: 3 : 0
  if. 0 <: nc<'ContentDispSet_j_' do. return. end.
  ContentDispSet_j_=: y
  println 'Content-Disposition: attachment; filename=',y
)

fext=:'.'&(i:~}.]) 
fname=: PATHSEP_j_&(>:@i:~}.])
isJHP=: (;:'jhp asp') e.~ [:<fext
transfer=: 3 : 0
  '' transfer y
  :
  'fpth fnme'=.2{. boxopen y
  
  myext=. fext fpth
  ctype=. myext keyval makeTable MimeMap 
  select. myext
  case. '.jhp';'.asp' do.
	Expires 0
    ContentType ctype
    markup fpth
  case. do.
    Expires 0
    if. *#fnme do. ContentDisp fnme end.
    ContentType ctype
    if. *#x do.
      stdout x
    else.
      stdout fread jpath fpth
    end.
  end.
)

Note 'CGI Testing'
CGIKEYS=: <;._1 '|action|flkdams2sire|cullage|cullage|mateage|mateage|trtsrecorded|trtsrecorded|trtsrecorded|trtsrecorded|trts2select|trts2select|trts2select|objectvrevs|objectvrevs|objectvrevs|selnmeth|trts2summ|trts2summ|trts2summ|trts2summ|trts2summ|summtype|summtyp'
CGIVALS=: <;._1 '|chgparams|50|8|8|2|2|NLB|LW8|FW12|FD|NLB|LW8|FD|5|3|-4|genDe|NLB|LW8|FW12|FAT|LEAN|phen|genD'

CGIKEYS=: <;._1 '|action|Upld_fem|Upld_male'
CGIVALS=: <;._1 '|uploadSL|Tag,Flk,YOB,Mtd,AOD,BR,DOB,pLW8,pFD,pFAT,pLEAN  200400274,1,2004,12,3,1,-0.9,48.95325177,4.030984783,,  200100346,1,2001,11112,2,1,-6.3,48.86565182,4.271521078,,  200100370,1,2001,11112,1,1,5.3,46.89300694,4.762921181,,  200100343,1,2001,11112,3,1,-0.6,46.17547369,3.455460892,,  200500074,1,2005,1,4,1,-12.1,46.05296769,5.341503248,,  200200331,1,2002,1112,4,1,-1.1,45.39484645,4.142378276,,  200500028,1,2005,1,1,1,3.9,38.67851262,1.56124158  199900425,1,1999,1111112,3,2,-2.8,34.83060492,1.756794846  200200332,1,2002,1112,2,2,6,34.79601909,3.198942513  200500079,1,2005,1,1,2,6.5,34.79466461,3.741469411  200500072,1,2005,1,4,1,-1.9,34.69026073,3.489232777  200500085,1,2005,1,4,1,8.4,32.873602,1.026880573  200500004,1,2005,1,3,2,-1.4,32.70060414,2.662249756  200500044,1,2005,1,2,2,0.1,32.62690318,2.856263165  199900439,1,1999,1111112,3,1,14,32.6039013,3.401926152  200500009,1,2005,1,3,1,-2.7,32.55296755,0.981724313  200400244,1,2004,12,1,2,-3.5,32.46166876,2.770021921  200500070,1,2005,1,1,1,-6.2,32.37781276,3.188548712  200500092,1,2005,1,1,2,-3.9,32.3485021,4.505456237  200100366,1,2001,11112,3,2,8.7,32.27643367,2.598342709  200500091,1,2005,1,4,2,3.5,32.22780809,1.8170505  200200324,1,2002,1112,2,2,6.3,32.05034764,3.000975391  200300277,1,2003,112,1,1,-0.6,31.99438592,2.940832441  200500100,1,2005,1,4,2,6.3,31.96962864,4.320502691  200500008,1,2005,1,2,1,5.5,31.96679559,1.796884848  |Tag,Flk,YOB,Mtd,AOD,BR,DOB,pLW8,pFD,pFAT,pLEAN  200500174,1,2005,1,4,1,-1.5,49.27337484,3.324896691,,  200500148,1,2005,1,2,1,-2.3,49.14943999,5.410582075,,  200300442,1,2003,112,4,1,0.8,48.90579541,2.810506745,,  200500126,1,2005,1,3,2,4.6,46.94914573,2.853458612,,  '
CGIFILES=: <;._1 '||SelectLstFEM.csv|SelectLstMALE-1.csv'
CGIMIMES=: <;._1 '||application/csv|application/csv'

parseQRY=: 3 : '<"1|:> <;._1 each ''='',each <;._1 ''&'',y'
'CGIKEYS CGIVALS' =. parseQRY 'ciids=1&ciids=2&ciids=13&trts=NLB&trts=FW12&trts=FD&inftyps=genD'
)
postrequest=: 4 : 0
  uri=. x
  qs=. args y
  host=. ([:'http://'&-:7&{.) {:: (env 'SERVER_NAME'); 0 ({:: <;._1) 6 }. ]
  path=. ( '/' dropto 7 }. ])^:([:'http://'&-:7&{.)
  println 'POST ',(path uri),' HTTP/1.0'
  println 'Host: ',host uri
  println 'Content-Length: ',":#qs
  Expires 0
  ContentType 'application/x-www-form-urlencoded'
  stdout qs
)

redirect=: 3 : 0
  '' redirect y
:
  url=.y
  qs=. ('?',args)^:(*@#) x
  println 'Location: ',url,qs
  ContentType'text/html'
)

refresh=: 3 : 0
  uri=.y
  
  println 'Refresh: 0; url=',uri
  ContentType'text/html'
)
safe=: (33}.127{.a.)-.'=&%+'
encode=:  [: toupper ('%',(I.'6'=,3!:3'f') {&, 3!:3)
urlencode=:  [: ; encode^:(safe -.@e.~ ])&.>
nvp=: >@{.,'=',urlencode@":@>@{:
args=: [: }.@; ('&'<@,nvp)"1
MimeMap=: 0 : 0
.*            application/octet-stream
.323          text/h323
.acx          application/internet-property-stream
.ai           application/postscript
.aif          audio/x-aiff
.aifc         audio/aiff
.aiff         audio/aiff
.application  application/x-ms-application
.asf          video/x-ms-asf
.asp          text/html
.asr          video/x-ms-asf
.asx          video/x-ms-asf
.au           audio/basic
.avi          video/x-msvideo
.axs          application/olescript
.bas          text/plain
.bcpio        application/x-bcpio
.bin          application/octet-stream
.bmp          image/bmp
.c            text/plain
.cat          application/vndms-pkiseccat
.cdf          application/x-cdf
.cer          application/x-x509-ca-cert
.clp          application/x-msclip
.cmx          image/x-cmx
.cod          image/cis-cod
.cpio         application/x-cpio
.crd          application/x-mscardfile
.crl          application/pkix-crl
.crt          application/x-x509-ca-cert
.csh          application/x-csh
.css          text/css
.csv          application/octet-stream
.dcr          application/x-director
.deploy       application/octet-stream
.der          application/x-x509-ca-cert
.dib          image/bmp
.dir          application/x-director
.disco        text/xml
.dll          application/x-msdownload
.doc          application/msword
.dot          application/msword
.dvi          application/x-dvi
.dxr          application/x-director
.eml          message/rfc822
.eps          application/postscript
.etx          text/x-setext
.evy          application/envoy
.exe          application/octet-stream
.fif          application/fractals
.flr          x-world/x-vrml
.gif          image/gif
.gtar         application/x-gtar
.gz           application/x-gzip
.h            text/plain
.hdf          application/x-hdf
.hlp          application/winhlp
.hqx          application/mac-binhex40
.hta          application/hta
.htc          text/x-component
.htm          text/html
.html         text/html
.htt          text/webviewhtml
.ico          image/x-icon
.ief          image/ief
.iii          application/x-iphone
.ins          application/x-internet-signup
.isp          application/x-internet-signup
.IVF          video/x-ivf
.jfif         image/pjpeg
.jhp          text/html
.jpe          image/jpeg
.jpeg         image/jpeg
.jpg          image/jpeg
.js           application/x-javascript
.latex        application/x-latex
.lsf          video/x-la-asf
.lsx          video/x-la-asf
.m13          application/x-msmediaview
.m14          application/x-msmediaview
.m1v          video/mpeg
.m3u          audio/x-mpegurl
.man          application/x-troff-man
.manifest     application/x-ms-manifest
.mdb          application/x-msaccess
.me           application/x-troff-me
.mht          message/rfc822
.mhtml        message/rfc822
.mid          audio/mid
.mmf          application/x-smaf
.mny          application/x-msmoney
.mov          video/quicktime
.movie        video/x-sgi-movie
.mp2          video/mpeg
.mp3          audio/mpeg
.mpa          video/mpeg
.mpe          video/mpeg
.mpeg         video/mpeg
.mpg          video/mpeg
.mpp          application/vnd.ms-project
.mpv2         video/mpeg
.ms           application/x-troff-ms
.mvb          application/x-msmediaview
.nc           application/x-netcdf
.nws          message/rfc822
.oda          application/oda
.ods          application/oleobject
.p10          application/pkcs10
.p12          application/x-pkcs12
.p7b          application/x-pkcs7-certificates
.p7c          application/pkcs7-mime
.p7m          application/pkcs7-mime
.p7r          application/x-pkcs7-certreqresp
.p7s          application/pkcs7-signature
.pbm          image/x-portable-bitmap
.pdf          application/pdf
.pfx          application/x-pkcs12
.pgm          image/x-portable-graymap
.pko          application/vndms-pkipko
.pma          application/x-perfmon
.pmc          application/x-perfmon
.pml          application/x-perfmon
.pmr          application/x-perfmon
.pmw          application/x-perfmon
.png          image/png
.pnm          image/x-portable-anymap
.pnz          image/png
.pot          application/vnd.ms-powerpoint
.ppm          image/x-portable-pixmap
.pps          application/vnd.ms-powerpoint
.ppt          application/vnd.ms-powerpoint
.prf          application/pics-rules
.ps           application/postscript
.pub          application/x-mspublisher
.qt           video/quicktime
.ra           audio/x-pn-realaudio
.ram          audio/x-pn-realaudio
.ras          image/x-cmu-raster
.rgb          image/x-rgb
.rmi          audio/mid
.roff         application/x-troff
.rtf          application/rtf
.rtx          text/richtext
.scd          application/x-msschedule
.sct          text/scriptlet
.setpay       application/set-payment-initiation
.setreg       application/set-registration-initiation
.sh           application/x-sh
.shar         application/x-shar
.sit          application/x-stuffit
.smd          audio/x-smd
.smx          audio/x-smd
.smz          audio/x-smd
.snd          audio/basic
.spc          application/x-pkcs7-certificates
.spl          application/futuresplash
.src          application/x-wais-source
.sst          application/vndms-pkicertstore
.stl          application/vndms-pkistl
.stm          text/html
.sv4cpio      application/x-sv4cpio
.sv4crc       application/x-sv4crc
.t            application/x-troff
.tar          application/x-tar
.tcl          application/x-tcl
.tex          application/x-tex
.texi         application/x-texinfo
.texinfo      application/x-texinfo
.tgz          application/x-compressed
.tif          image/tiff
.tiff         image/tiff
.tr           application/x-troff
.trm          application/x-msterminal
.tsv          text/tab-separated-values
.txt          text/plain
.uls          text/iuls
.ustar        application/x-ustar
.vcf          text/x-vcard
.wav          audio/wav
.wbmp         image/vnd.wap.wbmp
.wcm          application/vnd.ms-works
.wdb          application/vnd.ms-works
.wks          application/vnd.ms-works
.wmf          application/x-msmetafile
.wps          application/vnd.ms-works
.wri          application/x-mswrite
.wrl          x-world/x-vrml
.wrz          x-world/x-vrml
.wsdl         text/xml
.xaf          x-world/x-vrml
.xbm          image/x-xbitmap
.xla          application/vnd.ms-excel
.xlc          application/vnd.ms-excel
.xlm          application/vnd.ms-excel
.xls          application/vnd.ms-excel
.xlt          application/vnd.ms-excel
.xlw          application/vnd.ms-excel
.xml          text/xml
.xof          x-world/x-vrml
.xpm          image/x-xpixmap
.xsd          text/xml
.xsl          text/xml
.xwd          image/x-xwindowdump
.z            application/x-compress
.zip          application/x-zip-compressed
)

coclass COBASE_z_  
listatom=: 1&#
boxopenatoms=:<"0^:(L.=0:)
mfv1=: ,:^:(#&$ = 1:)
idxfnd=: i. #~ i. < [: # [
loc_z_=: 3 : '> (4!:4 <''y'') { 4!:3 $0'
join=: ' '&$. : (4 : '(;@(#^:_1!.(<x))~  1 0$~_1 2 p.#) y')  
dquote=: '"'&, @ (,&'"')
vfms=: [: }. [: , ' ' ,. ] 

makeTable=: [: > [: <;._1 each ' ',each [: <;._2 (deb@:toJ ]) , LF -. {:
boxitem=: ,`(<"_1) @. (0=L.)
setcolnames=: 3 : 0
  if. y-:i.0 0 do. return. end.
  'hdr dat'=. split y
  (hdr)=: |:dat
  ''
)
coercetxt=: 3 : 0
  isboxed=.0<L. y
  y=. boxopen y
  msk=. -.isnum @> y
  newnums=. 0&coerce each msk#y
  y=.[newnums (I.msk)}y 
  if. -.isboxed do. >y end. 
)

keyval=: ''&$: : (4 : 0)     
  if. (#y) > i=. ({."1 y) i. <,>x do.
    (<i,1) {:: y else. '' end.
)
createSession=: 3 : 0
 if. isdefseed_rgspasswd_'' do. randomize'' end.
 sid=. >:?<:-:2^32 
 sh=. salthash ":sid 
 'newsession' insertInfo  sid;y;sh
 tk=. writeTicket sid;{:sh
)
expireSession=: 3 : 0
  if.0=#y do. y=. qcookie 'SessionTicket' end.
  sid=.0{:: readTicket y
  'expiresession' updateInfo ".sid
)
isActive=: 3 : 0
  s=. 'userstatus' getInfo y
)
readTicket=: 3 : 0
  kVTable=. qsparse y  
  sid=.'ssid' keyval kVTable
  shash=. 'hash' keyval kVTable
  sid;shash
)

registerUser=: 3 : 0
  'action uname fname lname refnum email passwd'=.y
  if. action-:'guest' do. uname=. randPassword 16  end.
  if. *#'userlogin' getInfo uname  do. _2 return. end. 
  if. 0=# pid=. 'idfromemail' getInfo email  do. 
    pid=. 'newperson' insertInfo fname;lname;email 
  end.
  sph=. salthash passwd 
  uid=.'newuser' insertInfo pid;uname;refnum;|.sph 
)
updateSession=: 3 : 0
  if.0=#y do. y=. qcookie 'SessionTicket' end.
  sid=.0{:: readTicket y
  'extendsession' updateInfo ".sid
)
validCase=: 3 : 0
  if. 0-: uofid=.validEnrolment'' do. 0 return. end.
  uofid validCase y
:
  if. 0=#y do. y=.0 qcookie 'CaseID' end.
  vldcs=.'validcase' getInfo x,<y
  if. #vldcs do. x,<y else. 0 end.
)
validEnrolment=: 3 : 0
  if. 0-: uid=.validSession'' do. 0 return. end.
  uid validEnrolment y
:
  if. 0=#y do. y=. 0 qcookie 'OfferingID' end.
  enrld=.'enrolled' getInfo x;y
  if. #enrld do. x;y else. 0 end.
)
validLogin=: 3 : 0
 'usrnme passwd'=. y
  if. 0=# usrnme do. _1 return. end. 
  uinfo =. 'userlogin' getInfo usrnme  
  if. 0=# uinfo   do. _2 return. end.   
  'duid dunme dhash dsalt' =. 4{.uinfo
  if. -. dhash-: _1{::dsalt salthash passwd do. _3 return. end. 
  duid
)
validSession=: 3 : 0
  if. 0=#y do. y=. qcookie 'SessionTicket' end.
  'sid shash'=. readTicket y
  sinfo=.'sessioninfo' getInfo sid
  if. 0=#sinfo do. 0 return. end. 
  'hdr dat'=. split sinfo         
  (hdr)=. |:dat                   
  if. -. shash -: 1{::ss_salt salthash sid do. 0 return. end.
  if. timeleft<0 do. 
    'expiresession' updateInfo sid
    0
  else.
    'extendsession' updateInfo sid
    ss_urid
  end.
)
writeTicket=: 3 : 0
  'tsid thash'=.y
  ('ssid=',":tsid),'&hash=',thash
)

cleanGuests=: 3 : 0
  ginfo=. 'expiredguests' getInfo ''
  if. 0=#ginfo do. 0 return. end. 
  'hdr dat'=. split ginfo
  (hdr)=. |:dat                   
  if. *#ss_id do.
    'expiresession' updateInfo boxopenatoms ss_id
  end.
  resetUsers ur_id
  ''
)
resetUsers=: 3 : 0
  if. *#y do.
    urids=. boxopenatoms y
    cids=. 'caseinst2expire' getInfo urids
    resetCaseInsts cids
    deleteUserFolders y 
    'resetusers' updateInfo urids
    ''
  end.
)
resetCaseInsts=: 3 : 0
  if. *#y do.
    ciids=. boxopenatoms y
    'expirecaseinst' updateInfo ciids
    'delstoredcaseinst' updateInfo ciids
    ''
  end.
)

setUsers=: 3 : 0
  if. *#y do.
    'setusers' updateInfo y
    ''
  end.
)
deleteUsers=: 3 : 0
  if. *#y do.
    deleteUserFolders y 
    'deleteusers' updateInfo boxopenatoms y
    ''
  end.
)
createCaseInstance=: 3 : 0
  ciid=. 'newcaseinstance' insertInfo y
  uz=. createCaseInstFolder ciid
  
  ciid
)
createCaseInstFolder=: 3 : 0
  zippath=. 'scendefpath' getFnme y
  newpath=. 'caseinstpath' getFnme y
  uz=. newpath unziptree zippath 
)
getCaseInstance=: 3 : 0
  if. 0=#y do.
    if. 0-: uofcsid=. validCase'' do. 0 return. end.
  else.
    uofcsid=. y
  end.
  ciid=. 'caseinstanceid' getInfo uofcsid
  if. #ciid do.
    ciid
  else. 
    ciid=. createCaseInstance uofcsid
  end.
)
updateCaseStage=: 3 : 0
  'casestage' updateInfo y
)
storeCaseInstance=: 3 :0
  nms=. <"1&dtb"1 'sumryfiles' getFnme y 
  zipnm=. 'sumryzippath' getFnme y  
  dirinf=. '' 
  z=. (zipnm;dirinf) zipfiles nms
  if. (#nms)={:z do. 
    'storecaseinst' updateInfo y  
  end.
)
deleteStoredCaseInst=: 3 :0
  if. *#y do.
    zipnm=. 'sumryzippath' getFnme y
    kfnm=. 'ijf',~_3}. zipnm
    ferase zipnm;kfnm
    if. -. fexist zipnm do.
      'delstoredcaseinst' updateInfo y  
    end.
    ''
  end.
)
cleanStoredKeyFiles=: 3 :0
  pth=. getpath_j_ ,'userfolderpath' getFnme 1 
  kfls=. 2{."1 dirtree pth,'*.ijf'
  if. #kfls do.
    oldmsk=. (4%365)<,(3{. 6!:0 '')&tsdiff&(3&{.) every 1{"1 kfls
    kfls=. oldmsk# {."1 kfls
    ferase kfls
  end.
)

expireCaseInstance=: 3 : 0
  'expirecaseinst' updateInfo y
  deleteCaseInstFolder y
)
deleteCaseInstFolder=: 3 : 0
  delpath=. 'caseinstpath' getFnme y
  res=.deltree delpath
  if. 1=*./res do. 1 else. 0 end.
)
deleteUserFolders=: 3 : 0
  delpath=. ,each 'userfolderpath'&getFnme each y
  res=.deltree every delpath
  if. 1=*./res do. 1 else. 0 end.
)
updateSelnDetails=: 3 : 0
  CGIKEYS=: 1&transName each CGIKEYS 
  ANIMINI_z_=: 'animini' getInfo y
  TRTINFO_z_=: 'trtinfoall' getInfo y
  
  keyscalc=. ;:'Trts2Sim Phens2Sim EBVs2Sim GetEBVs SelectListCols Respons2Outpt'
  keyscalc=. keyscalc,;:'ObjectvTrts ObjectvREVs'
  keysform=. ~. qparamKeys'' 
  keysini=. 1{"1 ANIMINI  
  keys2upd8=. ~.(tolower each keyscalc),(keysform e. keysini)#keysform 
  keysform updateKeyState"1 0 keys2upd8
  ANIMINI_z_=: (; (<ANIMINI) getIniIdx each keys2upd8){ANIMINI 
  'animini' updateScenarioInfo y 
)
TransNames=: makeTable 0 : 0
animsummaryfnme  animsumrypath
curryear         currcycle
flkdams2sire     dams2hrdsire
flksizes         hrdsizes
flkspecfnme      hrdspecfnme
mateallocfnme    mateallocpath
pedigreefnme     pedigreepath
sampleflkeffects samplehrdeffects
selnlistfnme     selnlistpath
traitinfofnme    trtinfopath
usesiresxflk     usesiresxhrd
flocks           herds
flock            herd
flk              hrd
)
transType=: TransNames |."1~]
transName=: (]keyval [:transType [)^:( (TransNames{"1~[) e.~ [: boxopen ])

getIniVals=: 4 : 0
  x getIniValue 1 transName y
)

getIniIdx=: 4 : 0
 'idx ini'=. 2{.!.a: x getIniIndex 1 transName y
  idx
)
prefsuf=: [:,<@;@(1&C.)@,"1 0/
makeTrtColLbl=: 3 : 0
  ('phen';'genD';'genDe') makeTrtColLbl y
:
  ps=. ('phen';'genD';'genDe') e. boxopen x
  ps=. ps# ('p';''),('g';'d'),:('g';'de')
  z=. ps prefsuf boxopen y 
)
sortTrtColLbl=: ] /: ,@|:@i.@[
getTrtBase=: ((<'pgde') -.&.>~ ])
getTrtsOnly=: ] #~ 'pg' e.~ {.@>
getTrtsNot=:  ] #~ [: -. 'pg' e.~ {.@>
getTrtInfoTyps=: 3 : 0
  lst=. {:&>y
  msk=. 0 e. lst e. 'de'
  msk=. msk, 'de' e. lst
  res=. msk#{."1 INFOTYPES
)

INFOTYPES=:  (;:'phen genD genDe'),. 'Phenotypes';'Genotypes';'Estimated Breeding Values'
getTrtInfo=: 3 : 0
'TrtCaption' getTrtInfo y
:
  if. (#{.TRTINFO)=cidx=. ({.TRTINFO) i. boxopen x do. '' return. end.
  msk=. (#TRTINFO)>ridx=. ({."1 TRTINFO) i. boxopen y
  ridx=. msk#ridx
  (<ridx;cidx){TRTINFO
)
getTrtsPhn=: 3 : 0
      msk=. 9999&~:@>'AOM' getTrtInfo y 
      res=. msk#y
)
getParamState=: 3 : 0
  '' getParamState y
  :
  seld=. vals=. nmes=. a:  
  select. y
    case. 'coltypes' do.
      seld=. <'phen'
      vals=. {."1 INFOTYPES
      nmes=. {:"1 INFOTYPES
    case. 'cullage' do.
      vals=. <"0 ANIMINI getIniVals y
      nmes=. 'Female';'Male'
    case. 'hrdsizes'    do.
      vals=. <"0 ANIMINI getIniVals y
      if. 1 do. 
        seld=. boxopen vals
        vals=. <"0 (100,200*>:i.5), 1500 2000 4000
      end.
    case. 'mateage' do.
      vals=. <"0 ANIMINI getIniVals y
      nmes=. 'Female';'Male'
    case. 'objectvrevs' do.
      nmes=. ANIMINI getIniVals 'trtsavail' 
      vals=. (#nmes)#a:
      tmpv=. <"0 ANIMINI getIniVals y
      tmpn=. 0{:: getParamState 'trts2select'
      vals=. tmpv (nmes i. tmpn)}vals
    case. 'selnmeth'    do.
      'seld vals nmes'=. getParamState 'coltypes'
      tmp=. ANIMINI getIniVals 'selectlistcols'
      tmp=. getTrtsOnly tmp 
      tmp=. {:>{:tmp  
      seld=. ('ed' i. tmp){ |.vals 
    case. 'summtype'    do.
      'seld vals nmes'=. getParamState 'coltypes'
      tmp=. ANIMINI getIniVals'respons2outpt'
      tmp=. getTrtsOnly tmp 
      seld=. getTrtInfoTyps tmp  
    case. 'trtsrecorded' do.
      vals=. ANIMINI getIniVals 'trtsavail'
      vals=. getTrtsPhn vals
      nmes=. 'TrtCaption' getTrtInfo vals
      seld=. ANIMINI getIniVals y
    case. 'trts2select';'trts2summ' do.
      vals=. ANIMINI getIniVals 'trtsavail'
      nmes=. 'TrtCaption' getTrtInfo vals
      nmes=. ('(',each vals ,each <') '),each nmes
      tmp=. (('trts2select';'trts2summ')i. boxopen y) { 'selectlistcols';'respons2outpt'
      tmp=. ANIMINI getIniVals tmp
      tmp=. getTrtsOnly tmp  
      tmp=. tmp -. each <'pdge' 
      seld=. ~. tmp 
    case. do. 
    
      vals=. ANIMINI getIniVals y
      if. isnum vals do. vals=. <"0 vals end.
      vals=. boxopen vals  
  end.
  seld;vals;<nmes
)
updateKeyState=: 4 : 0
  key2upd8=. >y
  select. key2upd8
    case. 'ebvs2sim'  do.
    
      msk=. (<'genDe') e."0 1> qparamList each 'selnmeth';'summtype'
      frmtrts=. msk#'trts2select';'trts2summ'
    
      notset=. -.frmtrts e. x
      initrts=. notset# msk#'selectlistcols';'respons2outpt'
      initrts=. getTrtBase getTrtsOnly ;(<ANIMINI) getIniVals each initrts
      frmtrts=. ;qparamList each frmtrts
      kval=. ~.frmtrts,initrts
    case. 'getebvs'   do.
    
      kval=. qparamList key2upd8
      if. ''-:kval do. 
        frmflds=. 'selnmeth';'summtype'
        notset=. -.frmflds e. x
        iniflds=. notset# 'selectlistcols';'respons2outpt'
        isebv=. 'e' e. {:@>getTrtsOnly ;(<ANIMINI) getIniVals each iniflds
        kval=. +./isebv,(<'genDe') e."0 1> qparamList each frmflds
        key2upd8=. (*./notset){:: key2upd8;'' 
      end.
    case. 'objectvrevs'    do.
      if. (<'objectvrevs') e. x do.
        kval=. qparamList key2upd8
      else.
        if. (<'trts2select') e. x do. 
          kval=. (# qparamList 'trts2select')#1 
        else. key2upd8=. 'NOTAVALIDKEY' end. 
      end.
    case. 'objectvtrts'    do.
      if. (<'trts2select') e. x do. 
        trts=. qparamList 'trts2select'
        if. (<'selnmeth') e. x do.
          sm=. qparamList 'selnmeth'
        else. sm=. <'phen' end. 
        kval=. sm makeTrtColLbl trts 
        kval=. (<'BR') (kval ((([: # [) > [ i. [: < ]) # [ i. [: < ]) 'pNLB')} kval 
      else. key2upd8=. 'NOTAVALIDKEY' end. 
    case. 'phens2sim' do.
    
      frmtyps=. 'selnmeth';'summtype'
      notset=. -.frmtyps e. x
      msk=. (<'phen') e."0 1> qparamList each 'selnmeth';'summtype'
      msk=. notset +. msk
      frmtrts=. (<'trtsrecorded'),msk#'trts2select';'trts2summ'
    
      notset=. -.frmtrts e. x
      initrts=. notset# (<'trtsrecorded'),msk#'selectlistcols';'respons2outpt'
      initrts=. getTrtBase getTrtsOnly ;(<ANIMINI) getIniVals each initrts
      frmtrts=. ;qparamList each frmtrts
      kval=. getTrtsPhn ~.(<'NLB'),frmtrts,initrts  
    case. 'respons2outpt'  do.
      if. (<'trts2summ') e. x do. 
        trts=. qparamList 'trts2summ'
        if. (<'summtype') e. x do.
          st=. qparamList 'summtype'
        else. st=. 'phen';'genD' end. 
        kval=. st makeTrtColLbl trts 
      else. key2upd8=. 'NOTAVALIDKEY' end.
    case. 'selectlistcols' do.
      if. (<'trts2select') e. x do. 
        trts=. qparamList 'trts2select'
        if. (<'selnmeth') e. x do.
          sm=. qparamList 'selnmeth'
        else. sm=. <'phen' end. 
        trtflds=. sm makeTrtColLbl trts 
        nttrt=. getTrtsNot ANIMINI getIniVals key2upd8 
        kval=. nttrt,trtflds
      else. key2upd8=. 'NOTAVALIDKEY' end.
    case. 'trts2sim' do.
    
      frmtrts=. ;:'trtsrecorded trts2select trts2summ'
    
      notset=. -. frmtrts e. x
      initrts=. notset# ;:'trtsrecorded selectlistcols respons2outpt'
      initrts=. getTrtBase getTrtsOnly ;(<ANIMINI) getIniVals each initrts
      frmtrts=. ;qparamList each frmtrts
      kval=. ~.frmtrts,initrts
    case. do. 
      kval=. qparamList key2upd8
  end.
  if. -. key2upd8-:'NOTAVALIDKEY' do.
    ANIMINI=: ANIMINI updateIniStrings kval;key2upd8
  end.
  ''
)

makeMateAlloc=: 4 : 0
  okexist=. -.a:= fnms=. {."1 y  
  okext=. '.csv'(-:"1) _4&{.@> fnms  
  
  msg=. 'selection list doesn''t exist.';'selection list file extension is not ".csv".'
  msg=. |:2 2$(,.'Female ';'Male ') prefsuf msg
  if. *./*./ok=. okexist,:okext do. 
    fcs=. fixcsv each toJ each {:"1 y 
    hdrs=. {.!.a: each fcs 
    fcs=. }.each fcs 
    
    okhdr=. (([: +./"1('Flk';'Flock')&e."1)*.[: +./"1('uid';'Tag')&e."1) >hdrs
    ms=. boxopen 'selection list does not contain "Tag" and/or "Flk" column labels.'
    msg=. msg, (,.'Female ';'Male ') prefsuf ms
    if. *./*./ok=. ok,okhdr do. 
      ANIMINI_z_=. 'animini' getInfo x
      'ndams d2s xhrd'=. (<ANIMINI) getIniVals each ('hrdsizes';'dams2hrdsire';'usesiresxhrd')
      nsires=. <.0.5&+ ndams%d2s   
      
      idx=. <"0 <./"1 (>hdrs) i."1 'Flk';'Flock' 
      hrds=. idx {"1 each fcs 
      nprnts=. (([: #@> </.~) /: ~.) each hrds 
      okf=. (listatom ndams)-: nfems=. 0{::nprnts 
      okm=. *./3>|nsires- nmales=. _1{::nprnts 
      ms=. 'Female selection list contained ',(":nfems),' animals, there should be ',(":ndams),'.'
      msg=. msg, ms;'Male selection list contained ',(":nmales),' animals, there should be approximately ',(":nsires),'.'
      ok=. ok,okf,okm
    end.
  end.
  if. *./*./ok do. 
    fpth=. 'mateallocpath' getFnme x
    dat=. xhrd allocateMatings hdrs,.fcs
    ok=. 0<(;dat) writecsv fpth
    msg=. ok{:: 'Error writing Mate Allocation file';1
  else.
    msg=. (,-.ok)#,msg
  end.
)
allocateMatings=: 4 : 0
  lbls=. >{."1 y
  slsts=. {:"1 y
  idx=. (({:$lbls)>idx)#"1 idx=.lbls i."1 'Tag';'uid';'Flk';'Flock'
  parents=. (<"1 idx) {"1 each slsts 
  if. x do. 
    nparents=. # @> parents
  else.     
    nparents=. (([: #@> </.~) /: ~.) @> 1{"1 each parents 
  end.
  nsiremtgs=. <. %/nparents
  rem=. |/|.nparents 
  rem=. (,rem,.rem-~{:nparents)# (+:#rem)$1 0
  mtgs=. rem+({:nparents)#nsiremtgs
  parents=. parents /: each |."1 each parents  
  sires=. mtgs#>{:parents
  sires=. sires /: x}."1 (1{"1 sires),.<"0 (#sires)?@#0 
  (;:'DTag DFlk STag SFlk');< (>{.parents),.sires
)
breedPopln=: 3 : 0
  stge=. (>:checkCycle y){1 21 99
  if. stge<99 do.   
    msg=. y validMateAlloc stge
    if. 1-:msg do. 
      if. okansim=. runAnimalSim y do.
        if. stge=1 do.
          inipath=. 'animinipath' getFnme y
          writeIniStrings 1;'Resume';'Control';inipath
        end.
        stge=. (>:checkCycle y){1 21 99
        updateCaseStage stge;y
        msg=. 1
      else.     
        msg=. 'There was an error running AnimalSim.'
      end.
    end.
  else. msg=. 0 
  end.
  msg
)
validMateAlloc=: 4 : 0
  if. y=21 do. 
    okexist=. fexist fnme=. 'mateallocpath' getFnme x
    msg=. boxopen 'Mate Allocation list not found.<br/>Did you upload your selected parents?'
    if. *./ok=. okexist do. 
      ma=. readcsv fnme
      oklen=. *# ma 
      'hdr ma'=. split ma
      ANIMINI_z_=. 'animini' getInfo x
      'popsz cage mage'=. (<ANIMINI) getIniVals each 'hrdsizes';'cullage';'mateage'
      oknmtgs=. (#ma)=+/popsz
      
      
      
      slsts=. <@readcsv"1 'selnlistpath' getFnme x
      lbls=. >{.each slsts 
      slsts=. }.each slsts 
      idx=. (({:$lbls)>idx)#"1 idx=.lbls i."1 'Tag';'uid';'Flk';'Flock'
      slsts=. (<"1 idx) {"1 each slsts   
      okf=. *./( 2{."1 ma) e. 0{:: slsts 
      okm=. *./(_2{."1 ma) e. 1{:: slsts 
      okanims=. *./okf,okm
      msg=. msg,<'Mate Allocation file is zero length.'
      msg=. msg,<'Incorrect number of matings in Mate Allocation file.'
      msg=. msg,<'There are animals in the Mate allocation list, that were not in the selection lists. Have you uploaded new selection lists for this cycle?'
      ok=. ok,oklen,oknmtgs,okanims
    end.
  else. ok=. 1  
  end.
  if. *./ok do.
    msg=. 1
  else.
    msg=. (,-.ok)#,msg
  end.
)
checkCycle=: 3 : 0
  'crcyc ncyc'=. 'caseprogress' getInfo y
  issm=. fexist 'animsumrypath' getFnme y
  res=. (issm *. crcyc = ncyc)-crcyc=0
)
runAnimalSim=: 3 : 0
  inipath=. 'animinipath' getFnme y
  if. -.fexist inipath do. 0 return. end.
  crcyc=. getIniValue key=. (1&transName 'currcycle');'GenCycle';inipath
  _1 fork '"c:\program files\animalsim\animalsim" ',inipath
  if. fexist  'errorlog.txt',~ cifldr=. 'caseinstpath' getFnme y do. 
    if. crcyc< getIniValue key do.
      writeIniStrings crcyc;key  
    end.
    0
  else.
    1
  end.
)

Note 'test data'
keylbls=. ;:'YOB'
trtlbls=. ;:'NLB LW8 FW12 FD LEAN FAT'
inftyps=. ;:'phen genD'
csinsts=. 1 2 3
keylbls=. ;:'YOB'
trtlbls=. ;:'NLB WWT LW8 FW12'
inftyps=. ;:'phen'
csinsts=. 1 2

datlbls=. ((#trtlbls),#inftyps) sortTrtColLbl inftyps makeTrtColLbl trtlbls
(keylbls;< datlbls) plotSummaries csinsts
)
sumSummaryCSV=: 4 :0
  'keylbls datlbls'=. x
  'hdr invtble'=. 'animsumry' getInfo y
  keyidx=. hdr idxfnd keylbls 
  key=. listatom keyidx{invtble  
  datidx=. hdr i. datlbls
  dat=. 0".each datidx{(<@((,.'0') #~ ttally),~]) invtble 
  sum=. key tkeytble (<tfreq key),key tkeyavg dat 
  ini=. 'animini' getInfo y
  yr0=. ini getIniString 'yearzero' 
  strt=. ((keylbls i. <'YOB'){tnub key) tindexof boxopen yr0
  if. (#datlbls)>idx=.datlbls i.<'pNLB' do. 
    
    popsz=. +/ ini getIniValue 1 transName 'hrdsizes' 
    sum=. (<popsz %~ tfreq key ) (idx+>:#keyidx)}  sum
  end.
  sum=. strt}. each sum  
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

preplotsummry=: 4 :0
  collbls=. {.{. every x 
  keylen=. collbls i. <'Freq'
  data=. {: each x
  X=. 0". &> each keylen{.each data
  Y=. > each (>:keylen)}. each data 
  Y=. ;,.each/ <"1 each Y  
  inftyps=. getTrtInfoTyps getTrtsOnly collbls
  inftyps=. >inftyps
  
  
  
  
  
  trtnms =. >~.getTrtBase getTrtsOnly collbls 
  cinms=. 'caseinstname' getInfo  boxopenatoms y
  cinmsidx=. 0=# every {."1 }. cinms
  cinms=. >(<"1 (i.<:#cinms),.cinmsidx){}.cinms
  fnme=. ('sumryfolderpath' getFnme ;{.y),'sumryplot.pdf'
  res=. (trtnms;inftyps;cinms;fnme) ;< X;<Y
)
plotSummaries=: 4 :0 
 
 sumrys=. (<x) sumSummaryCSV each y
 
 'names data'=. (listatom sumrys) preplotsummry y
 
 names plotsummry data
 
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
plotsummry=: 3 : 0
  inftyps=. >;:'phen genD genDe' 
  ntrts  =. %/# every (1{::y);inftyps 
  trtnms =. 'Trait ',"_ 1 (8!:2) ,.>:i.ntrts
  ncis   =. >./ #every 1{::y 
  cinms  =. 'Scenario ',"_ 1 (8!:2) ,.>:i.ncis
  (trtnms;inftyps;cinms) plotsummry y
:
  'X Y'=. 2{. boxopen y
  'trtnms inftyps cinms fnme'=. mfv1 each x
  infotypes=.('phen';'Phenotype'),('genD';'Genotype'),:('genDe';'EBV')
  idx=. (<"1&dtb"1 inftyps) i. ~{."1 infotypes 
  nplots=. */#every trtnms;inftyps;cinms
  msksnull=. <"_1 +./@:*every Y 
  mskpnull=. -.+./every msksnull 
  frmt=. [: vfms dquote"1@dtb"1
  clrs=. ;:'blue red green purple fuchsia olive teal yellow tan aqua brown gray'
  pd 'reset'
  pd 'visible ',":-. IFCONSOLE  
  pd 'multi ',": (#trtnms),#inftyps
  pd 'title Comparison of Trait progress by Scenario'
  pd 'captionfont arial 13'
  pd 'xcaption ', frmt >idx { {:"1 infotypes
  pd 'ycaption ', frmt trtnms
  
  pd 'xgroup ',": mskpnull 
  
  pd 'ygroup ',": ,  idx{"1 |:({:,~])i.2, #trtnms 
  pd 'key ', frmt cinms
  pd 'keypos center top outside'
  pd 'keystyle left boxed horizontal fat'
  pd 'keycolor ',',' join (#cinms){. clrs
  xtp=. ';xticpos ',,":(] {::~ (] i. >./)@:(#&>)) X  
  allcmd=. 'type line; pensize 2;',xtp

  itmclr=. nplots$(#cinms) {. clrs
  itmclr=. (<';itemcolor '), each itmclr

  fbclr=. (nplots)$(#cinms) # idx { 'lightcyan';'mistyrose';'lemonchiffon'
  fbclr=. (<';framebackcolor '), each fbclr

  opts=. (<allcmd),each ;each <"1 itmclr,.fbclr
  
  opts=. (nplots $(#cinms){.1)<;.1 opts 
  opts=. msksnull# each opts  
  data=. ,.each/"1 (<X),. <"_1 Y
  data=. msksnull# each data
  pd ,.each/"1 opts ,. <"1 each data
  
  
  pd 'pdf ',(,fnme),' 600 400'
)
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
    y putimg~ glqall'' 
  else.
    y writeimg~ glqall''  
  end.
)

Note 'to use platimg instead of image3'
  
  
  load 'media/platimg'
  coinsert 'jgl2'
  glqall=: (|. $ [:glqpixels 0 0&,)@glqwh
  pd 'visible 0'
  pd 'isi'
  
  'tst.png' writeimg~ glqall''
  tstpng=: 'png' putimg~ glqall'' 

To resize window/image before capture use:
   glwh=: 3 : 'wd''pmovex '',(+0 0,y-glqwh_jgl2_@$@#)&.".wd''qformx'''
   glwh 4 3*200  
)


Note 'test data for plotsummry1'
  X=. i. each 6 + i.9
  Y=. X ^ each 1 + 0.3 * i.9
  Y=. (*: , +: ,: ]) each Y
  Y=. (<1 2 4 9 16 25,(0 6$0),0 1 2 3 4 5) (0)}Y
plotsummry1 X;<Y
((>'Fleece weight 12';'No. Lambs Born';'Live weight 8');(>'phen';'genD';'genDe');>'My first one';'My second version';'Base case' )plotsummry1 X;<Y

  Y=. mfv1 each <"1 data  
  X=. ((#Y)#<lbls)  
  dat=. X;<Y
  datinfo=. (>'No of Lambs Born';'Live weight 8';'Fleece weight 12';'Fat Depth';'carcass Lean';'carcass Fat');(>'phen';'genD');>'My first one'
datinfo plotsummry1 dat
)
plotsummry1=: 3 : 0
  inftyps=. >;:'phen genD genDe' 
  ntrts  =. %/# every (1{::y);inftyps 
  trtnms =. 'Trait ',"_ 1 (8!:2) ,.>:i.ntrts
  ncis   =. >./ #every 1{::y 
  cinms  =. 'Scenario ',"_ 1 (8!:2) ,.>:i.ncis
  (trtnms;inftyps;cinms) plotsummry1 y
:
  'X Y'=. 2{. boxopen y
  'trtnms inftyps cinms'=. mfv1 each x
  infotypes=.('phen';'Phenotype'),('genD';'Genotype'),:('genDe';'EBV')
  idx=. (<"1&dtb"1 inftyps) i. ~{."1 infotypes 
  frmt=. [: vfms dquote"1@dtb"1
  pd 'reset'
  pd 'visible 1'
  pd 'multi ',": (#trtnms),#inftyps
  pd 'title Comparison of Trait progress by Scenario'
  pd 'captionfont arial 13'
  pd 'xcaption ', frmt >idx { {:"1 infotypes
  pd 'ycaption ', frmt trtnms
  pd 'xgroup ',": (#idx)#0 
  
  pd 'ygroup ',": ,  idx{"1 |:({:,~])i.2, #trtnms 
  pd 'key ', frmt cinms
  pd 'keypos center top outside'
  pd 'keystyle left boxed horizontal fat'
  clrs=. ;:'blue red green purple fuchsia olive teal yellow tan aqua brown gray'
  pd 'keycolor ',',' join (#cinms){. clrs
  allcmd=. 'type line; pensize 2'
  cidx=.([: I. [: (*./"1) 0&~:) each Y 
  Y=. cidx {each Y  
  msknull=. *&#each cidx  

  itmclr=. cidx { each <clrs  
  itmclr=. ',' join each (<a:) (I.-.*#&>tstm)}tstm 
  
  itmclr=. (<'; itemcolor '), each itmclr

  fbclr=. (#Y)$ idx { 'lightcyan';'mistyrose';'lemonchiffon'
  fbclr=. (<'; framebackcolor '), each fbclr

  opts=. (<allcmd),each ;each <"1 itmclr,.fbclr
  
  opts=. msknull# each opts  
  data=. msknull# each <"1 X,.Y
  pd opts ,. data
 
  pd 'isi'
  pd 'save png'
 
)
QRYci=: ;:'animinipath caseinstpath casedetails caseinstname caseinststatus casestage paramform scendefpath txtblks'
UPDci=: ;:'casestage caseinstusrdescr delstoredcaseinst expirecaseinst storecaseinst'
INSci=: ;:'newcaseinstance'
QRYur=: ;:'caseinst2expire expiredguests usergreeting usercourses userstatus userlist username userrec'
QRYcomb=: ;:'caseinstanceid enrolled validcase'
QRYother=: ;:'idfromemail userlogin'
UPDur=: ;:'deleteusers resetusers setusers'
INSur=: ;:'newuser newperson'
QRYof=: ;:'coursecases coursedetails coursename coursesumrys'
UPDof=: ;:''
INSof=: ;:''
QRYss=: ;:'sessioninfo'
UPDss=: ;:'expiresession extendsession'
INSss=: ;:'newsession'
DBQRY=: QRYci,QRYof,QRYur,QRYss,QRYcomb,QRYother
DBUPD=: UPDci,UPDur,UPDof,UPDss
DBINS=: INSci,INSur,INSof,INSss
  DBtable   =:          ;:'casedetails caseinstname paramform'
  DBtable   =: DBtable, ;:'userlist userrec usergreeting usercourses expiredguests validcase enrolled'
  DBtable   =: DBtable, ;:'coursecases coursedetails coursename coursesumrys'
DBtable   =: DBtable, ;:'sessioninfo txtblks'
DBtablestr=: ;:'caseinstpath'
DBrow     =: ;:'casestage userlogin caseinststatus'
DBcol     =: ;:'caseinst2expire username'
DBitem    =: ;:'animinipath scendefpath caseinstanceid userstatus idfromemail'
FLQRY=: ;:'animini trtinfoall caseprogress'
FLQRY=: FLQRY, ;:'animsumry animsumrycnt ansumrycsv animsumryhdr '
FLQRY=: FLQRY, ;:'selnlistfem selnlistmale '
getInfo=: 4 : 0
  
  
  if. (boxopen x) e. DBQRY do.
    x getInfoDB y
  else. 
    (x,':query undefined') assert (boxopen x) e. FLQRY
    sts=. 'caseinststatus' getInfoDB y 
    select. <sts
      case. <0;0  do. 
        '' 
      case. <(0;1) do.  
        x getCIInfoCurr y  
      case. (1;0);<(1;1) do.  
        x getCIInfoStored y
    end.
  end.
)
updateInfo=: 4 : 0
  (x,':query undefined') assert (boxopen x) e. DBUPD
  x updateDBTable y
)
insertInfo=: 4 : 0
  (x,':query undefined') assert (boxopen x) e. DBINS
  x insertDBTable y
)

getInfoDB=: 4 : 0
  select. x
    case. DBtable do.
      res=. x getDBTable y
    case. DBtablestr do.
      res=. x getDBTableStr y
    case. DBrow do.
      res=. {: x getDBTable y
    case. DBcol do.
      res=. x getDBField y
    case. DBitem do.
      res=. x getDBItem y
    case. do. 
      (x,':querytype undefined') assert 0
  end.
  res
)
getCIInfoStored=: 4 : 0
  fnme=. <"1&dtb"1 (x,'pathSTORED') getFnme y 
  kfnme=. 'ijf',~_3}. 1{:: fnme
  ns=. (x-:'animsumry'){:: (<x);< 'animsumryhdr';'animsumrycnt'
  if. -.fexist kfnme do. keycreate kfnme end.
  if. _4-: res=. keyread kfnme;<ns do.  
    select. x
      case. 'ansumrycsv' do.
        res=. zread fnme return. 
      case. 'animsumry';'animsumryhdr';'animsumrycnt' do.
        dat=. split fixcsv toJ zread fnme
        dat=. (ifa each 1{dat) 1}dat
        res=. ((tmp=.'animsumryhdr';'animsumrycnt')i. ns){dat
        ns=. tmp
      case. 'animini' do.
        res=. dat=. <(toJ zread fnme) getIniAllSections ''
      case. 'caseprogress' do.
        ini=. 'animini' getCIInfoStored y
        dat=. ini getIniValue 1&transName 'curryear'
        res=. dat=. <dat; ini getIniValue 'ncycles'
      case. 'trtinfoall' do.
        tmp=.  (getpath_j_ 1{::fnme),'tmp.xls' 
        tmp fwrite~ zread fnme 
        res=. dat=. <'tDefn' readexcel tmp
        ferase tmp 
    end.
    s=. dat keywrite kfnme;<ns
  end.
  >^:(#=1:) res 
)
getCIInfoCurr=: 4 : 0
  fnme=. (x,'path') getFnme y
  select. x
    case. 'animini' do.
      res=. getIniAllSections fnme
    case. nms=. 'animsumry';'animsumryhdr';'animsumrycnt' do.
      dat=. split fixcsv freads fnme
      dat=. (ifa each 1{dat) 1}dat
      idx=. (nms i. boxopen x){:: 0 1;0;1
      res=. >^:(#=1:) idx{dat
    case. 'ansumrycsv' do.
      res=. freads fnme
    case. 'caseprogress' do. 
      ini=. getIniAllSections fnme
      crcyc=. ini getIniValue 1&transName 'curryear'
      ncyc=.  ini getIniValue 'ncycles'
      res=. crcyc;ncyc
    case. nms=. 'selnlistfem';'selnlistmale' do.
      fnme=. (nms i. boxopen x){ 'selnlistpath' getFnme y
      res=. freads fnme
    case. 'trtinfoall' do.  
      res=. 'tDefn' readexcel fnme
  end.
  res
)

updateScenarioInfo=: 3 : 0
  'animini' updateScenarioInfo y
  :
  infotyp=. boxopen x
  select. infotyp
    case. <'animini' do.
      fnme=. <'animinipath' getFnme y
      res=. ANIMINI writeIniAllSections fnme 
  end.
)

pathdelim=: 4 : '}.;([:x&,,)each y'  
getFnme=: 4 : 0
  is2ndlevel=. (+./('public',PATHSEP_j_) E. jpath '~CGI'){:: '~.CGI/';'~..CGI/'
  basefldr=. jpath IFCONSOLE{:: '~home/documents/web/selectj/';is2ndlevel
  
  
  select. x
    case. 'animinipath';'caseprogresspath' do.
      fdir=. 'caseinstpath' getFnme y
      fnme=. 'animinipath' getInfo y
      fnme=. fdir,fnme
    case. 'animinipathSTORED';'caseprogresspathSTORED' do.
      
      fnme=. 'animinipath' getInfo y
      zipnme=. 'sumryzippath' getFnme y
      fnme=. >fnme;zipnme
    case. 'ansumrycsvpath'; 'animsumry'&,each ('';'hdr';'cnt') ,each <'path' do.
      fkey=. 1 transName 'animsumrypath'
      fdir=. 'caseinstpath' getFnme y
      ini=. 'animini' getInfo y
      fnme=. ini getIniString fkey;'FileNames'
      if. 0=*#fnme do. fnme=. 'output/animsummary.csv' end.
      fnme=. extcsv fnme
      fnme=.fdir,fnme
    case. 'ansumrycsvpathSTORED';'animsumry'&,each ('';'hdr';'cnt') , each <'pathSTORED' do. 
      
      fkey=. 1 transName 'animsumrypath'
      ini=. 'animini' getInfo y
      fnme=. ini getIniString fkey;'FileNames'
      if. 0=*#fnme do. fnme=. 'output/animsummary.csv' end.
      fnme=. extcsv '\/' charsub fnme 
      zipnme=. jpath 'sumryzippath' getFnme y
      fnme=. >fnme;zipnme
      return. 
    case. 'caseinstpath' do.
      
      pathinfo=. 'caseinstpath' getInfo y
      'hdr dat'=. split pathinfo
      (hdr)=. |:dat
      of_code=. '_' pathdelim cr_code;of_year;sm_code;dm_code
      fnme=. '/' pathdelim ur_uname;of_code;sd_code;ci_id
      fnme=. basefldr,'userpop/',fnme,'/'
    case. 'scendefpath' do.
      
      cde=. 'scendefpath' getInfo y
      fnme=. basefldr,'scendefs/',cde,'.zip'
    case. keys=. ;:'selnlistpath pedigreepath mateallocpath' do.
      fkey=. 1 transName x
      fdir=. 'caseinstpath' getFnme y
      ini=. 'animini' getInfo y
      fnme=. ini getIniString fkey;'FileNames'
      if. 0=*#fnme do. 
        fnme=. (keys i.<x){:: ('output/selectlstfem.csv';'output/selectlstmale.csv'); cut'output/pedigree.csv matealloc.csv'
      elseif. x-:'selnlistpath' do.
        fnme=. fnme&,each ;:'fem male'
      end.
      fnme=. extcsv each boxopen fnme
      fnme=.fdir&, @> fnme
    case. 'sumryfiles' do. 
      fnme=. >(;:'animinipath animsumrypath trtinfopath') getFnme each y
    case. 'sumryzippath' do.
      
      fdir=. 'sumryfolderpath' getFnme y
      fnme=. ":y
      fnme=. fdir,fnme,'.zip'
    case. 'sumryfolderpath' do.
      
      pathinfo=. 'caseinstpath' getInfo y
      'hdr dat'=. split pathinfo
      (hdr)=. |:dat
      of_code=. '_' pathdelim cr_code;of_year;sm_code;dm_code
      fnme=. '/' pathdelim ur_uname;of_code;'summaries'
      fnme=. basefldr,'userpop/',fnme,'/'
    case. 'trtinfopath';'trtinfoallpath' do.
      fkey=. 1 transName 'trtinfopath'
      fdir=. 'caseinstpath' getFnme y
      ini=. 'animini' getInfo y
      fnme=. ini getIniString fkey;'QuantTrts'
      if. *#fnme do. fnme=. 'TrtInfo.xls' end.
      fnme=. (, #&'.xls'@(0: = '.'"_ e. (# | i:&PATHSEP_j_) }. ])) fnme
      fnme=. fdir,fnme
    case. 'trtinfo'&,each ('';'all') , each <'pathSTORED' do.
      fkey=. 1 transName 'trtinfopath'
      ini=. 'animini' getInfo y
      fnme=. ini getIniString fkey;'FileNames'
      if. 0=*#fnme do. fnme=. 'TrtInfo.xls' end.
      fnme=. (, #&'.xls'@(0: = '.'"_ e. (# | i:&PATHSEP_j_) }. ])) fnme
      fnme=. '\/' charsub fnme 
      zipnme=. jpath 'sumryzippath' getFnme y
      fnme=. >fnme;zipnme
      return. 
    case. 'userfolderpath' do. 
      uns=.'username' getInfo y
      fnme=. (basefldr,'userpop/'),"1 uns
    case. do.
      '' return.
  end.
  fnme=. jpath"1 fnme
)

coclass 'rgssqliteq'
sqlsel_userlogin=: 0 : 0
  SELECT users.ur_id ur_id, 
         users.ur_uname ur_uname,
         users.ur_passhash ur_passhash,
         users.ur_salt ur_salt
  FROM users
  WHERE users.ur_uname=?;
)

sqlsel_userstatus=: 0 : 0
  SELECT users.ur_status ur_status
  FROM users
  WHERE users.ur_id=?;
)
sqlsel_username=: 0 : 0
  SELECT users.ur_uname ur_uname
  FROM users
  WHERE users.ur_id=?;
)
sqlsel_idfromemail=: 0 : 0
  SELECT pp.pp_id pp_id ,
         pp.pp_fname pp_fname ,
         pp.pp_lname pp_lname
  FROM `people` pp
  WHERE pp.pp_email=?;
)

sqlins_newperson=: 0 : 0
  INSERT INTO people (pp_fname,pp_lname,pp_email)
  VALUES(?,?,?);
)

sqlins_newuser=: 0 : 0
  INSERT INTO users (ur_ppid,ur_uname,ur_refnum,ur_passhash,ur_salt)
  VALUES(?,?,?,?,?);
)

sqlins_newsession=: 0 : 0
  INSERT INTO sessions (ss_id,ss_urid,ss_salt,ss_hash,ss_expire)
  VALUES(?,?,?,?,julianday('now','20 minutes'));
)

sqlsel_sessioninfo=: 0 : 0
  SELECT ss.ss_urid ss_urid ,
         ss.ss_salt ss_salt ,
         (ss.ss_expire-julianday('now')) timeleft 
  FROM  `sessions`  ss 
  WHERE (ss.ss_id =?) AND (ss.ss_status >0);
)

sqlupd_extendsession=: 0 : 0
  UPDATE sessions
  SET ss_expire=julianday('now','20 minutes')
  WHERE ss_id=?;
)
sqlupd_expiresession=: 0 : 0
  UPDATE sessions
  SET ss_status=0
  WHERE ss_id=?;
)

sqlsel_expiredguests=: 0 : 0
  SELECT ur.ur_id ur_id ,
         ss.ss_id ss_id 
  FROM main.`users` ur INNER JOIN main.`sessions` ss ON ( `ur`.`ur_id` = `ss`.`ss_urid` ) 
       INNER JOIN main.`people` pp ON ( `pp`.`pp_id` = `ur`.`ur_ppid` ) 
  WHERE (pp.pp_id =1) 
  AND (ur.ur_status >0)
  AND (((ss.ss_expire -julianday('now'))<0) OR (ss.ss_status=0));
)

sqlsel_enrolled=: 0 : 0
  SELECT en.en_urid en_urid ,
         en.en_ofid en_ofid 
  FROM   `enrolments` en
  WHERE (en.en_urid =?) AND (en.en_ofid =?);
)

sqlsel_validcase=: 0 : 0
  SELECT en.en_urid ur_id ,
         en.en_ofid of_id ,
         oc.oc_csid cs_id 
  FROM  `enrolments` en INNER JOIN `offeringcases` oc ON ( `en`.`en_ofid` = `oc`.`oc_ofid` ) 
  WHERE (en.en_urid =?) AND (en.en_ofid =?) AND (oc.oc_csid =?);
)

sqlins_newcaseinstance=: 0 : 0
  INSERT INTO caseinstances (ci_urid,ci_ofid,ci_csid)
  VALUES(?,?,?);
)

sqlsel_caseinstanceid=: 0 : 0
  SELECT ci.ci_id ci_id 
  FROM  `caseinstances`  ci 
  WHERE (ci.ci_urid =?) AND (ci.ci_ofid =?) AND (ci.ci_csid =?) AND (ci.ci_status >0);
)

sqlsel_caseinststatus=: 0 : 0
  SELECT ci.ci_stored ci_stored ,
         ci.ci_status ci_status 
  FROM   main.`caseinstances`  ci 
  WHERE (ci.ci_id =?);
)

sqlsel_caseinstpath=: 0 : 0
  SELECT ur.ur_uname ur_uname ,
         off_info.cr_code cr_code ,
         off_info.of_year of_year ,
      	 off_info.sm_code sm_code ,
         off_info.dm_code dm_code ,
         sd.sd_code sd_code ,
         ci.ci_id ci_id 
  FROM  `users` ur INNER JOIN `caseinstances` ci ON ( `ur`.`ur_id` = `ci`.`ci_urid` ) 
        INNER JOIN `cases` cases ON ( `cases`.`cs_id` = `ci`.`ci_csid` ) 
        INNER JOIN `offering_info` off_info ON ( `off_info`.`of_id` = `ci`.`ci_ofid` ) 
        INNER JOIN `scendefs` sd ON ( `sd`.`sd_id` = `cases`.`cs_sdid` ) 
  WHERE (ci.ci_id =?);
)

sqlsel_scendefpath=: 0 : 0
  SELECT sd.sd_code sd_code 
  FROM  `cases` cs INNER JOIN `caseinstances` ci ON ( `cs`.`cs_id` = `ci`.`ci_csid` ) 
        INNER JOIN `scendefs` sd ON ( `sd`.`sd_id` = `cs`.`cs_sdid` ) 
  WHERE (ci.ci_id =?);
)

sqlsel_caseinstname=: 0 : 0
  SELECT ci.ci_usrname ci_usrname ,
         sd.sd_name sd_name ,
         ci.ci_usrdescr ci_usrdescr ,
         sd.sd_descr sd_descr ,
         sd.sd_code sd_code 
  FROM  `cases` cs INNER JOIN `caseinstances` ci ON ( `cs`.`cs_id` = `ci`.`ci_csid` ) 
        INNER JOIN `scendefs` sd ON ( `sd`.`sd_id` = `cs`.`cs_sdid` ) 
  WHERE (ci.ci_id =?);
)

sqlupd_caseinstusrdescr=: 0 : 0
  UPDATE caseinstances
  SET    ci_usrname=? ,
         ci_usrdescr=?
  WHERE  ci_id=?;
)

sqlsel_caseinst2expire=: 0 : 0
  SELECT ci.ci_id ci_id 
  FROM   main.`users` ur INNER JOIN main.`caseinstances` ci ON ( `ur`.`ur_id` = `ci`.`ci_urid` ) 
  WHERE  (ur.ur_id =?) AND (ci.ci_status >0);
)

sqlupd_expirecaseinst=: 0 : 0
  UPDATE caseinstances
  SET ci_status=0
  WHERE ci_id=?;
)

sqlupd_storecaseinst=: 0 : 0
  UPDATE caseinstances
  SET ci_stored=1
  WHERE ci_id=?;
)

sqlupd_delstoredcaseinst=: 0 : 0
  UPDATE caseinstances
  SET ci_stored=0
  WHERE ci_id=?;
)

sqlsel_txtblks=: 0 : 0
  SELECT 
      xn_id,
      xn_name
  FROM 
      textblocks;
)
sqlsel_animinipath=: 0 : 0
  SELECT sd.sd_filen sd_filen 
  FROM  `cases` cases INNER JOIN `caseinstances` ci ON ( `cases`.`cs_id` = `ci`.`ci_csid` ) 
        INNER JOIN `scendefs` sd ON ( `sd`.`sd_id` = `cases`.`cs_sdid` ) 
  WHERE (ci.ci_id =?);
)
sqlsel_userlist=: 0 : 0
  SELECT ur.ur_id ur_id ,
         ur.ur_status ur_status ,
         pp.pp_fname pp_fname ,
         pp.pp_lname pp_lname
  FROM `users` ur INNER JOIN `people` pp ON ur.ur_ppid=pp.pp_id
  WHERE (ur_status >=?) AND (pp.pp_id !=?);
)


sqlsel_userrec=: 0 : 0
  SELECT ur.ur_id ur_id ,
         pp.pp_fname pp_fname ,
         pp.pp_lname pp_lname ,
         ur.ur_uname ur_uname ,
         ur.ur_refnum ur_refnum ,
         pp.pp_email pp_email ,
         ur.ur_status ur_status ,
         ur.ur_salt ur_salt ,
         ur.ur_passhash ur_passhash
  FROM `users` ur INNER JOIN `people` pp ON ur.ur_ppid=pp.pp_id
  WHERE ur.ur_id=?;
)

sqlupd_resetusers=: 0 : 0
  UPDATE users
  SET ur_status=0
  WHERE ur_id=?
)

sqlupd_setusers=: 0 : 0
  UPDATE users
  SET ur_status=1
  WHERE ur_id=?
)

sqlupd_deleteusers=: 0 : 0
  DELETE FROM users
  WHERE ur_id=?
)

coclass 'rgssqliteq'
sqlsel_usergreeting=: 0 : 0
  SELECT pp.pp_fname pp_fname,
         pp.pp_lname pp_lname
  FROM `users` ur INNER JOIN `people` pp ON ur.ur_ppid=pp.pp_id
  WHERE ur.ur_id=?;
)

sqlsel_usercourses=: 0 : 0
  SELECT off_info.of_id of_id ,
         off_info.cr_name cr_name ,
         off_info.cr_code cr_code ,
         off_info.of_year of_year ,
         off_info.sm_code sm_code ,
         off_info.dm_code dm_code ,
         off_info.pp_adminfname pp_adminfname ,
         off_info.pp_adminlname pp_adminlname ,
         rl.rl_name rl_name 
  FROM  offering_info off_info INNER JOIN enrolments en ON ( off_info.of_id = en.en_ofid ) 
        INNER JOIN roles rl ON ( en.en_rlid = rl.rl_id ) 
  WHERE (en.en_urid =?) 
   AND (off_info.of_status >0) 
   AND NOT EXISTS (
     SELECT  off_info2.of_id of_id , 
             rl2.rl_id FROM offering_info off_info2
     INNER JOIN enrolments en2 ON ( off_info2.of_id = en2.en_ofid ) 
     INNER JOIN roles rl2 ON ( en2.en_rlid = rl2.rl_id )
     WHERE (en2.en_urid == en.en_urid) 
       AND (off_info2.of_status >0) 
       AND (off_info2.of_id == off_info.of_id) 
       AND (rl2.rl_id > rl.rl_id)
     ) -- end select do not remove this SQL comment otherwise bracket closes noun
  GROUP BY of_id
  ORDER BY off_info.cr_code  Asc, off_info.of_year  Asc;
)
sqlsel_effrole=: 0 : 0
  SELECT off_info.of_id of_id ,
         rl.rl_id rl_id ,
         rl.rl_name rl_name 
  FROM  offering_info off_info INNER JOIN enrolments en ON ( off_info.of_id = en.en_ofid ) 
        INNER JOIN roles rl ON ( en.en_rlid = rl.rl_id ) 
  WHERE (en.en_urid =?) 
    AND (off_info.of_id=?) 
    AND NOT EXISTS (
      SELECT  off_info2.of_id of_id , 
              rl2.rl_id FROM offering_info off_info2
      INNER JOIN enrolments en2 ON ( off_info2.of_id = en2.en_ofid ) 
      INNER JOIN roles rl2 ON ( en2.en_rlid = rl2.rl_id )
      WHERE (en2.en_urid == en.en_urid) 
        AND (off_info2.of_id == off_info.of_id) 
        AND (rl2.rl_id > rl.rl_id)
      ) -- end select do not remove this SQL comment otherwise bracket closes noun
  GROUP BY of_id
)

sqlsel_coursedetails=: 0 : 0
SELECT off_info.of_id of_id,
      off_info.cr_name cr_name,
      off_info.cr_code cr_code,
      off_info.of_year of_year,
      off_info.sm_code sm_code,
      off_info.dm_code dm_code,
      off_info.pp_adminfname pp_adminfname,
      off_info.pp_adminlname pp_adminlname,
      ox.ox_intro ox_intro
FROM  `offeringstext`  ox
      INNER JOIN `offerings` off ON (ox.ox_id = off.of_oxid) 
      INNER JOIN `offering_info` off_info ON (off.of_id = off_info.of_id) 
WHERE (off_info.of_id=?)
)

sqlsel_coursename=: 0 : 0
  SELECT off_info.cr_name cr_name ,
         off_info.cr_code cr_code 
  FROM `offering_info` off_info
  WHERE (off_info.of_id =?);
)

sqlsel_coursecases=: 0 : 0
  SELECT sd.sd_name sd_name ,
        sd.sd_descr sd_descr ,
        sd.sd_id sd_id ,
        sd.sd_code sd_code ,
        oc.oc_csid cs_id 
  FROM  `scendefs` sd INNER JOIN `cases` cs ON ( `sd`.`sd_id` = `cs`.`cs_sdid` ) 
        INNER JOIN `offeringcases` oc ON ( `cs`.`cs_id` = `oc`.`oc_csid` ) 
  WHERE (oc.oc_ofid =?);
)
sqlsel_coursesumrys=: 0 : 0
  SELECT ci.ci_id ci_id ,
         sd.sd_code sd_code ,
         sd.sd_name sd_name ,
         sd.sd_descr sd_descr ,
         ci.ci_usrname ci_usrname ,
         ci.ci_usrdescr ci_usrdescr 
  FROM   main.`scendefs` sd INNER JOIN main.`cases` cases ON ( `sd`.`sd_id` = `cases`.`cs_sdid` ) 
         INNER JOIN main.`caseinstances` ci ON ( `cases`.`cs_id` = `ci`.`ci_csid` ) 
  WHERE  (ci.ci_urid =?) AND (ci.ci_ofid =?) AND (ci.ci_stored =1)
  ORDER BY ci.ci_id  Asc, ci.ci_csid  Asc;
)

sqlsel_casestage=: 0 : 0
  SELECT ci.ci_stage ci_stage ,
         ci.ci_stored ci_stored
  FROM  `caseinstances`  ci 
  WHERE (ci.ci_id =?);
)

sqlupd_casestage=: 0 : 0
  UPDATE caseinstances
  SET ci_stage=?
  WHERE (ci_id=?);
)

sqlsel_casedetails=: 0 : 0
  SELECT sd.sd_name sd_name ,
         sd.sd_code sd_code ,
         sd.sd_descr sd_descr ,
         xn.xn_name xn_name ,
         cx.cx_text cx_text
FROM  `scendefs` sd INNER JOIN `cases` cs ON ( `sd`.`sd_id` = `cs`.`cs_sdid` ) 
      INNER JOIN `casestext` cx ON ( `cs`.`cs_id` = `cx`.`cx_csid` ) 
      INNER JOIN `textblocks` xn ON ( `xn`.`xn_id` = `cx`.`cx_xnid` ) 
WHERE (cs.cs_id =?) AND (xn.xn_id =?);
)

sqlsel_param=: 0 : 0
  SELECT pr.pr_class pr_class ,
         pr.pr_name pr_name ,
         fp.fp_label fp_label ,
         pr.pr_note pr_note ,
         fp.fp_note fp_note ,
         pr.pr_class pr_class ,
         fp.fp_class fp_class ,
         pr.pr_ctype pr_ctype ,
         fp.fp_ctype fp_ctype ,
         pr.pr_cprops pr_cprops ,
         fp.fp_cprops fp_cprops ,
         pr.pr_code pr_code 
  FROM `params` pr INNER JOIN `fieldsetparams` fp ON ( `pr`.`pr_id` = `fp`.`fp_prid` ) 
  WHERE (fp.fp_fsid=? AND fp.fp_prid =?);
)

sqlsel_fieldset=: 0 : 0
  SELECT fs.fs_name fs_name ,
         fp.fp_fsid fs_id ,
         fp.fp_prid pr_id 
  FROM  `fieldsets` fs INNER JOIN `fieldsetparams` fp ON ( `fs`.`fs_id` = `fp`.`fp_fsid` ) 
  WHERE (fs.fs_id =?);
)


sqlsel_paramform=: 0 : 0
  SELECT cf.cf_fsid fs_id ,
         cf.cf_value cf_value 
  FROM  `cases` cs INNER JOIN `caseinstances` ci ON ( `cs`.`cs_id` = `ci`.`ci_csid` ) 
        INNER JOIN `casefieldsets` cf ON ( `cs`.`cs_id` = `cf`.`cf_csid` ) 
  WHERE (ci.ci_id =?);
)
coclass 'rgswebforms'
coinsert COBASE 
buildButtons=: 3 : 0
  bt=. INPUT class 'button' type 'submit' value 'Save Changes' ''
  bt=. bt,LF, INPUT class 'button' type 'reset' value 'Discard Changes' ''
  DIV class 'buttonrow' bt
)
buildParamsForm=: 3 : 0
  ANIMINI_z_=: 'animini' getInfo y
  TRTINFO_z_=: 'trtinfoall' getInfo y
  info=. 'paramform' getInfo y  
  'hdr dat'=. split info
  (hdr)=. |:dat                   
  lgd=. P class 'legend' 'This is the legend for my form'
  lgd=. lgd, INPUT class 'input' type 'hidden' name 'action' id 'action' value 'chgparams' ''
  fsts=. cf_value buildFieldset each fs_id
  frm=. LF join lgd;fsts, boxopen buildButtons ''
  frm=. FORM id 'params' name 'params' method 'post' action 'case.jhp' frm
  DIV class 'form-container' frm
)
buildFieldset=: 3 : 0
  1 buildFieldset y
  :
  info=. 'fieldset' getDBTable y 
  'hdr dat'=. split info
  (hdr)=. |:dat                   
  lgd=. LEGEND {.fs_name        
  pdvs=. buildParamDiv each boxitemidx <"0 each fs_id;pr_id
  fst=. FIELDSET LF join lgd;pdvs
  dsabld=. (x<1)#'disabled="disabled"'
  fst=. ('disabled="disabled"';dsabld) stringreplace fst
)
buildParamDiv=: 3 : 0
  info=. 'param' getDBTable y  
  'hdr dat'=. split info
  (hdr)=. ,dat                   
  if. #fp_label do. pr_name=. fp_label end. 
  if. #fp_note  do. pr_note=. fp_note  end. 
  if. #fp_class do. pr_class=. fp_class end. 
  if. #fp_ctype do. pr_ctype=. fp_ctype end. 
  if. #fp_cprops do. pr_cprops=. fp_cprops end. 
  info=. getParamState pr_code 
  'seld vals nms'=. 3{. info
  ctrlprops=. boxopen pr_cprops
  ctrlprops=. (#vals)#ctrlprops
  idx=. makeidx (<:^:(=1:)) #vals 
  if. 'select'-: pr_ctype do. idx=. a: end. 
  if. pr_class-:'controlset' do.
    lbl=. LABEL class 'controlset' pr_name
    ctrls=. seld buildControlset  ctrlprops;vals;nms;<idx
    ctrls=. boxopen DIV ctrls
    nte=. buildNote pr_note
    pdv=. DIV class 'controlset' LF join lbl;ctrls,<nte
  else.
    lbl=. 'pr_code' buildLabel pr_name;{.idx
    select. pr_ctype  
      case. 'select' do.
        if. -.a:-:nms do. vals=. boxitemidx vals;<nms end.
        ctrls=. boxopen seld buildSelect (0{::ctrlprops);<vals
      case. 'textarea' do.
        ctrls=. buildTextarea ctrlprops;<vals
      case. 'input' do.
        ctrls=. seld&buildInput each boxitemidx ctrlprops;vals;<idx
    end.
    nte=. buildNote pr_note
    pdv=. DIV LF join lbl;ctrls,<nte
  end.
  pdv=. ('pr_code';pr_code) stringreplace pdv
)
buildControlset=: 3 : 0
  '' buildControlset y
  :
  'cprops vals nms idx'=. 4{. y
  ctrls=. x&buildInput each boxitemidx cprops;vals;<idx
  lbls=. 'pr_code'&buildLabel each boxitemidx nms;<idx
  LF join ,ctrls,.lbls,.<BR ''
)
buildInput=: 3 : 0
  '' buildInput y
  :
  'Ctrlprops Val Idx'=. 3{. y
  Val=. ,8!:2 Val
  x=. 8!:0 x
  Pcode=. 'pr_code'
  Chk=. 'checked="checked"'
  ". '((x e.~ <Val)#Chk) INPUT id (Pcode,":Idx) value Val name Pcode disabled Pcode ',Ctrlprops,' '''''
)
buildLabel=: 3 : 0
  '' buildLabel y
  :
  'nme idx'=. 2{. boxopen y
  Pcode=. x 
  LABEL for (Pcode,":idx) nme
)
buildNote=: 3 : 0
  if. #y do.
    P class 'note' y
  else. y end.
)
buildOption=: 3 : 0
  '' buildOption y
  :
  'Val Descr'=. 2$y
  sel=. 'selected="selected"'
  ((x e.~ <Val)#sel) OPTION value Val ":Descr
)
buildSelect=: 3 : 0
  '' buildSelect y
  :
  'Ctrlprops opts'=. 2{. y
  opts=. ,each (<"0^:(L.=1:)) opts 
  
  
  Pcode=. 'pr_code'
  opts=. x&buildOption each opts
  opts=. LF join opts
  ". 'SELECT id Pcode name Pcode disabled Pcode ',Ctrlprops,' opts'
)
makeTable=: 3 : 0
  TABLE TBODY LF join TR each ,each/"1 TD each y
)

enclose=: [ , ,~

buildTag=: 4 :0
  'tgn attn attv'=. x
  attr=. ((' 'enclose each boxopen attn),each quote each boxopen attv)
  tgdefs=. ,each/"1 |: (<toupper tgn),attr
  ".each tgdefs ,each (' ',each quote each y)
)
altclass=: 13 : '(<''class'') ,. x ,&.> (8!:0) >:2&| i.y'

buildForm=: 3 : 0
  '' buildForm y
  :
  select. x
    case. 'caseparams' do.
      buildParamsForm y
    case. 'caseusrdescr' do.
      ciid=. y
    case. 'caseedtxt' do.
      'csid cistage'=. y
      'vals cnts'=. |:}.'txtblks' getInfo ''
      idx=. vals i. cistage
      optatts=.((<'selected') (<idx,0)} ((#cnts),2)$<''),:"1 (('value');"1 0 vals) 
      selatts=. ('name';'cx_xnid'),('id';'cx_xnid'),:('onchange';'do this function')
      frm=. selatts atr'select'elm~ optatts atr"2 1 cnts txt"1 elm"1 'option'
    case. 'sumryplotsrc' do.
      ciids=. y
      page=. 'coursesumry_plot.jhp'
      qry=. '?',args ((<'ciids'),.ciids),((<'trts'),.trtsseld),(<'inftyps'),.inftypsseld
      imgattrs=. ('src';page,qry),('id';'sumryplot'),: 'alt';'Summary plot'
      qry=. '?',args (<'ciids'),.{.ciids
      aattrs=. ('href';'coursesumry_plotpdf.jhp',qry),: 'title';'Click to see PDF version of plot'
      frm=. tag  aattrs atr (,'a') (txt elm)~(imgattrs) atr elm 'img'
    case. 'sumrydef' do.
      ciids=. y
      hdrs=. 'animsumryhdr'&getInfo each ciids
      trtflds=. getTrtsOnly each hdrs
      trts=. ~.&getTrtBase each trtflds 
      dict=. 0 _1&{"1&('trtinfoall'&getInfo) each ciids
      trts=. trts ,. each (trts) keyval each each <"0 dict
      unqtrts=. ~.; trts
      inftyps=. getTrtInfoTyps each trtflds 
      dict=. <(;:'phen genD genDe'),.(cut 'Phenotypes Genotypes Est.&nbsp;Genotypes')
      inftyps=. inftyps ,. each (inftyps) keyval each each <"0 dict
      unqinftyps=. ~.; inftyps 
      trtmsk=. |:unqtrts&e. every trts
      trtmsk=. trtmsk{ '-';'*'
      
      inftypmsk=. |:unqinftyps&e. every inftyps
      inftypmsk=. inftypmsk{ '-';'*'
      
      csinsts=. 'caseinstname' getInfo  boxopenatoms ciids
      csinstsidx=. 0=# every {."1 }. csinsts
      csnmes=. (<"1 (i.<:#csinsts),.csinstsidx){}.csinsts
    
    
      
      mkchks=.  elm"1~ (elm 'input') atr"2 1~ ]
      mktblh2=. (;:'class tblheading2') atr"1 'td' elm~"1 ]
      mktblbodyhdg=. ('th' (txt elm)~ [) , 'td' elm"0 1~ ' ' #~ [: >:@# ]
      S=. LF elm ''
      nhcols=. 2
      trtids=. ('traits'&,each 8!:0 i. #unqtrts)
      inftypids=. ('inftyps'&,each 8!:0 i. #unqinftyps)
      caseids=. ('ciid'&,each 8!:0 i. #ciids)
      
    
      csnmes=. csnmes ,each (' (';')') prefsuf 8!:0 ciids
      cinms=. 'th' elm~"1 ((<'for'),.caseids) atr"1 'label' (txt elm)~"1 >csnmes
      cichks=. ('checked';''),('type';'checkbox'),:('name';'ciid')
      cichks=. (((<'id'),.caseids ),:"1 ((<'value'),.ciids)),"2 _ cichks
      cichks=. 'th' mkchks cichks
      hdr=. S,"2 ((('colspan';":nhcols) atr elm 'th'),"2 cinms,:cichks),"2 S
      hdr=. 'thead' elm~ 'tr' elm~"1 2 hdr
      
    
      trtcnts=. ('class';'tbltick') atr"1 (>,each trtmsk) elm"1 'td'
      trtchks=. ('type';'checkbox'),:('name';'traits')
      trtchks=. (('checked';'') (({."1 unqtrts) idxfnd trtsseld)}((#unqtrts),2)$a:),"1 _ trtchks
      trtchks=. (((<'id'),.trtids),:"1 ((<'value'),.{."1 unqtrts)),. trtchks
      trtchks=. 'td' mkchks trtchks
      
      trtabrs=. (<'abbr'),.(<"1(<'title'),.{:"1 unqtrts),.{."1 unqtrts
      trtlbls=. ((<'for'),.trtids) atr"1 'label' elm"1 2~ trtabrs
      trtlbls=. mktblh2 trtlbls
      
      trthdg=. 'Traits' mktblbodyhdg ciids
      
      trtbdy=. S,"2 (trthdg,trtlbls,.trtchks,.trtcnts) ,"2 S
      trtbdy=. ('r' altclass >:#unqtrts) atr"1 'tr' (txt elm)~"1 2 trtbdy
      trtbdy=. ('id';'trts')atr 'tbody' elm~ trtbdy
      
    
      inftypcnts=. ('class';'tbltick') atr"1 (>,each inftypmsk) elm"1 'td'
      inftypchks=. ('type';'checkbox'),:('name';'inftyps')
      inftypchks=. (('checked';'') (({."1 unqinftyps) idxfnd inftypsseld)}((#unqinftyps),2)$a:),"1 _ inftypchks
      inftypchks=. (((<'id'),.inftypids),:"1 ((<'value'),.{."1 unqinftyps)),. inftypchks
      inftypchks=. 'td' mkchks inftypchks
      
      inftypabrs=. (<'abbr'),.(<"1(<'title'),.{:"1 unqinftyps),.{."1 unqinftyps
      inftyplbls=. ((<'for'),.inftypids) atr"1 'label' elm"1 2~ inftypabrs
      inftyplbls=. mktblh2 inftyplbls
      
      inftyphdg=. 'InfoTypes' mktblbodyhdg ciids
      
      inftypbdy=. S,"2 (inftyphdg,inftyplbls,.inftypchks,.inftypcnts) ,"2 S
      inftypbdy=. ('r' altclass >:#unqinftyps) atr"1 'tr' (txt elm)~"1 2 inftypbdy
      inftypbdy=. ('id';'inftyps')atr 'tbody' elm~ inftypbdy
      
    
      tls=. 'Plot Summary';'Tabulate Summary'
      tls=.  ((<'value'),.tls),"1 _('type';'submit'),:('name';'action')
      tls=. ('colspan';":nhcols+#ciids) atr 'td' elm~ tls (atr elm)"2 'input'
      ftr=. 'tfoot' elm~ ('class';'tbltools') atr 'tr' elm~ tls
      
    
      tbl=. ('cellspacing';'0') atr 'table' elm~ hdr,trtbdy,inftypbdy,:ftr
      frm=. (<;._1' id action method name'),.<;._1' defsumry coursesumry.jhp post defsumry'
      frm=. tag frm atr 'form' elm~ tbl
      
    case. do.
  end.
)

Note  'Build Sumrydef Table'
cols4row=. (TD class 'tbltick')"1  '1st','&nbsp;',:'hello'
cols4row=. (TD class 'tbltick') every '1st';'&nbsp;';'hello'
row=. TR class 'r1' vfm cols4row
INPUT type 'checkbox' name 'traits' id 'traits0' ''
LF join TR each ,each/"1 |: TD classA ('r1';'r2';'r3') |: 8!:0 i.  4 3
LF join TR each ,each/"1    TD classA  'r1' 8!:0 i.  4 3
TABLE id 'sumrydef' TBODY id 'infotyps' LF join TR each ,each/"1 |: TD class2 ('r1';'r2';'r3') |: 8!:0 i.  4 3
(TD classA ('trait'&,each 8!:0 >:i.4) 8!:0 i.  4 1),.TD classA ('tbletick') 8!:0 i.  4 3
unbox1=: >^:(<:&L.) 
unbox1 TD ismap noresize checked 8!:0 i. 3 4
TABLE id 'sumrydef' TBODY id 'trts' LF join TR classA ('r1';'r2';'r1') ,each/"1(TD each tst),. TD classA ('s1';'s2';'s3') 8!:0 i.3 2
((;:'n1 n2 n3') <@,"0 ;:'s1 s2 s3') cell each 8!:0 i.3 2
('TD' ;('name';'id';'class');< ('n1';'id1';'s3')) buildTag '3'
('TD' ;('name';'id';'class');< ('n1';'id1';'s3')) buildTag 8!:0 i.3 2
('TD' ;('name';'id';'class');< ((;:'n1 n2 n3') , (;:'id1 id2 id3') ,: ;:'s1 s2 s3')) cell1 8!:0 i.3 2
('TD' ;('name';'id';'disabled');< ((;:'n1 n2 n3') , (;:'id1 id2 id3') ,: ;:'s1 s2 s3')) buildTag 8!:0 i.3 2

)


Note 'using `tag` verb'
]smrytbl=. ('class';'r1') atr 'tr' elm~('class';'tbltick') atr"1 (>8!:0 i.4) txt"1 elm"1 'td'
tag smrytbl
]smrytbl=. ('class';'r1') atr"1 'tr'elm~"1 2 ('class';'tbltick') atr"1 (>8!:0 i.3 4) txt"1 elm"1 'td'
,(tag"1 smrytbl),.LF
]smrytbl=. (('class';'r1'),('class';'r2'),:('class';'r1')) atr"1 'tr'elm~"1 2 ('class';'tbltick') atr"1 (>8!:0 i.3 4) txt"1 elm"1 'td'
,(tag"1 smrytbl),.LF
]icls=.   ((<'id'),.'traits'&,each 8!:0 i.4),"1 _ (('value';'1'),('type';'checkbox'),:('name';'traits'))
tag"1 icls atr"2 1 elm 'input'
((icls atr"2 1 elm 'input') elm"1 'td'),. ('class';'tbltick') atr"1 (>8!:0 i.4 3 ) elm"1 'td'
)
makeidx=: [: 8!:0 i.

boxitemidx=: <"1@:|:@:>
Note 'tests'
tst=: ('Dollar';'$')
rarg=: ('Dollar';'$');(<'Kroner';'DKK')
larg=: ''
selectoptions rarg
larg selectoptions rarg
rarg=: ('VISA';'MasterCard')
larg=: 'MasterCard'
larg selectoptions rarg
rarg=: dict 'Basic="$20"';'Plus="$40"'
larg=: '$40'
larg selectoptions rarg
rarg=:  'VISA';'MasterCard';'Discover'
larg=:  'VISA';'Discover'
larg selectoptions rarg
rarg=:  '';('No. of Lambs Born';'NLB');('Live weight at 8-mon';'LW8');('Fleece weight at 12-mon';'FW12');(<'Ultrasound backfat depth';'FD')
larg=:  'NLB';'FD'
larg buildSelect rarg
)
buildForm_z_=:  buildForm_rgswebforms_
makeTable_z_=:  makeTable_rgswebforms_
buildTable_z_=: buildTable_rgswebforms_

addpath_z_=: adverb def '(copath~ ~.@(x&;)@copath)@(coname^:(0:=#)) :. ((copath~ copath -. (<x)"_)@(coname^:(0:=#)))'
webdefs_z_=: 'jweb' addpath
webdefs ''      

cocurrent 'jweb'   
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
parm=:  adverb def 'conjunction def ((''('''''',x,''='''' glue v) u y'');'':'';(''(('''''',x,''='''' glue v),'''' '''',x) u y''))'
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
   language onreset
)

enquote=: ('"'&,)@(,&'"')^:('"'&~:@{.@(1&{.))
glue=: , enquote@":
parm0=: adverb def 'conjunction def (('''''''',(x,''=''glue x),'''''''','' u y'');'':'';(''('''''',(x,''=''glue x),'' '''',x) u y''))'
makeparm0=: verb def 'empty ".y,''=: '''''',y,'''''' parm0'''
makeparm0@> ;:noun define-.LF
    checked compact declare defer disabled ismap multiple
    nohref noresize noshade nowrap readonly selected
)
point=: adverb def 'verb def ((''''''<'',x,'' />'''''');'':'';(''''''<'',x,'' '''',x,'''' />''''''))'
makepoint=: verb def 'empty ".y,''=: '''''',(tolower y),'''''' point'''
makepoint@> ;:noun define-.LF
  IMG BR HR PARAM MAP ISINDEX META INPUT
)
makecolor=: verb def 'empty ".y,''=: '''''',y,'''''''''
makecolor@> ;:noun define-.LF
   Black  Silver Gray   White
   Maroon Red    Purple Fuchsia
   Green  Lime   Olive  Yellow
   Navy   Blue   Teal   Aqua
)
join=: ' '&$. : (4 : '(;@(#^:_1!.(<x))~  1 0$~_1 2 p.#) y')  

unbox1=: >^:(<:&L.) 

splice=: 2 : '; @ (<@u ;. n)'

decorate=: adverb define
:
c=. <;._1 y [ d=. {.y            
g=. (+: 0: , }:) mt=. (0: = #@>) c  
c=. g <@; ;. 1 c,&.>mt<@#"0 d      
(1#~#c) (u{~x i. {.@>c)@> splice 1 }.&.>c
)
ftext=: verb def '''_*%~@'' (]`B`I`CODE`link) decorate y'
fdecor=: adverb def (':';'(''_*%~@'',x) (]`B`I`CODE`LINE`U) decorate y')
link=: verb define
i=. y i. PATHSEP_j_
A href (i{.y) (}.i}.y)
)

image=: verb def ('IMG src y 0';':';'x IMG src y 0')
jsite=: link@('http://www.jsoftware.com/'&,)
spread=: ;@({.&.>&1)   
upon=: 2 : '(u@:v) : (u v)'
by=: ,&LF : (, LF&,)
onbox=: ;@:(by&.>) :.<

table=: TABLE upon (onbox@:(TR&.onbox"1)@:(TD@by&.>))
all=: 2 : '; @ (((by@x)&.>) @ y)'
boxes=: ]
lines=: <;._2
paras=: (_1&|.&((2#LF)&E.) <;._2 ])@by
words=: (#~ *@#@>) @ (<;._1) @ (' '&,)
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
asciibox=: (,(179 180 191 192 193 194 195 196 197 217 218{a.),.'|++++++-+++')&charsub
pdecorate=: adverb def (':';'u@}.@.(x"_ i. {.) all paras y')
fparas=: '>]"''-'&(ftitle`fraw`(P@ftext)`fpre`(P@flist) pdecorate)
fpdecor=: adverb def (':';'(''>]"''''-'',x) (ftitle`fraw`(p@ftext)`fpre`(p@flist)`u) pdecorate y')
fpre=: PRE@(LF&,)
ftitle=: verb def '(''H'',{.y)tag }.}:y'
fraw=: ]
flist=: UL@(LI all lines)

coclass 'rgswebforms'
tag=: 3 : 0
  if. 0=L.y do. htsafe ":y return. end.
  'e a c'=. y
  if. 0=#e do. htsafe ":c return. end.
  e assert (<e) e. tagsC,tagsNC
  A=. C=. ''
  for_i. ,:^:((0<#) *. 1=#@$) a do.
    'n v'=. i
    n assert (<n) e. a:,attrV,attrNV
    if. (<n) e. attrNV do. v=. n end.
    if. #n do.
      A=. A,<' ',n,'="',(htsafe ":v),'"'
    end.
  end.
  for_i. ,:^:((0<#) *. 1=#@$) c do.
    C=. C,<tag i
  end.
  r=. '<',e,;A
  if. (0<#C) +. -.(<e) e. tagsNC do. 
    r,'>',(;C),'</',e,'>'
  else. r,' />' end.
)

buildTag=: 3 : 0
  try.
    tag y
  catch.
    13!:12''
  end.
)
rp=.  2 : '; }. ,(<m) ,. ,.<;._1 n , y'
htsafe=: [:'&gt;'rp'>'[:'&lt;'rp'<'[:'&quot;'rp'"' '&amp;'rp'&'

tagsC=: ;: noun define-.LF  
  a abbr acronym address applet area b base basefont big blockquote
  body button caption cite code col colgroup dd del dfn dir div dl
  dt em fieldset font form frameset h1 h2 h3 h4 h5 h6 head html 
  i iframe ins kbd label legend li link menu noframes noscript 
  object ol optgroup option p pre q samp script select small span 
  strike strong style sub sup table tbody td textarea tfoot th
  thead title tr tt u ul var xmp
)
tagsNC=: ;: noun define-.LF  
   br hr img input isindex map meta param 
)
attrV=: ;: noun define-.LF  
  abbr accept accesskey action align alink alt archive axis bgcolor
  border cellpadding cellspacing char charoff charset cite class 
  classid clear codebase codetype color cols colspan content coords 
  data datetime dir enctype face for frame frameborder headers height 
  href hreflang hspace id lang language link longdesc marginheight 
  marginwidth maxlength media method name object onblur onchange onclick 
  ondblclick onfocus onkeydown onkeypress onkeyup onload onmousedown 
  onmousemove onmouseout onmouseover onmouseup onreset onselect onsubmit
  onunload prompt rel rel rev rows rowspan rules scope scrolling shape 
  size span src standby start style summary tabindex target text title 
  type usemap value valuetype vlink vspace width
)
attrNV=: ;: noun define-.LF  
    checked compact declare defer disabled ismap multiple
    nohref noresize noshade nowrap readonly selected
)
elm=: (a: ,~ ;&a:) : ((<@[ ,~ a:;~])`(a: ,~ ];<@[)@.(1=L.@[))
atr=: <@(, ,:^:(1=#@$)@(,.^:(0=#))@(1&{::))`1:`] }
txt=: <@(, ,:^:(1=#@$)@(,.^:(0=#))@(2&{::))`2:`] }

Note 'test'  
  ]t1=. 'td';(_2]\;:'name n1 class c1');<'';'';'test 1'
  tag t1
  ]t2=. 'test <2>'elm'td'   
  tag t2
  ]t3=. 'td'elm~(;:'name class');&>1 2
  tag t3
  ]t=. 'tr'elm~t1,S,t2,S,:t3 [ S=. LF elm''
  tag t
  ]t=. 'br'elm~'class';'b"1"'
  tag t
  ]t=. 'input'elm~'checked';''
  tag t
  ]t=. ('id';'zz') atr ('name';'zz') atr (,:~'1'elm'td') txt elm 'tr'
  tag t

  ]e1=. ('td'elm~_2]\;:'NotAnAttrib n1 class c1')txt~'test 1'
  buildTag e1
  ]e2=. 'NotATag'elm~'test <2>'   
  buildTag e2
  ]e=. 'tr'elm~t1,S,t2,S,:t3 [ S=. 'NotATagDeep'elm~LF
  buildTag e
  tag e
)
require 'data/sqlite'
coclass 'rgssqliteq'
3 : 0 ''
  if. 0=4!:0 <'CONNECTSTR_base_' do.
    ConStr=:  CONNECTSTR_base_  
  else.
  is2ndlevel=: (+./('public',PATHSEP_j_) E. jpath '~CGI'){:: '~.CGI/code/';'~..CGI/code/'
  ConStr=: IFCONSOLE{:: '~home/documents/web/selectj/code/';is2ndlevel
  ConStr=: jpath ConStr,'select_cmplx.sqlite'
end.
)
lasterr=: [: deb LF -.~ }.@(13!:12)
sqldberr_z_=: (assert 0=#) f.

sBegin=: 0 : 0
  r=. 0 0$''
  msg=. ''
  try.
    db=. ConStr conew 'psqlite'
)
sEnd=: 0 : 0
  catch. msg=. lasterr'' end.
  if. 0=nc<'db' do. destroy__db '' end.
  sqldberr msg
  r
)
sdefine=: 1 : 'm : (sBegin , (0 : 0) , sEnd)'
getDBItem=: 3 : 0
 '' getDBItem y
:
 r=. x getDBTable y
 if. #r do. r=.>{.{:r end.
 r
)
getDBField=: 3 : 0
 '' getDBField y
:
 r=. x getDBTable y
 if. #r do. r=.>{."1}.r end.
 r
)
getDBItemStr=: 3 : 0
 '' getDBItemStr y
:
 r=. x getDBTableStr y
 r=.>{.{:r
)
getDBTable=: dyad sdefine
  r=.(boxopen y) query__db ".'sqlsel_',x
)
getDBTableStr=: dyad sdefine
  r=.(boxopen y) strquery__db ".'sqlsel_',x
)
insertDBTable=: dyad sdefine
  sql=. ". 'sqlins_',x
  r=. (boxopen y) apply__db sql
)
updateDBTable=: dyad sdefine
  r=. (boxopen y) apply__db ". 'sqlupd_',x
)

execSQL=: dyad sdefine
  r=. exec__db y
)

getDBField_z_=: getDBField_rgssqliteq_
getDBItem_z_=: getDBItem_rgssqliteq_
getDBItemStr_z_=: getDBItemStr_rgssqliteq_
getDBTable_z_=: getDBTable_rgssqliteq_
getDBTableStr_z_=: getDBTableStr_rgssqliteq_
insertDBTable_z_=: insertDBTable_rgssqliteq_
updateDBTable_z_=: updateDBTable_rgssqliteq_
require 'random convert/misc/md5'

coclass 'rgspasswd'
createSalt=: ([: _2&ic a. {~ [: ? 256 $~ ])&4
randPassword=: 3 : 0
  defx=.'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789' 
  defx randPassword y
:
  if. isdefseed'' do. randomize'' end.
  len=. (*#y){ 8,y  
  len (]{~ [:?[$ [:#]) x
)
isdefseed=: 3 : '+./({.2{::9!:44'''')=16807 1215910514'
salthash=: 3 : 0
  '' salthash y 
  :
  if. *#x do. s=.x
    if. 2=3!:0 s do. s=.".s end. 
  else. 
    if. isdefseed'' do. randomize'' end.
    s=. createSalt '' 
  end.
  h=. md5 y,2&ic s 
  s;h
)

salthash_z_=: salthash_rgspasswd_
randPassword_z_=: randPassword_rgspasswd_
require 'files'

coclass 'rgsdiradd'
addPS=: , PATHSEP_j_ -. {:
dropPS=: }:^:(PATHSEP_j_={:)
dircreate=: 3 : 0
  y=. boxxopen y
  msk=. -.direxist y
  if. ''-:$msk do. msk=.(#y)#msk end.
  res=.1!:5 msk#y
  msk expand ,res
)
direxist=: 2 = ftype&>@: boxopen
pathcreate=: 3 : 0
  todir=. addPS jhostpath y
  todirs=. }. ,each /\ <;.2 todir 
  msk=. -.direxist todirs 
  
  
  
  msk=. 0 (i. msk i: 0)}msk
  dircreate msk#todirs 
)

dircreate_z_=: dircreate_rgsdiradd_
direxist_z_=: direxist_rgsdiradd_
pathcreate_z_=: pathcreate_rgsdiradd_
addPS_z_=: addPS_rgsdiradd_
dropPS_z_=: dropPS_rgsdiradd_
require 'dir files'
3 : 0 ''
if. -.IFCONSOLE do. 
  require 'dir_add' 
end.
)
coclass 'rgstrees'
copytree=: 4 : 0
  'todir fromdir'=. addPS each x;y
  if. -.direxist fromdir do. 0 0 return. end. 
  dprf=. ] }.&.>~ [: # [  
  aprf=. ]  ,&.>~ [: < [    
  fromdirs=. }. dirpath fromdir
  todirs=. todir aprf fromdir dprf fromdirs
  fromfiles=. {."1 dirtree fromdir
  tofiles=. todir aprf fromdir dprf fromfiles
  resdir=. pathcreate todir
  resdir=. resdir, dircreate todirs
  resfile=. 0&< @>tofiles fcopy"0 fromfiles
  (+/resdir),+/resfile
)
deltree=: 3 : 0
  try.
    res=.0< ferase {."1 dirtree y
    *./ res,0<ferase |.dirpath y
  catch. 0 end.
)
fcopy=: fwrite~ fread

copytree_z_=: copytree_rgstrees_
deltree_z_=: deltree_rgstrees_
coclass 'z'

ifa =: <@(>"1)@|:              
afi =: |:@:(<"_1@>)            

tassert=: 3 : 0
 assert. (1>:#$y) *. 32=3!:0 y  
 assert. 1=#~.#&>y             
 1
)

ttally    =: #@>@{.
tfrom     =: <@,@[ {&.> ]
tindexof  =: i.&>~@[ i.&|: i.&>
tmemberof =: i.&>~ e.&|: i.&>~@]
tless     =: <@:-.@tmemberof #&.> [
tnubsieve =: ~:@|:@:(i.&>)~
tnub      =: <@tnubsieve #&.> ]
tkey      =: 1 : '<@tindexof~@[ u/.&.> ]'
tgrade    =: > @ ((] /: {~)&.>/) @ (}: , /:&.>@{:)
tgradedown=: > @ ((] \: {~)&.>/) @ (}: , \:&.>@{:)
tsort     =: <@tgrade {&.> ]

tfreq     =: #/.~@:|:@:(i.&>)~  

Note 'suggestions by Roger in forum'
- Alternative defns for tfreq are:
tfreq=: #/.~@tindexof~
tfreq=: >@(# tkey)~
Tested them and they are both slower and fatter than current tfreq

tsort1 should perhaps be "order x by y" rather than the proposed "order y by x", to follow the dyads /: and \: .

)
mfv1=: ,:^:(#&$ = 1:)
tindexof1=: ([,&.>]) tindexof {:@$&.>@([,&.>]) {."1&.>] 

tsort1    =: <@tgrade@[ {&.> ]
tfreq     =: #/.~@:|:@:(i.&>)~
tfreqtble =: [: tsort tnub , <@:tfreq
tkeytble  =: [: tsort1 ([: tnub [) , [: boxopen ]
tkeysum=: <@:tindexof~@:[ +//.&.> ]

tkeyavg   =: tkeysum % &.> <@:tfreq@:[
tkeyavg1  =: (+/ % #)tkey  
tkey      =: 1 : '<@tindexof~@[ u/.&.> ]'


Note 'Test animalsim data'
require 'csv'
smry=: readcsv jpath '~temp/summary.csv'
smrysm=:({.smry),(40?<:#smry){ }.smry
'hdr sm'=:split smry
invtble=: ifa sm

key=: 1 3{invtble 
dat=: 0".each 7 10 12{invtble   

key=: listatom 1{invtble
dat=: 0". each 9}.invtble
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
,.each key tkeytble (<tfreq key),key tkeyavg dat
)
require 'dir arc/zip/zfiles'
require 'strings files'  
3 : 0 ''
  if. -.IFCONSOLE do. 
    require 'dir_add' 
  end.
)

coclass 'rgsztrees'
unziptree=: 4 : 0
  'todir fromzip'=. x;y
  todir=. addPS todir
  if. -.fexist fromzip do. 0 0 return. end. 
  fromall=. /:~{."1 zdir fromzip
  dirmsk=. '/'={:@> fromall
  fromfiles=. (-.dirmsk)#fromall
  repps=. (<'/',PATHSEP_j_) charsub&.> ] 
  aprf=. ] ,&.>~ [: < [   
  tofiles=. repps fromfiles
  tofiles=. todir aprf tofiles
  fromfiles=. fromfiles,.<fromzip
  todirs=. repps dirmsk#fromall
  todirs=. ~.;(,each /\)@(<;.2) each todirs 
  todirs=. todir aprf todirs
  resdir=. pathcreate todir 
  resdir=. resdir, dircreate todirs  
  resfile=. 0&<@>tofiles zextract"0 1 fromfiles 
  (+/resdir),+/resfile
)
ziptree=: 4 : 0
  'tozip fromdir'=. x;y
  if. -.direxist fromdir do. 0 0 return. end. 
  repps=. (<PATHSEP_j_,'/') charsub&.> ] 
  dprf=. ] }.&.>~ [: # [  
  fromdir=. addPS fromdir
  fromdirs=. addPS each }.dirpath fromdir
  todirs=. repps fromdir dprf fromdirs
  todirs=. todirs,.<tozip
  fromfiles=. {."1 dirtree fromdir
  tofiles=. repps fromdir dprf fromfiles
  tofiles=. tofiles,.<tozip
  zipdir=. PATHSEP_j_ dropto&.|. tozip
  resdir=. pathcreate zipdir 
  resdir=. resdir, 0= (((#todirs),0)$'') zwrite"1 todirs 
  resfile=. 0&<@>tofiles zcompress"1 0 fromfiles
  (+/resdir),+/resfile
)
zipfiles=: 4 : 0
  fromfiles=. boxopen y
  'tozip dirinf'=. 2{. boxopen x
  if. *./-.fexist @> fromfiles do. 0 return. end. 
  repps=. (<PATHSEP_j_,'/') charsub&.> ] 
  dprf=. ] }.&.>~ [: # [  
  aprf=. ]  ,&.>~ [: < [   
  if. (0-:dirinf) +. (''-:dirinf) *. 1=#fromfiles do. 
    tofiles=. '/' taketo&.|. each repps fromfiles
    tofiles=. tofiles,.<tozip
    todirs=. ''
  else.
    basedir=. (0 i. ~ *./ 2=/\>fromfiles){."1 >{.fromfiles 
    basedir=. PATHSEP_j_ dropto&.|. basedir
    if. 1-:dirinf do.
      dirinf=. basedir 
    else.
      dirinf=. (, ('/' -. {:))^:(*@#) > repps <dirinf 
    end.
    tofiles=. repps dirinf aprf basedir dprf fromfiles 
    todirs=. '/' dropto&.|. each tofiles 
    todirs=. todirs #~ (a:~:todirs) *. ~: tolower each todirs 
    todirs=. todirs,.<tozip
    tofiles=. tofiles,.<tozip
  end.
  zipdir=. PATHSEP_j_ dropto&.|. tozip
  resdir=. pathcreate zipdir 
  resdir=. resdir, 0= (((#todirs),0)$'') zwrite"1 todirs 
  resfile=. 0&<@>tofiles zcompress"1 0 fromfiles
  (+/resdir),+/resfile
)
ztypes=: [: >: '/' = [: {:@> [: {."1 zdir

zextract=: fwrite~ zread
zcompress=: zwrite~ fread

unziptree_z_=: unziptree_rgsztrees_
zipfiles_z_=: zipfiles_rgsztrees_
ziptree_z_=: ziptree_rgsztrees_
ztypes_z_=: ztypes_rgsztrees_