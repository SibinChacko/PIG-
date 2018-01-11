retail= Load '/home/hduser/2000.txt' using PigStorage(',') as (catid:int, catname:chararray, month1:double, month2:double, month3:double, month4:double, month5:double, month6:double, month7:double, month8:double, month9:double, month10:double, month11:double, month12:double);

groupretail = foreach retail generate catid, catname, $2+$3+$4+$5+$6+$7+$8+$9+$10+$11+$12+$13 as total2000;

--describe groupretail;

--dump groupretail;

retail2= Load '/home/hduser/2001.txt' using PigStorage(',') as (catid:int, catname:chararray, month1:double, month2:double, month3:double, month4:double, month5:double, month6:double, month7:double, month8:double, month9:double, month10:double, month11:double, month12:double);

groupretail2 = foreach retail2 generate catid, catname, $2+$3+$4+$5+$6+$7+$8+$9+$10+$11+$12+$13 as total2001;

--describe groupretail2;

--dump groupretail2;

retail3= Load '/home/hduser/2002.txt' using PigStorage(',') as (catid:int, catname:chararray, month1:double, month2:double, month3:double, month4:double, month5:double, month6:double, month7:double, month8:double, month9:double, month10:double, month11:double, month12:double);

groupretail3 = foreach retail3 generate catid, catname,$2+$3+$4+$5+$6+$7+$8+$9+$10+$11+$12+$13 as total2002;

--describe groupretail3;

--dump groupretail3;

retailcombine = join groupretail by $0, groupretail2 by $0, groupretail3 by $0;

--dump retailcombine;

--describe retailcombine;

retailcombine_net = foreach retailcombine generate $0,$1,$2,$5,$8;

--describe retailcombine_net;
--dump retailcombine_net;

growthchange= foreach retailcombine_net generate $0,$1,$2,$3,$4, ($3-$2)/$2*100, ($4-$3)/$3*100;

--dump growthchange;

avgGrowthChange = foreach growthchange generate $0,$1,$2,$3,$4,$5,$6, ROUND_TO(($5+$6)/2,2);

--dump avgGrowthChange;

Growth10percent = filter avgGrowthChange by ($7>=10.0);

--dump Growth10percent;

negativeGrowth5percent = filter avgGrowthChange by ($7<=-5.0);

--dump negativeGrowth5percent;

grandtotalsales = foreach retailcombine_net generate $0,$1, ($2+$3+$4);

--dump grandtotalsales;

top5order = order grandtotalsales by $2 desc;

--dump top5order;

finaltop5 = limit top5order 5;

--dump finaltop5;

bottom5order = order grandtotalsales by $2;

finalbottom5 = limit bottom5order 5;

dump finalbottom5;

