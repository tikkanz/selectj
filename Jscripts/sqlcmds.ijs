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
  SELECT ur_fname, ur_lname
  FROM users
  WHERE ur_id=?;
)

sqlsel_userlist=: 0 : 0
  SELECT ur_id,ur_status,ur_fname,ur_lname
  FROM users
)
sqlsel_userrec=: 0 : 0
  SELECT ur_id,ur_fname,ur_lname,ur_uname,ur_studentid,ur_email,ur_status,ur_salt,ur_passhash
  FROM users
  WHERE ur_id=?;
)

sqlins_newuser=: 0 : 0
  INSERT INTO users (ur_uname,ur_fname,ur_lname,ur_studentid,ur_email,ur_passhash,ur_salt)
  VALUES(?,?,?,?,?,?,?);
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