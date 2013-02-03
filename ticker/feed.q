\d .feed
\d .
sts:`ibm`msft`goog`csco;
es:sts!(-2;0;-1;2);
fgp:{[s;e;c](10 xexp e@s)*rand each c?999};
fr:{ s:first 1?key es; (s,(raze fgp[s;es;2])),raze 1?100};
rcnt:3;


fgl:{r:();do[rcnt;r,:enlist fr[]];:flip r;};

add:{h(`.u.upd;`quote;fgl[]);}
.z.ts:add
h:hopen `::30000;

\t 1000

