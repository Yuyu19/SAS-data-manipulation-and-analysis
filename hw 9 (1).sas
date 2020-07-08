/* Hw9  Combining Data Sets Assignment */
/* Yuyu Fan */

/* 1 */
libname prg1 '/courses/d649d56dba27fe300/STA5066';
data work.current;
 set prg1.price_current;
Run;
data work.new;
  set prg1.price_new;
Run;
PROC CONTENTS data = work.current;
Run;
/* number of observations=171 and has factor varriable*/
PROC CONTENTS data = work.new;
Run;
/* number of observations=88*/
PROC APPEND base=work.current data=work.new;
Run;
PROC CONTENTS data=work.current;
Run;
/* number of observations=259*/


/* 2 */
PROC CONTENTS data= prg1.qtr1_2007;
Run; 
PROC CONTENTS data= prg1.qtr2_2007;
Run; 
/* qtr1- 22obs   qtr2-36 obs
   Employee_ID in qtr2 but not qtr1*/
PROC APPEND base=work.ytd data=prg1.qtr1_2007;
Run;
PROC CONTENTS data=work.ytd;
Run;
PROC APPEND base=work.ytd data=prg1.qtr2_2007 force;
Run;
PROC CONTENTS data=work.ytd;
Run; 
/* number of observations in work.ytd = 58*/


/* 3 */
PROC CONTENTS data= prg1.mnth7_2007;
Run;
PROC CONTENTS data= prg1.mnth8_2007;
Run;
PROC CONTENTS data= prg1.mnth9_2007;
Run;
DATA work.thirdqtr;
 set prg1.mnth7_2007  prg1.mnth8_2007  prg1.mnth9_2007 ;
Run;
PROC CONTENTS data= work.thirdqtr;
Run;
/*32 obs- correct */


/* 4 */
PROC CONTENTS data= prg1.sales;
Run;
PROC CONTENTS data= prg1.nonsales;
Run;
/* sales = 165 obs      First_Name Last_Name
   nonsales = 235 obs   First Last      */
DATA work.allemployees;
set  prg1.sales  prg1.nonsales(rename=(First=First_Name Last=Last_Name)) ;
keep Employee_ID First_Name Last_Name Job_Title Salary;
Run; 
PROC PRINT data=work.allemployees(obs=100);
Run;


/* 5 */
PROC CONTENTS data= prg1.employee_payroll;
Run;
PROC CONTENTS data= prg1.employee_addresses;
Run;
/* payroll = 424 obs   8 vars   First_Name Last_Name
   addresses = 424 obs  9 vars First Last      */
PROC SORT data=prg1.employee_payroll out=work.payroll;
by Employee_ID;
run;
PROC SORT data=prg1.employee_addresses  out=work.addresses;
by Employee_ID;
run;
DATA work.payadd;
 merge  work.payroll work.addresses;
 by Employee_ID;
run;
PROC CONTENTS data= work.payadd;
Run;
/* number of observations=424 vars= 16*/
  
  
/* 6 */
PROC SORT data=prg1.employee_addresses  out=work.addresses;
by Employee_ID;
run;
PROC SORT data=prg1.employee_payroll out=work.payroll;
by Employee_ID;
run;
PROC SORT data=prg1.employee_organization  out=work.organization;
by Employee_ID;
run;

PROC CONTENTS data= work.addresses;
run;
/* obs=424 vars= 9*/
PROC CONTENTS data= work.payroll;
run;
/* obs=424 vars= 8*/
PROC CONTENTS data= work.organization;
run;
/* obs=424 vars= 4*/
DATA work.payaddorg;
 merge  work.addresses work.payroll work.organization;
 by Employee_ID;
run;
PROC PRINT data=work.payaddorg;
Run;
/*has 424 obs - correct*/

  
/* 7 */
PROC SORT data=prg1.product_list  out=work.product;
by supplier_id;
Run;
PROC SORT data=prg1.supplier   out=work.suppliersort ;
by supplier_id;
Run;
DATA work.prodsup;
merge work.product (in=work.product) work.suppliersort (in=work.suppliersort);
by supplier_id;
if work.product and not work.suppliersort;
run;
proc print data=work.prodsup;
run;

/* 8 */
PROC PRINT data=prg1.lookup_country;
Run;
PROC PRINT data=prg1.customer;
Run;
PROC SORT data=prg1.customer out=work.customer;
by Country ;
Run;
Data work.allcustomer;
  merge  prg1.lookup_country (in=lookup_country  rename=(Start=Country Label=Country_Name) )
          work.customer(in=customer);
  by Country ;
Run;
PROC PRINT Data= work.allcustomer;
Run;


/* 9 */
PROC SORT data=prg1.labsub2  out=work.lab;
by seqn;
Run;
PROC SORT data=prg1.examsub2   out=work.exam ;
by seqn;
Run;

DATA work.ExamOnly work.LabOnly work.LabAndExam;
merge work.exam(in=exam)  work.lab(in=lab);
by seqn;
if exam and not lab then output work.ExamOnly;
if not exam and lab then output work.LabOnly;
if exam and lab then output work.LabAndExam;
run;
proc contents data=work.ExamOnly; run;
proc contents data=work.labonly; run;
proc contents data=work.labandexam; run;





data five;
input x @@;
datalines;
6 7 9 11
;
run;
data six;
input x @@;
datalines;
5 8 10 12
;
run;
data seven;
set five six;
by x;
run; 


data ten; 
input x @@;
datalines;
10 11 12 13 14 
;
run;
data eleven; 
input x @@;
datalines;
11 13 
;
run;
data twelve; 
merge ten eleven; 
by x;
run; 


data ten; 
input x @@;
datalines;
10 11 12 13 14 
;
run;
data eleven; 
input x @@;
datalines;
11 13 15
;
run;
data twelve; 
merge ten eleven; 
by x;
run; 


data nine; 
input x @@;
datalines;
9 10 11 12 13 
;
run;
data ten; 
input x @@;
datalines;
10 12 
;
run;
data eleven; 
merge nine(in=one) ten(in=two); 
by x;
if one and two;
run; 


data three ; 
input x @@; 
datalines;
3 4 5 6 7 
;
run;
data four; 
input x @@;
datalines;
4 6 8
;
run;
data five; 
merge three(in=one) four(in=two); 
run; 