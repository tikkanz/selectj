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

insert into textblocks (xn_id,xn_name,xn_code) values (1,'Introduction','intro');
insert into textblocks (xn_id,xn_name,xn_code) values (11,'Instructions','instruct');
insert into textblocks (xn_id,xn_name,xn_code) values (21,'Between Cycles','btwncycles');
insert into textblocks (xn_id,xn_name,xn_code) values (99,'Conclusion','conc');

insert into fieldsets (fs_id,fs_name,fs_code) values (1,'Selection progress','progress');
insert into fieldsets (fs_id,fs_name,fs_code) values (10,'Population Size','popsz');
insert into fieldsets (fs_id,fs_name,fs_code) values (12,'Dams per Sire','dams2sire');
insert into fieldsets (fs_id,fs_name,fs_code) values (15,'Age Structure','agestruct');
insert into fieldsets (fs_id,fs_name,fs_code) values (20,'Traits to Record','trt2record');
insert into fieldsets (fs_id,fs_name,fs_code) values (25,'Traits to Select','trt2select');
insert into fieldsets (fs_id,fs_name,fs_code) values (26,'Trait REVs','trtrevs');
insert into fieldsets (fs_id,fs_name,fs_code) values (27,'Selection Method','selmeth');
insert into fieldsets (fs_id,fs_name,fs_code) values (30,'Summarise Selection','selsumm');
insert into fieldsets (fs_id,fs_name,fs_code) values (31,'Summarise Selection','selsumm2');
insert into fieldsets (fs_id,fs_name,fs_code) values (35,'Summary Types','sumtypes');

insert into params (pr_id,pr_name,pr_code,pr_ctype) values (1,'No. of cycles to select for','ncycles','input');
insert into params (pr_id,pr_name,pr_code,pr_ctype) values (2,'Current cycle of selection','currcycle','input');
insert into params (pr_id,pr_name,pr_code,pr_ctype) values (3,'No. of Dams per Sire','dams2hrdsire','input');
insert into params (pr_id,pr_name,pr_code,pr_note,pr_ctype) values (4,'Age to cull at','cullage','Animals older that this age will not appear in selection lists.','input');
insert into params (pr_id,pr_name,pr_code,pr_note,pr_ctype) values (5,'Age at birth','mateage','The parents age when its first progeny is born.','input');
insert into params (pr_id,pr_name,pr_code,pr_note,pr_ctype) values (6,'Allele frequencies','allelefreq','Values must sum to zero.','input');
insert into params (pr_id,pr_name,pr_code,pr_class,pr_ctype) values (7,'Relative Economic Values (REVs)','objectvrevs','controlset','input');
insert into params (pr_id,pr_name,pr_code,pr_class,pr_ctype) values (8,'Select using','selnmeth','controlset','input');
insert into params (pr_id,pr_name,pr_code,pr_class,pr_ctype) values (9,'Summarise','summtype','controlset','input');
insert into params (pr_id,pr_name,pr_code,pr_note,pr_ctype) values (10,'Traits to select on','trts2select','These traits will be available in your selection lists','select');
insert into params (pr_id,pr_name,pr_code,pr_note,pr_ctype) values (11,'Traits to summarise','trts2summ','These traits will be summarised in your final population report','select');
insert into params (pr_id,pr_name,pr_code,pr_ctype) values (12,'Traits to record','trtsrecorded','select');
insert into params (pr_id,pr_name,pr_code,pr_note,pr_ctype) values (13,'No. of breeding females','hrdsizes','This does not include female replacements that are too young to mate.<br/>&nbsp;','select');

insert into people (pp_fname, pp_lname, pp_email) values ('Ric', 'Sherlock', 'r.g.sherlock@massey.ac.nz');
insert into people (pp_fname, pp_lname, pp_email) values ('Tricia', 'Johnson', 'tricia.johnson@hotmail.co.nz');
insert into people (pp_fname, pp_lname, pp_email) values ('Jason', 'Win', 'onfire@xtra.co.nz');
insert into people (pp_fname, pp_lname, pp_email) values ('Joe', 'Bloggs', 'jbloggs@xtra.co.nz');
insert into people (pp_fname, pp_lname, pp_email) values ('Temporary', 'Guest', 'guest@nodomain.com');

