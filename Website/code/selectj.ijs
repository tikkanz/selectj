NB. built from project: ~Projects/selectj/selectj

IFJIJX_j_=: 1
script_z_ '~system\main\convert.ijs'
script_z_ '~system\packages\files\csv.ijs'
script_z_ '~system\main\dir.ijs'
script_z_ '~system\main\dll.ijs'
script_z_ '~system\main\files.ijs'
script_z_ '~addons\convert\misc\md5.ijs'
script_z_ '~system\packages\stats\random.ijs'
script_z_ '~addons\data\sqlite\sqlite.ijs'
script_z_ '~addons\data\sqlite\def.ijs'
script_z_ '~system\main\strings.ijs'
script_z_ '~addons\tables\tara\tara.ijs'
script_z_ '~system\packages\misc\task.ijs'
script_z_ '~system\packages\winapi\winapi.ijs'

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
    if. 0<#fnme do. ContentDisp fnme end.
    ContentType ctype
    stdout fread jpath fpth
  end.
)

Note 'CGI Testing'
CGIKEYS=: <;._1 '|action|flkdams2sire|cullage|cullage|mateage|mateage|trtsrecorded|trtsrecorded|trtsrecorded|trtsrecorded|trts2select|trts2select|trts2select|objectvrevs|objectvrevs|objectvrevs|selnmeth|trts2summ|trts2summ|trts2summ|trts2summ|trts2summ|summtype|summtyp'
CGIVALS=: <;._1 '|chgparams|50|8|8|2|2|NLB|LW8|FW12|FD|NLB|LW8|FD|5|3|-4|genDe|NLB|LW8|FW12|FAT|LEAN|phen|genD'

CGIKEYS=: <;._1 '|action|Upld_fem|Upld_male'
CGIVALS=: <;._1 '|uploadSL|Tag,Flk,YOB,Mtd,AOD,BR,DOB,pLW8,pFD,pFAT,pLEAN  200400274,1,2004,12,3,1,-0.9,48.95325177,4.030984783,,  200100346,1,2001,11112,2,1,-6.3,48.86565182,4.271521078,,  200100370,1,2001,11112,1,1,5.3,46.89300694,4.762921181,,  200100343,1,2001,11112,3,1,-0.6,46.17547369,3.455460892,,  200500074,1,2005,1,4,1,-12.1,46.05296769,5.341503248,,  200200331,1,2002,1112,4,1,-1.1,45.39484645,4.142378276,,  200500028,1,2005,1,1,1,3.9,38.67851262,1.56124158  199900425,1,1999,1111112,3,2,-2.8,34.83060492,1.756794846  200200332,1,2002,1112,2,2,6,34.79601909,3.198942513  200500079,1,2005,1,1,2,6.5,34.79466461,3.741469411  200500072,1,2005,1,4,1,-1.9,34.69026073,3.489232777  200500085,1,2005,1,4,1,8.4,32.873602,1.026880573  200500004,1,2005,1,3,2,-1.4,32.70060414,2.662249756  200500044,1,2005,1,2,2,0.1,32.62690318,2.856263165  199900439,1,1999,1111112,3,1,14,32.6039013,3.401926152  200500009,1,2005,1,3,1,-2.7,32.55296755,0.981724313  200400244,1,2004,12,1,2,-3.5,32.46166876,2.770021921  200500070,1,2005,1,1,1,-6.2,32.37781276,3.188548712  200500092,1,2005,1,1,2,-3.9,32.3485021,4.505456237  200100366,1,2001,11112,3,2,8.7,32.27643367,2.598342709  200500091,1,2005,1,4,2,3.5,32.22780809,1.8170505  200200324,1,2002,1112,2,2,6.3,32.05034764,3.000975391  200300277,1,2003,112,1,1,-0.6,31.99438592,2.940832441  200500100,1,2005,1,4,2,6.3,31.96962864,4.320502691  200500008,1,2005,1,2,1,5.5,31.96679559,1.796884848  |Tag,Flk,YOB,Mtd,AOD,BR,DOB,pLW8,pFD,pFAT,pLEAN  200500174,1,2005,1,4,1,-1.5,49.27337484,3.324896691,,  200500148,1,2005,1,2,1,-2.3,49.14943999,5.410582075,,  200300442,1,2003,112,4,1,0.8,48.90579541,2.810506745,,  200500126,1,2005,1,3,2,4.6,46.94914573,2.853458612,,  '
CGIFILES=: <;._1 '||SelectLstFEM.csv|SelectLstMALE-1.csv'
CGIMIMES=: <;._1 '||application/csv|application/csv'
)


redirect=: 3 : 0
  uri=.y
  
  println 'Location: ',uri
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
listatom=: 1&#
loc_z_=: 3 : '> (4!:4 <''y'') { 4!:3 $0'
join=: ' '&$. : (4 : '(;@(#^:_1!.(<x))~  1 0$~_1 2 p.#) y')  

