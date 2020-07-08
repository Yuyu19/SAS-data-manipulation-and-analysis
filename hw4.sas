/* Hw4 Homework Reading Raw Data */
/* Yuyu Fan */
/* 1 */
filename newemps '/courses/d649d56dba27fe300/Data Sets/newemps.csv';
data work.newemps;
   length LastName $18 FirstName $12 Title $25 Salary 8;
   infile newemps dlm=",";
   input LastName FirstName Title Salary;
run; 
PROC CONTENTS data=work.newemps;
Run;  
proc print data=work.newemps(obs=7);
Run;

/* 2 */
filename Donation  '/courses/d649d56dba27fe300/Data Sets/donation.dat';
data work.Donation;
   length IDNum $6 Q1 8 Q2 8 Q3 8 Q4 8;
   infile Donation dlm=" " ;
   input IDNum Q1 Q2 Q3 Q4;
run; 
PROC CONTENTS data=work.Donation;
Run;  
proc print data=work.Donation(obs=10);
Run;

/* 3 */
filename supplier  '/courses/d649d56dba27fe300/Data Sets/supplier.dat';
data work.supplier ;
   infile supplier;
    input ID 1-5
         Name $ 8 -37
         Country $ 40-41;
run; 
PROC CONTENTS data=work.supplier;
Run;  
proc print data=work.supplier(obs=5);
Run;

/* 4 */
filename canada  '/courses/d649d56dba27fe300/Data Sets/custca.csv';
data work.canada ;
   length First $20 Last $20 ID 8 Gender $1  BirthDate 8 age 8 AgeGroup $12;
   infile canada dlm=",";
    input First Last  ID  Gender  BirthDate ddmmyy10. age AgeGroup;
run; 
PROC CONTENTS data=work.canada;
Run;  
proc print data=work.canada(obs=3);
Run;
proc print data=work.canada(obs=3);
format BirthDate ddmmyy10.;
run;



/* 5 */
filename prices  '/courses/d649d56dba27fe300/Data Sets/prices.dat';
data work.prices ;
 infile prices dlm="*" ;
    input  ProductID 1-12
   StartDate: date9. 
   EndDate: date9. 
   UnitCostPrice: DOLLARX6.2 
  UnitSalesPrice: DOLLARX6.2 ;
run; 
PROC CONTENTS data=work.prices;
Run;  				
proc print data=work.prices(obs=4);
Run;
proc print data=work.prices;
format StartDate date9. 
      EndDate date9.
      UnitCostPrice DOLLARX6.2
      UnitSalesPrice DOLLARX6.2;
run;

/* 6 */
filename sales  '/courses/d649d56dba27fe300/Data Sets/sales1.dat';
data work.sales ;
 infile sales dlm="*";

 length gender $1 country $2 JobTitle $13;
 input @1 id 6.
       @8 FirstName $
       @21 LastName $
       @40 Gender $ 
       @43 JobTitle $
       @64 salary DOLLARX8.3
       @73 country $
       @76 BirthDate mmddyy10.
       @87 HireDate mmddyy10. ;
 run; 
 PROC CONTENTS data=work.sales;
Run;  				
proc print data=work.sales(obs=6);
Run;
proc print data=work.sales(obs=6);
format BirthDate mmddyy10. 
      HireDate mmddyy10.
      salary DOLLARX8.3;
run;

/* 7 */
filename sales2 '/courses/d649d56dba27fe300/Data Sets/sales2.dat';
data work.staff2  ;
infile sales2 dlm=" ";
 length EmployeeID  6 
 FirstName  $12
 LastName $18
 JobTitle $20
   Salary 8 
   Gender $1 
   Country $2;
 input @1 EmployeeID 
       @8 FirstName $
       @21 LastName $ ;
 input
  @1 JobTitle $
       @22 HireDate mmddyy10.
       @33 Salary DOLLARX8.3 ;
 input
  @1 Gender $
       @3 BirthDate mmddyy10. 
       @14 Country $;
run;			
proc print data=work.staff2;
Run;   
proc print data=work.staff2(obs=2);
format BirthDate mmddyy10. 
      HireDate mmddyy10.
      salary DOLLARX8.3;
Run;   


/* 8 */
filename sales3 '/courses/d649d56dba27fe300/Data Sets/sales3.dat';
data work.sales   ;
infile sales3 dlm=" ";
length EmployeeID 6 ;
input @1 EmployeeID 6.
      @8 FirstName $12.
      @21 LastName $18.
      @40 Gender $1
      @43 JobTitle $20. / 
      @1 Salary DOLLARX8.3
      @10 Country $2. @;
if Country ="AU" then 
   input 
         @13 BirthDate ddmmyy10.
         @24 HireDate ddmmyy10. ;
if Country ="US" then 
   input 
         @13 BirthDate mmddyy10.
         @24 HireDate mmddyy10. ;
run;
PROC CONTENTS data=work.sales;
Run; 
proc print data=work.sales(obs=10);
where Country ="AU";
Run;        
proc print data=work.sales(obs=15);
where Country ="US";
Run;        

data tmp8;
x=5;
y=4;
x=y/2+x*3+1;
run;   
data tmp4;
x=4;
y=2;
z=y*x**2+1;
run;  

data tmp5;
x=5;
y=2;
z=(y+x)**2+1;
run; 

data tmp6;
input y  z $;
if z="X" then output;
datalines;
17 Z
14 Z
10 X
13 X
19 X
;
run;

data tmp8;
input x1 x2;
if x1 < x2 then delete;
datalines;
1 2 
21 14 
1 11 
;
run;

data tmp1;
input x1 x2;
if x1 < x2 then delete;
datalines;
10 15 
 18 9 
 18 7 
;
run;
