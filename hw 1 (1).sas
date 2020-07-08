/* 1 */
title;
data anscombe;
  do data=1 to 4;
  do n=1 to 11;
    input x y @@;
    output;
	end;
  end;
datalines;
10 8.04 8 6.95 13 7.58 9 
8.81 11 8.33 14 9.96 6 7.24 
4 4.26 12 10.84
;
run;
proc print data=anscombe;
run;


/* 2 */
data tmp; 
input x y @@;
datalines;
1 7 2 8 3 9 4 10
run;

proc freq data=work.tmp;
tables x;
run;

/* 3 */
data tmp;
input x y @@;
datalines;
1 7 2 8 3 9 4 10
run;

proc print data=work.tmp;
run;


/* 4 */
data tmp; 
input x y @@;
datalines;
1 7 2 8 3 9 4 10
run;

proc freq data=work.tmp;
tables x;
run;


/* 5 */
data meta;
  input id a b c d;
  label id = 'Study Number'
      a = 'Number of occurrences for the Treatment (new surgery)Group'
      b = 'Number of nonoccurrences for the Treatment (new surgery)Group'
      c = 'Number of occurrences for the Control (old surgery)Group'
      d = 'Number of nonoccurrences for the Control (old surgery)Group';
datalines;
1 7 8 11 2  
2 8 11 8 8  
3 5 29 4 35  
4 7 29 4 27 
;
run;
proc means data=meta;
var a;
run;

/* 6 */
data tmp17; 
title "this is a small data set";
input w t @@;
datalines;
43 55 67 79 41 57 
15 17 23 19
run;

proc print data=tmp17;
run;

/* 7 */
data ages;
input age gender $ @@;
datalines;
22 f 27 m 23 m 34 f
run;

proc print data=ages;
title "Listing of work.ages;
run;



