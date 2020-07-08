/* HW 17 Simulating Sampling Distributions */
/* Yuyu Fan */


/* 1 */
%let obs = 50;
%let rep = 1000;
%let seed=54321;
/* a */
data simsk;
call streaminit(&seed);
do SampleID = 1 to &rep;
   do i = 1 to &obs;
      Exponential=rand("exponential");   
      output;
   end;
end;
run;

/* b */
proc means data=simsk kurtosis noprint;
   by SampleID;
   var Exponential;
   output out=moments  kurtosis=;
run;


/* c */
proc sgplot data=moments;
   title"Kurtosis Bias in Small Samples:N=50";
   xaxis label='kurtosis' discreteorder=data;
   density Exponential/ type=kernel;
run;



/* 2 */
/* a */
%let  obs = 50;
%let reps = 1000;
%let seed=54321;
proc iml;
call randseed(123);
x = j(&reps,&obs);      
call randgen(x, "exponential");  
create simsk2 from x  ;
append from x;
close simsk2;
quit;

/* b */
data moments2(keep=Kurtosis);
set simsk2;
Kurtosis = kurtosis(of COL1-COL50);                                                                                                                                                                                                                                            
Run;

/* c */
proc sgplot data=moments2;
   title"Kurtosis Bias in Small Samples:N=50";
   xaxis label='kurtosis' discreteorder=data;
   density Kurtosis/ type=kernel;
run;
