/* Hw8  Manipulating Data part 2 */
/* Yuyu Fan */

/* 1 */
libname prg1 '/courses/d649d56dba27fe300/STA5066';
PROC PRINT data=prg1.au_salesforce;
Run;
data work.codes;
 set prg1.au_salesforce;
 FCode1 =substr(First_Name,1,1) ;
 FCode2= substr(First_Name,length(First_Name)-1,1);
 LCode 	 =substr(Last_Name,1,4);
 User_ID=cats(FCode1,FCode2,LCode);
 User_ID=lowcase(user_id);
Run;
Proc print data=work.codes;
var First_Name FCode1 FCode2 Last_Name LCode User_ID;
Run;

/* 2 */
PROC PRINT data=prg1.newcompetitors;
Run;
Data work.smallstores;
set prg1.newcompetitors;
not2=substr(ID, 3, length(ID));
not2=left(not2);
number=substr(not2,1,1);
if number ne 1 then delete;
city=propcase(city);
run;

proc print  data=smallstores;
run;

/* 3 */
PROC CONTENTS data= prg1.contacts;
run;
PROC PRINT data= prg1.contacts;
run;
Data states;
set prg1.contacts;
Location = propcase(zipname(substr(address2,length(address2)-4,5)));
run;
PROC PRINT data= states;
run;

/* 4 */
PROC CONTENTS data= prg1.customers_ex5 details;
Run;
PROC PRINT data= prg1.customers_ex5(obs=15);
Run;
DATA work.names;
set prg1.customers_ex5;
lname=scan(name,1,",");
fname=scan(name,2,",");
if gender='M' then ad="Mr.";
else ad="Ms.";
New_Name=propcase(catx(" ",ad,fname,lname));
keep New_Name Name Gender;
Run;
PROC PRINT data= prg1.customers_ex5 details;
Run;


/* 5 */
PROC PRINT data=prg1.customers_ex5;
Run;
DATA work.silver work.gold work.platinum;
set prg1.customers_ex5;
Customer_ID=Tranwrd(Customer_ID,"-00-","-15-");
if find(Customer_ID, "silver", "I") gt 0 then do;
output work.silver;
end;
if find(Customer_ID, "gold", "I") gt 0 then do;
output work.gold;
end;
if find(Customer_ID, "platinum", "I") gt 0 then do;
output work.platinum;
end;
Keep Customer_ID Name Country;
Run;
proc print data=work.silver;
run;
proc print data=work.gold;
run;
proc print data=work.platinum;
run;

/* 6 */
PROC PRINT data = prg1.employee_donations;
run;
DATA work.split;
set  prg1.employee_donations;
PctLoc=find(Recipients,'%','I'); 
IF pctloc >0 then  do; 
charity = substr(Recipients,1,PctLoc);
output;
charity=substr(Recipients,pctloc+2,length(Recipients));
output;
end;
else do; charity=recipients;
output;
end;
run;
proc print data=work.split;
run;

/* 7 */
PROC PRINT data = prg1.orders_midyear;
run;
Data work.sale_stats;
set prg1.orders_midyear;
MonthAvg = round(mean(of month1-month6));
MonthMax =max(month1, month2, month3, month4, month5,month6);
MonthSum = sum(of month1-month6);
Run;
PROC PRINT data=work.sale_stats;
var Customer_Id MonthAvg MonthMax MonthSum;
Run;

/* 8 */
PROC PRINT data=prg1.orders_midyear;
Run;
DATA work.freqcustomers;
set prg1.orders_midyear;
num=n(of month1-month6);
if num lt 5 then delete;
median=median(of month1-month6);
MonthMax1=largest(1, month1, month2, month3, month4, month5, month6);
MonthMax2=largest(2, month1, month2, month3, month4, month5, month6);
run;
proc print data=work.freqcustomers;
run;

/* 9 */
Proc contents data=prg1.shipped details;
Run;
PROC PRINT data=prg1.shipped;
Run;
data shipping_notes; 
set prg1.shipped; 
length Comment $ 21.; 
Comment = cat(’Shipped on ’,Ship_Date); 
Total = Quantity * Price; 
run; 
proc print data=shipping_notes noobs; 
format Total dollar7.2; 
run; 

/*corrected code*/
data shipping_notes;
set prg1.shipped;
price=input(price, dollar7.2 );
ship=input(Ship_Date, $21.);
drop ship;
Comment = Cat("Shipped on ",ship);
Total = Quantity * Price;
run;
proc print data=shipping_notes noobs;
format Total dollar7.2;
run;


/* 10  */
PROC CONTENTS data=prg1.US_newhire;
Run;
PROC PRINT data=prg1.US_newhire;
Run;
DATA US_converted;
Set prg1.US_newhire;
ID=compress(ID,"-");
I1=input(ID,15.);
drop ID;
rename I1=ID;
telephone1=input(telephone,$15.);
pt1=substr(telephone1,1,3);
pt2=substr(telephone1,4,length(telephone1));
telephone3=pt1||"-"||pt2;
drop Telephone telephone1 pt1 pt2;
rename telephone3=Telephone;
Birthday1=input(Birthday, date9.);
drop birthday;
rename birthday1=Birthday;
run;
proc contents data=us_converted;
run;
proc print data=us_converted;
run;