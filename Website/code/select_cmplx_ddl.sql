-- This script creates the tables for Select - the Web interface of AnimalSim

-- Dropping tables users 

--begin transaction;
--drop table users;
--drop table passrecvry;
--commit;

-- Create the new tables

-- tables with no foreign keys
CREATE TABLE institutions (
  in_id    INTEGER NOT NULL PRIMARY KEY,
  in_name  CHAR(64) NOT NULL,  -- full name for institution eg. Massey University 
  in_code  CHAR(16) NOT NULL,  -- abbreviation eg. MU
  in_descr CHAR(100) DEFAULT NULL, -- description of institution
  in_addr  CHAR(200) DEFAULT NULL, -- institute postal address
  in_contact INTEGER REFERENCES people(pp_id));  --reference contact person in people table

CREATE TABLE delivmodes (
  dm_id    INTEGER NOT NULL PRIMARY KEY,
  dm_name  CHAR(32) NOT NULL,  -- full name for delivery mode eg. Extramural
  dm_code  CHAR(16) NOT NULL,  -- abbreviation eg. XM
  dm_descr CHAR(100) );        -- description of delivery mode eg. study by correspondence

CREATE TABLE semesters (
  sm_id    INTEGER NOT NULL PRIMARY KEY,
  sm_name  CHAR(32) NOT NULL,  -- full name for semester eg. Double Semester
  sm_code  CHAR(16) NOT NULL,  -- abbreviation eg. 1 or 12
  sm_descr CHAR(100) );        -- description/definition of semester

CREATE TABLE roles (
  rl_id    INTEGER NOT NULL PRIMARY KEY,
  rl_name  CHAR(32) NOT NULL,
  rl_code  CHAR(16) NOT NULL,  -- abbreviation eg. usr or admin
  rl_descr CHAR(100) );        -- description of roles

CREATE TABLE people (
  pp_id   INTEGER NOT NULL PRIMARY KEY,
  pp_fname  CHAR(32) NOT NULL,    -- first names
  pp_lname  CHAR(32) NOT NULL,    -- last names
  pp_pname  CHAR(32) DEFAULT NULL,-- preferred name
  pp_initls CHAR(8) DEFAULT NULL,-- initials
  pp_gendr  CHAR(8) DEFAULT NULL,-- gender
  pp_dob    INTEGER  DEFAULT NULL,-- date of birth (julianday)
  pp_email  CHAR(64) NOT NULL);   -- email here instead of user record for uniqueness? 

CREATE TABLE scendefs (
  sd_id    INTEGER NOT NULL PRIMARY KEY,
  sd_name  CHAR(32) NOT NULL,  -- full name of scenario
  sd_code  CHAR(16) NOT NULL,  -- abbreviation for scenario name
  sd_descr CHAR(100) DEFAULT NULL,  -- short description of scenario purpose
  sd_filen CHAR(100) ); -- filename of zip file containing scendef. Instead of file name could store files as BLOBS?

CREATE TABLE textblocks (  -- block of text used in interface
  xb_id     INTEGER NOT NULL PRIMARY KEY,
  xb_text   TEXT DEFAULT 'Lorem ipsum dolor sit.' );  -- block of text

CREATE TABLE blocktypes ( -- "types" of text blocks
  bt_id    INTEGER NOT NULL PRIMARY KEY,
  bt_name  CHAR(64) NOT NULL,  -- name for block type eg. 'Introduction' or 'Materials and Methods'
  bt_code  CHAR(16) NOT NULL,  -- code for block type eg. 'caseintro' or 'instruct' 
  bt_xbid  INTEGER REFERENCES textblocks(xb_id) DEFAULT 1); -- xb_id of default text for this block type     

CREATE TABLE fieldsets ( -- fieldsets available to a case form
  fs_id    INTEGER NOT NULL PRIMARY KEY,
  fs_name  CHAR(64) NOT NULL,  -- legend for fieldset eg. 'Population Size' or 'Age Structure'
  fs_code  CHAR(16) NOT NULL );  -- code for fieldset eg. 'popsz' or 'agestruct'

