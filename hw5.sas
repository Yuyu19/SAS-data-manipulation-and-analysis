/* Hw5 HomeworkManipulatingData */
/* Yuyu Fan */
/* 1 */
libname prg1 '/courses/d649d56dba27fe300/STA5066';
data work.increase(keep=Employee_ID Salary Increase NewSalary);
 set prg1.staff;
     Increase = Salary * 0.1;
     NewSalary = Salary + Increase;
 format Salary comma10. Increase dollar10.  NewSalary dollar10.;
 run; 
 
proc print data=work.increase;
Run;

/* 2 */
libname prg1  '/courses/d649d56dba27fe300/STA5066';
data work.birthday;
 set prg1.customer;
     Bday2017 = MDY( month(Birth_Date),day(Birth_Date), 2017) ;
     BdayDOW2017 = day(week(Bday2017));
     Age2017 = (Bday2017 - Birth_Date)/ 365.25;
 keep Customer_Name Birth_Date Bday2017 BdayDOW2017  Age2017;
format Bday2017 date10. Age2017 12.0 ;
 run; 
proc print data=work.birthday(obs=23);
Run;

/* 3 */
libname prg1   '/courses/d649d56dba27fe300/STA5066';
data work.region;
 set prg1.supplier;
 length Region $17;
 format Discount Percent5.; 
 if Country = 'US' then do;
     Discount = 0.1;
     DiscountType = 'Required';
     Region = 'North America';
 end;
 else if Country = 'CA' then do;
     Discount = 0.1;
     DiscountType = 'Required';
     Region = 'North America';
 end;
 else do; 
     Discount = 0.05;
     DiscountType = 'Optional';
     Region = 'Not North America';
 end;
 keep Supplier_Name Country Discount DiscountType Region;
 run;
 proc print data=work.region;
Run;

/* 4 */
libname prg1   '/courses/d649d56dba27fe300/STA5066';
data work.ordertype;
 set prg1.ORDERS ;
 DayOfWeek =week(Order_Date); 
 if Order_Type = 1  then do;
     Type = 'Catalog Sale ';
     SaleAds='Mail';
 end;
 else if Order_Type = 2 then do;
    Type = 'Internet Sale ';
    SaleAds='Email ';
 end;
 else if Order_Type = 3 then do;
    Type = 'Retail Sale ';
 end;
 drop Order_Type Employee_ID Customer_ID;
 run;
 proc print data=work.ordertype(obs=25);
Run;


/* 5  */
libname prg1   '/courses/d649d56dba27fe300/STA5066';
data work.gifts  ;
  set prg1.nonsales ;
 select (Gender);
   when ('F') do;
            Gift1 = 'Perfume';  
            Gift2 = 'Cookware';
            end;
   when ('M') do;
            Gift1 = 'Cologne'; 
            Gift2 = 'Equipment';
            end;
   otherwise do;
            Gift1 = 'Coffee'; 
            Gift2= 'Lawn Calendar';
            end;
   end;
 keep Employee_ID First Last Gift1 Gift2;
 run;
proc print data=work.gifts(obs=27);
Run;


/* 6 */
libname prg1   '/courses/d649d56dba27fe300/STA5066';
data work.increase  ;
  set prg1.staff  ;
 where Emp_Hire_Date >= '01JUL2006'd;
 increase = salary *0.1;
 NewSalary = sum (salary, increase);
 IF increase > 3000;
 format Salary Increase NewSalary comma10.;
 keep Employee_ID Emp_Hire_Date Salary Increase NewSalary;
 run;
 proc print data=work.increase;
Run;


/* 7 */
libname prg1   '/courses/d649d56dba27fe300/STA5066';
data work.bigdonations  ;
  set prg1.employee_donations  ;
  Total= sum(Qtr1, Qtr2, Qtr3, Qtr4);
  NoDonation= nmiss(Qtr1, Qtr2, Qtr3, Qtr4);
  IF Total  < 50 and
     NoDonation  ne 0
    THEN DELETE;
 run;
proc print data=work.bigdonations(keep =Employee_ID Qtr1 Qtr2 Qtr3 Qtr4 Total NoDonation);
Run;

/* 8 */
libname prg1   '/courses/d649d56dba27fe300/STA5066';
data work.diabetes (drop=HAD1 HAD3 HAD4 );
  set prg1.adult (keep=SEQN DMARETHN HSSEX HSAGEIR HAD1 HAD3 HAD4);
  IF HAD1  not in (1,2)
    THEN DELETE;
   if HAD1 =1 then diabetic=1;
   else diabetic=0;
   if hssex=2 and diabetic=1 and HAD4=2
    then diabetic = 0;
run;
PROC FREQ data = work.diabetes;
 table diabetic; 
 run; 
