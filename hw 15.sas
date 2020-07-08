/* HW 15 Macro SQL Interface */
/* Yuyu Fan */
%let path=/courses/d649d56dba27fe300/STA5067/SAS Data;
libname orion "&path/orion";

/* 1 */
/* a */
%macro custtype(type);
	%let type=%upcase(&type);

	proc print data=orion.customer_dim;
		var Customer_Group Customer_Name Customer_Gender Customer_Age;
		where upcase(Customer_Group) contains "&type";
		title "&type Customers";
	run;

%mend custtype;

%custtype(Internet) 

/* b */
%macro custtype(type)/ minoperator;
%let type=%upcase(&type);
%if &type in GOLD  INTERNET %then %do;
 proc print data=orion.customer_dim;
 var Customer_Group Customer_Name Customer_Gender  
        Customer_Age;
 where upcase(Customer_Group) contains "&type";
 title "&type Customers";
 run;
%end;
%else %put
 ERROR: Value of TYPE: &type is not valid.
 ERROR: Valid values are INTERNET;
%mend custtype;

/* c */
%custtype(GOLD)
%custtype(Sales)	

/* d */
%macro custtype(type)/minoperator;
   %if &type=  %then %do;
   %put ERROR: You must provide a value for TYPE;
   %put ERROR: Valid values are INTERNET or GOLD;
   %end;
   %else %do;
   %let type=%upcase(&type);
     %if &type in GOLD INTERNET %then %do;
      proc print data=orion.customer_dim;
         var Customer_Group Customer_Name Customer_Gender  
           Customer_Age;
         where upcase(Customer_Group) contains "&type";
         title "&type Customers";
         run;
         %end;
         %else %do;
        %put ERROR: Value of TYPE: &type is not valid;
        %put ERROR: Valid values are INTERNET or GOLD;
        %end;
      %end;
%mend custtype;

/* e */
%custtype()
%custtype(GOLD)
%custtype(Sales)

/* 2 */
/* a */
%macro listing(custtype);
   proc print data=orion.customer noobs;
   run;
%mend listing;
%listing(2010)

/* b */	
%macro listing(custtype);
%if &type=  %then %do;
   proc print data=orion.customer noobs;
   var Customer_ID Customer_Name Customer_Type_ID;
   title "A Listing of All Customers";
   run;
 %end;
 %else %do;
   proc print data=orion.customer noobs;
   where Customer_Type_ID =&custtype;
   var Customer_ID Customer_Name;
   title "A Listing of &custtype Customers";
   run;
  %end;
%mend listing;

/* c */
%listing()
%listing(2010)

/* d */
%macro listing(custtype)/minoperator;
 proc sql noprint;
 select distinct Customer_Type_ID
 into :idlist separated by ' ' 
 from orion.customer_type;
 quit;
 %put &idlist;
 %if &custtype= %then %let FLAG=0;
 %else %if &custtype in &idlist %then %let FLAG=0;
 %else %let FLAG=1;
 %if &FLAG=0 %then %do;
   %if &custtype= %then %do;
   proc print data=orion.customer noobs;
   var Customer_ID Customer_Name Customer_Type_ID;
   title "A Listing of All Customers";
   run;
   %end;
   %else %do;
   proc print data=orion.customer noobs;
   where Customer_Type_ID =&custtype;
   var Customer_ID Customer_Name;
   title "A Listing of &custtype Customers";
   run;
   %end; 
 %end;
 %else %do;
  %put ERROR: Value for CUSTTYPE is invalid;
  %put Valid values are 1010 1020 1030 1040 2010 2020 2030 3010;
  %end;
%mend listing;


/* e */
%listing();
%listing(2010);
%listing(3030);


/* 3 */
/* a */
%macro generatecode(bartype=VBAR, dims=3D, 
                    var=Customer_Age_Group, color=pink, 
                    surface=S);
    proc gchart data=orion.customer_dim;
       &bartype&dims &var;
       pattern color=&color value=&surface;
    run;
    quit;
%mend generatecode;
%generatecode()

