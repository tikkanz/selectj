
begin;
create temp table temp_table as select * from price_profiles;
drop table price_profiles;

CREATE TABLE price_profiles (
	pp_id      INTEGER   NOT NULL PRIMARY KEY,
	pp_client  INTEGER   REFERENCES clients(cl_id) ON DELETE RESTRICT, --if null then created 
	pp_year    CHAR(10)   NOT NULL );  --date price profile was created

insert into price_profiles select * from temp_table;
drop table temp_table;



create temp table temp_table as select * from scenarios;
drop table scenarios;

CREATE TABLE scenarios (
	sc_id      INTEGER NOT NULL PRIMARY KEY,
	sc_year    CHAR(10) NOT NULL,      --date scenario was created
	sc_validuntil CHAR(10),            --date replaced if null then current
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

insert into scenarios select * from temp_table;
drop table temp_table;


create temp table temp_table as select * from revs;
drop table revs;

CREATE TABLE revs (
	rv_id         INTEGER NOT NULL PRIMARY KEY,
	rv_year       CHAR(10) NOT NULL,      --date revs definition created
  rv_validuntil CHAR(10),            --date revs replaced if null then still current
  rv_client     INTEGER NOT NULL REFERENCES clients(cl_id) ON DELETE RESTRICT,
	rv_scenario   INTEGER REFERENCES scenarios(sc_id) ON DELETE RESTRICT,
	rv_pp         INTEGER REFERENCES price_profiles(pp_id) ON DELETE RESTRICT,
	rv_cfw        REAL DEFAULT NULL, --rev for clean fleece weight
	rv_mfd        REAL DEFAULT NULL, --rev for mean fibre diameter
	rv_value      REAL DEFAULT NULL ); --dollar value of extra index unit

insert into revs select * from temp_table;
drop table temp_table;

commit;


