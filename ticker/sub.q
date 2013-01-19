\l log4.q
tp:hopen `::30000


/ .u.sub
/ `quote
/ +`time`sym`bid`ask`size!(`time$();`g#`symbol$();`float$();`float$();`int$())

/sub:{[x;y]m:x(`.u.sub;y;`);-1 -3!m;@[`.;y;:;last m]}
sub:{[x;y]m:x(`.u.sub;y;`)}

/ function to calculate HLOC from upd raw ticks
fs:{ 0!?[x;();(enlist `sym)!(enlist `sym);`time`bhigh`blow`bopen`bclose!(enlist(last;`time)),((max;min;first;last),'`bid)] };

/ cache for HLOC
cache:();

/ upd for Daily HLOC by sym
.upd.hloc:{
    DEBUG ("upd called for table: %1";x);
    cache::0!?[(cache,fs [x]);();(enlist `sym)!(enlist `sym);`time`bhigh`blow`bopen`bclose!((last;`time);(max;`bhigh);(min;`blow);(first;`bopen);(last;`bclose))]; 
  };


.u.end:{[x]};

/ replay the tp log
upd:{ if[x~`quote;.upd.hloc[flip (`time`sym`bid`ask`size)!y]] };
tl:`$("d",string .z.d);
tfl:` sv (hsym `data;tl);
INFO ("Replaying Tickerplant log: %1";tfl);
rc:-11!tfl;
INFO ("Replayed count: %1";rc);

/ start subscription
upd:{ if[x~`quote;.upd.hloc[y]] };
sub[tp;`quote];