/* bc */
%macro generatecode(bartype=VBAR, dims=3D, 
                    var=Customer_Age_Group, color=pink, 
                    surface=S)/minoperator;
 %let numerrors=0;
 %if not (%upcase(&bartype) in VBAR,HBAR) %then %do;
      %let numerrors=%eval(&numerrors+1);
      %put ERROR: Invalid Bar Type was supplied;
      %put Valid Values are VBAR or HBAR;
    %end;
 %if not (%upcase(&DIMS)= or %upcase(&DIMS)=3D) %then %do;
      %let numerrors=%eval(&numerrors+1);
      %put ERROR: Invalid Dimension Value;
      %put The value can be 3D or a null value;
    %end;
 %if not (%upcase(&surface) in S,X1,X2,X3,X4,X5) %then %do;
      %let numerrors=%eval(&numerrors+1);
      %put ERROR: Invalid Surface Value;
      %put The value can be S, X1, X2, X3, X4, X5;
    %end;
 %if &numerrors=0 %then %do;
    proc gchart data=orion.customer_dim;
       &bartype&dims &var;
       pattern color=&color value=&surface;
    run;
    quit;
    %end;
 %if &numerrors>0 %then %do;
      %put ERROR: Due to parameter errors SAS code will not execute;
      %put You have &numerrors errors;
      %end;
%mend generatecode;
%generatecode(bartype=sbar, dims=1t ,surface=99)


/* 4 */
/* a */
proc means data=orion.order_fact sum mean maxdec=2;
   where Order_Type = 1;
   var Total_Retail_Price CostPrice_Per_Unit;  
   title "Summary Report for Order Type 1";
run;

/* b */
%macro putloop;
    %do i=1 %to 3;
    proc means data=orion.order_fact sum mean maxdec=2;
    var Total_Retail_Price CostPrice_Per_Unit;  
    title "Summary Report for Order Type &i";
   run;
   %end;
  
%mend putloop;
%putloop


/* 5 */
/* a */
%macro tops(obs=3);
    proc means data=orion.order_fact sum nway noprint; 
       var Total_Retail_Price;
       class Customer_ID;
       output out=customer_freq sum=sum;
    run;
    proc sort data=customer_freq;
       by descending sum;
    run;
    data _null_;
       set customer_freq(obs=&obs);
       call symputx('top'||left(_n_), Customer_ID);
    run;
%mend tops;
%tops()
%tops(obs=5)

/* b */ 
%macro tops(obs=3);
   proc means data=orion.order_fact sum nway noprint; 
       var Total_Retail_Price;
       class Customer_ID;
       output out=customer_freq sum=sum;
    run;

    proc sort data=customer_freq;
       by descending sum;
    run;

    data _null_;
       set customer_freq(obs=&obs);
       call symputx('top'||left(_n_), Customer_ID);
    run;
    proc print data=orion.customer_dim noobs;
    where Customer_ID in (%do i=1 %to &obs;&&top&i %end;);
    var Customer_ID Customer_Name Customer_Type;
    title "Top &obs Customers";	     
    run;
%mend tops;

options mprint;
%tops()
%tops(obs=5)
options nomprint;


/* 6 */
/* a */
%macro memberlist(custtype);
   proc print data=Orion.Customer_dim;
      var Customer_Name Customer_ID Customer_Age_Group;
      where Customer_Type="&custtype";
      title "A List of &custtype";
   run;
%mend memberlist;

%macro listall;
   data _null_;
      set orion.customer_type end=final;
      call symputx('type'||left(_n_), Customer_Type);
      if final then call symputx('n',_n_);
   run;
   %put _user_; 
%mend listall;

%listall

/* b */
%macro memberlist(custtype);
   proc print data=Orion.Customer_dim;
      var Customer_Name Customer_ID Customer_Age_Group;
      where Customer_Type="&custtype";
      title "A List of &custtype";
   run;
%mend memberlist;

%macro listall;
   data _null_;
      set orion.customer_type end=final;
      call symputx('type'||left(_n_), Customer_Type);
      if final then call symputx('n',_n_);
   run;
   %put _user_; 
   %do i=1 %to &n;
     %memberlist(&&type&i)
   %end;
%mend listall;

%listall


/* 7 */
/* a */
%macro varscope;
   data _null_;
      set orion.customer_type end=final;
      call symputx('localtype'||left(_n_), Customer_Type);
      if final then call symputx('localn',_n_);
   run;
   %put _user_;
%mend varscope;

%varscope

/* b */
%macro varscope;
%local localtype;
%local localn;
   data _null_;
      set orion.customer_type end=final;
      call symputx('localtype'||left(_n_), Customer_Type);
      if final then call symputx('localn',_n_);
   run;
   %put _user_;
%mend varscope;

%varscope