insert into scendefs (sd_name,sd_code,sd_descr,sd_filen) values ('Population Size','POPSZ','Does the size of the breeding population affect the rate of progress through selection?','animalsim.ini');
insert into scendefs (sd_name,sd_code,sd_descr,sd_filen) values ('Changing REVs','CHGREV','You can change relative economic values (REVs) for the traits in your selection index.','animalsim.ini');
insert into scendefs (sd_name,sd_code,sd_descr,sd_filen) values ('Select animals manually','MANSEL','You specify which animals to use as parents individually, using your own selection criteria.','animalsim.ini');

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

update offeringstext set ox_intro='
Lorem ipsum dolor sit amet consectetuer tempus lobortis Nunc Nulla et. Et wisi Aliquam Morbi et Maecenas at mi lorem ut justo. Mi neque justo mi elit ac egestas malesuada id pharetra tempus. Magna vitae convallis condimentum condimentum congue tellus et nibh Ut ultrices. Justo et.</p>
<p>Feugiat nibh adipiscing malesuada nascetur mi ut dictum In elit congue. Elit amet mauris Vestibulum Phasellus justo adipiscing semper semper penatibus lorem. Vel pretium dolor convallis at gravida enim nibh mi ac consectetuer. Volutpat semper pretium accumsan In nulla Aliquam nunc condimentum condimentum.</p>
<p>Est Quisque risus nibh Curabitur tellus Quisque auctor tincidunt nulla parturient. Ipsum senectus ipsum elit tortor nec urna ligula lacus ac ipsum. Congue suscipit nisl euismod Vestibulum semper id ut convallis pharetra tincidunt. Proin Phasellus Vestibulum pretium eget penatibus tellus egestas dolor ac vestibulum. Libero amet Nam.
' where ox_id=1;

update offeringstext set ox_intro='
This is the intro text for the extramural version of 117.352.</br><p>Lorem ipsum dolor sit amet consectetuer eu sed natoque elit dui. Accumsan Cras nec montes id at orci eleifend pretium morbi dis. Et nunc mauris ornare sed porttitor Vestibulum tellus Sed felis ultrices. In Vestibulum faucibus In augue interdum sit Vestibulum Suspendisse eros est. Tempus wisi eros enim mauris Nam at.</p>
<p>Enim orci quis cursus Mauris tellus Duis felis odio congue fringilla. Hac quis turpis adipiscing eget odio id Sed consectetuer eget nunc. Phasellus Pellentesque laoreet Maecenas Nulla semper egestas massa feugiat lacinia Nulla. Adipiscing cursus natoque id dictum Vestibulum ligula egestas velit Curabitur enim. At id Curabitur at eu et in Vestibulum Sed consectetuer in. Nec vel Curabitur velit sociis dapibus tellus orci Vestibulum Sed Vivamus. Justo sed.
' where ox_id=2;

