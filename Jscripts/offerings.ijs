NB. verbs for working with courses and course offerings

NB.*getOfferingText v Returns requested textblock for offering
NB. returns boxed list of blocktype name and textblock for offering of requested blocktype
NB. or if none directly specified returns default textblock for blocktype
NB. y is offering id
NB. x is optional blocktype id. Default is 200 (offintro)
getOfferingText=: 3 : 0
  200 getOfferingText y
  :
  'btid ofid'=. x;y
  if. 0=#res=. 'offeringtext' getInfo ofid;btid do.
    res=. 'defaulttext' getInfo btid
  end.
  res
)

NB.*getOfferingxbids v Returns id of textblock for offering and blocktype
NB. result is numeric list of textblock ids for offering and blocktype.
NB. y is 1 or 2-item numeric list OR 1 or 2-column numeric table
NB.       0{"1 offering ids.
NB.       1{"1 blocktype ids. Optional, defaults to 200 (offintro)
getOfferingxbids=: 3 : 0"1
  assert. 2>:{:$y
  'ofid btid'=. 2{.!.200 y
  if. 0= xbid=. existOfferingsText ofid,btid do. NB. using default xbid
    xbid=. 'defaulttextid' getInfo btid
  end.
  xbid
)

NB.*existOfferingsText v checks to see if textblock type is specified for an offering(s)
NB. result is numeric list of textblock ids if specifed else 0s if not.
NB. y is numeric table of 0{"1 offering ids
NB.                      1{"1 blocktype ids. Optional, defaults to
existOfferingsText=: 3 : 0"1
  assert. 2>:{:$y
  'ofid btid'=. 2{.!.200 y
  xbid=. 'offeringxbid' getInfo boxopen"0 ofid,btid
  if. xbid-: empty'' do. 0 else. xbid end.
)

NB.*getCasexbids v Returns id of textblock for case and blocktype
NB. result is numeric list of textblock ids for case and blocktype.
NB. y is 1 or 2-item numeric list OR 1 or 2-column numeric table
NB.       0{"1 case ids.
NB.       1{"1 blocktype ids. Optional, defaults to 1 (caseintro)
getCasexbids=: 3 : 0"1
  assert. 2>:{:$y
  'csid btid'=. 2{.!.1 y NB. default btid is 1
  if. 0= xbid=. existCasesText csid,btid do. NB. using default xbid
    xbid=. 'defaulttextid' getInfo btid
  end.
  xbid
)

NB.*existCasesText v checks to see if textblock type is specified for a case(s)
NB. result is numeric list of textblock ids if specifed else 0s if not.
NB. y is numeric table of 0{"1 case ids
NB.                      1{"1 blocktype ids. Optional, defaults to 1 (caseintro)
existCasesText=: 3 : 0"1
  assert. 2>:{:$y
  'csid btid'=. 2{.!.1 y  NB. default btid is 1
  xbid=. 'casexbid' getInfo boxopen"0 csid,btid
  if. xbid-: empty'' do. 0 else. xbid end.
)

NB.*getCaseText v Returns requested textblock for case
NB. returns textblock for case of requested blocktype
NB. or if none directly specified returns default textblock for blocktype
NB. y is case id
NB. x is optional blocktype id. Default is 1 (caseintro)
getCaseText=: 3 : 0
  1 getCaseText y
  :
  'btid csid'=. x;y
  if. 0=#res=. 'casetext' getInfo csid;btid do.
    res=. 'defaulttext' getInfo btid
  end.
  res
)

NB.*getMsg v Returns requested message class and text.
NB. returns 2-item boxed list of 0{:: msg text
NB.                              1{:: msg class
NB. y is literal of message to use instead of 
NB. x is literal of mx_code
getMsg=: 4 : 0
  y=. 2{.boxopen y
  res=. 2{.boxopen 'msgtxt' getInfo x
  res=. (y-.a:) (I. a:~:y)} res
)