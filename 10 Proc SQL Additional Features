/* Homework 10 Proc SQL Additional Features */
/* Yuyu Fan */
%let path=/courses/d649d56dba27fe300/STA5067/SAS Data;
libname orion "&path/orion";


/* 1 */
/*a*/
Proc SQL;
title 'The highest Salary';
select max(Salary)
 into :MaxSalary
 from  orion.Employee_payroll;
quit;

/*b*/
%let DataSet = Employee_payroll;
%let VariableName = Salary;
%put The value of Employee_payroll is &DataSet;
%put The value of Salary is &VariableName; 

/*c*/
%let DataSet = Price_List;
%let VariableName = Unit_Sales_Price;


/* 2 */
/*a*/
Proc SQL;
title "2007 Purchases by Country";
Select Country, 
       SUM(Total_Retail_Price) as Purchases  format=dollar10.2
 from  orion.Order_fact as f,
       orion.Customer as c
where  f.Customer_ID = c.Customer_ID
  and  year(order_date)=2007
group by Country
order by calculated Purchases desc;
Quit;
Title;

/*b*/
Proc SQL;
title1 "2007 US Customer Purchases";
title2 "Total US Purchases: $10,655.97"; 
Select Customer_Name, 
       SUM(Total_Retail_Price) as Purchases  format=dollar10.2
 from  orion.Order_fact as f,
       orion.Customer as c
where  f.Customer_ID = c.Customer_ID
  and  year(order_date)=2007
  and  country='US'
group by Customer_Name
order by calculated Purchases desc;
Quit;
Title; 


/*c*/
Proc SQL;
title "2007 Purchases by Country";
Select Country, 
       SUM(Total_Retail_Price) as Purchases  format=dollar10.2
 into :Country , :Country_Purchases
 from  orion.Order_fact as f,
       orion.Customer as c
where  f.Customer_ID = c.Customer_ID
  and  year(order_date)=2007
group by Country
order by calculated Purchases desc;
Quit;
%put country: &Country    Purchases: &Country_Purchases;


Proc SQL;
title1 "2007 &Country Purchases";
title2 "Total &Country Purchases: &Country_Purchases"; 
Select Customer_Name, 
       SUM(Total_Retail_Price) as Purchases  format=dollar10.2
 from  orion.Order_fact as f,
       orion.Customer as c
where  f.Customer_ID = c.Customer_ID
  and  year(order_date)=2007
  and  "country =  &Country"
group by Customer_Name
order by calculated Purchases desc;
Quit;
Title;  
 
 
/*d*/
Proc SQL;
title "2007 Purchases by Country";
Select Country, 
       SUM(Total_Retail_Price) as Purchases format=dollar10.2
 into :Country , :Country_Purchases
 from  orion.Order_fact as f,
       orion.Customer as c
where  f.Customer_ID = c.Customer_ID
  and  year(order_date)=2007
group by Country
order by calculated Purchases asc;
Quit;
%put country: &Country    Purchases: &Country_Purchases;


Proc SQL;
title1 "2007 &Country Purchases";
title2 "Total &Country Purchases: &Country_Purchases"; 
Select Customer_Name, 
       SUM(Total_Retail_Price) as Purchases format=dollar10.2
 from  orion.Order_fact as f,
       orion.Customer as c
where  f.Customer_ID = c.Customer_ID
  and  year(order_date)=2007
  and  "country =  &Country"
group by Customer_Name
order by calculated Purchases asc;
Quit;
Title;  
 
 
 
 
 
 
 
 
 

















