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

insert into roles (rl_id,rl_name,rl_code,rl_descr) values (1,'Student', 'STUD', 'User is a Student in the offering');
insert into roles (rl_id,rl_name,rl_code,rl_descr) values (10,'Offering Editor', 'OFFEDIT', 'User able to edit the offering');
insert into roles (rl_id,rl_name,rl_code,rl_descr) values (12,'Offering Administrator', 'OFFADMIN', 'User responsible for administering the offering');
insert into roles (rl_id,rl_name,rl_code,rl_descr) values (20,'Case Editor', 'CEDIT', 'User is able to edit the case');
insert into roles (rl_id,rl_name,rl_code,rl_descr) values (22,'Case Owner', 'COWNER', 'User created the case and can assign additonal Case Editors');
insert into roles (rl_id,rl_name,rl_code,rl_descr) values (50,'Site Administrator', 'SADMIN', 'Super user');

insert into blocktypes (bt_id,bt_name,bt_code,bt_xbid) values (1,'Introduction','caseintro',4);
insert into blocktypes (bt_id,bt_name,bt_code,bt_xbid) values (11,'Instructions','caseinstruct',5);
insert into blocktypes (bt_id,bt_name,bt_code,bt_xbid) values (21,'Between Cycles','casebtwncycles',6);
insert into blocktypes (bt_id,bt_name,bt_code,bt_xbid) values (99,'Conclusion','caseconc',7);
insert into blocktypes (bt_id,bt_name,bt_code,bt_xbid) values (200,'Introduction','offintro',3);

insert into fieldsets (fs_id,fs_name,fs_code) values (1,'Selection progress','progress');
insert into fieldsets (fs_id,fs_name,fs_code) values (10,'Population Size','popsz');
insert into fieldsets (fs_id,fs_name,fs_code) values (12,'Dams per Sire','dams2sire');
insert into fieldsets (fs_id,fs_name,fs_code) values (15,'Age Structure','agestruct');
insert into fieldsets (fs_id,fs_name,fs_code) values (16,'Age Structure','agestruct2');
insert into fieldsets (fs_id,fs_name,fs_code) values (20,'Traits to Record','trt2record');
insert into fieldsets (fs_id,fs_name,fs_code) values (25,'Traits to Select','trt2select');
insert into fieldsets (fs_id,fs_name,fs_code) values (26,'Trait REVs','trtrevs');
insert into fieldsets (fs_id,fs_name,fs_code) values (27,'Selection Method','selmeth');
insert into fieldsets (fs_id,fs_name,fs_code) values (30,'Summarise Selection','selsumm');
insert into fieldsets (fs_id,fs_name,fs_code) values (31,'Summarise Selection','selsumm2');
insert into fieldsets (fs_id,fs_name,fs_code) values (35,'Summary Types','sumtypes');

insert into params (pr_id,pr_name,pr_code,pr_ctype,pr_cprops) values (1,'No. of cycles to select for','ncycles','input','type ''text'' maxlength ''3'' size ''4''');
insert into params (pr_id,pr_name,pr_code,pr_ctype,pr_cprops) values (2,'Current cycle of selection','currcycle','input','type ''text'' maxlength ''3'' size ''4''');
insert into params (pr_id,pr_name,pr_code,pr_ctype,pr_cprops) values (3,'No. of Dams per Sire','dams2hrdsire','input','type ''text'' size ''5''');
insert into params (pr_id,pr_name,pr_code,pr_note,pr_ctype,pr_cprops) values (4,'Age to cull at','cullage','Females and Males older that this age will not appear in selection lists.','input','type ''text'' size ''5''');
insert into params (pr_id,pr_name,pr_code,pr_note,pr_ctype,pr_cprops) values (5,'Age at birth','mateage','The Female and Male parents'' age when their first progeny is born.','input','type ''text'' size ''5''');
insert into params (pr_id,pr_name,pr_code,pr_note,pr_ctype,pr_cprops) values (6,'Allele frequencies','allelefreq','Values must sum to zero.','input','type ''text'' size ''5''');
insert into params (pr_id,pr_name,pr_code,pr_class,pr_ctype,pr_cprops) values (7,'Relative Economic Values (REVs)','objectvrevs','controlset','input','type ''text'' size ''5''');
insert into params (pr_id,pr_name,pr_code,pr_class,pr_ctype,pr_cprops) values (8,'Select using','selnmeth','controlset','input','type ''radio''');
insert into params (pr_id,pr_name,pr_code,pr_class,pr_ctype,pr_cprops) values (9,'Summarise','summtype','controlset','input','type ''checkbox''');
insert into params (pr_id,pr_name,pr_code,pr_note,pr_ctype,pr_cprops) values (10,'Traits to select on','trts2select','These traits will be available in your selection lists','select','onchange ''REVStatus()'' multiple '''' size ''6''');
insert into params (pr_id,pr_name,pr_code,pr_note,pr_ctype,pr_cprops) values (11,'Traits to summarise','trts2summ','These traits will be summarised in your final population report','select','multiple '''' size ''6''');
insert into params (pr_id,pr_name,pr_code,pr_ctype,pr_cprops) values (12,'Traits to record','trtsrecorded','select','multiple '''' size ''6''');
insert into params (pr_id,pr_name,pr_code,pr_note,pr_ctype,pr_cprops) values (13,'No. of breeding females','hrdsizes','This does not include female replacements that are too young to mate.<br/>&nbsp;','select','');

