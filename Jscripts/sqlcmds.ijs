coclass 'rgssqliteq'

NB.! rgssqliteq should probably be coinserted in path of the locale
NB.! containing the SQL commands (call it rgssqlcmds)

NB. =========================================================
NB. Login, validate & register users/sessions

NB. sqlsel_userid=: 0 : 0
NB.   SELECT users.ur_id ur_id
NB.   FROM users
NB.   WHERE users.ur_uname=?;
NB. )
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

sqlins_newenrolment=: 0 : 0
  INSERT INTO enrolments (en_urid,en_ofid,en_rlid)
  VALUES (?,?,?);
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

sqlsel_caseinstbasics=: 0 : 0
  SELECT ci.ci_urid urid ,
         ci.ci_ofid ofid ,
         ci.ci_csid csid
  FROM  `caseinstances` ci 
  WHERE (ci.ci_id =?);
)

sqlsel_scendefpath=: 0 : 0
  SELECT sd.sd_code sd_code 
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
  SELECT bt_id,
         bt_name
  FROM   blocktypes;
)

NB. =========================================================
NB. Case SQL

sqlsel_animinipath=: 0 : 0
  SELECT sd.sd_filen sd_filen 
  FROM  `cases` cases INNER JOIN `caseinstances` ci ON ( `cases`.`cs_id` = `ci`.`ci_csid` ) 
        INNER JOIN `scendefs` sd ON ( `sd`.`sd_id` = `cases`.`cs_sdid` ) 
  WHERE (ci.ci_id =?);
)

NB. =========================================================
NB. Admin SQL

sqlsel_userlist=: 0 : 0
  SELECT ur.ur_id ur_id ,
         ur.ur_uname ur_uname ,
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
  WHERE ur_id=?;
)

sqlins_createoffering=: 0 : 0
  INSERT INTO offerings (of_crid,of_year,of_smid,of_dmid,of_admin)
  VALUES (?,?,?,?,?);
)

sqlsel_existoffering=: 0 : 0
  SELECT of.of_id of_id 
  FROM `offerings` of
  WHERE (of.of_crid =?) 
    AND (of.of_year =?)
    AND (of.of_smid =?)
    AND (of.of_dmid =?);
)

sqlsel_existofferingcases=: 0 : 0
  SELECT oc.rowid rowid 
  FROM `offeringcases` oc
  WHERE (oc.oc_ofid IN (?)) 
    AND (oc.oc_csid IN (?));
)

sqlins_addofferingcases=: 0 : 0
  INSERT INTO offeringcases (oc_ofid,oc_csid)
  VALUES(?,?);
)

sqlupd_deleteofferingcases=: 0 : 0
  DELETE FROM offeringcases
  WHERE rowid=?;
)

sqlins_createofferingstext=: 0 : 0
  INSERT INTO offeringstext (ox_ofid,ox_btid,ox_xbid)
  VALUES(?,?,?);
)

sqlins_createtextblock=: 0 : 0
  INSERT INTO textblocks (xb_text)
  VALUES(?);
)

sqlins_updatetextblock=: 0 : 0
  UPDATE textblocks 
  SET xb_text=?
  WHERE xb_id=?;
)

sqlupd_updateofferingxbid=: 0 : 0
  UPDATE offeringstext
  SET ox_xbid=?
  WHERE (ox_ofid=?) AND (ox_btid=?);
)

sqlsel_offeringxbid=: 0 : 0
  SELECT ox_xbid
  FROM  offeringstext
  WHERE  (ox_ofid=?)
         AND (ox_btid=?);
)

sqlsel_countofferingxbid=: 0 : 0
  SELECT count(ox_xbid) cnt_xbid
  FROM offeringstext
  WHERE ox_xbid=?;
)

sqlins_createcasestext=: 0 : 0
  INSERT INTO casestext (cx_csid,cx_btid,cx_xbid)
  VALUES(?,?,?);
)

sqlupd_updatecasexbid=: 0 : 0
  UPDATE casestext
  SET cx_xbid=?
  WHERE (cx_csid=?) AND (cx_btid=?);
)

sqlsel_casexbid=: 0 : 0
  SELECT cx_xbid
  FROM  casestext
  WHERE  (cx_csid=?)
         AND (cx_btid=?);
)

sqlsel_countcasexbid=: 0 : 0
  SELECT count(cx_xbid) cnt_xbid
  FROM casestext
  WHERE cx_xbid=?;
)

sqlsel_msgtxt=: 0 : 0
  SELECT mx_text,
         mx_class
  FROM   messagetext
  WHERE  mx_code=?;
)