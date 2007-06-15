NB. =========================================================
NB. SQL commands for Customised indexes application

sqlsel_Clients=: 0 : 0
  SELECT cl_lname,cl_initial,cl_id
  FROM clients
  WHERE cl_status=1
  ORDER BY cl_lname;
)

sqlsel_Address=: 0 : 0
  SELECT cl_lname,cl_fname,cl_title,cl_initial,
         cl_addr,cl_city,cl_email,cl_ph,cl_fax,cl_mob
  FROM clients
  WHERE cl_id=?;
)

sqlupd_Address=: 0 : 0
  UPDATE clients
  SET cl_lname=?,cl_fname=?,cl_title=?,cl_initial=?,
      cl_addr=?,cl_city=?,cl_email=?,cl_ph=?,cl_fax=?,cl_mob=?
  WHERE cl_id=?;
)

sqlins_Address=: 0 : 0
  INSERT INTO clients (cl_lname,cl_fname,cl_title,cl_initial,cl_addr,cl_city,cl_email,cl_ph,cl_fax,cl_mob)
  VALUES(?,?,?,?,?,?,?,?,?,?);
)

sqlsel_Scenario=: 0 : 0
  SELECT sc_year,sc_ewes2ram,sc_yrs_ram,sc_pct_lmb,
     sc_ret_elmb,sc_ret_ehog,sc_yrs_ewe,
     sc_cfw_ehog,sc_mfd_ehog,sc_cfw_ewe,sc_mfd_ewe,
     sc_ret_wlmb,sc_ret_whog,sc_yrs_weth,
     sc_cfw_whog,sc_mfd_whog,sc_cfw_weth,sc_mfd_weth
  FROM scenarios
  WHERE sc_client=?
  AND sc_validuntil IS NULL;
)
sqlsel_calcrevsScenario=: 0 : 0
  SELECT sc_ewes2ram, sc_yrs_ram, sc_pct_lmb, 
     sc_ret_elmb,sc_ret_wlmb,sc_ret_ehog,sc_ret_whog,
     sc_yrs_ewe,sc_yrs_weth,
     sc_cfw_ehog,sc_cfw_whog,sc_cfw_ewe,sc_cfw_weth,
     sc_mfd_ehog,sc_mfd_whog,sc_mfd_ewe,sc_mfd_weth
  FROM scenarios
  WHERE sc_id=?;
)

sqlupd_validScenario=: 0 : 0
  UPDATE scenarios
  SET sc_validuntil = ?
  WHERE sc_validuntil IS NULL AND sc_client=? ;
)

sqlins_Scenario=: 0 : 0
  INSERT INTO scenarios (sc_year,sc_client,sc_ewes2ram,sc_yrs_ram,sc_pct_lmb,sc_ret_elmb,sc_ret_ehog,sc_yrs_ewe,sc_cfw_ehog,sc_mfd_ehog,sc_cfw_ewe,sc_mfd_ewe,sc_ret_wlmb,sc_ret_whog,sc_yrs_weth,sc_cfw_whog,sc_mfd_whog,sc_cfw_weth,sc_mfd_weth)
  VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) ;
)

sqlsel_Price_Profile=: 0 : 0
  SELECT pp_year, pr_mfd, pr_price
  FROM (price_profiles INNER JOIN prices ON pp_id = pr_pp) 
       INNER JOIN revs ON pp_id = rv_pp
  WHERE rv_client=? AND rv_validuntil IS Null
  ORDER BY pr_mfd;
)

sqlsel_calcpricePrice_Profiles=: 0 : 0
  SELECT rv_id, pr_mfd, pr_price
  FROM (price_profiles INNER JOIN prices ON pp_id = pr_pp) 
       INNER JOIN revs ON pp_id = rv_pp
  WHERE rv_id=?
  ORDER BY rv_id,pr_mfd;
)

