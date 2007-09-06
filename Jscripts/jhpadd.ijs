require 'files'
NB. require 'web/jhp/jhp'

coclass 'z'

ContentDisp=: 3 : 0
  if. 0 <: nc<'ContentDispSet_j_' do. return. end.
  ContentDispSet_j_=: y
  println 'Content-Disposition: attachment; filename=',y
)

fext=:'.'&(i:~}.]) NB. get file extension
fname=: PATHSEP_j_&(>:@i:~}.])
isJHP=: (;:'jhp asp') e.~ [:<fext

NB.* transfer v transfers a file to stdout with appropriate response headers
NB. y is 1 or 2-item boxed list.
NB.         0{ path to file on server
NB.         1{ optional name for file to be downloaded

transfer=: 3 : 0
  'fpth fnme'=.2{. boxopen y
  NB. map fpth to physical path if required
  myext=. fext fpth
  ctype=. myext keyval makeMimeTable MimeMap NB. determine Content-Type here
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

redirect=: 3 : 0
  uri=.y
  NB. if relative URL, convert to absolute
  println 'Location: ',uri
  ContentType'text/html'
)

refresh=: 3 : 0
  uri=.y
  NB. if relative URL, convert to absolute
  println 'Refresh: 0; url=',uri
  ContentType'text/html'
)

boxitem=: ,`(<"_1) @. (0=L.)

setcolnames=: 3 : 0
  if. y-:i.0 0 do. return. end.
  'hdr dat'=. split y
  (hdr)=: |:dat
  ''
)

NB.*coercetxt v converts any boxed txt to numeric, leave boxed numeric alone
coercetxt=: 3 : 0
  isboxed=.0<L. y
  y=. boxopen y
  msk=. -.isnum @> y
  newnums=. 0&coerce each msk#y
  y=.[newnums (I.msk)}y NB. works?
  if. -.isboxed do. >y end. NB. unboxed if was at start
)

NB. ---------------------------------------------------------
NB.*listatom v makes y a 1-item list if y is atom (rank 0)
NB. suggested by Chris Burke JForum June 2007
NB. (listatom 5) -: ,5
NB. (listatom i.4 3) -: i.4 3
listatom=: 1&#

NB. loc returns the full path of the script calling it.
NB. could be useful for relative calling?
NB. from the forums
NB. http://www.jsoftware.com/pipermail/general/2003-May/015265.html
loc_z_=: 3 : '> (4!:4 <''y'') { 4!:3 $0'

makeMimeTable=:[: > [: <;._1 each TAB,each [: <;._2 ] , LF -. {:

NB. MimeMap is a tab-delimited mapping of file extensions to mime types.
NB. Edit as required
MimeMap=: 0 : 0
.*	application/octet-stream
.323	text/h323
.acx	application/internet-property-stream
.ai	application/postscript
.aif	audio/x-aiff
.aifc	audio/aiff
.aiff	audio/aiff
.application	application/x-ms-application
.asf	video/x-ms-asf
.asp	text/html
.asr	video/x-ms-asf
.asx	video/x-ms-asf
.au	audio/basic
.avi	video/x-msvideo
.axs	application/olescript
.bas	text/plain
.bcpio	application/x-bcpio
.bin	application/octet-stream
.bmp	image/bmp
.c	text/plain
.cat	application/vndms-pkiseccat
.cdf	application/x-cdf
.cer	application/x-x509-ca-cert
.clp	application/x-msclip
.cmx	image/x-cmx
.cod	image/cis-cod
.cpio	application/x-cpio
.crd	application/x-mscardfile
.crl	application/pkix-crl
.crt	application/x-x509-ca-cert
.csh	application/x-csh
.css	text/css
.csv	application/octet-stream
.dcr	application/x-director
.deploy	application/octet-stream
.der	application/x-x509-ca-cert
.dib	image/bmp
.dir	application/x-director
.disco	text/xml
.dll	application/x-msdownload
.doc	application/msword
.dot	application/msword
.dvi	application/x-dvi
.dxr	application/x-director
.eml	message/rfc822
.eps	application/postscript
.etx	text/x-setext
.evy	application/envoy
.exe	application/octet-stream
.fif	application/fractals
.flr	x-world/x-vrml
.gif	image/gif
.gtar	application/x-gtar
.gz	application/x-gzip
.h	text/plain
.hdf	application/x-hdf
.hlp	application/winhlp
.hqx	application/mac-binhex40
.hta	application/hta
.htc	text/x-component
.htm	text/html
.html	text/html
.htt	text/webviewhtml
.ico	image/x-icon
.ief	image/ief
.iii	application/x-iphone
.ins	application/x-internet-signup
.isp	application/x-internet-signup
.IVF	video/x-ivf
.jfif	image/pjpeg
.jhp	text/html
.jpe	image/jpeg
.jpeg	image/jpeg
.jpg	image/jpeg
.js	application/x-javascript
.latex	application/x-latex
.lsf	video/x-la-asf
.lsx	video/x-la-asf
.m13	application/x-msmediaview
.m14	application/x-msmediaview
.m1v	video/mpeg
.m3u	audio/x-mpegurl
.man	application/x-troff-man
.manifest	application/x-ms-manifest
.mdb	application/x-msaccess
.me	application/x-troff-me
.mht	message/rfc822
.mhtml	message/rfc822
.mid	audio/mid
.mmf	application/x-smaf
.mny	application/x-msmoney
.mov	video/quicktime
.movie	video/x-sgi-movie
.mp2	video/mpeg
.mp3	audio/mpeg
.mpa	video/mpeg
.mpe	video/mpeg
.mpeg	video/mpeg
.mpg	video/mpeg
.mpp	application/vnd.ms-project
.mpv2	video/mpeg
.ms	application/x-troff-ms
.mvb	application/x-msmediaview
.nc	application/x-netcdf
.nws	message/rfc822
.oda	application/oda
.ods	application/oleobject
.p10	application/pkcs10
.p12	application/x-pkcs12
.p7b	application/x-pkcs7-certificates
.p7c	application/pkcs7-mime
.p7m	application/pkcs7-mime
.p7r	application/x-pkcs7-certreqresp
.p7s	application/pkcs7-signature
.pbm	image/x-portable-bitmap
.pdf	application/pdf
.pfx	application/x-pkcs12
.pgm	image/x-portable-graymap
.pko	application/vndms-pkipko
.pma	application/x-perfmon
.pmc	application/x-perfmon
.pml	application/x-perfmon
.pmr	application/x-perfmon
.pmw	application/x-perfmon
.png	image/png
.pnm	image/x-portable-anymap
.pnz	image/png
.pot	application/vnd.ms-powerpoint
.ppm	image/x-portable-pixmap
.pps	application/vnd.ms-powerpoint
.ppt	application/vnd.ms-powerpoint
.prf	application/pics-rules
.ps	application/postscript
.pub	application/x-mspublisher
.qt	video/quicktime
.ra	audio/x-pn-realaudio
.ram	audio/x-pn-realaudio
.ras	image/x-cmu-raster
.rgb	image/x-rgb
.rmi	audio/mid
.roff	application/x-troff
.rtf	application/rtf
.rtx	text/richtext
.scd	application/x-msschedule
.sct	text/scriptlet
.setpay	application/set-payment-initiation
.setreg	application/set-registration-initiation
.sh	application/x-sh
.shar	application/x-shar
.sit	application/x-stuffit
.smd	audio/x-smd
.smx	audio/x-smd
.smz	audio/x-smd
.snd	audio/basic
.spc	application/x-pkcs7-certificates
.spl	application/futuresplash
.src	application/x-wais-source
.sst	application/vndms-pkicertstore
.stl	application/vndms-pkistl
.stm	text/html
.sv4cpio	application/x-sv4cpio
.sv4crc	application/x-sv4crc
.t	application/x-troff
.tar	application/x-tar
.tcl	application/x-tcl
.tex	application/x-tex
.texi	application/x-texinfo
.texinfo	application/x-texinfo
.tgz	application/x-compressed
.tif	image/tiff
.tiff	image/tiff
.tr	application/x-troff
.trm	application/x-msterminal
.tsv	text/tab-separated-values
.txt	text/plain
.uls	text/iuls
.ustar	application/x-ustar
.vcf	text/x-vcard
.wav	audio/wav
.wbmp	image/vnd.wap.wbmp
.wcm	application/vnd.ms-works
.wdb	application/vnd.ms-works
.wks	application/vnd.ms-works
.wmf	application/x-msmetafile
.wps	application/vnd.ms-works
.wri	application/x-mswrite
.wrl	x-world/x-vrml
.wrz	x-world/x-vrml
.wsdl	text/xml
.xaf	x-world/x-vrml
.xbm	image/x-xbitmap
.xla	application/vnd.ms-excel
.xlc	application/vnd.ms-excel
.xlm	application/vnd.ms-excel
.xls	application/vnd.ms-excel
.xlt	application/vnd.ms-excel
.xlw	application/vnd.ms-excel
.xml	text/xml
.xof	x-world/x-vrml
.xpm	image/x-xpixmap
.xsd	text/xml
.xsl	text/xml
.xwd	image/x-xwindowdump
.z	application/x-compress
.zip	application/x-zip-compressed
)