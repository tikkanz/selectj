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


sqlsel_courses=: 0 : 0
  SELECT of_id,cr_code,cr_name,of_year,sm_code,dm_code,rl_name
  FROM (enrolments INNER JOIN roles ON en_rlid=rl_id)
       INNER JOIN
       (((offerings INNER JOIN courses ON of_crid=cr_id)
       INNER JOIN delivmodes ON of_dmid=dm_id)
       INNER JOIN semesters  ON of_smid=sm_id)
       ON en_ofid=of_id
  WHERE en_urid=1 AND of_status >0;
)

Notes 'link enrolments with names, roles, and course offering info'
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