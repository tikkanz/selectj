NB.verbs for adminstering courses and course offerings

NB.*updateTextBlock v updates text in a textblock entry.
NB.    All items referencing that textblock are affected.
NB. result is 1 if successful
NB. y is xb_id of textblock to update
NB. x is literal list of new textblock text
updateTextBlock=: 4 : 0
  0='updatetextblock' updateInfo x;xbid
)

NB.*createOfferings v creates course offering(s)
NB. result is numeric list of offering ids created
NB. y is numeric table with row for each offering and columns for:
NB.      of_crid,of_year,of_smid,of_dmid,of_admin
createOfferings=: 3 : 0
  msk=. 0=existOfferings }:"1 y
  if. 0= +/msk do. '' return. end. NB.chk if no offerings to create
  'createoffering' insertInfo boxopen"0 msk#y
)

NB. deleteOfferings
NB.  need to first delete appropriate:
NB.     offeringstext, 
NB.     textblock, (only if unique to offering)
NB.     offeringcases(trigger), 
NB.     enrolments(trigger), 
NB.     caseinstances
NB. probably best just to make inactive by updating status to _1

NB.*updateOfferingsText v updates textblock for an Offering and blocktype.
NB.    All items referencing that textblock are affected.
NB. y is a 1 or 2-item numeric list of of_id [and bt_id] entry that uses the textblock to be updated
NB. x is literal list of new offering text
updateOfferingsText=: 4 : 0
  'ofid btid'=. 2{.!.200 y  NB. 200 is default btid for offering
  xbid=. btid existOfferingsText ofid
  x updateTextBlock xbid
)

NB.*updateOfferingText v links Offering to new offeringstext entry.
NB.       only this offering is affected.
NB. result is 1 if successful
NB. y is 2-item numeric list of of_id and bt_id corresponding to textblock to update
NB. x is literal list of xb_text contents to create entry for and link to
updateOfferingText=: 4 : 0
  'ofid btid'=. 2{.!.200 y   NB. 200 is default btid for offering
  if. xbid=. existOfferingsText ofid,btid do.  NB. not using default textblock
    if. 1<'countofferingxbid' getInfo xbid do. NB. other offeringstext use same textblock
      xbid=. 'createtextblock' insertInfo x  NB. create new textblock
      0='updateofferingxbid' updateInfo xbid;ofid;btid NB.  update ox_xbid
    else. NB. xbid is unique to this offering
      0= x updateTextBlock xbid  NB. update textblock
    end.
  else. NB. was using default textblock
    xbid=. 'createtextblock' insertInfo x  NB. create new textblock
    0< 'createofferingstext' insertInfo ofid;btid;xbid NB. create new offeringstext entry
  end.
)

NB.*updateOfferingxbid v links Offering to existing textblock entry.
NB.     textblock is not affected and is now potentially shared.
NB. result is 1 if successful
NB. y is 1 or 2-item numeric list of of_id and bt_id corresponding to textblock to update
NB. x is numeric xb_id of textblock to link to
updateOfferingxbid=: 4 : 0
  'ofid btid'=. 2{.!.200 y   NB. 200 is default btid for offering
  if. xbid=. existOfferingsText ofid,btid do.  NB. not using default textblock
    0='updateofferingxbid' updateInfo x;ofid;btid NB.  update ox_xbid
  else. NB. was using default textblock
    0= 'createofferingstext' insertInfo ofid;btid;x NB. create new offeringstext entry
  end.
)

NB.*updateCasesText v updates textblock for a Case and blocktype.
NB.    All items referencing that textblock are affected.
NB. y is a 1 or 2-item numeric list of cs_id [and bt_id] entry that uses the textblock to be updated
NB. x is literal list of new offering text
updateCasesText=: 4 : 0
  'csid btid'=. 2{.!.1 y  NB. 1 is default btid for case
  xbid=. btid existCasesText csid
  x updateTextBlock xbid
)

NB.*updateCaseText v links Case to new casestext entry.
NB.       only this case is affected.
NB. result is 1 if successful
NB. y is 2-item numeric list of cs_id and bt_id corresponding to textblock to update
NB. x is literal list of xb_text contents to create entry for and link to
updateCaseText=: 4 : 0
  'csid btid'=. 2{.!.1 y   NB. 1 is default btid for offering
  if. xbid=. existCasesText csid,btid do.  NB. not using default textblock
    if. 1<'countcasexbid' getInfo xbid do. NB. other casestext use same textblock
      xbid=. 'createtextblock' insertInfo x  NB. create new textblock
      0='updatecasexbid' updateInfo xbid;csid;btid NB.  update cx_xbid
    else. NB. xbid is unique to this offering
      0= x updateTextBlock xbid  NB. update textblock
    end.
  else. NB. was using default textblock
    xbid=. 'createtextblock' insertInfo x  NB. create new textblock
    0< 'createcasestext' insertInfo csid;btid;xbid NB. create new casestext entry
  end.
)

NB.*updateCasexbid v links Case to existing textblock entry.
NB.     textblock is not affected and is now potentially shared.
NB. result is 1 if successful
NB. y is 1 or 2-item numeric list of cs_id and bt_id corresponding to textblock to update
NB. x is numeric xb_id of textblock to link to
updateCasexbid=: 4 : 0
  'csid btid'=. 2{.!.1 y   NB. 1 is default btid for offering
  if. xbid=. existCasesText csid,btid do.  NB. not using default textblock
    0='updatecasexbid' updateInfo x;csid;btid NB.  update cx_xbid
  else. NB. was using default textblock
    0= 'createcasestext' insertInfo csid;btid;x NB. create new casestext entry
  end.
)

NB.*addOfferingCases v adds case(s) to offering(s)
NB. result is numeric list of new rowids in offeringcases table
NB. y is numeric list of case ids to add to each offering in x
NB. x is numeric list of offering ids to add cases in y to
addOfferingCases=: 4 : 0
  ofcs=. >,{x;y NB. get all offeringcase combinations
  msk=. 0=existOfferingCases ofcs NB. find out which don't already exist
  if. 0= +/msk do. '' return. end.
  'addofferingcases' insertInfo boxopen"0 msk#ofcs NB. create them
)

NB.*deleteOfferingCases v deletes case(s) from offering(s)
NB. result is numeric number of successful deletions
NB. y is numeric list of case ids to delete from offerings in x
NB. x is numberc list of offering ids to delete cases in y from
deleteOfferingCases=: 4 : 0
  ofcs=. >,{x;y NB. get all offeringcase combinations
  msk=. 0<rowids=. existOfferingCases ofcs NB. find out which already exist
  if. 0= +/msk do. '' return. end.
  +/ 0='deleteofferingcases' updateInfo boxopen"0 msk#rowids NB. delete them
)

NB.*existOfferingCases v checks to see if a case is specified for an offering
NB. result is the rowid if specifed else 0 if not
NB. y is numeric list of of_crid,of_year,of_smid,of_dmid 
existOfferingCases=: 3 : 0"1
  rowid=. 'existofferingcases' getInfo boxopen"0 y
  if. rowid-:empty'' do. 0 else. rowid end.
)

NB.*existOfferings v checks to see if an offering with same details exists
NB. result is the of_id if exists else 0 if no offering has
NB.        matching combination of of_crid,of_year,of_smid,of_dmid 
NB. y is numeric list of of_crid,of_year,of_smid,of_dmid 
existOfferings=: 3 : 0"1
  ofid=. 'existoffering' getInfo boxopen"0 y
  if. ofid-:empty'' do. 0 else. ofid end.
)

NB. createCourses
NB. deleteCourses
NB. editCourse
