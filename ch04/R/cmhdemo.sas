%include goptions ;
goptions vsize=7 in hsize=7 in horigin=.75in vorigin=.5in lfactor=3;
goptions ftext=hwpsl009;
%size(SUGI,0);

*-- demonstrate CMH frequency patterns;
options ls=68;
*-- This table contains a general association, but
    no row mean differences or linear association;
data gen;
  input a $ @;
  do b = 1 to 5;
     input count @;
     output; end;
datalines;
a1    0  15   25  15   0
a2    5  20    5  20   5
a3   20   5    5   5  20
proc freq;
  weight count;
  tables a * b / cmh norow nocol nopercent;
  run;

proc sort;
	by b a;
proc iml;
	%include mosaics(readlab);
	vnames = {a b};
	run readtab('gen', 'count', vnames, table, dim, lnames);

   title = 'General Association';
	font='hwpsl009';
/*	
	reset storage=mosaic;
   load module=_all_;
	colors={BLUE RED};
	filltype={HLS HLS};
   htext=1.6;
   plots = 2;
   run mosaic(dim, table, vnames, lnames, plots, title);
*/	
	%include catdata(sieve);
	table = shape(table,5,3)`;
	print table;
	run sieve(table, vnames, lnames, title);
quit;
%gskip;

*-- This table contains a weak, non-significant
    general association, but significant row mean
    and linear associations;
data lin;
  input a $ @;
  do b = 1 to 5;
     input count @;
     output; end;
datalines;
a1    2   5    8   8   8
a2    2   8    8   8   5
a3    5   8    8   8   2
a4    8   8    8   5   2
proc freq;
  weight count;
  tables a * b / cmh norow nocol nopercent;
proc means mean;
  weight count;
  class a;
  var b;

proc sort;
	by b a;
proc iml;
	%include mosaics(readlab);
	vnames = {a b};
	run readtab('lin', 'count', vnames, table, dim, lnames);
	
   title = 'Linear Association';
	font='hwpsl009';
/*
	reset storage=mosaic;
   load module=_all_;
	colors={BLUE RED};
	filltype={HLS HLS};
   htext=1.6;
   plots = 2;
	shade = {.5 1 1.5 2};
   run mosaic(dim, table, vnames, lnames, plots, title);
*/
	%include catdata(sieve);
	table = shape(table,5,4)`;
	print table;
	run sieve(table, vnames, lnames, title);
quit;


%gfinish;