NB. sqlsel_choosePrice_Profile=: 0 : 0
NB. SELECT pr_pp, pp_year, pr_mfd, pr_price
NB. FROM (price_profiles INNER JOIN prices ON pp_id = pr_pp) LEFT JOIN revs ON pp_id = rv_pp
NB. WHERE (rv_validuntil Is Null AND rv_client=?) OR (pp_client Is Null)
NB. ORDER BY pp_client DESC, pp_year DESC, pr_mfd;
NB. )
sqlsel_choosePrice_Profile=: 0 : 0
SELECT pr_pp, pp_year, pr_mfd, pr_price
FROM (price_profiles INNER JOIN prices ON pp_id = pr_pp)
WHERE (pp_id=?) OR (pp_client Is Null)
ORDER BY pp_client DESC, pp_year DESC, pr_mfd;
)

sqlsel_currentPrice_Profile=: 0 : 0
SELECT rv_pp
FROM revs
WHERE rv_validuntil IS NULL AND rv_client=? ;
)

sqlins_newPrice_Profile=: 0 : 0
  INSERT INTO price_profiles (pp_year,pp_client)
  VALUES(?,?) ;
)
sqlins_newPrices=: 0 : 0
  INSERT INTO prices (pr_pp,pr_mfd,pr_price)
  VALUES(?,?,?) ;
)
sqlsel_REVs=: 0 : 0
  SELECT rv_year,rv_scenario,rv_pp,rv_cfw,rv_mfd,rv_value
  FROM revs
  WHERE rv_client=?
  AND rv_validuntil IS NULL;
)

sqlsel_chkoldREVs=: 0 : 0
  SELECT rv_id,rv_scenario,rv_pp,rv_cfw,rv_mfd,rv_value
  FROM revs
  WHERE rv_client=?
  AND rv_validuntil IS NULL;
)

sqlsel_all2updateREVs =: 0 : 0
  SELECT rv_id, rv_pp, rv_scenario
  FROM revs
  WHERE rv_validuntil IS NULL AND rv_mfd IS NULL
        AND rv_pp IS NOT NULL AND rv_scenario IS NOT NULL;
)

sqlsel_updateclientREVs =: 0 : 0
  SELECT rv_id, rv_pp, rv_scenario
  FROM revs
  WHERE rv_client=? AND rv_validuntil IS NULL;
)

sqlupd_fkeysREVs=: 0 : 0
  UPDATE revs
  SET rv_scenario=?,rv_pp=?
  WHERE rv_id=?;
)

sqlupd_validREVs=: 0 : 0
  UPDATE revs
  SET rv_validuntil = ?
  WHERE rv_validuntil IS NULL AND rv_client=? ;
)

sqlupd_clientcalcREVs=: 0 : 0
  UPDATE revs 
  SET rv_cfw=?,rv_mfd=?,rv_value=?
  WHERE rv_client=? AND rv_validuntil IS NULL;
)

sqlupd_calcREVs=: 0 : 0
  UPDATE revs 
  SET rv_cfw=?,rv_mfd=?,rv_value=?
  WHERE rv_id=? ;
)

sqlins_newREVs=: 0 : 0
  INSERT INTO revs (rv_year,rv_client,rv_scenario,rv_pp)
  VALUES(?,?,?,?) ;
)

sqlins_manREVs=: 0 : 0
  INSERT INTO revs (rv_year,rv_client,rv_cfw,rv_mfd,rv_value)
  VALUES(?,?,?,?,?) ;
)

sqlsel_Index_List=: 0 : 0
  SELECT rv_id,rv_client,rv_cfw,rv_mfd,rv_value
  FROM revs
  WHERE rv_client=? AND rv_validuntil IS NULL;
)

sqlsel_yrsCatalog=: 0 : 0
  SELECT ct_year
  FROM catalogs;
)

sqlsel_viewCatalog=: 0 : 0
  SELECT ct_catalog
  FROM catalogs
  WHERE ct_year=? ;
)

sqlins_impCatalog=: 0 : 0
  INSERT INTO catalogs (ct_year,ct_catalog)
  VALUES (?,?);
)

