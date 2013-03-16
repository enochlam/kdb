/ google charts - see http://code.google.com/apis/chart/
/ NOTE: your data is sent to google to prepare the graphic 
/ example: chart chartsize[150 200] charttype[`lc] axistype[`x`y] axislabel[(`mar`apr`may`jun`jul;``50Kb)] simpleencode[26?60] title["kdb+"] endchart
/\d .gc
CMDDELIM:"&"
img:{"<img src=\"",x,"\" />"} / img chart ..
chart:{"http://chart.apis.google.com/chart?",x}
endchart:""
simpleencode:{chd"s:",$[0h=type x;brc simplelookup each x;simplelookup x]}
textencode:{chd"t:",raze$[0h=type x;1_raze{"|",1_raze x}each textlookup each x;1_raze textlookup x]}
extendedencode:{chd"e:",raze$[0h=type x;brc extendedlookup each x;extendedlookup x]}
/ granularity values 61 for simple, 100 for text, 4095 for extended 
scale0:{[granularity;startatzero;data]
	high:max rdata:raze data;low:$[startatzero;0;min rdata];
	scaled:floor 0.5+granularity*(data-low)%high-low;
	f:{x[where null x]:-1;x};
	scaled:$[0h=type scaled;f each scaled;f scaled];
	`high`low`data!(high;low;scaled)}
scale:scale0[;1b;]
axislabel:{chxl brp((string til count x),'":"),'{rp string x}each x:enlisted x}
axisposition:{chxp brp{brc string x}each x:enlisted x}
axisrange:{chxr brp(string til count x),'{rc string x}each x:enlisted x}
axisstyle:{chxs brp(string til count x),'{rc string x}each x:enlisted x}
axistype:{assert all x in`x`t`y`r;chxt x}
backgroundfill:chartareafill:{chf brc string x}
barwidth:{chbh brc string x}
chartsize:{chs brx string x}
charttype:{assert x in `lc`lxy`bhs`bhg`bvs`bvg`p`p3`v`s;cht x}
datasetcolor:{chco brc string x}
fillarea:rangemarker:shapemarker:{chm brp{brc string x}each x:enlisted x}
gridline:{chg brc string x}
label:{chl rp string x}
legend:{chdl brp string x}
linearstripe:lineargradient:{chf brp{brc string x}each x:enlisted x}
linestyle:{chls brp{brc string x}each x:enlisted x}
title:{x:$[0h=type x;brp x;x];x[where x=" "]:"+";chtt x}

// private
rc:raze",",'
rp:raze"|",'
brc:1_raze",",'
brp:1_raze"|",'
brx:1_raze"x",'
assert:{if[not x;'`assert];}
enlisted:{$[0h=type x;x;enlist x]}
gckey:{CMDDELIM,(string x),"="}
gcval:{x,:();$[10=type x;x;brc string x]}
gccmd:{(gckey x),(gcval y),z}
simplelookup:(`u#-1,til 62)!"_",-2_.Q.b6 
textlookup:(`u#-1,til 101)!(enlist",-1"),{",",x,".0"}each string til 101 
extendedlookup:(`u#-1,til 4096)!(enlist"__"),t cross t:(-2_.Q.b6),"-."
chbh:gccmd`chbh
chco:gccmd`chco
chd:gccmd`chd
chdl:gccmd`chdl
chf:gccmd`chf
chg:gccmd`chg
chl:gccmd`chl
chls:gccmd`chls
chm:gccmd`chm
chs:gccmd`chs
cht:gccmd`cht
chtt:gccmd`chtt
chxl:gccmd`chxl
chxp:gccmd`chxp
chxr:gccmd`chxr
chxs:gccmd`chxs
chxt:gccmd`chxt

\d .colour
palegray:`efefefe
red:`ff0000
green:`00ff00
blue:`0000ff         
black:`000000
white:`ffffff        
