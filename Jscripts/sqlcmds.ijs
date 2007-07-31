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