
begin;
create temp table temp_table as select * from revs;
drop table revs;

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

insert into revs select * from temp_table;
drop table temp_table;
commit;
