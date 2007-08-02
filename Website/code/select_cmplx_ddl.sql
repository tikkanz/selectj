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
  in_name  CHAR(50) NOT NULL,  -- full name for institution eg. Massey University 
  in_code  CHAR(15) NOT NULL,  -- abbreviation eg. MU
  in_descr CHAR(100) DEFAULT NULL, -- description of institution
  in_addr  CHAR(200) DEFAULT NULL, -- institute postal address
  in_contact INTEGER REFERENCES people(pp_id));  --reference contact person in people table

CREATE TABLE delivmodes (
  dm_id    INTEGER NOT NULL PRIMARY KEY,
  dm_name  CHAR(30) NOT NULL,  -- full name for delivery mode eg. Extramural
  dm_code  CHAR(10) NOT NULL,  -- abbreviation eg. XM
  dm_descr CHAR(100) );        -- description of delivery mode eg. study by correspondence

CREATE TABLE semesters (
  sm_id    INTEGER NOT NULL PRIMARY KEY,
  sm_name  CHAR(30) NOT NULL,  -- full name for semester eg. Double Semester
  sm_code  CHAR(10) NOT NULL,  -- abbreviation eg. 1 or 12
  sm_descr CHAR(100) );        -- description/definition of semester

CREATE TABLE roles (
  rl_id    INTEGER NOT NULL PRIMARY KEY,
  rl_name  CHAR(30) NOT NULL,
  rl_code  CHAR(10) NOT NULL,  -- abbreviation eg. usr or admin
  rl_descr CHAR(100) );        -- description of roles

CREATE TABLE people (
  pp_id   INTEGER NOT NULL PRIMARY KEY,
  pp_fname  CHAR(30) NOT NULL,    -- first names
  pp_lname  CHAR(30) NOT NULL,    -- last names
  pp_pname  CHAR(30) DEFAULT NULL,-- preferred name
  pp_initls CHAR(10) DEFAULT NULL,-- initials
  pp_gendr  CHAR(10) DEFAULT NULL,-- gender
  pp_dob    INTEGER  DEFAULT NULL,-- date of birth (julianday)
  pp_email  CHAR(40) NOT NULL);   -- email here instead of user record for uniqueness? 

CREATE TABLE scendefs (
  sd_id    INTEGER NOT NULL PRIMARY KEY,
  sd_name  CHAR(30) NOT NULL,  -- full name of scenario
  sd_code  CHAR(10) NOT NULL,  -- abbreviation for scenario name
  sd_descr CHAR(100) DEFAULT NULL,  -- short description of scenario purpose
  sd_filen CHAR(100) ); -- filename of zip file containing scendef. Instead of file name could store files as BLOBS?

CREATE TABLE textblocks ( -- names for blocks of text (not just in cases?)
  xn_id    INTEGER NOT NULL PRIMARY KEY,
  xn_name  CHAR(50) NOT NULL,  -- name for text block eg. 'Introduction' or 'Materials and Methods'
  xn_code  CHAR(10) NOT NULL );  -- code for text block eg. 'intro' or 'instruct'   
  
-- tables with foreign keys  
CREATE TABLE users (
	ur_id     INTEGER NOT NULL PRIMARY KEY,
	ur_ppid   INTEGER NOT NULL REFERENCES people(pp_id),
	ur_inid   INTEGER DEFAULT 1 REFERENCES institutions(in_id),
	ur_uname    CHAR(20)  UNIQUE NOT NULL, -- username 
	ur_passhash CHAR(32),                  -- hashed (salt + password)
	ur_salt     INTEGER,                   -- salt for creating hashed password
	ur_status   INTEGER NOT NULL DEFAULT 1,--status active (1) or not (0)
	ur_refnum   CHAR(10)  DEFAULT NULL);   --reference number -institution student/staff ID number
  --	ur_email     CHAR(30)  NOT NULL);  --email address - store in people instead

CREATE TABLE passrecvry (  -- table used to help users recover from forgotten password
  ps_id     INTEGER NOT NULL PRIMARY KEY,
  ps_urid   INTEGER NOT NULL,   -- uid to recover for
  ps_token  CHAR(30),  -- forgotten password recovery token
  ps_tstamp REAL);   -- timestamp for tokens (julianday.time) 

CREATE TABLE courses (  -- courses offered by each institution
  cr_id     INTEGER NOT NULL PRIMARY KEY,
  cr_name   CHAR(50) NOT NULL,  -- course name
  cr_code   CHAR(10) NOT NULL,  -- course number/code eg. '117.010' or 'ANS-110'
  cr_descr  CHAR(700),          -- course description
  cr_inid   INTEGER NOT NULL REFERENCES institutions(in_id) );

CREATE TABLE offerings (  -- an offering of a course in terms of year, delivery mode and semester
  of_id     INTEGER NOT NULL PRIMARY KEY,
  of_crid   INTEGER NOT NULL REFERENCES courses(cr_id),
  of_year   INTEGER DEFAULT 2007,
  of_smid   INTEGER NOT NULL REFERENCES semesters(sm_id),
  of_dmid   INTEGER NOT NULL REFERENCES delivmodes(dm_id),
  of_admin  INTEGER DEFAULT NULL REFERENCES users(ur_id), -- Paper coordinator
  of_status INTEGER DEFAULT 1 );  

