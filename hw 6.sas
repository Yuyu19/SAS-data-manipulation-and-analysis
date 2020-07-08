/* HW 08 Creating Tables and Views */
/* Yuyu Fan */
%let path=/courses/d649d56dba27fe300/STA5067/SAS Data;
libname orion "&path/orion";



/* 2 */
/*a*/
Proc sql;
create view work.T_Shirts as
select d.Product_ID,
       Supplier_Name format = $20.,
       Product_Name,
       Unit_Sales_Price as Price Label = "Retail Price"  
from   orion.Product_Dim as d,
       orion.Price_list as p
where  d.Product_ID=p.Product_ID 
 and   Product_Name contains 'T-Shirt';
Quit;

/*b*/
Proc sql;
select *
from work.T_Shirts
order by Supplier_Name, Product_ID;
quit; 

/*c*/
Proc sql;
select Product_ID, Product_Name, Price
from work.T_Shirts
where Price < 20
order by Price;
quit; 

/* 3 */
/*a*/
Proc sql;
create view work.Current_Catalog as
select d.*,
      round(Unit_Sales_Price*(Factor**(year(Today())-year(Start_Date))),.01) 
      as Price Label ='Current Retail Price'
from  orion.Product_dim as d,
      orion.Price_list as l
where d.Product_ID=l.Product_ID;
Quit;

/*b*/
Proc sql;
title "Products With ‘Roller Skate‘ In The Product Name";
select  Supplier_Name, Product_Name,  Price    
from  work.Current_Catalog
where  Product_Name contains 'Roller Skate' 
order by Supplier_Name, price;
quit;

/*c*/
proc sql;
title 'Products with Increase Greater than $5';
select Product_Name, 
       Price, 
       Unit_Sales_Price,
       (Price-Unit_Sales_Price) as Increase
from work.Current_Catalog as c, 
     orion.Price_List as l
where c.Product_ID=l.Product_ID 
and calculated Increase>5
order by Increase desc;
quit;


/* 4 */
/*a*/
Proc sql;
create table work.Employees as
select a.Employee_ID ,
       Employee_Hire_Date as Hire_Date format=MMDDYY10.,
       Salary format=COMMA10.2,
       Birth_Date format=MMDDYY10., 
       Employee_Gender as Gender,
       Country,
       City
from   orion.Employee_Addresses as a,
       orion.Employee_Payroll as p
where  a.Employee_ID=p.Employee_ID 
and    Employee_Term_Date is missing
order by year(Employee_Hire_Date) ASC, Salary Desc;
quit;

/*b*/
Proc sql;
select * 
from work.Employees
where Gender='F' 
and Salary > 75000;
quit;



/* 5 */
Proc sql;
create table Direct_Compensation 
(Employee_ID num,
 Name char(30),
 level char(3),
 Salary num format=comma10.2,
 Commission num format=comma10.2,
 Direct_Compensation num format=comma10.2)
 ;
insert into Direct_Compensation
select distinct f.Employee_ID, 
       catx(" ",First_Name, Last_Name), 
       scan(Job_Title,-1),  
       Salary,
       sum(Total_Retail_Price*0.15),
       sum(Total_Retail_Price*0.15) + Salary
from   orion.Order_fact as f,
       orion.Sales as s
where  f.Employee_ID=s.Employee_ID
and    year(Order_Date)=2007 
group by f.Employee_ID;
quit;


proc sql;
select *
from work.Direct_Compensation;
quit;          



