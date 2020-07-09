/* HW 07 Complex Queries */
/* Yuyu Fan */
%let path=/courses/d649d56dba27fe300/STA5067/SAS Data;
libname orion "&path/orion";

/* 1 */
/*a*/
proc sql;
title1 '2007 Sales Force Sales Statistics';
title2 'For Employees With 200.00 or More In Sales';
Select Country, First_Name, Last_Name, Value_Sold, Orders, Value_Sold / Orders as Avg_Order 
from (select Country, First_Name, Last_Name,
             sum(Total_Retail_Price) as Value_Sold,
             count(*) as Orders
      from  orion.Order_Fact as f,
            orion.Sales as t
      where f.Employee_ID = t.Employee_ID 
      and   year(Order_date)=2007
      group by Country, First_Name, Last_Name)
where calculated Value_Sold >=200
Order by Country, Value_Sold desc, Orders desc;
quit;
title;

/*b*/
proc sql;
title '2007 Sales Summary by Country';
select Country, 
       max(Value_Sold) as max_value_sold, 
       max(Orders) as max_orders, 
       max(Avg_Order) as max_average,
       min(Avg_Order) as min_average
from (Select Country, First_Name, Last_Name, Value_Sold, Orders, Value_Sold / Orders as Avg_Order 
from (select Country, First_Name, Last_Name,
             sum(Total_Retail_Price) as Value_Sold,
             count(*) as Orders
      from  orion.Order_Fact as f,
            orion.Sales as t
      where f.Employee_ID = t.Employee_ID 
      and   year(Order_date)=2007
      group by Country, First_Name, Last_Name)
where calculated Value_Sold >=200)
group by Country;
quit;
title;


/* 2 */
/*a*/
proc sql;
title1 '2007 Sales Force Sales Statistics';
title2 'For employees with 200.00 or more in sales';
select Department, sum(Salary) as Dept_Salary_Total
from orion.Employee_Payroll as p,
     orion.Employee_Organization as o
where  p.Employee_ID = o.Employee_ID
group by Department;
QUit;

/*b*/
proc sql;
title1 '2007 Sales Force Sales Statistics';
title2 'For employees with 200.00 or more in sales';
select a.Employee_ID, Employee_Name,  department
from orion.Employee_Addresses as a,
     orion.Employee_Organization as o
where a.Employee_ID = o.Employee_ID;
QUit;

/*c*/
proc sql;
title 'Employee Salaries as a Percent of Department Total';
select new2.Department, new2.Employee_Name, e.Salary format=comma9.2, 
e.salary/Dept_Salary_Total as Percent format=percent.2
from (select Department, 
              Sum(Salary) as Dept_Salary_Total
      from orion.Employee_Payroll as a,
           orion.Employee_Organization as b
      where a.Employee_ID=b.Employee_ID
      group by Department) as new,
 (select c.Employee_ID, Employee_Name, Department 
  from orion.Employee_Addresses as c,
       orion.Employee_Organization as d
  where c.Employee_ID=d.Employee_ID) as new2, 
orion.Employee_Payroll as e
where new.Department=new2.Department and
new2.Employee_ID=e.Employee_ID
order by Department asc, Percent desc ;
quit;
title;




/* 3 */

proc sql;
title '2007 Total Sales Figures';
select distinct (scan(a1.Employee_Name,-1,',')||scan(a1.Employee_Name,1,',')) as Manager,
                (scan(a2.Employee_Name,-1,',')||scan(a2.Employee_Name,1,',')) as Employee,
                sum(Total_Retail_Price) as Total_Sales label="Total_Sales" format=6.2
from  orion.Employee_Addresses as a1, 
      orion.Employee_Organization as o,
      orion.Employee_Addresses as a2,
      orion.Order_Fact as f
where a1.Employee_ID=o.Manager_ID 
and   o.Employee_ID= a2.Employee_ID
and   a2.Employee_ID=f.Employee_ID
and   year(order_date)=2007
group by employee
order by a1.country, scan(manager,2),scan(manager,1),Total_Sales desc;
Quit;


