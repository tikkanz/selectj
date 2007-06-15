
begin;
create temp table temp_table as select * from scenarios;
drop table scenarios;

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

insert into scenarios select * from temp_table;
drop table temp_table;
commit;