makeTable=: [: > [: <;._1 each ' ',each [: <;._2 (deb@:toJ ]) , LF -. {:
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
createSession=: 3 : 0
 if. isdefseed_rgspasswd_'' do. randomize'' end.
 sid=. >:?<:-:2^32 
 sh=. salthash ":sid 
 'session' insertDBTable  sid;y;sh
 tk=. writeTicket sid;{:sh
)
expireSession=: 3 : 0
  if.0=#y do. y=. qcookie 'SessionTicket' end.
  sid=.0{:: readTicket y
  'sessionexpire' updateDBTable ".sid
)

GUESTID=:5
isActive=: 3 : 0
  s=. {:'status' getDBTable y
)
readTicket=: 3 : 0
  kVTable=. qsparse y  
  sid=.'ssid' keyval kVTable
  shash=. 'hash' keyval kVTable
  sid;shash
)

registerUser=: 3 : 0
  'uname fname lname refnum email passwd'=.y
  
  
  uinfo =. {:'login' getDBTable uname  
  if. -.uinfo-:'' do. _2 return. end. 
  pinfo =. {:'email' getDBTable  email
  if. -.pinfo-:''  do. 
    pid=. 0{::pinfo    
  else.
    pid=. 'newperson' insertDBTable fname;lname;email 
  end.
  sph=. salthash passwd 
  uid=.'newuser' insertDBTable pid;uname;refnum;|.sph 
  
)
updateSession=: 3 : 0
  if.0=#y do. y=. qcookie 'SessionTicket' end.
  sid=.0{:: readTicket y
  'session' updateDBTable ".sid
)
validCase=: 3 : 0
  if. 0-: uofid=.validEnrolment'' do. 0 return. end.
  uofid validCase y
:
  if. 0=#y do. y=.0 qcookie 'CaseID' end.
  vldcs=.'validcase' getDBTable x,<y
  if. #vldcs do. x,<y else. 0 end.
)
validEnrolment=: 3 : 0
  if. 0-: uid=.validSession'' do. 0 return. end.
  uid validEnrolment y
:
  if. 0=#y do. y=. 0 qcookie 'OfferingID' end.
  enrld=.'enrolled' getDBTable x;y
  if. #enrld do. x;y else. 0 end.
)
validLogin=: 3 : 0
 'usrnme passwd'=. y
  if. usrnme -: '' do. _1 return. end. 
  uinfo =. {:'login' getDBTable usrnme  
  if. ''-: uinfo   do. _2 return. end.   
  'duid dunme dhash dsalt' =. 4{.uinfo
  if. -. dhash-: _1{::dsalt salthash passwd do. _3 return. end. 
  duid
)
validSession=: 3 : 0
  if. 0=#y do. y=. qcookie 'SessionTicket' end.
  'sid shash'=. readTicket y
  sinfo=.'session' getDBTable ".sid
  if. 0=#sinfo do. 0 return. end. 
  'hdr dat'=. split sinfo         
  (hdr)=. |:dat                   
  
  if. -. shash -: 1{::ss_salt salthash sid do. 0 return. end.
  if. timeleft<0 do. 
    'sessionexpire' updateDBTable ".sid
    0
  else.
    'session' updateDBTable ".sid
    ss_urid
  end.
)
writeTicket=: 3 : 0
  'tsid thash'=.y
  ('ssid=',":tsid),'&hash=',thash
)

resetUsers=: 3 : 0
  if. *#y do.
    'resetusers' updateDBTable y
    
    ''
  end.
)
setUsers=: 3 : 0
  if. *#y do.
    'setusers' updateDBTable y
    
    ''
  end.
)
deleteUsers=: 3 : 0
  if. *#y do.
    'deleteusers' updateDBTable y
    
    ''
  end.
)

pathdelim=: 4 : '}.;([:x&,,)each y'  
getFnme=: 4 : 0
  basefldr=. IFCONSOLE{:: 'd:/web/selectj/';'~.CGI/'
  
  select. x
    case. 'animini' do.
      fdir=. 'caseinstfolder' getFnme y
      fnme=. 'animini' getDBItem y
      fnme=. fdir,fnme
    case. 'caseinstfolder' do.
      
      pathinfo=. 'caseinstfolder' getDBTableStr y
      'hdr dat'=. split pathinfo
      (hdr)=. |:dat
      of_code=. '_' pathdelim cr_code;of_year;sm_code;dm_code
      fnme=. '/' pathdelim ur_uname;of_code;sd_code;ci_id
      fnme=. basefldr,'userpop/',fnme,'/'
    case. 'scendef' do.
      
      cde=. 'scendef' getDBItem y
      fnme=. basefldr,'scendefs/',cde,'.zip'
    case. keys=. ;:'selnlist pedigree matealloc animsumry' do.
      fdir=. 'caseinstfolder' getFnme y
      inipath=. 'animini' getFnme y
      fkey=. 1 transName x
      fnme=. getPPString inipath;'FileNames';fkey
      if. *#fnme do. 
        fnme=. (keys i.<x){:: ('output/selectlstfem.csv';'output/selectlstmale.csv'); cut'output/pedigree.csv matealloc.csv output/animsummary.csv'
      end.
      fnme=.fdir&, @> boxopen fnme
    case. 'trtinfo' do.
      fdir=. 'caseinstfolder' getFnme y
      inipath=. 'animini' getFnme y
      fkey=. 1 transName x
      fnme=. getPPString inipath;'quanttrts';fkey
      if. *#fnme do. fnme=. 'TrtInfo.xls' end.
      fnme=. fdir,fnme
    case. do.
  end.
  fnme=. jpath"1 fnme
)
createCaseInstance=: 3 : 0
  ciid=. 'caseinstance' insertDBTable y
  uz=. createCaseInstFolder ciid
  ciid
)
createCaseInstFolder=: 3 : 0
  zippath=. 'scendef' getFnme y
  newpath=. 'caseinstfolder' getFnme y
  uz=. unzip zippath;newpath  
)
getCaseInstance=: 3 : 0
  if. 0=#y do.
    if. 0-: uofcsid=. validCase'' do. 0 return. end.
  else.
    uofcsid=. y
  end.
  ciid=. >@{:'caseinstance' getDBTable uofcsid
  if. #ciid do.
    ciid
  else. 
    ciid=. createCaseInstance uofcsid
  end.
)
updateCaseStage=: 3 : 0
  'casestage' updateDBTable y
)
expireCaseInstance=: 3 : 0
  'expirecaseinst' updateDBTable y
  deleteCaseInstFolder y
)
deleteCaseInstFolder=: 3 : 0
  delpath=. 'caseinstfolder' getFnme y
  res=.deltree delpath
  if. 1=*./res do. 1 else. 0 end.
)
getScenarioInfo=: 3 : 0
  'animini' getScenarioInfo y
  :
  infotyp=. boxopen x
  select. infotyp
    case. <'animini' do.
      fnme=. 'animini' getFnme y
      res=. getPPAllSections fnme
    case. <'alltrtinfo' do.  
      xlfnme=. 'trtinfo' getFnme y
      'tDefn' readexcel xlfnme
    case. <'status' do. 
      fnme=. 'animini' getFnme y
      crcyc=. getPPVals fnme;'GenCycle';1&transName 'curryear'
      ncyc=. getPPVals fnme;'Control';'ncycles'
      crcyc;ncyc
  end.
)

