-- This script creates the Forest Range Customised Index database

-- Dropping tables clients, price_profiles, prices, scenarios 

--begin transaction;
--drop table clients;
--drop table price_profiles; 
--drop table prices; 
--drop table scenarios;
--drop table revs;
--commit;

-- Create the new tables

CREATE TABLE clients (
	cl_id      INTEGER   NOT NULL PRIMARY KEY,
	cl_lname   CHAR(20)  NOT NULL,    --last names
	cl_fname   CHAR(30)  NOT NULL,    --first names (used as salutation)               
	cl_title   CHAR(10)  NOT NULL,    --eg. Mr & Mrs
	cl_initial CHAR(15)  NOT NULL,    --initials
	cl_addr    CHAR(30),              --address
	cl_city    CHAR(30),              --city,town,region
	cl_email   CHAR(30),              --email address
	cl_ph      CHAR(15),              --phone number
	cl_fax     CHAR(15),              --fax number
	cl_mob     CHAR(15),              --mobile phone number
	cl_status  INTEGER   NOT NULL DEFAULT 1 );  --status active (1) or not (0)
  
CREATE TABLE price_profiles (
	pp_id      INTEGER   NOT NULL PRIMARY KEY,
	pp_client  INTEGER   REFERENCES clients(cl_id) ON DELETE RESTRICT, --if null then created 
	pp_year    INTEGER   NOT NULL );  --year price profile was created

CREATE TABLE prices (
	pr_id      INTEGER NOT NULL PRIMARY KEY,
	pr_pp INTEGER NOT NULL REFERENCES price_profiles(pp_id) ON DELETE RESTRICT,
	pr_mfd     REAL    NOT NULL,    --mean fibre diameter
	pr_price   REAL    NOT NULL );  --price for that mfd

CREATE TABLE scenarios (
	sc_id      INTEGER NOT NULL PRIMARY KEY,
	sc_year    INTEGER NOT NULL,      --year scenario was created
	sc_validuntil INTEGER,            --last year year if null then current
	sc_client  INTEGER NOT NULL REFERENCES clients(cl_id) ON DELETE RESTRICT,
	sc_ewes_per_ram INTEGER NOT NULL, --number of ewes mated per ram
	sc_yrs_ram_used INTEGER NOT NULL, --number of years rams used
	sc_lmb_pct      REAL NOT NULL,    --lambing percentage
	sc_e_hog_ret    REAL NOT NULL,    --percentage of ewe lambs retained as hoggets
	sc_ewes_ret     REAL NOT NULL,    --percentage of ewe hoggets retained as flock ewes
	sc_yrs_ewes_used INTEGER NOT NULL, --avg number of years ewes retained in flock
	sc_e_hog_cfw    REAL NOT NULL,    --ewe hogget clean fleece weight
	sc_e_hog_mfd    REAL NOT NULL,    --ewe hogget mean fibre diameter
	sc_ewe_cfw      REAL NOT NULL,    --ewe clean fleece weight
	sc_ewe_mfd      REAL NOT NULL,    --ewe mean fibre diameter
	sc_w_hog_ret    REAL,             --percentage of wether lambs retained as hoggets
	sc_weth_ret     REAL,             --percentage of wether hoggets retained as flock wethers
	sc_yrs_weth_used INTEGER,         --number of years wethers retained in flock 
	sc_w_hog_cfw    REAL,             --wether hogget clean fleece weight
	sc_w_hog_mfd    REAL,             --wether hogget mean fibre diameter
	sc_weth_cfw     REAL,             --wether clean fleece weight       
	sc_weth_mfd     REAL );           --wether mean fibre diameter       

CREATE TABLE scenarios (
	sc_id      INTEGER NOT NULL PRIMARY KEY,
	sc_year    INTEGER NOT NULL,      --year scenario was created
	sc_validuntil INTEGER,            --last year year if null then current
	sc_client  INTEGER NOT NULL REFERENCES clients(cl_id) ON DELETE RESTRICT,
	sc_ewes2ram INTEGER NOT NULL, --number of ewes mated per ram
	sc_yrs_ram INTEGER NOT NULL, --number of years rams used
	sc_pct_lmb      REAL NOT NULL,  --lambing percentage
	sc_ret_elmb    REAL NOT NULL,   --percentage of ewe lambs retained as hoggets
	sc_ret_ehog     REAL NOT NULL,  --percentage of ewe hoggets retained as flock ewes
	sc_yrs_ewe INTEGER NOT NULL,    --avg number of years ewes retained in flock
	sc_cfw_ehog    REAL NOT NULL,   --ewe hogget clean fleece weight
	sc_mfd_ehog    REAL NOT NULL,   --ewe hogget mean fibre diameter
	sc_cfw_ewe      REAL NOT NULL,  --ewe clean fleece weight
	sc_mfd_ewe      REAL NOT NULL,  --ewe mean fibre diameter
	sc_ret_wlmb    REAL DEFAULT 0,  --percentage of wether lambs retained as hoggets
	sc_ret_whog     REAL DEFAULT 0, --percentage of wether hoggets retained as flock wethers
	sc_yrs_weth INTEGER DEFAULT 0,  --number of years wethers retained in flock 
	sc_cfw_whog    REAL DEFAULT 0,  --wether hogget clean fleece weight
	sc_mfd_whog    REAL,            --wether hogget mean fibre diameter
	sc_cfw_weth     REAL DEFAULT 0, --wether clean fleece weight       
	sc_mfd_weth     REAL );         --wether mean fibre diameter



CREATE TABLE revs (
	rv_id         INTEGER NOT NULL PRIMARY KEY,
	rv_year       INTEGER NOT NULL,      --year revs calculated
  rv_validuntil INTEGER,            --last year revs used if null then still current
  rv_client     INTEGER NOT NULL REFERENCES clients(cl_id) ON DELETE RESTRICT,
	rv_scenario   INTEGER REFERENCES scenarios(sc_id) ON DELETE RESTRICT,
	rv_pp         INTEGER REFERENCES price_profiles(pp_id) ON DELETE RESTRICT,
	rv_cfw        REAL DEFAULT NULL, --rev for clean fleece weight
	rv_mfd        REAL DEFAULT NULL, --rev for mean fibre diameter
	rv_value      REAL DEFAULT NULL ); --dollar value of extra index unit
