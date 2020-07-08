/* Hw2 ReadingSASDataSets */
/* Yuyu Fan */
/* 1 */
libname customer '/courses/d649d56dba27fe300/STA5066';
data youth;
 set customer.customer_dim;
 where customer_gender = 'F'
       and customer_age>= 18 and customer_age<=36
       and Customer_Group contains 'Gold';
 keep Customer_Name Customer_Age Customer_BirthDate Customer_Gender Customer_Group;
Run;


/* 2 */
libname prg1 '/courses/d649d56dba27fe300/STA5066';
data sports;
  set prg1.product_dim;
  where Supplier_Country in ('GB','ES','NL') and
        Product_Category like '%Sports';
  drop  Product_ID Product_Line Product_Group Supplier_ID;
  Label Product_Category= 'Sports Category'
        Product_Name =	'Product Name (Abbrev)'
        Supplier_Name =	'Supplier Name (Abbrev)';
  format Product_Name $15. Supplier_Name $15.;
Run;
PROC CONTENTS data=sports;
Run;  
proc print data=sports(obs=14);
Run;

/* 3 */
libname nh3 '/courses/d649d56dba27fe300/STA5066';
data Demographics;
  set nh3.adult;
  keep seqn dmarethn dmaracer dmaethnr hssex hsageir;
  label dmarethn='Race-Ethnicity
  1=Non-Hispanic White 
  2=Non-Hispanic Black 
  3=Mexican American 
  4=Other'
  dmaracer= 'Race
  1=White
  2=Black
  3=Other
  8=Mexican-American of unknown race'
  dmaethnr= 'Ethnicity
  1=Mexican American
  2=Other Hispanic
  3=Not Hispanic'
  hssex='Gender
  1=Male 
  2=Female';
run;
proc print data=Demographics(obs=14);
Run;



/* 4 */
libname Nhanes3 '/courses/d649d56dba27fe300/STA5066';
data examsub1;
  set Nhanes3.exam;
  keep  hsageir hssex dmaracer
    bmpwt bmpht
pep6g1
pep6h1
pep6i1
pep6g3
pep6h3
pep6i3
sppfvc
sppfev1;
 format pep6g1 peph1 pep6i1 pep6g3 pep6h3 pep6i3 17.;
 rename hsageir=age
hssex	= gender
dmaracer= race
bmpwt	=wt_kg
bmpht=ht_cm
pep6g1=sbp1
pep6h1=sbp2
pep6i1=sbp3
pep6g3=dbp1
pep6h3=dbp2
pep6i3=dbp3
sppfvc=fvc
sppfev1=fvc1;
run;
proc print data=examsub1(obs=7);
Run;
PROC CONTENTS data=examsub1;
Run;  

/* 5 */
libname NH '/courses/d649d56dba27fe300/STA5066';
data labsub1;
  set NH.lab;
  keep seqn 
hgp	
htp	
tcp	
tgp	
lcp	
hdp	
fbpsi 
crp	
sgp	
urp;
PROC CONTENTS data=labsub1;
Run;  
proc print data=labsub1(obs=5);
Run;

/* 6 */
libname nh3 '/courses/d649d56dba27fe300/STA5066';
data mortsub1 ;
  set nh3.mortality ;
  where eligstat =1;
  keep SEQN MORTSTAT;
  label  MORTSTAT='0=alive at end of follow-up 1=died during the follow-up period';
run;
PROC CONTENTS data=mortsub1;
Run;  
proc print data=mortsub1(obs=100);
Run;