insert into people (pp_fname, pp_lname, pp_email) values ('Temporary', 'Guest', 'guest@nodomain.com');
insert into people (pp_fname, pp_lname, pp_email) values ('Ric', 'Sherlock', 'r.g.sherlock@massey.ac.nz');
insert into people (pp_fname, pp_lname, pp_email) values ('Tricia', 'Johnson', 'tricia.johnson@hotmail.co.nz');
insert into people (pp_fname, pp_lname, pp_email) values ('Jason', 'Win', 'onfire@xtra.co.nz');
insert into people (pp_fname, pp_lname, pp_email) values ('Joe', 'Bloggs', 'jbloggs@xtra.co.nz');

insert into scendefs (sd_name,sd_code,sd_descr,sd_filen) values ('Population Size','POPSZ','Does the size of the breeding population affect the rate of progress through selection?','animalsim.ini');
insert into scendefs (sd_name,sd_code,sd_descr,sd_filen) values ('Changing REVs','CHGREV','You can change relative economic values (REVs) for the traits in your selection index.','animalsim.ini');
insert into scendefs (sd_name,sd_code,sd_descr,sd_filen) values ('Select animals manually','MANSEL','You specify which animals to use as parents individually, using your own selection criteria.','animalsim.ini');

insert into users (ur_ppid, ur_inid, ur_uname, ur_passhash, ur_salt) values (2,1,'tikka','55f9078cf55595a928ec8cf35e20d106',2079797903);
insert into users (ur_ppid, ur_inid, ur_uname, ur_passhash, ur_salt) values (4,1,'injapan','6530575557447b07e16da4204329c8a8',-865438670);
insert into users (ur_ppid, ur_inid, ur_uname, ur_passhash, ur_salt) values (3,3,'tricia','ef5c0caabb090e216e24adfeca4ca316',64988700);
insert into users (ur_ppid, ur_inid, ur_uname, ur_passhash, ur_salt) values (5,2,'bloggs','8f90eacdc8ffe4e71b52906865d81f4c',-228865924);

insert into courses (cr_name, cr_code, cr_descr, cr_inid) values ('Experiment with AnimalSim','AnSim','Course for guests to play with AnimalSim',1);
insert into courses (cr_name, cr_code, cr_descr, cr_inid) values ('Sheep Production','117352','All about sheep production including genetics',1);
insert into courses (cr_name, cr_code, cr_descr, cr_inid) values ('Animal Breeding and Genetics','227202','Genetics for vets',1);
insert into courses (cr_name, cr_code, cr_descr, cr_inid) values ('Genetics for Livestock Improvement','117345','All about genetics',1);
insert into courses (cr_name, cr_code, cr_descr, cr_inid) values ('Principles of Animal Production','117254','Animal Production including genetics',1);
insert into courses (cr_name, cr_code, cr_descr, cr_inid) values ('Production Animal Science','ASC101','Intro course with genetics',2);
insert into courses (cr_name, cr_code, cr_descr, cr_inid) values ('Using Genetics','USEGEN','Extension for farmers',3);

