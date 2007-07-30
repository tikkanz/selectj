coclass 'pselectdb'

NB. =========================================================
NB. Interface SQL

sqlsel_greeting=: 0 : 0
  SELECT pp.pp_fname pp_fname,
         pp.pp_lname pp_lname
  FROM `users` ur INNER JOIN `people` pp ON ur.ur_ppid=pp.pp_id
  WHERE ur.ur_id=?;
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
