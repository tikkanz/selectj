coclass 'pselectdb'

NB. =========================================================
NB. Login, validate & register users/sessions

NB. sqlsel_userid=: 0 : 0
NB.   SELECT users.ur_id ur_id
NB.   FROM users
NB.   WHERE users.ur_uname=?;
NB. )
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
  WHERE ss_id=?
)
sqlupd_sessionexpire=: 0 : 0
  UPDATE sessions
  SET ss_status=0
  WHERE ss_id=?
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
  FROM  `scendefs` sd INNER JOIN `cases` cs ON ( `sd`.`sd_id` = `cs`.`cs_sdid` ) 
  WHERE (cs.cs_id =?);
)

sqlupd_expirecaseinst=: 0 : 0
  UPDATE caseinstances
  SET ci_status=0
  WHERE ci_id=?;
)

NB. =========================================================
NB. Admin SQL

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