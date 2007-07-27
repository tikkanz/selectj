coclass 'pselectdb'

sqlsel_userid=: 0 : 0
  SELECT users.ur_id ur_id
  FROM users
  WHERE users.ur_uname=?;
)
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

sqlsel_greeting=: 0 : 0
  SELECT pp.pp_fname pp_fname,
         pp.pp_lname pp_lname
  FROM `users` ur INNER JOIN `people` pp ON ur.ur_ppid=pp.pp_id
  WHERE ur.ur_id=?;
)

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

sqlsel_mycourses=: 0 : 0
  SELECT off_info.of_id of_id ,
         off_info.cr_name cr_name ,
         off_info.cr_code cr_code ,
         off_info.of_year of_year ,
         off_info.sm_code sm_code ,
         off_info.dm_code dm_code ,
         off_info.pp_adminfname pp_adminfname ,
         off_info.pp_adminlname pp_adminlname ,
         rl.rl_name rl_name 
  FROM `enrolments` en INNER JOIN `offering_info` off_info ON ( `en`.`en_ofid` = `off_info`.`of_id` ) 
        INNER JOIN `enrolmentroles` el ON ( `el`.`el_enid` = `en`.`en_id` ) 
        INNER JOIN `roles` rl ON ( `el`.`el_rlid` = `rl`.`rl_id` ) 
  WHERE (en.en_urid =?) AND (off_info.of_status >0)
  ORDER BY off_info.cr_code  Asc, off_info.of_year  Asc;
)

sqlsel_enrolled=: 0 : 0
  SELECT en.en_id en_id ,
         en.en_ofid en_ofid ,
         en.en_urid en_urid 
  FROM   `enrolments` en
  WHERE (en.en_ofid =?) AND (en.en_urid =?);
)

sqlsel_validcase=: 0 : 0
  SELECT en.en_urid ur_id ,
         en.en_ofid of_id ,
         oc.oc_csid cs_id 
  FROM  `enrolments` en INNER JOIN `offeringcases` oc ON ( `en`.`en_ofid` = `oc`.`oc_ofid` ) 
  WHERE (en.en_urid =?) AND (en.en_ofid =?) AND (oc.oc_csid =?);
)

sqlsel_course=: 0 : 0
  SELECT off_info.of_id of_id ,
        off_info.cr_name cr_name ,
        off_info.cr_code cr_code ,
        off_info.of_year of_year ,
        off_info.sm_code sm_code ,
        off_info.dm_code dm_code ,
        off_info.pp_adminfname pp_adminfname ,
        off_info.pp_adminlname pp_adminlname ,
        ox.ox_intro ox_intro 
  FROM `offering_info` off_info INNER JOIN `offeringstext` ox 
        ON ( `off_info`.`of_id` = `ox`.`ox_id` ) 
  WHERE (off_info.of_id =?);
)

sqlsel_coursename=: 0 : 0
  SELECT off_info.cr_name cr_name ,
         off_info.cr_code cr_code 
  FROM `offering_info` off_info
  WHERE (off_info.of_id =?);
)

sqlsel_coursecases=: 0 : 0
  SELECT sd.sd_name sd_name ,
        sd.sd_descr sd_descr ,
        sd.sd_id sd_id ,
        sd.sd_code sd_code ,
        oc.oc_csid cs_id 
  FROM  `scendefs` sd INNER JOIN `cases` cs ON ( `sd`.`sd_id` = `cs`.`cs_sdid` ) 
        INNER JOIN `offeringcases` oc ON ( `cs`.`cs_id` = `oc`.`oc_csid` ) 
  WHERE (oc.oc_ofid =?);
)

sqlsel_case=: 0 : 0
  SELECT sd.sd_descr cs_descr ,
         sd.sd_name cs_name ,
         sd.sd_code cs_code ,
         cx.cx_intro cx_intro 
  FROM  `cases` cs INNER JOIN `casestext` cx ON ( `cs`.`cs_id` = `cx`.`cx_id` ) 
        INNER JOIN `scendefs` sd ON ( `sd`.`sd_id` = `cs`.`cs_sdid` ) 
  WHERE (cs.cs_id =?);
)

Note 'link enrolments with names, roles, and course offering info'
  SELECT ur_uname,pp_fname,pp_lname,cr_id,cr_name,cr_code,of_year,dm_code,sm_code,rl_code
  FROM ((enrolments 
          INNER JOIN (users INNER JOIN people ON ur_ppid=pp_id) 
          ON en_urid=ur_id)
            INNER JOIN roles ON en_rlid=rl_id)
       INNER JOIN 
       (((offerings 
          INNER JOIN courses    ON of_crid=cr_id)
          INNER JOIN delivmodes ON of_dmid=dm_id)
          INNER JOIN semesters  ON of_smid=sm_id)
       ON en_ofid=of_id
  WHERE en_urid=1;
)