insert into offerings (of_crid, of_year, of_smid, of_dmid, of_admin) values (1,'',4,2,1); -- default offering
insert into offerings (of_crid, of_year, of_smid, of_dmid, of_admin, of_status) values (2,2007,1,1,1,-1);
insert into offerings (of_crid, of_year, of_smid, of_dmid, of_admin) values (2,2007,4,2,1);
insert into offerings (of_crid, of_year, of_smid, of_dmid, of_admin) values (3,2007,2,1,1);
insert into offerings (of_crid, of_year, of_smid, of_dmid, of_admin) values (4,2007,4,2,3);
insert into offerings (of_crid, of_year, of_smid, of_dmid, of_admin) values (7,2007,2,3,3);

insert into textblocks (xb_id, xb_text) values(1,'Lorem ipsum dolor sit amet consectetuer tempus lobortis Nunc Nulla et. Et wisi Aliquam Morbi et Maecenas at mi lorem ut justo.');
insert into textblocks (xb_id, xb_text) values(2,'
Lorem ipsum dolor sit amet consectetuer tempus lobortis Nunc Nulla et. Et wisi Aliquam Morbi et Maecenas at mi lorem ut justo. Mi neque justo mi elit ac egestas malesuada id pharetra tempus. Magna vitae convallis condimentum condimentum congue tellus et nibh Ut ultrices. Justo et.</p>
<p>Feugiat nibh adipiscing malesuada nascetur mi ut dictum In elit congue. Elit amet mauris Vestibulum Phasellus justo adipiscing semper semper penatibus lorem. Vel pretium dolor convallis at gravida enim nibh mi ac consectetuer. Volutpat semper pretium accumsan In nulla Aliquam nunc condimentum condimentum.</p>
<p>Est Quisque risus nibh Curabitur tellus Quisque auctor tincidunt nulla parturient. Ipsum senectus ipsum elit tortor nec urna ligula lacus ac ipsum. Congue suscipit nisl euismod Vestibulum semper id ut convallis pharetra tincidunt. Proin Phasellus Vestibulum pretium eget penatibus tellus egestas dolor ac vestibulum. Libero amet Nam.
');
insert into textblocks (xb_id, xb_text) values(3,'This is dummy introductory text for this offering of your course. Please edit to replace with desired text.');
insert into textblocks (xb_id, xb_text) values(4,'This is dummy introductory text for this case. Please edit to replace with desired text');
insert into textblocks (xb_id, xb_text) values(5,'
This is default intstruction text for a case instruction. Please edit to replace with desired text.</p>
<p>If you wish to return your choices to how they were when you opened this page, click <em>Discard Changes</em> at the bottom of the page.</p>
<p>Once you are happy with your choices click <em>Save Changes</em> at the bottom of the page to update your case and return to the <em>CaseHome</em> page.
');

insert into textblocks (xb_id, xb_text) values(6,'This is default text to display between cycles of case. Please edit to replace with desired text.</p>
<p>It is prior to mating and you need to make some selection decisions about which
females and males to breed from this coming season.</p> 
<ul><li>Download each of the selection lists containing potential sires and dams.</li>
<li>Open the selection lists in Excel and apply your selection strategy to choose your replacements by deleting
the rows containing all the unwanted animals. (Leave the header at the top)</li> 
<li>Save as comma-delimited files (.csv) on your computer with an appropriate
name (e.g. <code>Ewe_replacments.csv</code>) somewhere you will be able to find them again.</li>
<li>Browse to each of the files that you just saved, then click <em>Upload Files & Breed</em>.</li> 
</ul>
<p>You will need to repeat this step until you have completed X cycles of selection.</p>
<p>Once you click <em>Upload Files & Breed</em>, it can take some time for your sires and dams to be mated, their progeny generated and 
selection lists to be created. However, once your lists have been uploaded you can safely close your
AnimalSim session and next time you login, the new selection lists should be available.
');
insert into textblocks (xb_id, xb_text) values(7,'This is default conclusion text for a case conclusion.</p>
<p>Your breeding population has now been selected for xx selection cycles and the case is complete.</p>
<p>If you wish to analyse the results of your case you should save them. If you Reset the case before
the results are saved, then a new case will be initialised and the results of the completed one will be lost.</p>
<p>You can analyse the results of one or more saved cases by clicking <em>Analyse saved case(s)</em>. 
<p>You can download a comma-separated-value (csv) file with information on every animal that existed in your population by clicking <em>Download Summary file</em> below.
');
insert into textblocks (xb_id, xb_text) values(8,'
All new users are automatically enrolled in to this course by default. It consists of a few basic
Cases to give you a taste of what SelectJ and AnimalSim are capable of.</p>
<p>Please feel free to explore the cases listed below.</p>
<p>If you wish to enrol in other courses that use AnimalSim please contact your
paper administrator.
');

insert into textblocks (xb_id, xb_text) values(9,'
There is a common misconception that increasing the size of a breeding population will increase the rate of genetic progress through selection. Use this case to verify whether this is not in fact true.</p>
<p>Use the "Selection details" page to choose a trait to select for and the size of your breeding population.</p>
<p>You can use the "Describe case" page to label and describe a case so you can distinguish how it was special or different from the other cases you run.</p>
<p>The "Breed population" command will breed your population for 10 selection cycles according to your choices on the "Selection details" page</p>
<p>Things to try:
   <ul><li>Breed a population several times with the same selection details to see how big the effect of "chance" variation is on the result.</li>
   <li>What are the differences you get if you breed a small vs a large population (for the same trait)?</li>
   <li>Are the magnitude of the differences different for different traits?</li>
   </ul> 
');
insert into textblocks (xb_id,xb_text) values (10,'
Choose the desired size of your breeding population and the trait you wish to select for (selection is on phenotype only).</p>
<p>If you wish to return your choices to how they were when you opened this page, click <em>Discard Changes</em> at the bottom of the page.
<p>Once you are happy with your choices click <em>Save Changes</em> at the bottom of the page to update your case and return to the <em>CaseHome</em> page.
');
insert into textblocks (xb_id,xb_text) values (11,'
Your breeding population has now been selected for 10 selection cycles and the case is complete.</p>
<p>If you wish to analyse the results of your case you should save them. If you Reset the case before
the results are saved, then a new case will be initialised and the results of the completed one will be lost.</p>
<p>You can analyse the results of one or more saved cases by clicking <em>Analyse saved case(s)</em>. 
<p>You can download a comma-separated-value (csv) file with information on every animal that existed in your population by clicking <em>Download Summary file</em> below.
');

insert into textblocks (xb_id, xb_text) values(12,'
Breeders have a number of decisions they need to make when selecting their population.</p>
<ul><li>What they want to achieve by selection (Selection Objective)</li>
<li>Which traits to record and select for</li>
<li>How best to select their replacement sires and dams</li>
</ul>
<p>The objective of this project is for you to put yourself in the position of a breeder. Decide what market
you wish to supply sires to, what your selection objective will be and how you will go about reaching
that objective.</p>
<p>You should determine and record your target market and selection objective before beginning
the simulation. You should also document your selection strategies in such a way that someone else would
be able to follow them.</p>
<p>Once you have chosen your desired <em>Selection details</em>, you can breed your initial
crop of potential sires and dams by clicking <em>Breed population</em>.</p>
');
insert into textblocks (xb_id,xb_text) values (13,'
In the form below you need to make a number of choices.<br/>
You can indicate the number of Dams you wish to mate to each sire as well as the ages at which males'' and females'' progeny are first born.</p>
<p>You need to choose:</p>
<ul><li>which traits to record (measure) on your animals (<em>Traits to record</em>)</li>
    <li>which traits to select your replacements on (<em>Traits to select</em>) and what type of information to use (<em>Selection Method</em>)</li>
</ul>
<p>You can also choose what information you wish to summarise at the end of your case. You will 
probably at least want to summarise the traits that you selected on, but you may also want to 
investigate the effects on other traits as a result of your selection strategy.</p>
<p>If you wish to return your choices to how they were when you opened this page, click <em>Discard Changes</em> at the bottom of the page.
<p>Once you are happy with your choices click <em>Save Changes</em> at the bottom of the page to update your case and return to the <em>CaseHome</em> page. </p>
');
insert into textblocks (xb_id,xb_text) values (14,'
It is prior to mating and you need to make some selection decisions about which
females and males to breed from this coming season.</p> 
<ul><li>Download each of the selection lists containing potential sires and dams.</li>
<li>Open the selection lists in Excel and apply your selection strategy to choose your replacements by deleting
the rows containing all the unwanted animals. (Leave the header at the top)</li> 
<li>Save as comma-delimited files (.csv) on your computer with an appropriate
name (e.g. <code>Ewe_replacments.csv</code>) somewhere you will be able to find them again.</li>
<li>Browse to each of the files that you just saved, then click <em>Upload Files & Breed</em>.</li> 
</ul>
<p>You will need to repeat this step until you have completed 8 cycles of selection.</p>
<p>Once you click <em>Upload Files & Breed</em>, it can take some time for your sires and dams to be mated, their progeny generated and 
selection lists to be created. However, once your lists have been uploaded you can safely close your
AnimalSim session and next time you login, the new selection lists should be available.
');
insert into textblocks (xb_id,xb_text) values (15,'
You have now completed 8 cycles of selection for your breeding population.</p>
<p>How good was your population''s progress towards your objective? How could/would you improve your selection
strategy if you were starting again?</p>
<p>To analyse the results of your case you should save them first. If you <em>Reset case</em> before
the results are saved, then a new case will be initialised and the results of the completed one will be lost.</p>
<p>You can analyse the results of one or more saved cases by clicking <em>Analyse saved case(s)</em>. 
<p>You can download a comma-separated-value (csv) file with information on every animal that existed in your population by clicking <em>Download Summary file</em> below. The Pivot Tables 
feature of Excel is very useful for summarising this file.
');

-- Information/Status and Error messages
insert into messagetext (mx_code, mx_text) values ('caseintro','You have not yet started selecting your population.');
insert into messagetext (mx_code, mx_text) values ('casebtwncycles','Your population is beginning cycle <%=currcycle %> of <%=ncycles %> cycles of selection.');
insert into messagetext (mx_code, mx_text) values ('caseconc','All your selection cycles are complete.');
insert into messagetext (mx_code, mx_class, mx_text) values ('chgdparams','info','Your Selection details were successfully changed.');
insert into messagetext (mx_code, mx_class, mx_text) values ('chgdusrdescr','info','Your Case description was successfully changed.');
insert into messagetext (mx_code, mx_class, mx_text) values ('resetfin','info','The case was successfully reset.');
insert into messagetext (mx_code, mx_class, mx_text) values ('storefin','info','The case was successfully saved.');
insert into messagetext (mx_code, mx_class, mx_text) values ('cyclefin','info','The selection cycle(s) completed successfully.');
insert into messagetext (mx_code, mx_class, mx_text) values ('error','error','There was some sort of error!');
insert into messagetext (mx_code, mx_class, mx_text) values ('mateerr','error','There was some sort of error!');
insert into messagetext (mx_code, mx_class, mx_text) values ('slerr','error','There was some sort of error!');

insert into offeringstext (ox_ofid,ox_btid,ox_xbid) values (1,200,8); -- default course
insert into offeringstext (ox_ofid,ox_btid,ox_xbid) values (6,200,2); -- test assignment

insert into enrolments (en_urid, en_ofid, en_rlid) values (1,1,1);
insert into enrolments (en_urid, en_ofid, en_rlid) values (2,1,1);
insert into enrolments (en_urid, en_ofid, en_rlid) values (4,1,1);
insert into enrolments (en_urid, en_ofid, en_rlid) values (1,5,10);
insert into enrolments (en_urid, en_ofid, en_rlid) values (1,6,1);
insert into enrolments (en_urid, en_ofid, en_rlid) values (4,5,1);
insert into enrolments (en_urid, en_ofid, en_rlid) values (2,2,1);
insert into enrolments (en_urid, en_ofid, en_rlid) values (2,4,1);
insert into enrolments (en_urid, en_ofid, en_rlid) values (4,2,1);
insert into enrolments (en_urid, en_ofid, en_rlid) values (4,4,1);

insert into cases (cs_sdid,cs_admin) values (1,1);
insert into cases (cs_sdid,cs_admin) values (2,1);
insert into cases (cs_sdid,cs_admin) values (3,1);

insert into fieldsetparams (fp_fsid,fp_prid) values (1,1);
insert into fieldsetparams (fp_fsid,fp_prid) values (1,2);
insert into fieldsetparams (fp_fsid,fp_prid) values (10,13);
insert into fieldsetparams (fp_fsid,fp_prid) values (12,3);
insert into fieldsetparams (fp_fsid,fp_prid) values (15,5);
insert into fieldsetparams (fp_fsid,fp_prid) values (15,4);
insert into fieldsetparams (fp_fsid,fp_prid,fp_class,fp_note) values (16,4,'controlset','Animals older that this age will not appear in selection lists.');
insert into fieldsetparams (fp_fsid,fp_prid,fp_class,fp_note) values (16,5,'controlset','The parents'' age when their first progeny is born.');
insert into fieldsetparams (fp_fsid,fp_prid) values (20,12);
insert into fieldsetparams (fp_fsid,fp_prid) values (25,10);
insert into fieldsetparams (fp_fsid,fp_prid) values (26,7);
insert into fieldsetparams (fp_fsid,fp_prid) values (27,8);
insert into fieldsetparams (fp_fsid,fp_prid) values (30,11);
insert into fieldsetparams (fp_fsid,fp_prid) values (31,11);
insert into fieldsetparams (fp_fsid,fp_prid) values (31,9);
insert into fieldsetparams (fp_fsid,fp_prid) values (35,9);

insert into casefieldsets (cf_csid,cf_fsid,cf_value) values (1,1,0);
insert into casefieldsets (cf_csid,cf_fsid,cf_value) values (1,10,1);
insert into casefieldsets (cf_csid,cf_fsid,cf_value) values (1,25,1);
insert into casefieldsets (cf_csid,cf_fsid,cf_value) values (2,1,0);
insert into casefieldsets (cf_csid,cf_fsid,cf_value) values (2,10,0);
insert into casefieldsets (cf_csid,cf_fsid,cf_value) values (2,25,1);
insert into casefieldsets (cf_csid,cf_fsid,cf_value) values (2,26,1);
insert into casefieldsets (cf_csid,cf_fsid,cf_value) values (2,27,1);
insert into casefieldsets (cf_csid,cf_fsid,cf_value) values (3,1,0);
insert into casefieldsets (cf_csid,cf_fsid,cf_value) values (3,10,0);
insert into casefieldsets (cf_csid,cf_fsid,cf_value) values (3,12,1);
insert into casefieldsets (cf_csid,cf_fsid,cf_value) values (3,15,1);
insert into casefieldsets (cf_csid,cf_fsid,cf_value) values (3,20,1);
insert into casefieldsets (cf_csid,cf_fsid,cf_value) values (3,25,1);
insert into casefieldsets (cf_csid,cf_fsid,cf_value) values (3,26,1);
insert into casefieldsets (cf_csid,cf_fsid,cf_value) values (3,27,1);
insert into casefieldsets (cf_csid,cf_fsid,cf_value) values (3,30,1);
insert into casefieldsets (cf_csid,cf_fsid,cf_value) values (3,35,1);

-- if casestext entry doesn't exist for cs_id then the default textblock specifed for blocktype by bt_xbid is returned
insert into casestext (cx_csid,cx_btid,cx_xbid) values (1,1,9);
insert into casestext (cx_csid,cx_btid,cx_xbid) values (1,11,10);
insert into casestext (cx_csid,cx_btid,cx_xbid) values (1,99,11);
insert into casestext (cx_csid,cx_btid,cx_xbid) values (3,1,12);
insert into casestext (cx_csid,cx_btid,cx_xbid) values (3,11,13);
insert into casestext (cx_csid,cx_btid,cx_xbid) values (3,21,14);
insert into casestext (cx_csid,cx_btid,cx_xbid) values (3,99,15);

insert into offeringcases (oc_ofid, oc_csid) values (1,1);
insert into offeringcases (oc_ofid, oc_csid) values (1,2);
insert into offeringcases (oc_ofid, oc_csid) values (2,1);
insert into offeringcases (oc_ofid, oc_csid) values (2,3);
insert into offeringcases (oc_ofid, oc_csid) values (3,1);
insert into offeringcases (oc_ofid, oc_csid) values (3,2);
insert into offeringcases (oc_ofid, oc_csid) values (3,3);
insert into offeringcases (oc_ofid, oc_csid) values (4,2);
insert into offeringcases (oc_ofid, oc_csid) values (6,2);

commit;
