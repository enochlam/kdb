// RTD
tables `.
count quote
reverse quote
reverse select count sym by `minute$time from quote


// HDB
date
select from quote where date=.z.d


// SUB
-10#quote

hloc:([]sym:`a`b;high:(1.4;2.5);low:(1.23;2.3);open:(1.1;2.1);close:(1.24;2.4))

([]sym:`a`b;bid:(1.3;2.5);ask:(1.23;2.3))
