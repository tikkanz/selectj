NB.  Steps used to create Forest Range Customised indexes sqlite database from Excel data

NB. =========================================================
NB.*melt v reshape table to database style 
NB. optional left arg for number of "label" columns
melt=: 3 : 0
	1 melt y
:
	lbls=. (x{.{.y),;:'variable value'
	rows=. }. x {."1 y
	cols=. x }. {. y
	dat=. , x }."1 }. y
	lbls,((#cols)#rows),.(($dat)$cols),.dat
	NB. lbls,(>,{(<"1 a);<b),.,c
)

delim=: 3 : 0
  (',',LF) delim y
  :
  select. #x
    case. 1 do. NB. assume only intra-line delimiter specified
      (x,LF) delim y
    case. 2 do.
      if. 2<L. x do. NB. report arg error
      elseif. 2>L. x do.
        x=. <each x
      end.
      'il eol'=. x
      y=. 8!:0 y
      b=. 0>._1+2*{:$y
      b=. b$1 0      NB. calc boolean
      ;eol,"1~ b &#^:_1!.il"1 y
    case. do.
    NB. report arg error
  end.
)

NB. =========================================================
NB.  Create connection to custidx database
NB. =========================================================

require 'data/sqlite'

FDIR=: jpath '~user/projects/custidx/'
'FDB FDDL FDATA'=: cut 'custidx.sqlite custidx_ddl.sql custidx_data.sql '
NB. ferase FDIR,FDB NB. deletes database file

]db=: 'psqlite'conew~ FDIR,FDB  NB. creates new connection (and database file if required)

NB. Set up the table structure in the database
exec__db fread FDIR,FDDL  

require 'tables/tara'
data=. readexcel 'd:/proj/merino/custindexs/2007sale/customers.xls'
cust=. 1}.((0{ data) i. <'CFW'){."1 data
scenario=. (;/(_11}._2|.9}.2|.i.{.|.$data)){"1 data
pricepr=. (;/(_2|.28}.2|.i.{.|.$data)){"1 data
idx=.(<((}.1 2{"1 tmp) i. }.(0 1){"1 pricepr);0){}.tmp NB. cl_id of price profile 
pricepr=.((<'cl_id'),idx) 1}"0 1 pricepr  NB. amend FirstNames with cl_id
pricepr=.(I.-.*./"1 ((2}."1 pricepr)=<'')){pricepr NB. drop clients with no custom price profile
pricepr=. (<'pp_year') (<0;0)} (<'2007') 0}"1 pricepr NB. add profile_year

NB. Get price details
data=. readexcel 'd:/proj/merino/custindexs/MFD prices.xls'
pricepr2=.(<'cl_id') (<0;1)}_1|."1 a:,. 1|."1 (<'pp_year') (<0;0)}|:data
pricepr=. pricepr,}.pricepr2
pricepr=. (<'pp_id') (<0;0)}(;/i.#pricepr),.pricepr
prices=. 0 3 4 5 6 7 8 9 10 11 12 13{"1 pricepr
NB. "melt" prices using reshape package in R (writecsv readcsv)
NB. or use verb melt defined above
prices2=. readcsv 'c:\program files\j601\user\projects\custidx\prices2.csv'
prices2=. ((<'pr_mfd'),}.each}.2{"1 prices2) 2}"0 1 prices2 NB. drop added x
prices2=. (;:'pr_id pr_pprofile pr_mfd pr_price') 0}prices2
prices2=. (I.(3{"1 prices2)~:<'NA'){prices2
tmp=. query__db 'select cl_id, cl_lname, cl_fname from clients'
idx=.(<((}.1 2{"1 tmp) i. }.(0 1){"1 scenario);0){}.tmp NB. cl_id of scenario 
scenario=.((<'sc_client'),idx) 0}"0 1 scenario  NB. amend FirstNames with cl_id
scenario=. (<'sc_year') (<0;1)} (<'2007') 1}"1 scenario NB. add scenario_year
scenario=. _2|."1 a:,.a:,.2|."1 scenario
scenario=. (;/(-.*./"1 ((2}."1 pricepr)=<'')) #^:_1 (I.-.*./"1 ((2}."1 pricepr)=<''))) 3}"0 1 scenario NB. populating sc_pp
scenario=. (;:'sc_validuntil sc_pp') (0 2;0 3)}scenario
rev=. (i.7){"1 scenario
rev=.(;: 'rv_client rv_year rv_validuntil rv_pp rv_cfw rv_mfd rv_value') 0} rev
scenario=. 0 1 2 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22{"1 scenario
NB. missing a few steps now fiddling with scenario and rev so
NB. that columns in right order, foreign keys are sorted and
NB. added missing % wether lambs kept column
rev=.(rev=<0){"0 1 rev,"0<'' NB. does selective assignment

flds=. delim _1}.}.getColNames 'clients'
extran__db ('clients (',flds,')') bulkins__db (8!:0 cust)
extran__db 'price_profiles' bulkins__db (8!:0 (0 2 1{"1 }.pricepr))
extran__db 'prices' bulkins__db }.(8!:0 prices2)
flds=.delim }.getColNames 'scenarios'
extran__db ('scenarios (',flds,')') bulkins__db (8!:0 }.scenario)
flds=. delim }.getColNames 'revs'
extran__db ('revs (',flds,')') bulkins__db (8!:0 }.rev)


NB. add 0...13 as first column of cust
(,.<"0 i.#cust),.cust

NB. problem with inserting nulls in data for bulkins
NB. empty box ends up as zero length string not NULL
NB. See tstsqlite.ijs for ways to insert NULLs
NB. see Jforum thread "string replace problem"
	NB. Hui solution don't do string replace of ,,
	NB. first format in boxes according to type
	fdata=: ('1';'''alex''';'''rufon''';'2000-11-01'),:('2';'''vilma''')
	NB. then use following line to replace empty boxes with NULL and put in commas
	}."1 ;"1 ',',&.> (fdata=<''){"0 1 fdata,"0<'NULL'
	NB. Don't have to worry about not putting quotes around numbers
	NB. Sqlite coerces quoted number to number if going into 
	NB. column with specified NUMERIC, INTEGER or REAL affinity

