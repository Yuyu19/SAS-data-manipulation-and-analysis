/* Hw1  SQL Basic Queries */
/* Yuyu Fan */

%let path= /courses/d649d56dba27fe300/STA5067/SAS Data;
/* 1 */
libname orion "&path/orion";
Proc SQL;
  select *
  from orion.Employee_Payroll;
Quit;

Proc SQL;
  select Employee_ID, Employee_Gender, Marital_Status,  Salary
  from orion.Employee_Payroll;
Quit;

/* 2 */
Proc SQL;
  select Employee_ID, Employee_Gender, Marital_Status, Salary,
          Salary * 1/3 as Tax
  from orion.Employee_Payroll;
Quit;

/* 3 */
Proc SQL;
  select Employee_ID, Salary,
        case scan(Job_Title,-1,' ')
         when 'Manager' then  'Manager'
         when 'Director' then 'Director'
         when 'Officer' then 'Executive'
         when 'President' then 'Executive'
         else 'N/A'
         end as level ,
        case 
         when scan(Job_Title,-1,' ')='Manager' and  Salary< 52000  then  'Low'
         when scan(Job_Title,-1,' ')='Manager' and Salary>= 52000 and Salary<=72000  then  'Medium'
         when scan(Job_Title,-1,' ')='Manager' and Salary> 72000  then  'High'
         when scan(Job_Title,-1,' ')='Director' and  Salary< 108000  then  'Low'
         when scan(Job_Title,-1,' ')='Director' and Salary>= 108000 and Salary<=135000  then  'Medium'
         when scan(Job_Title,-1,' ')='Director' and Salary> 135000 then  'High'
         when scan(Job_Title,-1,' ')='Officer' and  Salary< 240000 then  'Low'
         when scan(Job_Title,-1,' ')='Officer' and Salary>= 240000 and Salary<=300000  then  'Medium'
         when scan(Job_Title,-1,' ')='Officer' and Salary> 300000 then  'High'
         when scan(Job_Title,-1,' ')='President' and  Salary< 240000 then  'Low'
         when scan(Job_Title,-1,' ')='President' and Salary>= 240000 and Salary<=300000  then  'Medium'
         when scan(Job_Title,-1,' ')='President' and Salary> 300000 then  'High'
         else ' '
        end as Salary_Range
  from orion.Staff;
Quit;



/* 4 */
title "Cities Where Employees Live";
Proc SQL;
  select distinct City
  from orion.Employee_Addresses;
Quit;
title;


/* 5 */
title " Donations Exceeding $90.00";
Proc SQL;
  select  Employee_ID, Recipients,
    sum(Qtr1, Qtr2, Qtr3, Qtr4) as Total
  from orion.Employee_donations
  where calculated  Total >90;
Quit;
title;


  