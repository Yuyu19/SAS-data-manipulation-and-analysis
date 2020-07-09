/* Hw7 Processing Data Iteratively */
/* Yuyu Fan */
/* 1 */
data work.future_costs;
wages = 12874000;
retire = 1765000;
medicine= 649000;
year=2019;
 do i= 1 to 10;
   year=year+1;
   wages =  wages* 1.03;
   retire=  retire*1.014;
   medicine= medicine*1.095;
   totalcost= wages+retire+medicine;
   output;
  end;
Run;

PROC PRINT data = work.future_costs;
Run;

data work.future_costs;
wages = 12874000;
retire = 1765000;
medicine= 649000;
income = 50000000;
year=2019;
 do until (totalcost>income);
   year=year+1;
   wages =  wages* 1.03;
   retire=  retire*1.014;
   medicine= medicine*1.095;
   income = income * 1.01;
   totalcost= wages+retire+medicine;
   output;
  end;
Run;
/*takes 42 or in 2061 years when total cost exceeds income*/

/* 2 */
data work.expenses;
income = 50000000;
expenses = 38750000;
year= 0;
 do until (expenses>income or year >30);
  income = income * 1.01;
  expenses = expenses * 1.02;
   year = year+1;
  output;
 end;
Run;

 PROC PRINT data =work.expenses; 
 format Income dollar14.2 Expenses dollar14.2 ;
 Run;

/* 3 */ 
data work.income;
  income = 50000000; 
  expenses = 38750000;
 do year=1 to 75;
  income = income * 1.01;
  expenses = expenses * 1.02;
  if expenses > income then leave;
  output;
 end;
Run;

Proc print data = work.income;
format Income dollar14.2 Expenses dollar14.2 ;
Run;

/* 4 */ 
libname prg1 '/courses/d649d56dba27fe300/STA5066';
PROC CONTENTS data= prg1.orders_midyear;
Run;
data discount_sales;
set prg1.orders_midyear;
  array Mon{6} month1-month6;
  do i=1 to 6;
  Mon{i}=Mon{i}-(Mon{i}*.05);
  end;
Run;
proc print data=discount_sales; 
run;

/* 5 */ 
data special_offer;
set prg1.orders_midyear;
  Total_Sales = sum(month1, month2,month3, month4, month5,month6);
  array Mon{3} month1-month3;
  do i=1 to 3;
  Mon{i}=Mon{i}-(Mon{i}*.1);
  end;
 Projected_Sales = sum(month1, month2,month3, month4, month5,month6);
 Difference = Total_Sales - Projected_Sales;
 keep Total_Sales Projected_Sales Difference;
Run;
options nodate nonumber;
PROC PRINT data = special_offer noobs;
 SUM Difference ;
 format Total_Sales dollar. Projected_Sales dollar. Difference dollar.;
Run;

/* 6 */ 
data preferred_cust;
set prg1.orders_midyear;
  array Mon{6} month1-month6;
  array Target{6}_temporary_(200, 400, 300, 100, 100, 200);
  array Over{6};
  do i=1 to 6;
  Over{i} = Mon{i} - Target{i};
  end;
  Total_Over = sum(Over1, Over2,Over3,Over4, Over5, Over6);
  if Total_Over <= 500 then delete;
  keep Customer ID Over1 Over2 Over3 Over4 Over5 Over6 Total_Over;
Run;

PROC PRINT data = preferred_cust;
Run;

/* 7 */ 
PROC PRINT DATA= prg1.test_answers;
RUN;
data passed failed;
  SET prg1.test_answers;
  ARRAY answer{10}$_temporary_('A', 'C', 'C', 'B', 'E', 'E', 'D', 'B', 'B', 'A');
  array point{10};
  array Q{10} Q1-Q10;
  do i = 1 to 10;
    if answer{i}=q{i} then point{i}=1;
    else point{i}=0;
  end;
  Score = sum(point1, point2, point3, point4,point5,point6, point7, point8, point9, point10);
  if Score ge 7 then output passed;
  else output failed;
Run;
PROC PRINT data = passed;
Run;
PROC PRINT data = failed;
Run; 

/* 8 */ 
PROC MEANS data = prg1.labsubset;
Run; 
DATA work.examsub2(drop=i);
set prg1.labsubset;
  array var{10} hgp--urp;
  array unknown{10}_temporary_(88888, 88888, 888, 8888, 888, 888, 8888, 88888, 888, 88888);
  do i=1 to 10;
    if var{i} eq unknown{i} then var{i}=.;
    end;
run;
PROC MEANS  data = work.examsub2;
Run; 
