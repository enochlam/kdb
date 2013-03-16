\d .utl
inf:(raze (::;neg)@\:(0W;0w;0we;0Wj;0Wh;0Wz;0Wd;0Wt;0Wv;0Wu))!20#1b;

jsonFuncs:enlist[`]!enlist (::)
jsonFuncs.atom:{
 $[null x;
  "null";
  -1h = type x;
  $[x;"true";"false"]; / JSON has specific keywords for true and false
  (type x) in neg 5 6 7 8 9h;
  $[.utl.inf x;$[x < 0;"-inf";"inf"];string x];
  "\"",(string x),"\""
  ]
 }

jsonFuncs.list:{
 r: $[1h = type x;
  string ?[x;`true;`false];
  (type x) in 5 6 7 8 9h;
  [infx: string ?[(x w:where .utl.inf x) < 0;`$"-inf";`inf];
   @[string x;w;:;infx]
   ];
  "\"",'(string x),'"\""
 ];
 "[ ",(", " sv @[r;nullx;:;(count nullx:where null x)#enlist "null"])," ]" / We want to replace occurences of null atoms with the JSON keyword "null"
 }

jsonFuncs.genList:{"[ ", (", " sv $[jsonFuncs.genListCharTest x;jsonFuncs.jsonT[;0b];jsonFuncs.jsonT[;1b]] each x), " ]"}
jsonFuncs.genListCharTest:{(not all 10h = type each x) and all 0h < type each x} / if the list is a list of simple lists and not all the lists are string lists

jsonFuncs.forceString:{"\"",' (string x),' "\""} / Keys *have* to be strings in JSON
jsonFuncs.dict:{[x;charListAsAtom]"{ ", (", " sv ": " sv/: flip (jsonFuncs.forceString key x;jsonFuncs.jsonT[;charListAsAtom] each value x)), " }"}

/ Tables will be treated as unflipped dictionaries of lists
jsonFuncs.table:{jsonFuncs.dict[flip x;0b]}
jsonFuncs.kTable:{"{ \"key\": ", jsonFuncs.table[key x], ", \"value\":", jsonFuncs.table[value x], " }"}

jsonFuncs.jsonT:{[x;charListAsAtom]; / Sometimes character lists should be strings, and sometimes they should be character lists
 $[ 0 > type x;
  jsonFuncs.atom[x];
  charListAsAtom and 10h = type x;
  "\"",x,"\"";
  (type x) within 1 19h;
  jsonFuncs.list[x];
  (type x) within 20 73h; / TODO:Figure out the highest enumeration type again
  jsonFuncs.list[value x];
  99h = type x;
  $[98h = type key x;jsonFuncs.kTable[x];jsonFuncs.dict[x;1b]];
  98h = type x;
  jsonFuncs.table[x];
  0h = type x;
  jsonFuncs.genList[x];
  "\"Unhandled type: ", (string type x), "\""
  ]
 }

json:{
 $[(type x) in 98 99h;
  jsonFuncs.jsonT[x;1b];
  (10h = type x) or 0h > type x;
  "{ \"atom\": ", jsonFuncs.jsonT[x;1b], " }";
  type[x] within 0 73h; / TODO:Figure out the highest enumeration type again
  jsonFuncs.jsonT[x;1b];
  "{ \"error\": ", jsonFuncs.jsonT[x;1b], " }"
  ]
 }
\d .

.h.ty[`jsn]:"application/json"
.h.tx[`jsn]:{enlist .utl.json x}

