NB. =========================================================
NB. works out menu to display on web page

NB.*getMenu v 

getMenu=: 3 : 0

bpage=: '' NB. page name (everything before .jhp) of URI
select. bpage
 case. 'course' do.
   NB. need userid and offeringid
   NB. getOfferingRole

 case. 'case' do.
   NB. need userid and offeringid and caseid
   NB. getCaseRole
   NB. get case instance id (could pass as arg too?)
   NB. get case stage (could pass as arg too?)
   NB. get action from URI
 case. do.  
   NB. no menu for all pages not specifed
end.


)

Note 'outline for verb'
Args to give to verb are:
  * page URI   (required)
  * userid     (optional)
  * offeringid (optional)
  * caseid     (optional)
verb could be monadic with boxed list y
verb could be dyadic, URI y, optional boxed list x

Not sure what to return yet.
  HTML,
  boolean list
  menu item ids/names
  menu item ids/names and boolean list
)