update offeringstext set ox_intro='
Lorem ipsum dolor sit amet consectetuer nibh wisi Maecenas elit eros. Nulla sodales Nulla mauris Sed sem Phasellus nulla natoque vitae neque. Et leo scelerisque malesuada accumsan odio consequat tincidunt Ut Phasellus Morbi. Quis Sed tincidunt consectetuer interdum leo quis Mauris aliquam eros Maecenas. Metus iaculis laoreet lorem in nibh tristique est.</p>
<p>Eget velit velit sed ipsum laoreet nibh sociis quis Pellentesque Morbi. Nunc est in parturient congue elit cursus nec et lacinia non. Laoreet pede lorem malesuada adipiscing venenatis magnis enim auctor a egestas. Nam justo vitae habitant est fermentum fames vitae Integer volutpat Curabitur. Commodo mus fringilla consectetuer habitasse est dictumst.
' where ox_id=3;
update offeringstext set ox_intro='
Lorem ipsum dolor sit amet consectetuer eu platea tempor orci id. Sed justo Nullam lacus hendrerit elit gravida.</p>
<p>Semper Nunc dui lorem id elit eros ligula nibh quis ornare. Justo ultrices pretium adipiscing ac volutpat volutpat scelerisque magna facilisis Vivamus. Lorem sit consectetuer nibh.</p>
<p>Odio et sapien nibh turpis a augue Nullam rutrum ut ligula. Eget dui ac Nam est pharetra velit Phasellus Pellentesque amet.</p>
<p>Congue non metus pede Morbi pretium nibh lorem mollis Ut nisl. Nulla pretium facilisis convallis cursus habitasse odio leo gravida.
' where ox_id=4;
update offeringstext set ox_intro='
Lorem ipsum dolor sit amet consectetuer mollis auctor wisi interdum Vestibulum. Dis netus facilisis Aenean tincidunt Vivamus consectetuer malesuada quis.</p>
<p>Nec eu id ipsum interdum velit leo pede tellus dui sit. Mauris nibh tincidunt est netus et venenatis consectetuer faucibus vestibulum Vivamus. Nunc.</p>
<p>Sapien urna orci urna et Pellentesque molestie vitae metus mollis semper. Libero et faucibus vel a semper tristique elit eu tincidunt orci. Risus aliquam lobortis ut lacus ultrices.</p>
<p>Vestibulum nibh Aliquam risus velit ut consectetuer sapien accumsan Aenean tempus. Neque arcu Donec rhoncus ut ut convallis lobortis consectetuer orci eu. Tempus ante quis et enim felis justo vel.
' where ox_id=5;
update offeringstext set ox_intro='
Lorem ipsum dolor sit amet consectetuer pellentesque mauris leo vel id. Interdum ac elit ante nunc sit id pede Quisque orci magna. Sit eget pellentesque id venenatis at quis egestas augue pellentesque vitae. Wisi id quis sodales sem pellentesque magna condimentum congue neque Donec. In vitae quis leo dui elit Curabitur risus Aenean nisl sapien. Eleifend Vestibulum et nisl semper tempus tincidunt pede Maecenas.</p>
<p>Volutpat Nam facilisis montes Integer elit Praesent pede pretium consequat Vestibulum. Nec et pede Morbi orci adipiscing Sed ligula facilisi Maecenas urna. Enim turpis pharetra Ut elit malesuada pretium tellus et elit Nullam. Cursus In Aenean nunc wisi dui lacinia iaculis quis semper mauris. Mattis at lorem In id Phasellus Suspendisse eget ac tempor quis. In feugiat et enim In Lorem wisi sociis elit.
' where ox_id=6;

insert into enrolments (en_urid, en_ofid, en_rlid) values (1,4,10);
insert into enrolments (en_urid, en_ofid, en_rlid) values (1,5,1);
insert into enrolments (en_urid, en_ofid, en_rlid) values (4,5,1);
insert into enrolments (en_urid, en_ofid, en_rlid) values (2,1,1);
insert into enrolments (en_urid, en_ofid, en_rlid) values (2,3,1);
insert into enrolments (en_urid, en_ofid, en_rlid) values (4,1,1);
insert into enrolments (en_urid, en_ofid, en_rlid) values (4,3,1);

insert into cases (cs_sdid,cs_admin) values (1,1);
insert into cases (cs_sdid,cs_admin) values (2,1);
insert into cases (cs_sdid,cs_admin) values (3,1);

insert into fieldsetparams (fp_fsid,fp_prid) values (1,1);
insert into fieldsetparams (fp_fsid,fp_prid) values (1,2);
insert into fieldsetparams (fp_fsid,fp_prid) values (10,13);
insert into fieldsetparams (fp_fsid,fp_prid) values (12,3);
insert into fieldsetparams (fp_fsid,fp_prid) values (15,5);
insert into fieldsetparams (fp_fsid,fp_prid) values (15,4);
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

