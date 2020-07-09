/* Homework 13 Data Step and Macro Interface */
/* Yuyu Fan */
%let path=/courses/d649d56dba27fe300/STA5067/SAS Data;
libname orion "&path/orion";

/* 1 */
/* a */
%macro emporders(idnum=121044);
   proc print data=orion.orders noobs;
      var Order_ID Order_Type Order_Date Delivery_Date;
      where Employee_ID=&idnum;
      title "Orders Received by Employee &idnum";
   run;
%mend emporders;

%emporders()

/* b */
%macro emporders(idnum=121044);
data _null_;
set orion.employee_addresses;
where Employee_ID=&idnum;
call symputx('name',Employee_Name);
run;

/* c */
proc print data=orion.orders noobs;
      var Order_ID Order_Type Order_Date Delivery_Date;
      where Employee_ID=&idnum;
      title "Orders Received by Employee &name";
   run;
%mend emporders;

%emporders()

/*d*/
%emporders(idnum=121066);


/* 2 */
/* a */
proc means data=orion.order_fact nway noprint; 
   var Total_Retail_Price;
   class Customer_ID;
   output out=customer_sum sum=CustTotalPurchase;
run;

proc sort data=customer_sum; 
   by descending CustTotalPurchase;
run;

proc print data=customer_sum(drop=_type_);
run;

/* b */
proc means data=orion.order_fact nway noprint; 
   var Total_Retail_Price;
   class Customer_ID;
   output out=customer_sum sum=CustTotalPurchase;
run;

proc sort data=customer_sum; 
   by descending CustTotalPurchase;
run;

data _null_;
set customer_sum (obs=1);
call Symputx('TOP',Customer_ID);
run;

proc print data=orion.order_fact noobs;
     var Order_ID Order_Type Order_Date Delivery_Date;
     where Customer_Id in (&TOP);
title "Order for Customer &TOP-Orion's Top Customer";
run;

/* c */
data _null_;
set customer_sum (obs=1);
call Symputx('name',Customer_Name);
run;

proc print data=orion.order_fact noobs;
     var Order_ID Order_Type Order_Date Delivery_Date;
     where Customer_Id in (&TOP);
title "Order for Customer &name-Orion's Top Customer";
run;


/* 3 */
/* a */
proc means data=orion.order_fact nway noprint; 
   var Total_Retail_Price;
   class Customer_ID;
   output out=customer_sum sum=CustTotalPurchase;
run;

proc sort data=customer_sum ;
   by descending CustTotalPurchase;
run;

proc print data=customer_sum(drop=_type_);
run;

/* b */
data _null_;
set customer_sum(obs=3) end=final;
length TOP_3 $12.;
retain TOP_3;

TOP_3=catx(',',TOP_3,trim(Customer_ID));
If final then call symputx('TOP3',TOP_3);
run;

/*c*/
proc print data=orion.customer_dim;
     var Customer_ID Customer_Name Customer_Type;
     where Customer_Id in (&TOP3);
     title 'Top 3 Customers';
run;
title;


/* 4 */
/* a */
%macro memberlist(id=1020);
   %put _user_;
   title "A List of &id";
   proc print data=orion.customer;
      var Customer_Name Customer_ID Gender;
      where Customer_Type_ID=&id;
   run;
%mend memberlist;

%memberlist()


/* b */
%macro memberlist(id=1020);
   %put _user_;
   data _null_;
   set orion.customer_type;
     call symputx('TYPE'||left(Customer_Type_ID),Customer_Type);
   run;

/* c */
proc print data=orion.customer;
      var Customer_Name Customer_ID Gender;
      where Customer_Type_ID=&id;
      title "A List of &&TYPE&id";
   run;
%mend memberlist;

%memberlist()

/* d */
%memberlist(id=2030);


/* 5 */
/* a */
data _null_;
   set orion.customer_type;
   call symputx('type'||left(Customer_Type_ID), Customer_Type);
run;

%put _user_;

%macro memberlist(custtype);
   proc print data=orion.customer_dim;
      var Customer_Name Customer_ID Customer_Age_Group;
      where Customer_Type="&custtype";
      title "A List of &custtype";
   run;
%mend memberlist;

/* b */
data _null_;
   set orion.customer_type;
   call symputx('type'||left(Customer_Type_ID), Customer_Type);
run;

%put _user_;
%let num=2010;

%macro memberlist(custtype=&&type&num);
   proc print data=orion.customer_dim;
      var Customer_Name Customer_ID Customer_Age_Group;
      where Customer_Type="&custtype";
      title "A List of &custtype";
   run;
%mend memberlist;
%memberlist()
title;

/* 6 */
/* a */
data _null_;
set orion.country;
call symputx(''||Country,Country_Name);
run;

/* b */
%let code=AU;
proc print data=Orion.Employee_Addresses;
   var Employee_Name City;
   where Country="&code";
   title "A List of xxxxx Employees";
run;

/* c */
%let code=AU;
proc print data=Orion.Employee_Addresses;
   var Employee_Name City;
   where Country="&code";
   title "A List of &&&code Employees";
run;

/* 7 */
/* a */
data _null_;
   set orion.customer_type;
   call symputx('type'||left(Customer_Type_ID), Customer_Type);
run;

%put _user_;

data us;
   set orion.customer;
   where Country="US";
   keep Customer_ID Customer_Name Customer_Type_ID;
run;

proc print data=us noobs;
   title "US Customers";
run;

/* b */
data _null_;
   set orion.customer_type;
   call symputx('type'||left(Customer_Type_ID), Customer_Type);
run;

%put _user_;

data us;
 set orion.customer;
 where Country="US";
 length CustType $40;
 CustType=symget('type'||left(Customer_Type_ID));
 keep Customer_ID Customer_Name Customer_Type_ID CustType;
run;

proc print data=us noobs;
   title "US Customers";
run;






