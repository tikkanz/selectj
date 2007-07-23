-- This script populates the database with dummy data
-- Populating tables

begin transaction;

insert into institutions (in_name, in_code, in_contact) values ('Massey University', 'MU', 1);
insert into institutions (in_name, in_code, in_contact) values ('Lincoln University', 'LU', 4);
insert into institutions (in_name, in_code, in_contact) values ('AgResearch', 'AGR', 2);

insert into delivmodes (dm_name, dm_code, dm_descr) values ('Internal', 'INT', 'Course delivered on-campus.');
insert into delivmodes (dm_name, dm_code, dm_descr) values ('Extramural', 'XM', 'Course delivered by correspondence.');
insert into delivmodes (dm_name, dm_code, dm_descr) values ('Block', 'BLK', 'Course delivered on-campus in blocks.');

insert into semesters (sm_name, sm_code, sm_descr) values ('Semester One', '01', 'February through June');
insert into semesters (sm_name, sm_code, sm_descr) values ('Semester Two', '02', 'July through November');
insert into semesters (sm_name, sm_code, sm_descr) values ('Semester Three', '03', 'November through February');
insert into semesters (sm_name, sm_code, sm_descr) values ('Double Semester', '12', 'February through November');

insert into roles (rl_name, rl_code, rl_descr) values ('Student', 'STUD', 'Student in the course');
insert into roles (rl_name, rl_code, rl_descr) values ('Template Designer', 'TDESIGN', 'User can create and edit templates');
insert into roles (rl_name, rl_code, rl_descr) values ('Course Administrator', 'CADMIN', 'Person responsible for administering the course');
insert into roles (rl_name, rl_code, rl_descr) values ('Site Administrator', 'SADMIN', 'Super user');

insert into people (pp_fname, pp_lname, pp_email) values ('Ric', 'Sherlock', 'r.g.sherlock@massey.ac.nz');
insert into people (pp_fname, pp_lname, pp_email) values ('Tricia', 'Johnson', 'tricia.johnson@hotmail.co.nz');
insert into people (pp_fname, pp_lname, pp_email) values ('Jason', 'Win', 'onfire@xtra.co.nz');
insert into people (pp_fname, pp_lname, pp_email) values ('Joe', 'Bloggs', 'jbloggs@xtra.co.nz');
insert into people (pp_fname, pp_lname, pp_email) values ('Temporary', 'Guest', 'guest@nodomain.com');

insert into scendefs (sd_filen) values ('BiggerPopln/animalsim.ini');
insert into scendefs (sd_filen) values ('ChangeREVs/animalsim.ini');
insert into scendefs (sd_filen) values ('SelectManual/animalsim.ini');

insert into users (ur_ppid, ur_inid, ur_uname, ur_passhash, ur_salt) values (1,1,'tikka','55f9078cf55595a928ec8cf35e20d106',2079797903);
insert into users (ur_ppid, ur_inid, ur_uname, ur_passhash, ur_salt) values (3,1,'injapan','6530575557447b07e16da4204329c8a8',-865438670);
insert into users (ur_ppid, ur_inid, ur_uname, ur_passhash, ur_salt) values (2,3,'tricia','ef5c0caabb090e216e24adfeca4ca316',64988700);
insert into users (ur_ppid, ur_inid, ur_uname, ur_passhash, ur_salt) values (4,2,'bloggs','8f90eacdc8ffe4e71b52906865d81f4c',-228865924);
insert into users (ur_ppid, ur_inid, ur_uname, ur_passhash, ur_salt) values (5,1,'guest','02969889acf88057663a97266e9d4728',-900589809);

insert into courses (cr_name, cr_code, cr_descr, cr_inid) values ('Sheep Production','117352','All about sheep production including genetics',1);
insert into courses (cr_name, cr_code, cr_descr, cr_inid) values ('Animal Breeding and Genetics','227202','Genetics for vets',1);
insert into courses (cr_name, cr_code, cr_descr, cr_inid) values ('Genetics for Livestock Improvement','117345','All about genetics',1);
insert into courses (cr_name, cr_code, cr_descr, cr_inid) values ('Principles of Animal Production','117254','Animal Production including genetics',1);
insert into courses (cr_name, cr_code, cr_descr, cr_inid) values ('Experiment with AnimalSim','AnSim','Course for guests to play with AnimalSim',1);
insert into courses (cr_name, cr_code, cr_descr, cr_inid) values ('Production Animal Science','ASC101','Intro course with genetics',2);
insert into courses (cr_name, cr_code, cr_descr, cr_inid) values ('Using Genetics','USEGEN','Extension for farmers',3);