-- could have multiple entries with same
CREATE TABLE params ( -- names for fieldsets available to a case form
  pr_id    INTEGER NOT NULL PRIMARY KEY,
  pr_name  CHAR(64) DEFAULT NULL ,  -- default label/name for param eg. 'No. of cycles to select for'
  pr_code  CHAR(16) NOT NULL , -- code for param eg. 'ncycles' or 'trts2select'  
  pr_note  CHAR(128) DEFAULT NULL ,  -- default note for param eg. 'This does not include female replacements that are too young to mate'
  pr_class CHAR(16) DEFAULT NULL , -- default display as controlset or not
  pr_ctype CHAR(8)  DEFAULT 'input' , -- default form control type 'input';'select';'textarea'
  pr_cprops CHAR(128) DEFAULT NULL ); -- default form control properties for parameter

-- tables with foreign keys  
CREATE TABLE users (
	ur_id     INTEGER NOT NULL PRIMARY KEY,
	ur_ppid   INTEGER NOT NULL REFERENCES people(pp_id),
	ur_inid   INTEGER DEFAULT 1 REFERENCES institutions(in_id),
	ur_uname    CHAR(16)  UNIQUE NOT NULL, -- username 
	ur_passhash CHAR(32),                  -- hashed (salt + password)
	ur_salt     INTEGER,                   -- salt for creating hashed password
	ur_status   INTEGER NOT NULL DEFAULT 1,--status active (1) or not (0)
	ur_refnum   CHAR(16)  DEFAULT NULL);   --reference number -institution student/staff ID number
  --	ur_email     CHAR(30)  NOT NULL);  --email address - store in people instead

CREATE TABLE passrecvry (  -- table used to help users recover from forgotten password
  ps_id     INTEGER NOT NULL PRIMARY KEY,
  ps_urid   INTEGER NOT NULL,   -- uid to recover for
  ps_token  CHAR(32),  -- forgotten password recovery token
  ps_tstamp REAL);   -- timestamp for tokens (julianday.time) 

CREATE TABLE courses (  -- courses offered by each institution
  cr_id     INTEGER NOT NULL PRIMARY KEY,
  cr_name   CHAR(64) NOT NULL,  -- course name
  cr_code   CHAR(16) NOT NULL,  -- course number/code eg. '117.010' or 'ANS-110'
  cr_descr  TEXT,          -- course description
  cr_inid   INTEGER NOT NULL REFERENCES institutions(in_id) );

CREATE TABLE offerings (  -- an offering of a course in terms of year, delivery mode and semester
  of_id     INTEGER NOT NULL PRIMARY KEY,
  of_crid   INTEGER NOT NULL REFERENCES courses(cr_id),
  of_year   INTEGER DEFAULT 2007,
  of_smid   INTEGER NOT NULL REFERENCES semesters(sm_id),
  of_dmid   INTEGER NOT NULL REFERENCES delivmodes(dm_id),
  of_admin  INTEGER DEFAULT NULL REFERENCES users(ur_id), -- Paper coordinator
--  of_oxid   INTEGER DEFAULT 1 REFERENCES offeringstext(ox_id),
  of_status INTEGER DEFAULT 1 );  

CREATE TABLE offeringstext (  -- text used in interface with offering
  ox_ofid  INTEGER NOT NULL REFERENCES offerings(of_id) ,
  ox_btid  INTEGER NOT NULL REFERENCES blocktypes(bt_id) DEFAULT 200,
  ox_xbid  INTEGER REFERENCES textblocks(xb_id) DEFAULT 3, -- id of text block
  PRIMARY KEY(ox_ofid,ox_btid) );

CREATE TABLE enrolments (  -- intersection of user, offering and user role for that offering
  en_urid   INTEGER NOT NULL REFERENCES users(ur_id),
  en_ofid   INTEGER NOT NULL REFERENCES offerings(of_id),
  en_rlid   INTEGER NOT NULL REFERENCES roles(rl_id),
  PRIMARY KEY(en_urid,en_ofid,en_rlid) );

