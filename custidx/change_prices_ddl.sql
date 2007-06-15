
begin;
create temp table temp_table as select * from prices;
drop table prices;

CREATE TABLE prices (
	pr_id      INTEGER NOT NULL PRIMARY KEY,
	pr_pp INTEGER NOT NULL REFERENCES price_profiles(pp_id) ON DELETE RESTRICT,
	pr_mfd     REAL    NOT NULL,    --mean fibre diameter
	pr_price   REAL    DEFAULT 0 );  --price for that mfd

insert into prices select * from temp_table;
drop table temp_table;
commit;


