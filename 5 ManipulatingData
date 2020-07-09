/* Hw6 Homework Editing Data */
/* Yuyu Fan */
/* 1 */
libname hw6 '/courses/d649d56dba27fe300/STA5066';
/* a */
PROC PRINT data=hw6.shoes_tracker;
  where Product_Category =  ' ' or
   Supplier_Country not in ('GB','US');
run;

/* b */
PROC FREQ data=hw6.shoes_tracker nlevels;
   tables Supplier_Name  Supplier_ID;
   where Supplier_Name in ('3Top Sports','Greenline Sports Ltd') and
	 Supplier_ID in (2963,14682) ;

run;

/* c */
PROC PRINT data=hw6.shoes_tracker;
  where Product_Name not = propcase(Product_Name);
run;

/* d */
data work.shoes_tracker;
  set hw6.shoes_tracker;
   Supplier_Country=upcase(Supplier_Country);
   if Supplier_Country='UT' then Supplier_Country='US';
   if Product_Category=' ' then Product_Category= 'Shoes';
   if Supplier_ID=. then Supplier_ID= 2963;
   if Supplier_Name = '3op Sports' then Supplier_Name = '3Top Sports';
   if _N_=4 then Product_ID =220200300079;
   else if _N_=8 then Product_ID =220200300129;
   if Product_Name not = propcase(Product_Name) then Product_Name = propcase(Product_Name);
   if Supplier_ID=14682 and Supplier_Name = '3Top Sports' then Supplier_Name = 'Greenline Sports Ltd';
run;

/* 2 */
/* a */
data work.qtr2;
  set hw6.qtr2_2007;
run;

/* b */
PROC PRINT data=work.qtr2;
  where Delivery_Date < Order_Date and
       Order_Date not between '01APR2007'd and '30JUN2007'd ;
run;

/* c */
PROC FREQ data=work.qtr2 nlevels;
  tables  Order_ID  Order_Type;
run;

/* d */
proc freq data=work.qtr2;
 tables Order_ID;
 where  Order_ID not = . ;
Run;

proc print data=work.qtr2;
 where Order_Type not in (1, 2,  3);
Run;

/* e */
data work.qtr2;
  set work.qtr2;
  if Order_ID=1242012259 then Delivery_Date ='12MAY2007'd;
  else if Order_ID=1242449327 then Order_Date = '26JUN2007'd;
  if _n_=18 then order_id = 1241895587;
  else if _n_=19 then order_id = 1241895564;
  else if _n_=2 then order_type = 3;
  else if _n_=10 then order_type = 3;
Run;

/* f */
PROC PRINT data=work.qtr2;
  where Delivery_Date >= Order_Date or
       Order_Date between '01APR2007'd and '30JUN2007'd ;
run;
PROC FREQ data=work.qtr2 nlevels;
  tables  Order_ID  Order_Type;
run;
proc freq data=work.qtr2;
 tables Order_ID;
 where  Order_ID not = .;
Run;
proc print data=work.qtr2;
 where Order_Type not in (1, 2, 3);
Run;




/* 3 */

/* a */
PROC contents data = hw6.price_current;
Run;

/* b */
PROC PRINT data = hw6.price_current;
 var Unit_Cost_Price Unit_Sales_Price Factor;
 where Unit_Cost_Price = . or
 Unit_Sales_Price = . or
 Factor= . ;
Run;

/* c */
PROC MEANS data = hw6.price_current; 
  var Unit_Cost_Price   
      Unit_Sales_Price  
      Factor ;
   where Unit_Cost_Price not between 1  and 400 or
     Unit_Sales_Price not  between 3  and 800 or
     Factor not between 1  and  1.05 ;
Run;

/* d */
ods select extremeobs;
proc univariate data = hw6.price_current;
var Unit_Sales_Price Factor;
run ;  

/* e */
DATA work.price_current;
  set  hw6.price_current;
  if Product_ID=220200200022 then Unit_Sales_Price= 57.30;
  else if Product_ID=240200100056 then Unit_Sales_Price= 41.20;
  if _N_=14 then Factor =1.0;
  else if _N_=170 then Factor =1.02;
  else if _N_=134 then Factor =1.0;
Run;


/* 4 */

/* a */
PROC CONTENTS data =hw6.labsub1 position ;
Run;

/* b */ 
PROC MEANS data =hw6.labsub1
            mean;
var
hgp
htp
tcp
tgp
lcp
hdp
fbpsi
crp
sgp
urp
;

RUn;

/* c */
PROC MEANS data =hw6.labsub1
            max;
Run;

/* d */
data  work.labsub2;
 set hw6.labsub1;
  if  HGP in (8,88,888,8888,88888)then  HGP = .; 
  if HTP in (8,88,888,8888,88888) then  HTP = .;
  if TCP in (8,88,888) then TCP = .;
  if TGP in (8,88,888,8888) then TGP = .;
  if LCP in (8,88,888) then LCP = .;
  if HDP in (8,88,888) then HDP = .;
  if FBPSI in (8,88,888,8888) then FBPSI =.;
  if CRP in (8,88,888,8888,88888) then CRP = .;
  if SGP in (8,88,888) then SGP = .;
  if URP in (8,88,888,8888,88888)  then URP = .;
run;

/* e */
PROC MEANS data = work.labsub2;
RUn;


/* 5 */

/* a */
PROC MEANS data =hw6.examsub1 
            max;
Run;

/* b */
data  work.examsub2 (keep =seqn hsageir hssex dmaracer bmi  sbpmn dbpmn fvc fev1 fev1pc) ;
 set hw6.examsub1;
 if PEP6G1 in (8,88,888) then PEP6G1 = .;
if PEP6G3 in (8,88,888) then PEP6G3 = .;
if PEP6H1 in (8,88,888) then PEP6H1 = .;
if PEP6H3 in (8,88,888) then PEP6H3 = .;
if PEP6I1 in (8,88,888) then PEP6I1 = .;
if PEP6I3 in (8,88,888) then PEP6I3 = .;
if BMPWT in (8,88,888,8888,88888) then BMPWT = .;
if BMPHT in (8,88,888,8888,88888) then BMPHT = .;
if SPPFEV1 in (8,88,888,8888)  then SPPFEV1 = .;
if SPPFVC in (8,88,888,8888) then SPPFVC = .;
sbpmn =  mean(pep6g1, pep6h1, pep6i1);
 dbpmn = mean(pep6g3, pep6h3, pep6i3);
 bmi = BMPWT/(BMPHT**2);
 fvc = SPPFVC /1000;
 fev1= SPPFEV1/1000;
 fev1pc= fev1/fvc*100; 
Run;

/* c */
PROC MEANS data =work.examsub2;
Run;


