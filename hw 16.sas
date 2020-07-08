/* HW 16 Simulating Univariate Distributions */
/* Yuyu Fan */

/* 1 */
/* a */
%let seed=54321;
%let numobs=1000;
Data s1(drop=i);
    call streaminit(&seed);
    do p=0.2 to 0.6 by 0.2;
    do i=1 to &numobs;
	x=rand("geometric",p);
	output;
	end;
  end;
run;

/* b */
proc sql;
create table geomnum as
select p,x , count(*) as Occurrences     
from s1
group by x,p;
quit;



/*c*/
proc sgplot data=geomnum;
series x=x y=Occurrences/group=p markers;


/* 2 */
/* a */
%let a=-2;
%let b=2;
%let obs=1000;
data rand (drop=i);
call streaminit(54321);
	do i=1 to &obs;
		x=rand("Uniform",&a,&b);
		output ;
	end;
run;

/* b */
proc means data=rand mean max min; 
run;

/* c */
%macro unif_a_b(varnm=x,a=0,b=1,seed=54321,obs=100,outdata=unif_a_b);
data &outdata (drop=i);
call streaminit(&seed);
	do i=1 to &obs;
		&varnm=rand("Uniform",&a,&b);
		output;
	end;
run;

/* d,e */
proc means data=&outdata mean max min; 
run;

%mend;
%unif_a_b(a=-1,b=3,seed=54321,obs=1000,outdata=tmp)


/* 3 */
/* a */
%let seed=54321;
%let obs=10000;
proc iml;
x=j(&obs,1,.);
call randseed(&seed);
call randgen(x,"negbin",.3,3);
create negbin var {x};
append from x;
close negbin;
quit;

/* b */
proc sql;
create table counts as
select x, count(x) as occurrences , "3" as K
from negbin
group by x;
quit;

/* c */
proc iml;
x=j(&obs,1,.);
call randseed(&seed);
call randgen(x,"negbin",.3,4);
create s2 var {x};
append from x;
close s2;
quit;

proc sql;
create table s1 as
select x, count(x) as occurrences , "4" as K
from s2
group by x;
quit;

proc sgplot data=s1;
series x=x y=Occurrences/group=K markers;