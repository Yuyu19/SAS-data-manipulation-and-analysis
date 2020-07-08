/* Hw3  SQL Subqueries */
/* Yuyu Fan */

%let path=/courses/d649d56dba27fe300/STA5067/SAS Data;
libname orion "&path/orion";

/* 1 */
Proc SQL;
 select AVG(Quantity) as MeanQuantity 
 from orion.Order_Fact;
Quit;

title "Employees whose Average Quantity Items Sold Exceeds the Company’s Average Items Sold";
Proc SQL;
 select Employee_ID, AVG(Quantity) as MeanQuantity 
 from orion.Order_Fact
 group by Employee_ID
 having AVG(Quantity)>
   (select AVG(Quantity) as MeanQuantity from orion.Order_Fact);
Quit;
title;

/* 2 */
title "Employee IDs for February Anniversaries";
Proc SQL;
 select Employee_ID
 from orion.Employee_Payroll
 where Employee_ID in
        (select Employee_ID
            from orion.Employee_Payroll
            where month(Employee_Hire_Date)=2)
      order by 1;
Quit;
title;

title "Employees with February Anniversaries";
Proc SQL;
 select Employee_ID, 
        scan(Employee_Name,2) as FirstName length=15 label='First Name',
        scan(Employee_Name,1) as LastName length=15 label='Last Name'
 from orion.Employee_Addresses
 where Employee_ID in (select Employee_ID
            from orion.Employee_Payroll
            where month(Employee_Hire_Date)=2 )
 order by LastName;
 Quit;
title;


/* 3 */

Proc SQL;
 select Employee_ID, Job_Title, Birth_Date, int(('24Nov2007'd- Birth_Date)/365.25) as Age
 from orion.Staff
 where Job_Title in ("Purchasing Agent I", "Purchasing Agent II") 
   and calculated Age > all(
   select int(('24Nov2007'd- Birth_Date)/365.25) as Age
   from orion.Staff
   where Job_Title = "Purchasing Agent III");
 Quit;
title;
 
 
/* 4 */
Proc SQL outobs=1;
 select Employee_ID, sum(Total_retail_price*Quantity) as Total_Sales
 from orion.Order_Fact
 where Employee_ID ne 99999999
 group by Employee_ID
 order by calculated Total_Sales desc;
 Quit;

Proc SQL outobs=1;
 select Employee_ID, Employee_Name
 from orion.Employee_Addresses
 where Employee_ID in (
   select Employee_ID
   from orion.Order_Fact
   where Employee_ID = 121045);
 Quit;
 
Proc SQL;
 select distinct e.Employee_ID, Employee_Name, sum(Total_retail_price*Quantity) as Total_Sales
 from orion.Order_Fact as o,
      orion.Employee_Addresses as e
where e.Employee_ID = o.Employee_ID
  and e.Employee_ID = 121045
 group by e.Employee_ID;
 Quit;
 
 
 /* 5 */
Proc SQL;
 select  p.Employee_ID, month(Birth_date) as Birth_month
 from orion.Employee_Payroll as p
 where 'AU'=(select Country
   from orion.Employee_Addresses as a
   where p.Employee_ID = a.Employee_ID )
 order by calculated Birth_month ;
Quit;
 
 
/* 6 */
Proc SQL;
 select Employee_ID, Employee_Gender, Marital_Status  
 from orion.Employee_Payroll as p
 where Employee_ID in(select Employee_ID 
   from orion.Employee_donations  as a
   where p.Employee_ID = a.Employee_ID and
   sum(Qtr1, Qtr2, Qtr3, Qtr4) /p.Salary > 0.002) ;
Quit;


 
 
 
 
 