updateScenarioInfo=: 3 : 0
  'animini' updateScenarioInfo y
  :
  infotyp=. boxopen x
  select. infotyp
    case. <'animini' do.
      fnme=. <'animini' getFnme y
      res=. writePPString"1 fnme,.ANIMINI
  end.
)
updateSelnDetails=: 3 : 0
  CGIKEYS=: 1&transName each CGIKEYS 
  ANIMINI_z_=: 'animini' getScenarioInfo y
  TRTINFO_z_=: 'alltrtinfo' getScenarioInfo y
  
  keyscalc=. ;:'Trts2Sim Phens2Sim EBVs2Sim GetEBVs SelectListCols Respons2Outpt'
  keyscalc=. keyscalc,;:'ObjectvTrts ObjectvREVs'
  keysform=. ~. qparamKeys'' 
  keysini=. tolower each 1{"1 ANIMINI  
  keys2upd8=. ~.(tolower each keyscalc),(keysform e. keysini)#keysform 
  keysform updateKeyState"1 0 keys2upd8
  ANIMINI_z_=: (; keys2upd8 getIniIdx each <ANIMINI){ANIMINI 
  'animini' updateScenarioInfo y 
)
TransNames=: makeTable 0 : 0
animsummaryfnme  animsumry
curryear         currcycle
flkdams2sire     dams2hrdsire
flksizes         hrdsizes
flkspecfnme      hrdspecfnme
mateallocfnme    matealloc
pedigreefnme     pedigree
sampleflkeffects samplehrdeffects
selnlistfnme     selnlist
traitinfofnme    trtinfo
usesiresxflk     usesiresxhrd
flock            herd
flk              hrd
)
transType=: TransNames |."1~]
transName=: (]keyval [:transType [)^:( (TransNames{"1~[) e.~ [: boxopen ])

getIniVals=: [: makeVals getIniStr
getIniStr=: 4 : 0
  i=. x getIniIdx y
  if. ''-:i do.
    i else.  (<i,2) {:: y end.
)
getIniIdx=: ''&$: : (4 : 0)
  if. (#y) > i=. (tolower each 1{"1 y) i. <,>1 transName tolower x do.
    i else. '' end.
)
prefsuf=: [:,<@;@(1&C.)@,"1 0/
getTrtBase=: ((<'pgde') -.&.>~ ])
getTrtsOnly=: ] #~ 'pg' e.~ {.@>
getTrtsNot=:  ] #~ [: -. 'pg' e.~ {.@>
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
      vals=. ;:'phen genD genDe'
      nmes=. 'Phenotypes';'Genotypes';'Estimated Breeding Values'
    case. 'cullage' do.
      vals=. <"0 y getIniVals ANIMINI
      nmes=. 'Female';'Male'
    case. 'hrdsizes'    do.
      vals=. <"0 y getIniVals ANIMINI
      if. 1 do. 
        seld=. boxopen vals
        vals=. <"0 (100,200*>:i.5), 1500 2000 4000
      end.
    case. 'mateage' do.
      vals=. <"0 y getIniVals ANIMINI
      nmes=. 'Female';'Male'
    case. 'objectvrevs' do.
      nmes=. 'trtsavail' getIniVals ANIMINI
      vals=. (#nmes)#a:
      tmpv=. <"0 y getIniVals ANIMINI
      tmpn=. 0{:: getParamState 'trts2select'
      vals=. tmpv (nmes i. tmpn)}vals
    case. 'selnmeth'    do.
      'seld vals nmes'=. getParamState 'coltypes'
      tmp=. 'selectlistcols' getIniVals ANIMINI
      tmp=. getTrtsOnly tmp 
      tmp=. {:>{:tmp  
      seld=. ('ed' i. tmp){ |.vals 
    case. 'summtype'    do.
      'seld vals nmes'=. getParamState 'coltypes'
      tmp=. 'respons2outpt' getIniVals ANIMINI
      tmp=. getTrtsOnly tmp 
      tmp=. ~.{:@>tmp   
      tmp=. (0<+/-.tmp e. 'de'),'de'e.tmp  
      seld=. tmp#vals   
    case. 'trtsrecorded' do.
      vals=. 'trtsavail' getIniVals ANIMINI
      vals=. getTrtsPhn vals
      nmes=. 'TrtCaption' getTrtInfo vals
      seld=. y getIniVals ANIMINI
    case. 'trts2select';'trts2summ' do.
      vals=. 'trtsavail' getIniVals ANIMINI
      nmes=. 'TrtCaption' getTrtInfo vals
      nmes=. ('(',each vals ,each <') '),each nmes
      tmp=. (('trts2select';'trts2summ')i. boxopen y) { 'selectlistcols';'respons2outpt'
      tmp=. tmp getIniVals ANIMINI
      tmp=. getTrtsOnly tmp  
      tmp=. tmp -. each <'pdge' 
      seld=. ~. tmp 
    case. do. 
    
      vals=. y getIniVals ANIMINI
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
      initrts=. getTrtBase getTrtsOnly ;initrts getIniVals each <ANIMINI
      frmtrts=. ;qparamList each frmtrts
      kval=. ~.frmtrts,initrts
    case. 'getebvs'   do.
    
      kval=. qparamList key2upd8
      if. ''-:kval do. 
        frmflds=. 'selnmeth';'summtype'
        notset=. -.frmflds e. x
        iniflds=. notset# 'selectlistcols';'respons2outpt'
        isebv=. 'e' e. {:@>getTrtsOnly ;iniflds getIniVals each <ANIMINI
        kval=. +./isebv,(<'genDe') e."0 1> qparamList each frmflds
        key2upd8=. (*./notset){:: key2upd8;'' 
      end.
    case. 'objectvrevs'    do.
      if. (<'objectvrevs') e. x do.
        kval=. qparamList key2upd8
      else.
        if. (<'trts2select') e. x do. 
          kval=. (# qparamList 'trts2select')#1 
        else. key2upd8=. '' end. 
      end.
    case. 'objectvtrts'    do.
      if. (<'trts2select') e. x do. 
        trts=. qparamList 'trts2select'
        if. (<'selnmeth') e. x do.
          sm=. qparamList 'selnmeth'
        else. sm=. <'phen' end. 
        ps=. ('phen';'genD';'genDe') e. sm
        ps=. ps# ('p';''),('g';'d'),:('g';'de')
        kval=. ps prefsuf trts 
        kval=. (<'BR') (kval ((([: # [) > [ i. [: < ]) # [ i. [: < ]) 'pNLB')} kval 
      else. key2upd8=. '' end. 
    case. 'phens2sim' do.
    
      frmtyps=. 'selnmeth';'summtype'
      notset=. -.frmtyps e. x
      msk=. (<'phen') e."0 1> qparamList each 'selnmeth';'summtype'
      msk=. notset +. msk
      frmtrts=. (<'trtsrecorded'),msk#'trts2select';'trts2summ'
    
      notset=. -.frmtrts e. x
      initrts=. notset# (<'trtsrecorded'),msk#'selectlistcols';'respons2outpt'
      initrts=. getTrtBase getTrtsOnly ;initrts getIniVals each <ANIMINI
      frmtrts=. ;qparamList each frmtrts
      kval=. getTrtsPhn ~.(<'NLB'),frmtrts,initrts  
    case. 'respons2outpt'  do.
      if. (<'trts2summ') e. x do. 
        trts=. qparamList 'trts2summ'
        if. (<'summtype') e. x do.
          st=. qparamList 'summtype'
        else. st=. 'phen';'genD' end. 
        ps=. ('phen';'genD';'genDe') e. st
        ps=. ps# ('p';''),('g';'d'),:('g';'de')
        kval=. ps prefsuf trts 
      else. key2upd8=. '' end.
    case. 'selectlistcols' do.
      if. (<'trts2select') e. x do. 
        trts=. qparamList 'trts2select'
        if. (<'selnmeth') e. x do.
          sm=. qparamList 'selnmeth'
        else. sm=. <'phen' end. 
        ps=. ('phen';'genD';'genDe') e. sm
        ps=. ps# ('p';''),('g';'d'),:('g';'de')
        trtflds=. ps prefsuf trts 
        nttrt=. getTrtsNot key2upd8 getIniVals ANIMINI 
        kval=. nttrt,trtflds
      else. key2upd8=. '' end.
    case. 'trts2sim' do.
    
      frmtrts=. ;:'trtsrecorded trts2select trts2summ'
    
      notset=. -. frmtrts e. x
      initrts=. notset# ;:'trtsrecorded selectlistcols respons2outpt'
      initrts=. getTrtBase getTrtsOnly ;initrts getIniVals each <ANIMINI
      frmtrts=. ;qparamList each frmtrts
      kval=. ~.frmtrts,initrts
    case. do. 
      kval=. qparamList key2upd8
  end.
  kidx=. key2upd8 getIniIdx ANIMINI
  if. -.''-:kidx do.
    ANIMINI=: (<kval) (<kidx,2) } ANIMINI
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
      ANIMINI_z_=. 'animini' getScenarioInfo x
      'ndams d2s xhrd'=. ('hrdsizes';'dams2hrdsire';'usesiresxhrd') getIniVals each <ANIMINI
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
    fpth=. 'matealloc' getFnme x
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
          inipath=. 'animini' getFnme y
          writePPString inipath;'Control';'Resume';1
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
    okexist=. fexist fnme=. 'matealloc' getFnme x
    msg=. boxopen 'Mate Allocation list not found.<br/>Did you upload your selected parents?'
    if. *./ok=. okexist do. 
      ma=. readcsv fnme
      oklen=. *# ma 
      'hdr ma'=. split ma
      ANIMINI_z_=. 'animini' getScenarioInfo x
      'popsz cage mage'=. ('hrdsizes';'cullage';'mateage') getIniVals each <ANIMINI
      oknmtgs=. (#ma)=+/popsz
      
      
      
      slsts=. <@readcsv"1 'selnlist' getFnme x
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
  'crcyc ncyc'=. 'status' getScenarioInfo y
  fnme=. 'animsumry' getFnme y
  issm=. fexist fnme
  res=. (issm *. crcyc = ncyc)-crcyc=0
)
runAnimalSim=: 3 : 0
  inipath=. 'animini' getFnme y
  if. -.fexist inipath do. 0 return. end.
  crcyc=. getPPVals key=. inipath;'GenCycle'; 1&transName 'currcycle'
  _1 fork 'c:\program files\animalsim\animalsim ',inipath
  if. fexist  'errorlog.txt',~ cifldr=. 'caseinstfolder' getFnme y do. 
    if. crcyc< getPPVals key do.
      writePPString key,<crcyc  
    end.
    0
  else.
    1
  end.
)


coclass 'rgssqliteq'
sqlsel_login=: 0 : 0
  SELECT users.ur_id ur_id, 
         users.ur_uname ur_uname,
         users.ur_passhash ur_passhash,
         users.ur_salt ur_salt
  FROM users
  WHERE users.ur_uname=?;
)

sqlsel_status=: 0 : 0
  SELECT users.ur_status ur_status
  FROM users
  WHERE users.ur_id=?;
)

sqlsel_email=: 0 : 0
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

sqlins_session=: 0 : 0
  INSERT INTO sessions (ss_id,ss_urid,ss_salt,ss_hash,ss_expire)
  VALUES(?,?,?,?,julianday('now','20 minutes'));
)

sqlsel_session=: 0 : 0
  SELECT ss.ss_urid ss_urid ,
         ss.ss_salt ss_salt ,
         (ss.ss_expire-julianday('now')) timeleft 
  FROM  `sessions`  ss 
  WHERE (ss.ss_id =?) AND (ss.ss_status >0);
)

sqlupd_session=: 0 : 0
  UPDATE sessions
  SET ss_expire=julianday('now','20 minutes')
  WHERE ss_id=?;
)
sqlupd_sessionexpire=: 0 : 0
  UPDATE sessions
  SET ss_status=0
  WHERE ss_id=?;
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

sqlins_caseinstance=: 0 : 0
  INSERT INTO caseinstances (ci_urid,ci_ofid,ci_csid)
  VALUES(?,?,?);
)

sqlsel_caseinstance=: 0 : 0
  SELECT ci.ci_id ci_id 
  FROM  `caseinstances`  ci 
  WHERE (ci.ci_urid =?) AND (ci.ci_ofid =?) AND (ci.ci_csid =?) AND (ci.ci_status >0);
)

sqlsel_caseinstfolder=: 0 : 0
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

sqlsel_scendef=: 0 : 0
  SELECT sd.sd_code sd_code 
  FROM  `cases` cs INNER JOIN `caseinstances` ci ON ( `cs`.`cs_id` = `ci`.`ci_csid` ) 
        INNER JOIN `scendefs` sd ON ( `sd`.`sd_id` = `cs`.`cs_sdid` ) 
  WHERE (ci.ci_id =?);
)

sqlupd_expirecaseinst=: 0 : 0
  UPDATE caseinstances
  SET ci_status=0
  WHERE ci_id=?;
)
sqlsel_animini=: 0 : 0
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
  FROM `users` ur INNER JOIN `people` pp ON ur.ur_ppid=pp.pp_id;
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
sqlsel_greeting=: 0 : 0
  SELECT pp.pp_fname pp_fname,
         pp.pp_lname pp_lname
  FROM `users` ur INNER JOIN `people` pp ON ur.ur_ppid=pp.pp_id
  WHERE ur.ur_id=?;
)

sqlsel_mycourses=: 0 : 0
  SELECT off_info.of_id of_id ,
         off_info.cr_name cr_name ,
         off_info.cr_code cr_code ,
         off_info.of_year of_year ,
         off_info.sm_code sm_code ,
         off_info.dm_code dm_code ,
         off_info.pp_adminfname pp_adminfname ,
         off_info.pp_adminlname pp_adminlname ,
         rl.rl_name rl_name 
  FROM  `offering_info` off_info INNER JOIN `enrolments` en ON ( `off_info`.`of_id` = `en`.`en_ofid` ) 
        INNER JOIN `roles` rl ON ( `en`.`en_rlid` = `rl`.`rl_id` ) 
  WHERE (en.en_urid =?) AND (off_info.of_status >0)
  ORDER BY off_info.cr_code  Asc, off_info.of_year  Asc;
)

sqlsel_course=: 0 : 0
  SELECT off_info.of_id of_id ,
        off_info.cr_name cr_name ,
        off_info.cr_code cr_code ,
        off_info.of_year of_year ,
        off_info.sm_code sm_code ,
        off_info.dm_code dm_code ,
        off_info.pp_adminfname pp_adminfname ,
        off_info.pp_adminlname pp_adminlname ,
        ox.ox_intro ox_intro 
  FROM `offering_info` off_info INNER JOIN `offeringstext` ox 
        ON ( `off_info`.`of_id` = `ox`.`ox_id` ) 
  WHERE (off_info.of_id =?);
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

sqlsel_casestage=: 0 : 0
  SELECT ci.ci_stage ci_stage ,
         ci.ci_sumry ci_sumry
  FROM  `caseinstances`  ci 
  WHERE (ci.ci_id =?);
)

sqlupd_casestage=: 0 : 0
  UPDATE caseinstances
  SET ci_stage=?
  WHERE (ci_id=?);
)

sqlsel_case=: 0 : 0
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
buildForm=: 3 : 0
  ANIMINI_z_=: 'animini' getScenarioInfo y
  TRTINFO_z_=: 'alltrtinfo' getScenarioInfo y
  info=. 'paramform' getDBTable y  
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
  fst=. ('disabled';dsabld) stringreplace fst
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
  if. 'select'-: pr_ctype do. idx=.a: end. 
  if. pr_class-:'controlset' do.
    lbl=. LABEL class 'controlset' pr_name
    ctrls=.seld buildControlset  ctrlprops;vals;nms;<idx
    ctrls=.boxopen DIV ctrls
    nte=. buildNote pr_note
    pdv=. DIV class 'controlset' LF join lbl;ctrls,<nte
  else.
    lbl=. 'pr_code' buildLabel pr_name;{.idx
    select. pr_ctype  
      case. 'select' do.
        if. -.a:-:nms do. vals=.boxitemidx vals;<nms end.
        ctrls=.boxopen seld buildSelect (0{::ctrlprops);<vals
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
  'cprops vals nms idx'=. 4{.y
  ctrls=. x&buildInput each boxitemidx cprops;vals;<idx
  lbls=.  buildLabel each boxitemidx nms;<idx
  LF join ,ctrls,.lbls,.<BR ''
)
buildInput=: 3 : 0
 '' buildInput y
:
  'Ctrlprops Val Idx'=. 3{.y
  Val=. ,8!:2 Val
  x=. 8!:0 x
  Pcode=.'pr_code'
  Chk=. 'checked="checked"'
  ". '((x e.~ <Val)#Chk) INPUT id (Pcode,Idx) value Val name Pcode disabled ',Ctrlprops,' '''''
)
buildLabel=: 3 : 0
  'pr_code' buildLabel y
:
  'nme idx'=. 2{. boxopen y
  Pcode=. x 
  LABEL for (Pcode,idx) nme
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
  ((x e.~ <Val)#sel) OPTION value Val Descr
)
buildSelect=: 3 : 0
  '' buildSelect y
:
  'Ctrlprops opts'=. 2{. y
  opts=. ,each (<"0^:(L.=1:)) opts 
  opts=. 8!:0 each opts
  x=. boxopen 8!:0 x
  Pcode=.'pr_code'
  opts=. x&buildOption each opts
  opts=. LF join opts
  ". 'SELECT id Pcode name Pcode disabled ',Ctrlprops,' opts'
)

makeidx=:[: 8!:0 i.

boxitemidx=:<"1@:|:@:>
Note 'tests'
tst=: ('Dollar';'$')
rarg=:('Dollar';'$');(<'Kroner';'DKK')
larg=:''
selectoptions rarg
larg selectoptions rarg
rarg=: ('VISA';'MasterCard')
larg=: 'MasterCard'
larg selectoptions rarg
rarg=: dict 'Basic="$20"';'Plus="$40"'
larg=:'$40'
larg selectoptions rarg
rarg=:  'VISA';'MasterCard';'Discover'
larg=:  'VISA';'Discover'
larg selectoptions rarg
rarg=:  ('No. of Lambs Born';'NLB');('Live weight at 8-mon';'LW8');('Fleece weight at 12-mon';'FW12');(<'Ultrasound backfat depth';'FD')
larg=:  'NLB';'FD'
larg selectoptions rarg
)

buildForm_z_=: buildForm_rgswebforms_
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
parm0=: adverb def 'adverb def (('''''''',x,'''''' u y'');'':'';(''('''''',x,'' '''',x) u y''))'
makeparm0=: verb def 'empty ".y,''=: '''''',y,'''''' parm0'''
makeparm0@> ;:noun define-.LF
   ismap compact nowrap declare nohref noshade
   noresize disabled
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

require 'data/sqlite'
coclass 'rgssqliteq'
3 : 0 ''
  if. 0=4!:0 <'CONNECTSTR_base_' do.
    ConStr=:  CONNECTSTR_base_  
  else.
    
    ConStr=:  'd:/web/selectj/code/select_cmplx.sqlite'
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
 r=.>{.{:r
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
coclass 'rgsunzip'

3 : 0 ''
if. -.IFUNIX do. require 'task' end.
if. IFCONSOLE do.
  UNZIP=: '"c:\program files\7-zip\7z.exe" x -y'
else.
  UNZIP=: UNZIP_j_
end.
)


dquote=: '"'&, @ (,&'"')
hostcmd=: [: 2!:0 '(' , ] , ' || true)'"_
exequote=: 3 : 0
  f=. deb y
  if. '"' = {. f do. f return. end.
  ndx=. 4 + 1 i.~ '.exe' E. f
  if. ndx >: #f do. f return. end.
  '"',(ndx{.f),'"',ndx }. f
)
shellcmd=: 3 : 0
  if. IFUNIX do.
    hostcmd y
  else.
    spawn y
  end.
)
unzip=: 3 : 0
  'file dir'=.y
  e=. 'Unexpected error'
  if. IFUNIX do.
    e=. shellcmd 'tar -xzf ',(dquote file),' -C ',dquote dir
  else.
    z=. exequote UNZIP
    if. +./'7z' E. UNZIP do. 
      dirsw=.' -o'
    else.  
      dirsw=.' -d'
    end.
    r=. z,' ',(dquote file),dirsw,dquote dir
    e=. shellcmd r
    
  end.
  e
)

unzip_z_=: unzip_rgsunzip_

require 'dir files'

coclass 'rgsdiradd'

addPS=: , PATHSEP_j_ -. {:          
dropPS=: }:^:(PATHSEP_j_={:)  
dircreate=: 3 : 0
  y=. boxopen y
  msk=. -.direxist y
  if. ''-:$msk do. msk=.(#y)#msk end.
  res=.1!:5 msk#y
  msk expand ,res
)
direxist=: 'd' e."1 [: > [: , [: ({:"1) 1!:0@(fboxname&>)@(dropPS&.>)@boxopen
 
 

dircreate_z_=: dircreate_rgsdiradd_
direxist_z_=: direxist_rgsdiradd_
addPS_z_=: addPS_rgsdiradd_
dropPS_z_=: dropPS_rgsdiradd_
require 'dir files'
3 : 0 ''
if. -.IFCONSOLE do. 
  require 'dir_add' 
end.
)
coclass 'rgstrees'

addPS=: , PATHSEP_j_ -. {:          
dropPS=: }:^:(PATHSEP_j_={:)  
copytree=: 4 : 0
  'todir fromdir'=. addPS each x;y
  if. -.direxist fromdir do. 0 0 return. end. 
  dprf=. ] }.&.>~ [: # [  
  aprf=. ] ,&.>~ [: < [    
  fromdirs=. dirpath fromdir
  todirs=. todir aprf fromdir dprf fromdirs
  todirs=. (}:}.,each/\ <;.2 todir), todirs
  fromfiles=. {."1 dirtree fromdir
  tofiles=. todir aprf fromdir dprf fromfiles
  resdir=. dircreate todirs
  resfile=. 0&< @>tofiles fcopy fromfiles
  (+/resdir),+/resfile
)
deltree=: 3 : 0
  try.
    res=.0< ferase {."1 dirtree y
    *./ res,0<ferase |.dirpath y
  catch. 0 end.
)

fcopy=: 4 : 0
  dat=. fread each boxopen y
  dat fwrite each boxopen x
)

copytree_z_=: copytree_rgstrees_
deltree_z_=: deltree_rgstrees_
require 'winapi strings'
coclass 'rgsini'
getPPAllSections=: 3 : 0
  snmes=. getPPSectionNames y
  keys=. getPPSection each <"1 (boxopen y),.snmes
  nkys=. #@> keys       
  keys=. ;(nkys>0)#keys 
  (nkys#snmes),.keys
)
getPPSection=: 3 : 0
  'fnme snme'=. y
  len=. #str=. 4096$' '  
  'len val'=. 0 2{'GetPrivateProfileSectionA'win32api snme;str;len;fnme
  val=. ({.a.),len{.val  
  val=. <;._1 val
  val=. dtb each '#' taketo each val
  msk=. 0< #@> val 
  val=. msk#val
  ><;._1 each '=',each val
)
getPPSectionNames=: 3 : 0
  fnme=. y
  len=. #str=. 1024$' '  
  'len val'=. 0 1{'GetPrivateProfileSectionNamesA'win32api str;len;fnme
  <;._2 val=. len{.val
)
getPPString=: 3 : 0
  'fnme snme knme'=. y
  len=. #str=. 1024$' '  
  'len val'=. 0 4{'GetPrivateProfileStringA'win32api snme;knme;'';str;len;fnme
  val=. len{.val
)
getPPValue=: 3 : 0
  '#' getPPValue y  
  :
  rval=. getPPString y   
  rval=. dtb x taketo rval  
)
getPPVals=: 3 : 0
  '#' getPPVals y  
  :
  'delim err'=. 2{.!.(<_999999) boxopen x
  val=. delim getPPValue y   
  err makeVals val
)
join=: ' '&$. : (4 : '(;@(#^:_1!.(<x))~  1 0$~_1 2 p.#) y')  
makeString=:[: ' '&join 8!:0
makeVals=: 3 : 0
  _999999 makeVals y
  :
  err=. x
  if. L.y do. y return. end. 
  val=. ', ' charsub y  
  if. -.+./err= nums=. err&". val do. val=. nums end.
  if. ' ' e. val do. val=. <;._1 ' ',deb val end.
  val
)
writePPString=: 3 : 0
  'fnme snme knme val'=. y
  val=. makeString val
  res=. 'WritePrivateProfileStringA'win32api snme;knme;val;fnme
  0{:: res
)
writePPSection=: 3 : 0
  'fnme snme keys'=. y
  null={.a.
  keys=. (makeString each 1{"1 keys) (1)}"0 1 keys 
  keys=. '=' join each <"1 keys  
  keys=. null,~ null join keys 
  
  res=. 'WritePrivateProfileSectionA'win32api snme;keys;fnme
  0{:: res
)


getPPAllSections_z_=: getPPAllSections_rgsini_
getPPString_z_=: getPPString_rgsini_
getPPVals_z_=: getPPVals_rgsini_
writePPString_z_=: writePPString_rgsini_
makeVals_z_=: makeVals_rgsini_