-- trigger automatially creates casestext entry for intro
update casestext set cx_text='
Intro texta. Lorem ipsum dolor sit amet consectetuer natoque sed libero tellus pede. Risus urna condimentum Pellentesque enim habitasse mauris pretium Aenean eros porta. At elit neque nonummy lorem cursus urna ipsum et auctor mattis. Augue id scelerisque quis dui ornare id leo Nulla odio nascetur. Venenatis nulla lacinia semper id justo ipsum mus lacinia.</p>
<p>Consectetuer lacinia Ut Nam convallis eget id purus congue adipiscing ac. Dui convallis sit id Aenean tincidunt est dictumst aliquam eros id. Et ac in Nam scelerisque ut quis pulvinar faucibus ac justo. Feugiat vel justo orci Donec enim elit pulvinar pede eu rutrum. Nam quis Pellentesque id tortor et Morbi elit mi Donec pretium. Quis montes ridiculus rhoncus Nulla eu.
' where cx_csid=1 and cx_xnid=1;

update casestext set cx_text='
Intro textb. Lorem ipsum dolor sit amet consectetuer Nulla Donec vitae ridiculus leo. Et fringilla ut hendrerit feugiat Nam laoreet mus non interdum in. Consequat non commodo consectetuer Nam et euismod neque Donec non nec. Nam tellus elit malesuada a Phasellus feugiat Curabitur Ut cursus tempor. Pretium Nullam Curabitur ut Nullam quam porttitor vitae dui Sed convallis. Congue Vivamus urna sem.</p>
<p>Sit faucibus enim Suspendisse elit eu Vivamus ullamcorper malesuada ante mauris. Sociis dictum libero penatibus tincidunt morbi adipiscing ridiculus risus faucibus Nulla. Congue dictumst vel ac iaculis sodales Aenean Phasellus Maecenas condimentum pretium. Nunc elit libero pulvinar amet nascetur Aenean congue vitae elit lacus. Consequat platea platea habitant amet amet justo feugiat ac Sed volutpat. Metus vel sed pharetra a consectetuer pede vitae.
' where cx_csid=2 and cx_xnid=1;

update casestext set cx_text='
Intro textc. Lorem ipsum dolor sit amet consectetuer felis et facilisi vitae Aenean. Nunc Vivamus dictumst parturient Vestibulum augue morbi ut at sem amet. Vestibulum nonummy ut magnis dui justo libero tempus tempor in quis. Mi enim Cras pellentesque ligula diam pulvinar Nam egestas aliquet feugiat. Pellentesque Integer.</p>
<p>Vel orci Phasellus semper ut semper lacinia ut elit tincidunt egestas. Nisl lacus elit ridiculus Suspendisse hendrerit diam ornare Donec pellentesque id. Mauris libero ultrices sociis augue consectetuer Donec ut nulla Aenean sodales. Massa nibh tellus tincidunt Mauris natoque nec cursus augue.</p>
<p>Ac Nunc semper non sodales Vestibulum est neque pulvinar sociis dolor. Pulvinar id enim amet quis orci felis laoreet dolor ultrices ligula. Wisi ante fringilla elit ac Phasellus enim pretium elit vitae leo. Laoreet eget Morbi malesuada pede Nam cursus nulla turpis dui quis. Semper arcu vel.
' where cx_csid=3 and cx_xnid=1;

