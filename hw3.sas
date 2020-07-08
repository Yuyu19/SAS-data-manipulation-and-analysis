/* Hw3 Homework Controlling Input and Output */
/* Yuyu Fan */
/* 1 */
libname prg '/courses/d649d56dba27fe300/STA5066';
PROC CONTENTS data=prg.discount2016;
Run;  
proc print data=prg.discount2016(obs=7);
Run;
data work.extended;
 set prg.discount2016;
 drop Unit_Sales_Price;
 WHERE Start_Date = '01Dec2016'd;
 Promotion = 'Holidays Bonus';
 Season ='Winter ';
 output;
 Start_Date ='01Jul2017'd;
 End_Date= '31Jul2017'd;
 Season ='Summer ';
 output;
Run;
proc print data=work.extended;
Run;

/* 2 */
libname lands '/courses/d649d56dba27fe300/STA5066';
PROC print data=lands.country ;
Run;
data work.new_country;  
set lands.country;
Outdated ='N';
output;
if Country_FormerName ='East/West Germany';
      Country_Name= Country_FormerName ;
      Outdated ='Y';
output;
run;
PROC print data= work.new_country;
Run;

/* 3 */
libname nh3 '/courses/d649d56dba27fe300/STA5066';
data work.males(drop=sex)
  work.females(drop=sex);
set nh3.adultdemographics ;
select  (SEX);
  when (1) output work.males;
  when (2) output work.females;
end;
run;
PROC print data= work.males(obs=3);
Run;
PROC print data= work.females(obs=3);
Run;
PROC CONTENTS data= work.males;
Run; 
PROC CONTENTS data=work.females;
Run; 

/* 4 */
libname fact '/courses/d649d56dba27fe300/STA5066';
PROC CONTENTS data= fact.orders;
Run; 
proc print data=fact.orders (obs=10);
Run; 
data work.fast work.slow work.slowest;
set fact.orders
(drop=Employee_ID);
ShipDays = Delivery_Date - Order_Date;
select;
 when (ShipDays < 3 ) output work.fast;
 when (ShipDays > 5 and ShipDays <=7) output work.slow;
 when (ShipDays > 7 ) output work.slowest;
	 otherwise ;
   end;
run;
proc print data=work.fast;
Run; 
proc print data=work.slow;
Run; 
proc print data=work.slowest;
Run; 



/* 5 */
libname hr '/courses/d649d56dba27fe300/STA5066';
PROC CONTENTS data=hr.employee_organization ;
Run;
proc print data=hr.employee_organization  (obs=5);
Run; 
data work.sales(keep=Employee_ID Job_Title  Manager_ID)
 work.exec(keep=Employee_ID  Job_Title);
set hr.employee_organization;
  if Department='Sales' then output work.sales;
  else if Department='Executives' then output work.exec;
run;
proc print data=work.sales(obs=5);
Run; 
proc print data=work.exec;
Run; 

/* 6 */
libname comp '/courses/d649d56dba27fe300/STA5066';
PROC CONTENTS data=comp.orders ;
Run;
proc print data=comp.orders(obs=11);
Run; 
data work.instore(keep =Order_ID Customer_ID Order_Date) 
     work.delivery(Keep=Order_ID Customer_ID Order_Date ShipDays);
set comp.orders;
ShipDays = Delivery_Date - Order_Date;
 if ShipDays =0 then output work.instore;
 else output work.delivery;
run;
proc print data=work.instore(obs=12);
Run; 
proc print data=work.delivery(obs=25);
Run; 