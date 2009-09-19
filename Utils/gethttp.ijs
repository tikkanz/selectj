NB. =========================================================
NB. J interface for Wget/cURL to retrieve contents
require 'task'

coclass 'rgsgethttp'

IFCURL=: IFUNIX *. UNAME-:'Darwin'
HTTPCMD=: (jpath '~tools/ftp/')&,^:(-.IFUNIX) 'wget'
HTTPCMD=: IFCURL{:: HTTPCMD;'curl'

3 : 0 ''
  if. IFUNIX do.   NB. fix task.ijs definition of spawn on mac/unix
    spawn=: [: 2!:0 '(' , ' || true)' ,~ ]
  end.
  ''
)

NB. Simple tacit version that suppresses errors & returns file contents to stdout
NB. require 'task'
NB. ifcurl=. IFUNIX *. UNAME-:'Darwin'
NB. opts=. ifcurl{:: ' -O - -q ';' -o - -s -S '
NB. httpcmd=. (jpath '~tools/ftp/')&,^:(-.IFUNIX) 'wget'
NB. httpcmd=. ifcurl{:: httpcmd;'curl'
NB. getHTTP=: spawn httpcmd , opts , ]

NB.*getHTTP v Retrieve URI using Wget/cURL tools
NB. [option] getHTTP uri
NB. result: depends on options, Default is URI contents
NB. y is: URI to retrieve
NB. x is: Optional retrieval options. One of:
NB.       'stdout' (Default)
NB.       'help'
NB.       'file' or ('file';jpath '~temp/myfile.htm')
NB.       Anything else is assumed to be a valid Wget/cURL option string
NB. eg: 'file' getHTTP 'http://www.jsoftware.com'
NB. eg: ('-o - --stderr ',jpath '~temp/gethttp.log') getHTTP 'http://www.jsoftware.com'
getHTTP=: 3 : 0
  'stdout' getHTTP y
:
  url=. y
  'jopts fnme'=. 2{. boxopen x
  select. jopts
  case. 'stdout' do.  NB. content retrieved from stdout, log suppressed
    opts=. IFCURL{:: '-O - -q';'-o - -s -S'
  case. 'file' do. 
    if. #fnme do.     NB. save as filename
      opts=. IFCURL{:: '-O ';'-o '
      opts=. opts,fnme
    else.             NB. copy file to current dir
      opts=. IFCURL{:: ' ';'-O'
    end.
  case. 'help' do.    NB. help
    opts=. '--help'
  case. do.           NB. custom option string?
    if. 2 131072 e.~ 3!:0 x do. opts=. x
    else. 'Invalid left argument for getHTTP' return. end.
  end.
  opts=. ' ',opts,' '
  spawn HTTPCMD , opts , url
)
NB. =========================================================
NB. Export z locale

getHTTP_z_ =: getHTTP_jgethttp_

NB. =========================================================
NB. Tests

Note 'test commands for getHTTP'
  1!:44 jpath '~temp' NB. ensure in user writeable folder
  getHTTP 'http://www.jsoftware.com'
  'stdout' getHTTP 'http://www.jsoftware.com'
  'help' getHTTP ''
  'file' getHTTP 'http://www.jsoftware.com/index.html'
  ('file';'') getHTTP 'http://www.jsoftware.com/index.html'
  ('file';jpath '~temp/jindex.htm') getHTTP 'http://www.jsoftware.com'
)

Note 'Test raw options for Wget (Windows/Linux)'
  NB. The following use raw Wget options.
  NB. content retrieved from stdout, log suppressed
  ]cnt=. '-O - -q' getHTTP 'http://www.jsoftware.com'
  NB. content & log retrieved from stdout
  ]all=. ('-O -') getHTTP 'http://www.jsoftware.com'
  NB. content retrieved from stdout, log saved to file
  ]cnt=. ('-O - -o ',jpath '~temp/gethttp.log') getHTTP 'http://www.jsoftware.com'
  NB. file copied to current dir, log suppressed
  '-q' getHTTP 'http://www.jsoftware.com'
  NB. file copied to current dir, log retrieved from stdout
  ]log=. '' getHTTP 'http://www.jsoftware.com'
  NB. file copied to current dir, log saved to file
  ('-o ',jpath '~temp/gethttp.log') getHTTP 'http://www.jsoftware.com'
  NB. content saved to file, log suppressed
  ('-O ',(jpath '~temp/jindex.htm'),' -q') getHTTP 'http://www.jsoftware.com'
  NB. content saved to file, log retrieved from stdout
  ]log=. ('-O ',jpath '~temp/jindex.htm') getHTTP 'http://www.jsoftware.com'
  NB. content saved to file, log saved to file
  ('-O ',(jpath '~temp/jindex.htm'),' -o ',jpath '~temp/gethttp.log') getHTTP 'http://www.jsoftware.com'
)

Note 'Test raw options for cURL (Mac)'
  NB. The following use raw cURL options. (untested)
  NB. content retrieved from stdout, log suppressed
  ]cnt=. '-o - -s -S' getHTTP 'http://www.jsoftware.com'
  NB. content & log retrieved from stdout
  ]all=. ('-o - --stderr -') getHTTP 'http://www.jsoftware.com'
  NB. content retrieved from stdout, log saved to file
  ]cnt=. ('-o - --stderr ',jpath '~temp/gethttp.log') getHTTP 'http://www.jsoftware.com'
  NB. file copied to current dir, log suppressed
  '-O -s -S' getHTTP 'http://www.jsoftware.com/index.html'
  NB. file copied to current dir, log retrieved from stdout
  ]log=. '-O --stderr -' getHTTP 'http://www.jsoftware.com/index.html'
  NB. file copied to current dir, log saved to file
  ('-O --stderr ',jpath '~temp/gethttp.log') getHTTP 'http://www.jsoftware.com/index.html'
  NB. content saved to file, log suppressed
  ('-o ',(jpath '~temp/jindex.htm'),' -s -S') getHTTP 'http://www.jsoftware.com'
   NB. content saved to file, log retrieved from stdout
  ]log=. ('-o ',(jpath '~temp/jindex.htm'),' --stderr -') getHTTP 'http://www.jsoftware.com'
  NB. content saved to file, log saved to file
  ('-o ',(jpath '~temp/jindex.htm'),' --stderr ',jpath '~temp/gethttp.log') getHTTP 'http://www.jsoftware.com'
  NB. help
  '--help' getHTTP ''
)