insert into casestext (cx_csid,cx_xnid,cx_text) values (1,11,'
Instruction texta. Lorem ipsum dolor sit amet consectetuer nibh Ut libero egestas quis. Eget Curabitur pellentesque Sed Nullam tempor Lorem Vestibulum Cras libero laoreet. </p>
<p>Et fringilla tortor lacinia tincidunt nunc fames magnis est mauris ut. Porttitor Pellentesque elit Morbi nec natoque Cras ut Suspendisse In nascetur. </p>
<p>Aenean magnis Sed dui at justo et nonummy at augue risus. Molestie massa morbi felis neque ligula pretium a habitasse.
');
insert into casestext (cx_csid,cx_xnid,cx_text) values (1,99,'
Conclusion texta. Lorem ipsum dolor sit amet consectetuer hendrerit sociis elit Quisque nibh. Consectetuer tortor risus consectetuer Ut Pellentesque tincidunt neque non laoreet egestas. Justo tellus ac id.</p>
<p>Vestibulum mi metus amet id augue nec condimentum feugiat turpis dui. Nullam justo faucibus pede Vestibulum porttitor tortor lacinia semper tellus auctor. Interdum at tincidunt wisi.</p>
<p>Pede at ac congue orci elit consectetuer eu pede consequat montes. Pede vel mauris laoreet leo elit quis id nunc metus nulla. Lobortis condimentum pellentesque est Curabitur.
');

insert into casestext (cx_csid,cx_xnid,cx_text) values (2,11,' 
Instruction textb. Lorem ipsum dolor sit amet consectetuer Integer at Curabitur amet gravida. Elit dolor Curabitur nec elit Vivamus neque.</p>
<p>Sed laoreet fringilla Curabitur lacinia semper dignissim senectus nibh nibh Maecenas. Netus consequat Donec quis.</p>
<p>Pellentesque accumsan eros natoque In eleifend tellus iaculis cursus Maecenas cursus. Risus vel elit at Curabitur justo accumsan.
');
insert into casestext (cx_csid,cx_xnid,cx_text) values (2,99,'
Conclusion textb. Lorem ipsum dolor sit amet consectetuer at id quis pede laoreet. Integer malesuada et penatibus ligula convallis malesuada ipsum elit vitae consequat. Nunc risus.</p>
<p>Proin Maecenas risus tincidunt dignissim Aenean facilisi morbi mauris consequat metus. Massa platea Donec tincidunt ridiculus amet leo leo Quisque sem Nulla. Dolor porta.
');

insert into casestext (cx_csid,cx_xnid,cx_text) values (3,11,'
Instruction textc. Lorem ipsum dolor sit amet consectetuer justo Donec eget Maecenas eu. Vel Sed sollicitudin rhoncus orci eleifend urna et nec nonummy.</p>
<p>Enim libero tempor nibh Curabitur Nam Curabitur pede convallis mauris Nulla. Quis convallis tristique tellus odio turpis in Aenean tincidunt ac quis. Volutpat.</p>
<p>In leo urna mauris Aliquam faucibus Suspendisse Praesent at magnis tincidunt. Aliquam quis orci Nam laoreet sapien consectetuer laoreet ante.</p>
<p>Id congue Sed vitae nec dolor Sed iaculis Nulla et amet. Nisl mauris ante convallis orci justo felis risus interdum id.
');
insert into casestext (cx_csid,cx_xnid,cx_text) values (3,21,'
Between cycle textc. Lorem ipsum dolor sit amet consectetuer at lacus odio wisi mauris. Eu tincidunt a id In Vestibulum.</p>
<p>Neque et eget Nunc id Phasellus penatibus semper mollis risus Suspendisse. Rhoncus id dapibus ut Lorem Pellentesque ipsum tempus.
');
insert into casestext (cx_csid,cx_xnid,cx_text) values (3,99,'
Conclusion textc. Lorem ipsum dolor sit amet consectetuer at elit scelerisque Aenean metus. Orci Duis et consequat dapibus id Nulla et ipsum Phasellus.</p>
<p>Sed feugiat volutpat Quisque non id nisl ac sem lorem et. Vestibulum nascetur Quisque molestie condimentum enim id aliquam ligula amet diam. Pretium Nullam.
');

insert into offeringcases (oc_ofid, oc_csid) values (1,1);
insert into offeringcases (oc_ofid, oc_csid) values (1,3);
insert into offeringcases (oc_ofid, oc_csid) values (2,1);
insert into offeringcases (oc_ofid, oc_csid) values (2,2);
insert into offeringcases (oc_ofid, oc_csid) values (2,3);
insert into offeringcases (oc_ofid, oc_csid) values (3,2);
insert into offeringcases (oc_ofid, oc_csid) values (5,2);
insert into offeringcases (oc_ofid, oc_csid) values (6,1);
insert into offeringcases (oc_ofid, oc_csid) values (6,2);

commit;
