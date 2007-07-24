coclass 'pselectdb'

sqlsel_userid=: 0 : 0
  SELECT ur_id
  FROM users
  WHERE ur_uname=?;
)
sqlsel_login=: 0 : 0
  SELECT ur_id, ur_uname, ur_passhash, ur_salt
  FROM users
  WHERE ur_uname=?;
)
sqlsel_status=: 0 : 0
  SELECT ur_status
  FROM users
  WHERE ur_id=?;
)

sqlsel_greeting=: 0 : 0
  SELECT pp_fname, pp_lname
  FROM users INNER JOIN people on ur_ppid=pp_id
  WHERE ur_id=?;
)

sqlsel_userlist=: 0 : 0
  SELECT ur_id,ur_status,pp_fname,pp_lname
  FROM users INNER JOIN people ON ur_ppid=pp_id;
)
sqlsel_userrec=: 0 : 0
  SELECT ur_id,pp_fname,pp_lname,ur_uname,ur_refnum,pp_email,ur_status,ur_salt,ur_passhash
  FROM users INNER JOIN people ON ur_ppid=pp_id
  WHERE ur_id=?;
)


sqlsel_email=: 0 : 0
  SELECT pp_id,pp_fname,pp_lname
  FROM people
  WHERE pp_email=?;
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
  SELECT offering_info.of_id of_id ,
        offering_info.cr_name cr_name ,
        offering_info.cr_code cr_code ,
        offering_info.of_year of_year ,
        offering_info.sm_code sm_code ,
        offering_info.dm_code dm_code ,
        offering_info.pp_adminfname pp_adminfname ,
        offering_info.pp_adminlname pp_adminlname ,
        roles.rl_name rl_name
  FROM offering_info INNER JOIN enrolments ON ( offering_info.of_id = enrolments.en_ofid ) 
        INNER JOIN roles ON ( roles.rl_id = enrolments.en_rlid ) 
  WHERE (offering_info.of_status >0) AND (enrolments.en_urid =?)
  ORDER BY offering_info.cr_code  Asc, offering_info.of_year  Asc;
)

sqlsel_enrolled=: 0 : 0
  SELECT enrolments.en_id en_id ,
         enrolments.en_ofid en_ofid ,
         enrolments.en_urid en_urid 
  FROM   enrolments 
  WHERE (enrolments.en_ofid =?) AND (enrolments.en_urid =?);
)

sqlsel_validcase=: 0 : 0

)

sqlsel_course=: 0 : 0
  SELECT offering_info.of_id of_id ,
        offering_info.cr_name cr_name ,
        offering_info.cr_code cr_code ,
        offering_info.of_year of_year ,
        offering_info.sm_code sm_code ,
        offering_info.dm_code dm_code ,
        offering_info.pp_adminfname pp_adminfname ,
        offering_info.pp_adminlname pp_adminlname ,
        offeringstext.ox_intro ox_intro 
  FROM `offering_info` offering_info INNER JOIN `offeringstext` offeringstext 
        ON ( `offering_info`.`of_id` = `offeringstext`.`ox_id` ) 
  WHERE (offering_info.of_id =?);
)

sqlsel_coursecases=: 0 : 0
  SELECT scendefs.sd_name sd_name ,
        scendefs.sd_descr sd_descr ,
        scendefs.sd_id sd_id ,
        scendefs.sd_code sd_code ,
        offeringcases.oc_id 
  FROM  `scendefs` scendefs INNER JOIN `cases` cases ON ( `scendefs`.`sd_id` = `cases`.`cs_sdid` ) 
        INNER JOIN `offeringcases` offeringcases ON ( `cases`.`cs_id` = `offeringcases`.`oc_csid` ) 
  WHERE (offeringcases.oc_ofid =?);
)

sqlsel_case=: 0 : 0

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