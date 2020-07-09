/* Homework 09 SQL Set Operators */
/* Yuyu Fan */
%let path=/courses/d649d56dba27fe300/STA5067/SAS Data;
libname orion "&path/orion";


/* 1 */
Proc sql;
Select Customer_ID 
from orion.Order_fact
intersect
Select Customer_ID 
from orion.Customer;
quit;


/* 2 */
Proc sql;
Select count(*) as Total  
from (select * from orion.Employee_organization
      except corr
      Select * from orion.Employee_donations);
quit;


/* 3 */
Proc sql;
Select count(*) as Total  
from (select * from orion.Order_fact
      intersect corr
      Select * from orion.Customer);
quit;


/* 4 */
Proc sql number;
title "Sales Reps Who Made No Sales in 2007";
Select Employee_ID, Employee_Name
from orion.Employee_Addresses
where Employee_ID in
(select Employee_ID from orion.Sales
      except corr
      Select Employee_ID from orion.Order_fact
      where year(order_date)=2007);
quit;


/* 5 */
Proc sql ;
Select Customer_ID, Customer_Name
from orion.Customer
where Customer_ID in
(select Customer_ID from orion.Customer
      INTERSECT corr
      Select Customer_ID from orion.Order_fact);
quit;


/* 6 */
Proc sql ;
title "Payroll Report for Sales Representatives";
select 'Total Paid to ALL Female Sales Representatives',
sum(salary), count(*)
from orion.Sales
where gender='F' 
and job_title contains 'Rep'
union
select 'Total Paid to ALL Male Sales Representatives',
sum(salary), count(*)
from orion.Sales
where gender='M' 
and job_title contains 'Rep';
quit;
title;

/* 7 */
Proc sql ;
select * from  orion.Qtr1_2007
outer union corr
select * from  orion.Qtr2_2007;
quit;


/* 8 */
Proc sql ;
select * from  orion.Qtr1_2007
union
select * from  orion.Qtr2_2007;
quit;

Proc sql ;
select * from  orion.Qtr1_2007
outer union
select * from  orion.Qtr2_2007;
quit;