CREATE TABLE offeringstext (  -- text used in interface with offering
  ox_id     INTEGER NOT NULL PRIMARY KEY REFERENCES offerings(of_id),
  ox_intro  CHAR(1024) DEFAULT NULL );  -- text for start of course_home.asp

CREATE TABLE enrolments (  -- intersection of user, offering and user role for that offering
  en_urid   INTEGER REFERENCES users(ur_id),
  en_ofid   INTEGER REFERENCES offerings(of_id),
  en_rlid   INTEGER REFERENCES roles(rl_id),
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
  cs_admin INTEGER NOT NULL REFERENCES users(ur_id), -- case admin
  cs_opt1  INTEGER DEFAULT 1,
  cs_opt2  INTEGER DEFAULT 1,
  cs_opt3  INTEGER DEFAULT 1); -- a bunch of boolean fields determining ScenDef options to include

CREATE TABLE casestext (  -- text that applicable to each scenario/case
  cx_csid  INTEGER NOT NULL REFERENCES cases(cs_id) ,
  cx_xnid  INTEGER NOT NULL REFERENCES textblocks(xn_id) ,
  cx_text  CHAR(1024) DEFAULT 'Lorem ipsum dolor sit.' ,  -- text to set scene for scenario
  PRIMARY KEY(cx_csid,cx_xnid) );

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
  ci_usrdescr CHAR(1000) DEFAULT NULL, -- user's description for CaseInstance
  ci_sumry    INTEGER DEFAULT 0,        -- summary saved? 0 no; 1 yes
  ci_stage    INTEGER DEFAULT 1 REFERENCES textblocks(xn_id),   -- stage, 
  ci_status   INTEGER DEFAULT 1);      -- 0 no longer current; 1 current

CREATE TABLE errors (
  er_id     INTEGER NOT NULL PRIMARY KEY,
  er_ssid   INTEGER NOT NULL REFERENCES sessions(ss_id),
  er_csid   INTEGER NOT NULL REFERENCES cases(cs_id),
  er_sdid   INTEGER NOT NULL REFERENCES scendefs(sd_id),
  er_errmsg CHAR(100) );  -- text of last error message   

CREATE TRIGGER create_offtext
AFTER INSERT ON offerings
BEGIN
       INSERT INTO offeringstext (ox_id)
       VALUES (new.of_id);
END;

CREATE TRIGGER create_offadminrole
AFTER INSERT ON offerings
BEGIN
       INSERT INTO enrolments (en_urid,en_ofid,en_rlid)
       VALUES (new.of_admin,new.of_id,12);
--       INSERT INTO enrolmentroles (el_enid,el_rlid)
--       VALUES (last_insert_rowid(),12);
END;

CREATE TRIGGER create_casetext -- creates placeholder for intro text for a case when it is created
AFTER INSERT ON cases
BEGIN
       INSERT INTO casestext (cx_csid,cx_xnid)
       VALUES (new.cs_id,1);
END;

CREATE TRIGGER create_caseowner
AFTER INSERT ON cases
BEGIN
       INSERT INTO caseroles (cl_csid,cl_urid,cl_rlid)
       VALUES (new.cs_id,new.cs_admin,50);
END;

CREATE TRIGGER enrol_new_user -- enrol new users in Experiment with AnSim course 
AFTER INSERT ON users
BEGIN
     INSERT INTO enrolments (en_urid,en_ofid,en_rlid)
     VALUES(new.ur_id,6,1);
--     INSERT INTO enrolmentroles (el_enid,el_rlid)
--     VALUES (last_insert_rowid(),1);
END;

CREATE TRIGGER delete_enrols
BEFORE DELETE ON users
BEGIN
     DELETE FROM enrolments
     WHERE en_urid=old.ur_id;
END;

CREATE VIEW `offering_info` AS 
-- this VIEW created by support@osenxpsuite.net [Visual Query Builder - SQLite2007 PRO]
-- created date: 23/07/2007 16:53:35
SELECT 
      of.of_id of_id ,
      cr.cr_id cr_id ,
      cr.cr_name cr_name ,
      cr.cr_code cr_code ,
      of.of_year of_year ,
      sm.sm_code sm_code ,
      dm.dm_code dm_code ,
      of.of_status of_status ,
      pp.pp_fname pp_adminfname ,
      pp.pp_lname pp_adminlname 

FROM 
      `semesters` sm INNER JOIN `offerings` of ON ( `sm`.`sm_id` = `of`.`of_smid` ) 
      INNER JOIN `delivmodes` dm ON ( `dm`.`dm_id` = `of`.`of_dmid` ) 
      INNER JOIN `users` ur ON ( `ur`.`ur_id` = `of`.`of_admin` ) 
      INNER JOIN `courses` cr ON ( `cr`.`cr_id` = `of`.`of_crid` ) 
      INNER JOIN `people` pp ON ( `pp`.`pp_id` = `ur`.`ur_ppid` ) 

WHERE 
      (of.of_status >0);
