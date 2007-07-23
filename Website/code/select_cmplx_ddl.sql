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
  sd_filen CHAR(100) ); -- instead of file name could store files as BLOBS?
  
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
  cr_inid   INTEGER NOT NULL REFERENCES institutions(in_id),
  cr_intro  CHAR(1000)          -- AnimalSim intro text for course 
  );

CREATE TABLE offerings (  -- an offering of a course in terms of year, delivery mode and semester
  of_id     INTEGER NOT NULL PRIMARY KEY,
  of_crid   INTEGER NOT NULL REFERENCES courses(cr_id),
  of_year   INTEGER DEFAULT 2007,
  of_smid   INTEGER NOT NULL REFERENCES semesters(sm_id),
  of_dmid   INTEGER NOT NULL REFERENCES delivmodes(dm_id),
  of_admin  INTEGER DEFAULT NULL REFERENCES users(ur_id), -- Paper coordinator
  of_status INTEGER DEFAULT 1 );  

CREATE TABLE enrolments (  -- intersection of user, offering and user role for that offering
  en_id     INTEGER NOT NULL PRIMARY KEY,
  en_urid   REFERENCES users(ur_id),
  en_ofid   REFERENCES offerings(of_id),
  en_rlid   REFERENCES roles(rl_id));
  
CREATE TABLE sessions (   -- log of user sessions
  ss_id     INTEGER NOT NULL PRIMARY KEY,
  ss_start  REAL,  -- stored as julianday.time
  ss_finish REAL,  -- stored as julianday.time
  ss_enid   INTEGER NOT NULL REFERENCES enrolments(en_id)); -- session starts when choose offering not at login?

CREATE TABLE templates (
  tm_id    INTEGER NOT NULL PRIMARY KEY,
  tm_sdid  INTEGER NOT NULL REFERENCES scendefs(sd_id),
  tm_opt1  INTEGER NOT NULL DEFAULT 1,
  tm_opt2  INTEGER NOT NULL DEFAULT 1,
  tm_opt3  INTEGER NOT NULL DEFAULT 1); -- a bunch of boolean fields determining ScenDef options to include

CREATE TABLE templatetext (  -- text that applicable to each scenario/template
  tt_id        INTEGER NOT NULL PRIMARY KEY,
  tt_tmid      REFERENCES templates(tm_id),
  tt_intro     CHAR(1000),  -- intro text to set scene for scenario
  tt_instruct  CHAR(1000),  -- instruction text for scenario
  tt_btwncycle CHAR(1000),  -- text to display between selection cycles
  tt_conc      CHAR(1000)); -- text to display at conclusion of selection cycles

CREATE TABLE offeringtemplates (  -- templates available for each offering
  ot_id   INTEGER NOT NULL PRIMARY KEY,
  ot_ofid INTEGER NOT NULL REFERENCES offerings(of_id) ,
  ot_tmid INTEGER NOT NULL );

CREATE TABLE errors (
  er_id     INTEGER NOT NULL PRIMARY KEY,
  er_ssid   INTEGER NOT NULL REFERENCES sessions(ss_id),
  er_tmid   INTEGER NOT NULL REFERENCES templates(tm_id),
  er_sdid   INTEGER NOT NULL REFERENCES scendefs(sd_id),
  er_errmsg CHAR(100) );  -- text of last error message   

CREATE TRIGGER enrol_new_user 
AFTER INSERT ON users
BEGIN
     INSERT INTO enrolments (en_urid,en_ofid,en_rlid)
     VALUES(new.ur_id,6,1);
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
      offerings.of_id of_id ,
      offerings.of_crid of_crid ,
      courses.cr_code cr_code ,
      offerings.of_year of_year ,
      semesters.sm_code sm_code ,
      delivmodes.dm_code dm_code ,
      offerings.of_status of_status ,
      people.pp_fname pp_fname ,
      people.pp_lname pp_lname 

FROM 
      `semesters` semesters INNER JOIN `offerings` offerings ON ( `semesters`.`sm_id` = `offerings`.`of_smid` ) 
      INNER JOIN `delivmodes` delivmodes ON ( `delivmodes`.`dm_id` = `offerings`.`of_dmid` ) 
      INNER JOIN `users` users ON ( `users`.`ur_id` = `offerings`.`of_admin` ) 
      INNER JOIN `courses` courses ON ( `courses`.`cr_id` = `offerings`.`of_crid` ) 
      INNER JOIN `people` people ON ( `people`.`pp_id` = `users`.`ur_ppid` ) 

WHERE 
      (offerings.of_status >0);
