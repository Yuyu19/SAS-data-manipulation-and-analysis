%macro bigloop; 

%do i = 1 %to 10; 

%let n = 4; 

%put Starting the inner loop; 

     %do j = 1 %to &n; 

     %put We are in the inner loop; 

     %end; 

%put The inner loop has ended; 

%end; 

%put &i &j &n;

%mend;

%bigloop;

%macro bigloop; 

%let i = 1; 

%do %until (&i=10); 

%let n = 4; 

%put Starting the inner loop; 

     %do j = 1 %to &n; 

     %put We are in the inner loop; 

     %end; 

%put The inner loop has ended; 

%let i=%eval(&i+1); 

%end; 

%put &i &j &n;

%mend;

data a3;
z=substr("ABCD",2,1);
Run;