CREATE TABLE sessions (   -- user sessions
  ss_id     INTEGER NOT NULL PRIMARY KEY,
  ss_urid   INTEGER NOT NULL REFERENCES users(ur_id),
  ss_salt   INTEGER, -- only need either salt or hash
  ss_hash   CHAR(32), -- don't think I need this. Just compare ticket hash to salthash of ticket id
  ss_status INTEGER DEFAULT 1, -- 0 inactive, 1 active
  ss_expire REAL );  -- date/time to expire stored as julianday.time
  -- make inactive or delete when logout/expire? could log start/end in separate table

CREATE TABLE cases (
  cs_id    INTEGER NOT NULL PRIMARY KEY,
  cs_sdid  INTEGER NOT NULL REFERENCES scendefs(sd_id),
  cs_admin INTEGER NOT NULL REFERENCES users(ur_id) ); -- case admin


CREATE TABLE casefieldsets ( -- fieldsets and setting for each scenario/case
  cf_csid  INTEGER NOT NULL REFERENCES cases(cs_id) ,
  cf_fsid  INTEGER NOT NULL REFERENCES fieldsets(fs_id) ,
  cf_value INTEGER DEFAULT 1 ,  -- value for option for case (-1 don't display; 1 display,enabled; 0 display,disabled)
  PRIMARY KEY(cf_csid,cf_fsid) );

CREATE TABLE fieldsetparams ( -- params and label for each fieldset
  fp_fsid   INTEGER NOT NULL REFERENCES fieldsets(fs_id) ,
  fp_prid   INTEGER NOT NULL REFERENCES params(pr_id) ,
  fp_label  CHAR(32) DEFAULT NULL ,  -- label to use for param in this fieldset
  fp_note   CHAR(128) DEFAULT NULL ,  -- note to use for param in this fieldset
  fp_class  CHAR(16)  DEFAULT NULL ,  -- class to use for param in this fieldset
  fp_ctype  CHAR(8)   DEFAULT NULL ,  -- control type to use for param in this fieldset
  fp_cprops CHAR(128) DEFAULT NULL ,  -- control properties to use for param in this fieldset
  PRIMARY KEY(fp_fsid,fp_prid) );

CREATE TABLE casestext (  -- text applicable to each scenario/case
  cx_csid  INTEGER NOT NULL REFERENCES cases(cs_id) ,
  cx_btid  INTEGER NOT NULL REFERENCES blocktypes(bt_id) ,
  cx_xbid  INTEGER DEFAULT 1 REFERENCES textblocks(xb_id) , -- id of text block
  PRIMARY KEY(cx_csid,cx_btid) );

CREATE TABLE caseroles (
  cl_csid INTEGER NOT NULL REFERENCES cases(cs_id),
  cl_urid INTEGER NOT NULL REFERENCES users(ur_id),
  cl_rlid INTEGER NOT NULL REFERENCES roles(rl_id),
  PRIMARY KEY(cl_csid,cl_urid,cl_rlid) );

CREATE TABLE offeringcases (  -- cases available for each offering
  oc_ofid INTEGER NOT NULL REFERENCES offerings(of_id) ,
  oc_csid INTEGER NOT NULL REFERENCES cases(cs_id),
  PRIMARY KEY(oc_ofid,oc_csid) );

CREATE TABLE caseinstances (  -- case instance for user offering
  ci_id INTEGER NOT NULL PRIMARY KEY, -- CaseInstance Id
  ci_urid  INTEGER NOT NULL REFERENCES users (ur_id),
  ci_ofid  INTEGER NOT NULL REFERENCES offerings (of_id),
  ci_csid  INTEGER NOT NULL REFERENCES cases (cs_id),
  ci_usrname  CHAR(32) DEFAULT NULL,   -- user's name for CaseInstance
  ci_usrdescr TEXT DEFAULT NULL, -- user's description for CaseInstance
  ci_stored   INTEGER DEFAULT 0, -- summary files stored? 0 no; 1 yes
  ci_stage    INTEGER DEFAULT 1 REFERENCES textblocks(xn_id),   -- stage, 
  ci_status   INTEGER DEFAULT 1);      -- 0 no longer current; 1 current

CREATE TABLE errors (
  er_id     INTEGER NOT NULL PRIMARY KEY,
  er_ssid   INTEGER NOT NULL REFERENCES sessions(ss_id),
  er_csid   INTEGER NOT NULL REFERENCES cases(cs_id),
  er_sdid   INTEGER NOT NULL REFERENCES scendefs(sd_id),
  er_errmsg CHAR(100) );  -- text of last error message   

-- rather than creating default entries, will look for entry & if it doesn't exist return the textblock specified by the default bt_xbid for that blocktype.
-- CREATE TRIGGER create_offtext
-- AFTER INSERT ON offerings
-- --insert a default entry in offeringstext for ox_ofid (ox_btid=200 & ox_xbid=3)
-- BEGIN
--   INSERT INTO offeringstext (ox_ofid) values (new.of_id);
-- END;
-- 
-- CREATE TRIGGER update_offtext_link
-- AFTER INSERT ON offeringstext
-- WHEN EXISTS(SELECT of_id FROM offerings WHERE of_crid=new.of_crid AND of_id != new.of_id)
-- --then if another offering with same course as new offering exists update ox_xbid to that of other offering
-- BEGIN
--   UPDATE offeringstext 
--   SET ox_xbid= 
--       (SELECT ox_xbid FROM offeringstext 
--        WHERE of_crid=new.of_crid AND of_id != new.of_id
--        ORDER BY of_smid,of_year DESC) 
--     WHERE of_id=new.of_id;
-- END;

--CREATE TRIGGER create_casetext -- creates placeholder for intro text for a case when it is created
--AFTER INSERT ON cases
--BEGIN
--       INSERT INTO casestext (cx_csid,cx_xnid)
--       VALUES (new.cs_id,1);
--END;


CREATE TRIGGER create_offadminrole
AFTER INSERT ON offerings
BEGIN
       INSERT INTO enrolments (en_urid,en_ofid,en_rlid)
       VALUES (new.of_admin,new.of_id,12);
--       INSERT INTO enrolmentroles (el_enid,el_rlid)
--       VALUES (last_insert_rowid(),12);
END;

CREATE TRIGGER create_caseowner
AFTER INSERT ON cases
BEGIN
       INSERT INTO caseroles (cl_csid,cl_urid,cl_rlid)
       VALUES (new.cs_id,new.cs_admin,50);
END;

CREATE TRIGGER delete_enrols
BEFORE DELETE ON users
BEGIN
     DELETE FROM enrolments
     WHERE en_urid=old.ur_id;
END;

CREATE TRIGGER delete_offering_enrolments
BEFORE DELETE ON offerings
BEGIN
     DELETE FROM enrolments
     WHERE en_ofid=old.of_id;
END;

CREATE TRIGGER deletecascade_offering
BEFORE DELETE ON offerings
BEGIN
     DELETE FROM offeringcases
     WHERE oc_ofid=old.of_id;
     DELETE FROM offeringstext
     WHERE ox_ofid=old.of_id;
END;

-- CREATE TRIGGER deletecascade_offeringstext
-- BEFORE DELETE ON offeringstext
-- the when statement needs to check that xbid is not used by any other offering
-- WHEN 1=SELECT count(ox_xbid) FROM offeringstext WHERE 
-- BEGIN
-- 		 DELETE FROM textblocks
-- 		 WHERE xb_id=old.ox_xbid
-- END;

CREATE VIEW `offering_info` AS 
SELECT of.of_id of_id ,
       cr.cr_id cr_id ,
       cr.cr_name cr_name ,
       cr.cr_code cr_code ,
       of.of_year of_year ,
       sm.sm_code sm_code ,
       dm.dm_code dm_code ,
       of.of_status of_status ,
       pp.pp_fname pp_adminfname ,
       pp.pp_lname pp_adminlname 
FROM  `semesters` sm INNER JOIN `offerings` of ON ( `sm`.`sm_id` = `of`.`of_smid` ) 
      INNER JOIN `delivmodes` dm ON ( `dm`.`dm_id` = `of`.`of_dmid` ) 
      INNER JOIN `users` ur ON ( `ur`.`ur_id` = `of`.`of_admin` ) 
      INNER JOIN `courses` cr ON ( `cr`.`cr_id` = `of`.`of_crid` ) 
      INNER JOIN `people` pp ON ( `pp`.`pp_id` = `ur`.`ur_ppid` ) 
WHERE (of.of_status >0);
