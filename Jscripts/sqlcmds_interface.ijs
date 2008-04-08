coclass 'rgssqliteq'

NB. =========================================================
NB. Interface SQL

sqlsel_usergreeting=: 0 : 0
  SELECT pp.pp_fname pp_fname,
         pp.pp_lname pp_lname
  FROM `users` ur INNER JOIN `people` pp ON ur.ur_ppid=pp.pp_id
  WHERE ur.ur_id=?;
)

sqlsel_usercourses=: 0 : 0
  SELECT off_info.of_id of_id ,
         off_info.cr_name cr_name ,
         off_info.cr_code cr_code ,
         off_info.of_year of_year ,
         off_info.sm_code sm_code ,
         off_info.dm_code dm_code ,
         off_info.pp_adminfname pp_adminfname ,
         off_info.pp_adminlname pp_adminlname ,
         rl.rl_name rl_name 
  FROM  offering_info off_info INNER JOIN enrolments en ON ( off_info.of_id = en.en_ofid ) 
        INNER JOIN roles rl ON ( en.en_rlid = rl.rl_id ) 
  WHERE (en.en_urid =?) 
   AND (off_info.of_status >0) 
   AND NOT EXISTS (
     SELECT  off_info2.of_id of_id , 
             rl2.rl_id FROM offering_info off_info2
     INNER JOIN enrolments en2 ON ( off_info2.of_id = en2.en_ofid ) 
     INNER JOIN roles rl2 ON ( en2.en_rlid = rl2.rl_id )
     WHERE (en2.en_urid == en.en_urid) 
       AND (off_info2.of_status >0) 
       AND (off_info2.of_id == off_info.of_id) 
       AND (rl2.rl_id > rl.rl_id)
     ) -- end select do not remove this SQL comment otherwise bracket closes noun
  GROUP BY of_id
  ORDER BY off_info.cr_code  Asc, off_info.of_year  Asc;
)

NB. gets effective role of user for a course offering
NB. i.e. role with highest rl_id
sqlsel_effrole=: 0 : 0
  SELECT off_info.of_id of_id ,
         rl.rl_id rl_id ,
         rl.rl_name rl_name 
  FROM  offering_info off_info INNER JOIN enrolments en ON ( off_info.of_id = en.en_ofid ) 
        INNER JOIN roles rl ON ( en.en_rlid = rl.rl_id ) 
  WHERE (en.en_urid =?) 
    AND (off_info.of_id=?) 
    AND NOT EXISTS (
      SELECT  off_info2.of_id of_id , 
              rl2.rl_id FROM offering_info off_info2
      INNER JOIN enrolments en2 ON ( off_info2.of_id = en2.en_ofid ) 
      INNER JOIN roles rl2 ON ( en2.en_rlid = rl2.rl_id )
      WHERE (en2.en_urid == en.en_urid) 
        AND (off_info2.of_id == off_info.of_id) 
        AND (rl2.rl_id > rl.rl_id)
      ) -- end select do not remove this SQL comment otherwise bracket closes noun
  GROUP BY of_id
)

sqlsel_coursedetails=: 0 : 0
SELECT off_info.of_id of_id,
      off_info.cr_name cr_name,
      off_info.cr_code cr_code,
      off_info.of_year of_year,
      off_info.sm_code sm_code,
      off_info.dm_code dm_code,
      off_info.pp_adminfname pp_adminfname,
      off_info.pp_adminlname pp_adminlname,
      ox.ox_intro ox_intro
FROM  `offeringstext`  ox
      INNER JOIN `offerings` off ON (ox.ox_id = off.of_oxid) 
      INNER JOIN `offering_info` off_info ON (off.of_id = off_info.of_id) 
WHERE (off_info.of_id=?)
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

NB. return case and case instance info for all stored case instances
NB. for the user offering
sqlsel_coursesumrys=: 0 : 0
  SELECT ci.ci_id ci_id ,
         sd.sd_code sd_code ,
         sd.sd_name sd_name ,
         sd.sd_descr sd_descr ,
         ci.ci_usrname ci_usrname ,
         ci.ci_usrdescr ci_usrdescr 
  FROM   main.`scendefs` sd INNER JOIN main.`cases` cases ON ( `sd`.`sd_id` = `cases`.`cs_sdid` ) 
         INNER JOIN main.`caseinstances` ci ON ( `cases`.`cs_id` = `ci`.`ci_csid` ) 
  WHERE  (ci.ci_urid =?) AND (ci.ci_ofid =?) AND (ci.ci_stored =1)
  ORDER BY ci.ci_id  Asc, ci.ci_csid  Asc;
)

sqlsel_casestage=: 0 : 0
  SELECT ci.ci_stage ci_stage ,
         ci.ci_stored ci_stored
  FROM  `caseinstances`  ci 
  WHERE (ci.ci_id =?);
)

sqlupd_casestage=: 0 : 0
  UPDATE caseinstances
  SET ci_stage=?
  WHERE (ci_id=?);
)

sqlsel_casedetails=: 0 : 0
  SELECT sd.sd_name sd_name ,
         sd.sd_code sd_code ,
         sd.sd_descr sd_descr ,
         xn.xn_name xn_name ,
         cx.cx_text cx_text
FROM  `scendefs` sd INNER JOIN `cases` cs ON ( `sd`.`sd_id` = `cs`.`cs_sdid` ) 
      INNER JOIN `casestext` cx ON ( `cs`.`cs_id` = `cx`.`cx_csid` ) 
      INNER JOIN `textblocks` xn ON ( `xn`.`xn_id` = `cx`.`cx_xnid` ) 
WHERE (cs.cs_id =?) AND (xn.xn_id =?);
)

sqlsel_param=: 0 : 0
  SELECT pr.pr_class pr_class ,
         pr.pr_name pr_name ,
         fp.fp_label fp_label ,
         pr.pr_note pr_note ,
         fp.fp_note fp_note ,
         pr.pr_class pr_class ,
         fp.fp_class fp_class ,
         pr.pr_ctype pr_ctype ,
         fp.fp_ctype fp_ctype ,
         pr.pr_cprops pr_cprops ,
         fp.fp_cprops fp_cprops ,
         pr.pr_code pr_code 
  FROM `params` pr INNER JOIN `fieldsetparams` fp ON ( `pr`.`pr_id` = `fp`.`fp_prid` ) 
  WHERE (fp.fp_fsid=? AND fp.fp_prid =?);
)

sqlsel_fieldset=: 0 : 0
  SELECT fs.fs_name fs_name ,
         fp.fp_fsid fs_id ,
         fp.fp_prid pr_id 
  FROM  `fieldsets` fs INNER JOIN `fieldsetparams` fp ON ( `fs`.`fs_id` = `fp`.`fp_fsid` ) 
  WHERE (fs.fs_id =?);
)


sqlsel_paramform=: 0 : 0
  SELECT cf.cf_fsid fs_id ,
         cf.cf_value cf_value 
  FROM  `cases` cs INNER JOIN `caseinstances` ci ON ( `cs`.`cs_id` = `ci`.`ci_csid` ) 
        INNER JOIN `casefieldsets` cf ON ( `cs`.`cs_id` = `cf`.`cf_csid` ) 
  WHERE (ci.ci_id =?);
)