NB.verbs for adminstering courses and course offerings

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
NB.     offeringstext(only if unique to offering), offeringcases(trigger), enrolments(trigger), caseinstances
NB. probably best just to make inactive by updating status to _1

NB.*updateOfferingsText v updates an offeringstext entry.
NB.     All offerings using that offeringstext entry are affected.
NB. result is 1 if successful
NB. y is of_id of an offering linked to the offeringstext entry to update
NB. x is literal list of new offering text
updateOfferingsText=: 4 : 0
  oxid=. 'offeringoxid' getInfo y
  0='updateofferingstext' updateInfo x;oxid
)

NB.*updateOfferingText v links Offering to new offeringstext entry.
NB.       only this offering is affected.
NB. result is 1 if successful
NB. y is numeric of_id of offering to update
NB. x is literal list of ox_intro contents to create entry for and link to
updateOfferingText=: 4 : 0
  oxid=. 'offeringoxid' getInfo y NB. oxid for this offering?
  if. 1<'countofferingsoxid' getInfo oxid do. NB. create new offeringstext and change of_oxid.
    oxid=. 'createofferingstext' insertInfo x
    0='updateofferingoxid' updateInfo oxid;y
  else. NB. oxid is unique to this offering so just update
    0='updateofferingstext' updateInfo x;oxid
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
