NB. =========================================================
NB. Verbs for extending the files script

require 'files task'

3 : 0 ''
  if. IFUNIX do.   NB. fix task.ijs definition of spawn on mac/unix
    spawn=: [: 2!:0 '(' , ' || true)' ,~ ]
    SHELL=: ''
    shell=: ''&$: : (spawn SHELL,])
  end.
  ''
)

NB. http://www.jsoftware.com/pipermail/general/2005-October/024973.html
NB. renamefile =: [: : ((0&{::) @ ('MoveFile' win32api) @ , "0~) 

NB.*frename v renames old file names (y) to new file names (x)
NB. result: The file is renamed, and the result is 1 if successful
NB. y is: old file name (boxed character list)
NB. x is: new file name (boxed character list)
NB. frename=: [: : (('kernel32 MoveFileA i *c *c'&cd)@,.~)
frename=: [: : (>@:({."1)@:('kernel32 MoveFileW x *w *w'&cd)@,.~&(uucp&.>@boxopen))

NB.*frenameL v Long path version of frename
NB. to handle paths longer than ~256 chars need full (not relative) path
NB. and need to prepend with '\\?\'
frenameL=: 4 : 0"0&(uucp&.>@boxopen)
  names=. fpath &.> y,x      NB. convert relative filenames to full filenames using fpath below
  names=. '\\?\'&, &.> names NB. prepend '\\?\' as per MoveFileW
  0&{:: ('kernel32 MoveFileW x *w *w'&cd) names
)

NB.http://www.jsoftware.com/pipermail/general/2005-October/025148.html
NB.     host =: 13 : '2!:0 ''('',y.,'' || true)''' NB. ALWAYS return a result...
NB.     host 'mv oldname newname'   NB. to rename a file
NB.     host 'rm file'              NB. remove file

NB. shell 'mv oldname newname'


NB.*fpath v Returns full, canonical path to path y
NB. /../
NB. handle jpath paths (eg. ~temp/) outside fpath
fpath=: 3 : 0
  path=. jhostpath y
  s=. PATHSEP_j_
  NB. if not full path then catenate with current dir
      NB. check for ':\' as 2nd & 3rd letters or 2 slashes '\\' at start
  NB. resolve /./ and /../ to canonical path
     NB. http://www.jsoftware.com/jwiki/System/Library/Requests/spath
)

NB.!! fcopy