insert into offerings (of_crid, of_year, of_smid, of_dmid, of_admin, of_status) values (1,2007,1,1,1,-1);
insert into offerings (of_crid, of_year, of_smid, of_dmid, of_admin) values (1,2007,4,2,1);
insert into offerings (of_crid, of_year, of_smid, of_dmid, of_admin) values (2,2007,2,1,1);
insert into offerings (of_crid, of_year, of_smid, of_dmid, of_admin) values (3,2007,4,2,3);
insert into offerings (of_crid, of_year, of_smid, of_dmid, of_admin) values (7,2007,2,3,3);
insert into offerings (of_crid, of_year, of_smid, of_dmid, of_admin) values (5,'',4,2,1);

insert into enrolments (en_urid, en_ofid, en_rlid) values (1,1,3);
insert into enrolments (en_urid, en_ofid, en_rlid) values (1,2,3);
insert into enrolments (en_urid, en_ofid, en_rlid) values (1,3,3);
insert into enrolments (en_urid, en_ofid, en_rlid) values (1,4,3);
insert into enrolments (en_urid, en_ofid, en_rlid) values (1,5,1);
insert into enrolments (en_urid, en_ofid, en_rlid) values (1,6,3);
insert into enrolments (en_urid, en_ofid, en_rlid) values (3,3,3);
insert into enrolments (en_urid, en_ofid, en_rlid) values (3,5,3);
insert into enrolments (en_urid, en_ofid, en_rlid) values (4,5,1);
insert into enrolments (en_urid, en_ofid, en_rlid) values (2,1,1);
insert into enrolments (en_urid, en_ofid, en_rlid) values (2,3,1);
insert into enrolments (en_urid, en_ofid, en_rlid) values (4,1,1);
insert into enrolments (en_urid, en_ofid, en_rlid) values (4,3,1);

insert into templates (tm_sdid, tm_opt1, tm_opt2, tm_opt3) values (1,1,1,1);
insert into templates (tm_sdid, tm_opt1, tm_opt2, tm_opt3) values (2,1,1,1);
insert into templates (tm_sdid, tm_opt1, tm_opt2, tm_opt3) values (3,1,1,1);

insert into templatetext (tt_tmid, tt_intro, tt_instruct, tt_conc) values (1,'intro texta','instruction texta','conclusion texta');
insert into templatetext (tt_tmid, tt_intro, tt_instruct, tt_conc) values (2,'intro textb','instruction textb','conclusion textb');
insert into templatetext (tt_tmid, tt_intro, tt_instruct, tt_btwncycle, tt_conc) values (3,'intro textc','instruction textc','between cycle textc','conclusion textc');

insert into offeringtemplates (ot_ofid, ot_tmid) values (1,1);
insert into offeringtemplates (ot_ofid, ot_tmid) values (1,3);
insert into offeringtemplates (ot_ofid, ot_tmid) values (2,1);
insert into offeringtemplates (ot_ofid, ot_tmid) values (2,3);
insert into offeringtemplates (ot_ofid, ot_tmid) values (3,2);
insert into offeringtemplates (ot_ofid, ot_tmid) values (5,2);
insert into offeringtemplates (ot_ofid, ot_tmid) values (2,3);
insert into offeringtemplates (ot_ofid, ot_tmid) values (6,1);
insert into offeringtemplates (ot_ofid, ot_tmid) values (6,2);
insert into offeringtemplates (ot_ofid, ot_tmid) values (7,1);
insert into offeringtemplates (ot_ofid, ot_tmid) values (7,2);
insert into offeringtemplates (ot_ofid, ot_tmid) values (8,1);
insert into offeringtemplates (ot_ofid, ot_tmid) values (8,2);
insert into offeringtemplates (ot_ofid, ot_tmid) values (9,1);
insert into offeringtemplates (ot_ofid, ot_tmid) values (9,2);

commit;
