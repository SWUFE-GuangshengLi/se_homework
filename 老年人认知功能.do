cd"C:\Users\hp\Desktop\ST论文\CLHLS_相关数据\CLHLS_2018_cross_sectional_dataset_15874"
use "CLHLS 2018.dta",clear

// 因变量：认知功能
gen cog16 = c16
recode cog16 99 . = . 88 = 0
replace cog16 = 7 if cog16 > 7
tab cog16

gen cog11 = c11
recode cog11 9  = . 8 = 0

gen cog12 = c12
recode cog12 8 = 0

gen cog13 = c13
recode cog13 9  = . 8 = 0

gen cog14 = c14
recode cog14 8 = 0

gen cog15 = c15
recode cog15 8 = 0

gen cog21a = c21a
recode cog21a 9 = . 8 = 0

gen cog21b = c21b
recode cog21b 8 = 0

gen cog21c = c21c
recode cog21c 8 = 0

gen cog31a = c31a
recode cog31a 8 = 0

gen cog31b = c31b
recode cog31b 8 = 0

gen cog31c = c31c
recode cog31c 9  = . 8 = 0

gen cog31d = c31d
recode cog31d 8 = 0

gen cog31e = c31e
recode cog31e 9 . = . 8 = 0

gen cog32 = c32
recode cog32 8 = 0 9 = .

gen cog41a = c41a
recode cog41a 9  = . 8 = 0

gen cog41b = c41b
recode cog41b 8 = 0

gen cog41c = c41c
recode cog41c 8 = 0

gen cog51a = c51a
recode cog51a 9 = . 8 = 0

gen cog51b = c51b
recode cog51b 9  = . 8 = 0

gen cog52 = c52
recode cog52 8 = 0

gen cog53a = c53a
recode cog53a 8 = 0

gen cog53b = c53b
recode cog53b 8 = 0

gen cog53c = c53c
recode cog53c 9  = . 8 = 0


generate cognition = cog11 + cog12 + cog13 + cog14 + cog15 + cog16 + ///
cog21a + cog21b + cog21c + cog31a + cog31b + cog31c + cog31d + cog31e + ///
cog32 + cog41a + cog41b + cog41c + cog51a + cog51b + cog52 + cog53a + cog53b + cog53c
tab cognition

sum cognition if cognition > 24
sum cognition if cognition < 25

gen cognition_yanzhong =cognition 
recode cognition_yanzhong(10/30 =.) // 0-9分的人（重度认知障碍）

gen cognition_zhongdu =cognition 
recode cognition_zhongdu(0/9=. )(21/30 =.) // 10-20分的人（中度认知障碍）

gen cognition_qingdu = cognition
recode cognition_qingdu (0/9=.) (10/20= .) (25/30=.) // 21-24分的人（轻度认知障碍）


gen cognition_wu= cognition
recode cognition_wu (0/24=.) // 25分以上的人界定无认知障碍的人

gen cognition_you = cognition
recode cognition_you  (25/30=.) // 24分及以下的人界定为有认知障碍




 replace cognition = 0 if cognition >= 0 & cognition <= 9		//0-9分为重度，记为0，
 replace cognition = 1 if cognition >= 10 & cognition <= 20		//10-20分为中度，记为1
replace cognition = 2 if cognition >= 21 & cognition <= 24		//21-24分为轻度，记为2
 replace cognition = 3 if cognition >= 25 & cognition <= 30      //25-30为正常，记为





//自变量：社会经济地位（受教育程度、职业特征、家庭经济收入、是否享有离退休制度、主观自评经济状况）

// 1、受教育程度
gen education = f1
recode education 88 = 0 99 = .
replace education = . if education < 0 | education > 23
recode education 0 = 0 1/6 = 1 7/9=2 3/12=3 13/15=4 13/16=5  17/23=6  // 0表示
//0表示文盲 1表示小学 2表示初中 3表示高中 4表示 大学专科 5 表示大学本科 6表示研究生（硕士及以上） 
tab education
tabstat cognition, by(education) statistics(mean sd median min max)

//2、职业 
gen occupation = f2 //0专业技术人员/医生/教师 1. 行政管理2. 一般职员/服务人员/工人3. 自由职业者 4. 农民5. 家务劳动 6. 军人7. 无业人员 8.其他
recode occupation 0 1 6 = 2 2 = 1  3 4 5 7 8 = 0  // 0表示初级从业者，1表示普通从业者，2表示高级从业者
tabstat cognition, by(occupation) statistics(mean sd median min max)
tab occupation

// 3、经济收入
gen income = f35
recode income 88888 99999 = . 99998 = 100000

// replace incoming = r(p1) if incoming < r(p1)
replace income = r(p99) if income > r(p99)	//右侧截尾处理
//hist income,norm

gen log_income = log(income + 1) //加1后取自然对数，使得取对数之后的结果大于等于0，因为In0=0没有任何意义，In1=0
//sum log_income
//hist log_income,norm
tabstat cognition, by(income) statistics(mean sd median min max)
tabstat cognition, by(log_income) statistics(mean sd median min max)

*******4、自评经济状况*****
gen economystatus = f34
recode economystatus 8 9 = .  1 2 = 2 3 = 1 4 5 = 0 // 0表示困难 1表示一般 2表示富裕
tab economystatus
tabstat cognition, by(economystatus) statistics(mean sd median min max)

*****5、离退休制度****
gen se_retiremen = f21
recode se_retiremen 8 9 =. 1 2 = 1 3 = 0
// 0表示没有享受离退休制度 1表示享受

tab se_retiremen
tab f21


*********************************************
//控制变量 人口学特征：性别，年龄，婚姻，户口、ADL（日常生活能力限制）、自评健康、社会参与、抑郁、焦虑

****性别
gen gender = a1
recode gender 1= 1 2 = 0 // 1为男性，0为女性

gen gender_1 = gender
recode gender_1 0 = .

gen gender_0 = gender
recode gender_0 1 = .


****年龄
gen age = trueage
replace age =. if age < 60 // 只保留年龄在60岁以上的

gen age_0 = age 
recode age_0 (75/117=.) // 根据联合国卫生组织的划分，60-74是年轻老人

gen age_1 = age
recode age_1 (60/74 =.) (85/117 =.) // 75到84是老老人

gen age_2 = age
recode age_2 (60/84=.) // 85以上是高龄老人

tabstat cognition, by(age) statistics(mean sd median min max) // tabstat是生成表格统计，by后面的内容表示按照此内容分组
//tabstat命令可以用于描述性统计，但是它不能用于分类变量。对分类变量进行描述性统计，可以使用tabulate命令. tabulate主要用于制作一维和二维频数数表，而tabstat主要用于计算变量的统计量，如均值、标准差等。
 asdoc tabulate age if cognition <=24
 asdoc sum age if cognition <=24

asdoc tabulate age if cognition >=25
asdoc sum age if cognition >=25
//replace age = 0 if age >=60 & age<= 74	//60-74是年轻老人
//replace age = 1 if age >74 & age <=84	//75到84是老老人
//replace age = 2 if age >84 // 85岁以上是高龄老人

gen marrige = f41
recode marrige 8 9 = .
recode marrige 1 2 = 1 3 4 5 = 0  // 1表示已婚 0表示未婚(将离婚，丧偶和从未结过婚记作未婚）
sum marrige if cognition <10
tabstat cognition, by(marrige) statistics(mean sd median min max)

*********户口********
gen hukou1 = hukou 
recode hukou1 1=1 2=0 // 1表示城镇 0表示农村
// tabstat age, by(hukou1) statistics(mean sd median min max)

gen nongchun = hukou1
recode nongchun 1 = . 

gen chengzheng = hukou1
recode chengzheng 0 = .

***日常活动能力限制*****
gen activitylimit = e0
recode activitylimit  8 9 = .
 recode activitylimit 1 2 = 1 3 = 0 8 9 = . // 0是无限制，1是活动能力受到限制
tabstat cognition, by(activitylimit) statistics(mean sd median min max)

tab activitylimit

*****自评健康****
gen self_health = b12
recode self_health 8 9 =.  1 = 5 2 = 4  3=3 4 = 2 5 = 1
tab self_health
// 1是自评健康很不好，5是自评健康很好

tabstat cognition, by(self_health) statistics(mean sd median min max)

// 社会参与
gen social_interaction = d11h
recode social_interaction  8=. 

recode social_interaction 1 2 3 4 =1 5 = 0
// 0是不参与社会交往 1是参与社会交往

***1表示每天参与社会活动 2表示每周一次 3表示每月一次 4 有时（但不是每月一次） 5表示不参加社会参与****
tab social_interaction

******子女数量*****
gen nh = f10
recode nh 88 99 =. 13/22=.
tab nh
sum nh

******慢性病*****
*****1、高血压
gen gxy= g15a1
recode gxy 8 9 = . 2=0 1=1 // 1表示有高血压，0表示没有高血压
tab gxy

****2、糖尿病
gen tlb = g15b1
recode tlb 8 9 =. 2=0 1=1 // 1表示有，0表示没有
tab tlb

****3、心脏病
gen xzb = g15c1
recode xzb 8 9 =. 2=0 1=1

*****4、中风及脑血管疾病
gen zf =g15d1
recode zf 8 9 =. 2=0 1=1

*****5、肺气肿
gen fqz =g15e1
recode fqz  8 9 =. 2=0 1=1

****6、肺结核
gen fjh = g15f1
recode fjh 8 9 =. 2=0 1=1
***7、白内障
gen bnz = g15g1
recode bnz  8 9 =. 2=0 1=1

*****8、癌症
gen az = g15i1
recode az 8 9 =. 2=0 1=1
****9、帕金森
gen pjs = g15l1
recode pjs 8 9 =. 2=0 1=1
tab g15l1
****10、痴呆
gen zd = g15o1
recode zd 8 9 =. 2=0 1=1
*****11、癫痫
gen dx =g15p1 
recode dx 8 9 =. 2=0 1=1

**********慢性病***********
gen mxb = zf  +bnz + pjs  + zd
// gxy + tlb + xzb + zf + fqz + fjh + bnz +az+ pjs + zd +dx
gen chronic = mxb
recode chronic 0=0 1/4 =1 //0表示没有慢性病，1表示有慢性病
sum chronic
sum nh

tab mxb
tab chronic
sum chronic

// gxy tlb  xzb zf fqz fjh bnz az pjs zd dx
 
***********抑郁 （问卷采用CESD-10计分量表）*******
gen dep_b31 = b31
recode dep_b31 8 9 =. 4 5 = 0 1=3 2=2 3=1

gen dep_b32 = b32
recode dep_b32 8 9 =. 4 5 = 0 1=3 2=2 3=1

gen dep_b33 = b33
recode dep_b33 8 9 =. 4 5 = 0 1=3 2=2 3=1

gen dep_b34 = b34
recode dep_b34 8 9 =. 4 5 = 0 1=3 2=2 3=1

gen dep_b35 = b35
recode dep_b35 8 9 =. 4 5 = 0 1=3 2=2 3=1

gen dep_b36 = b36
recode dep_b36 8 9 =. 4 5 = 0 1=3 2=2 3=1

gen dep_b37 = b37
recode dep_b37 8 9 =. 4 5 = 0 1=3 2=2 3=1

gen dep_b38 = b38
recode dep_b38 8 9 =. 4 5 = 0 1=3 2=2 3=1

gen dep_b39 = b39
recode dep_b39 8 9 =. 4 5 = 0 1=3 2=2 3=1

gen dep_b310a = b310a
recode dep_b310a 8 9 =. 1 2 = 0 3=1 4=2 5=3

gen depressio = dep_b31 +dep_b32 +dep_b33 + dep_b34 + dep_b34 + dep_b35 + dep_b36 + dep_b37 +dep_b38 + dep_b39 + dep_b310a

gen depression = depressio
recode depression 31=.
tab depression // 总分为0-30分，得分越高表示抑郁症越严重，12分以下无抑郁症，12分及以上为有抑郁症

gen depression_0 = depression
recode depression_0 0/11=.   

//11分及以下的人计为无抑郁 12分及12分以上的人计为有抑郁症
tab depression_0 // 表示只计算有抑郁症的人


**********焦虑（clhls2018问卷采用广泛性焦虑量表——GAD——7量表）********
gen anxi_1 =b41
recode anxi_1 8 9 =. 

gen anxi_2 =b42
recode anxi_2 8 9 =.

gen anxi_3 =b43
recode anxi_3 8 9 =. 

gen anxi_4 =b44
recode anxi_4 8 9 =. 

gen anxi_5 =b45
recode anxi_5 8 9 =. 

gen anxi_6 =b46
recode anxi_6 8 9 =. 

gen anxi_7 =b47
recode anxi_7 8 9 =. 

gen anxiety = anxi_1 + anxi_2 +anxi_3 +anxi_4 +anxi_5 +anxi_6 +anxi_7
tab anxiety // 小于5分是表示没有焦虑，5-9分为轻度焦虑，10-14分为中度焦虑，15分以上有重度焦虑
sum anxiety
gen anxiety_0 = anxiety
recode anxiety_0 0/4 = . // 5分及以上，即为有焦虑

*****是否跌倒*****
gen diedao = g4c1
recode diedao 8 9 =. 2=0 1=1
tab diedao

******锻炼****
gen exercise = d92
recode exercise 1=1 2=0 8 9=. // 1表示经常锻炼，0表示不进行锻炼

*******吸烟*****
gen smoking = d72
recode smoking 1=1 2=0 8 9=. // 1是吸烟，0不吸烟

*****喝酒*****
gen drinking = d82
recode drinking 1=1 2=0  8 9=. // 1 是喝酒 ，0是不喝酒
**************中介变量*********

**********门诊费用
gen outpatient_costs = f651a1
recode outpatient_costs  88888 99999 = . 99998 =100000
// tab outpatient_costs 
sum outpatient_costs

******住院费用
gen inpatient_costs = f651b2
recode inpatient_costs 88888 99999 = . 99998 = 100000
tab inpatient_costs
sum inpatient_costs if cognition <10
sum inpatient_costs if cognition >24
tabstat cognition, by(inpatient_costs) statistics(mean sd median min max)

******总的医疗费用********
generate total_cost = inpatient_costs + outpatient_costs 
tab total_cost
tabstat cognition, by(total_cost) statistics(mean sd median min max)
sum total_cost if cognition <10
sum total_cost if cognition >24
sum total_cost if cognition <25

replace total_cost = r(p99) if income > r(p99)
gen log_total_cost = log(total_cost + 1) 

tabstat cognition, by(log_total_cost) statistics(mean sd median min max)
sum log_total_cost

***医疗费用支付方式
gen pay_methods = f652
recode pay_methods  7 9 =.  1 2 3 = 1  4 5 6 8 = 0
// 1表示由医疗保险支付 0表示私人支付及其他
// 1. 城镇职工/居民医疗保险2. 新型农村合作医疗保险3. 商业医疗保险 4.自己5. 配偶 6.子女/孙子女 7.没钱付医药费 8. 其他
tab pay_methods
**社会保障和商业保险*****
gen secur_insur = nf64a
recode secur_insur 0=1 1=0 // 1表示有商业保险和社会保障 0表示没有
tab secur_insur
tabstat cognition, by(secur_insur) statistics(mean sd median min max)

*****养老保险******
gen p_insur = f24
recode p_insur 8 9 = . 1=1 2=0 // 1是有养老保险 0是没有养老保险
tabstat cognition, by(p_insur) statistics(mean sd median min max)

****每月养老金收入********
gen monthly_pension = f221
recode monthly_pension (88888 99999 =.) //

************处理部分********

*******KMO系数检验******
factortest education occupation income se_retiremen economystatus
 // bartlett球形检验命令和kmo系数都出来，第一种方法

factor education occupation income se_retiremen economystatus
// greigen, yline(1)
  estat kmo // 只进行kmo命令检验 第二种方法

*******主成分分析*********
pca education occupation income se_retiremen economystatus
factor education occupation income se_retiremen economystatus,mineigen(0.6) pcf
rotate,promax(5) factors(3)
predict factor_1 factor_2 factor_3
gen Socioeconomic_status =(factor_1*0.5406+factor_2*0.1869+ factor_3*0.1269 )/0.8544
summarize Socioeconomic_status

exit

global y "cognition"
global x " education occupation log_income se_retiremen economystatus "
global c"gender age marrige hukou1 activitylimit self_health chronic nh social_interaction  "

exit 

reg cognition Socioeconomic_status $c

******变量的描述性统计分析******
asdoc sum cognition education occupation income se_retiremen economystatus gender age marrige hukou1 activitylimit self_health pay_methods social_interaction depression anxiety

*******相关性分析******
asdoc  pwcorr_a  Socioeconomic_status  pay_methods cognition
asdoc sum Socioeconomic_status

 *********不用PCA方法合成的多元回归******
reg cognition_yanzhong  $x $c,cluster( prov ) r  // 0-9分
est store table1
reg cognition_zhongdu  $x $c,cluster( prov ) r // 10-20分
est store table2
reg cognition_qingdu $x $c,cluster( prov ) r // 21-24分
est store table3
reg cognition_wu $x $c,cluster( prov ) r // 25分以上
est store table4
reg cognition $x $c,cluster( prov ) r // 全样本
est store table5
outreg2 [table*] using 多元回归2.doc,alpha(0.05,0.01,0.001) adjr2


**********用PCA方法合成的回归****
reg cognition_yanzhong  Socioeconomic_status $c,cluster( prov ) r // 0-9分
est store table1
reg cognition_zhongdu  Socioeconomic_status $c,cluster( prov ) r // 10-20分
est store table2
reg cognition_qingdu Socioeconomic_status $c,cluster( prov ) r // 21-24分
est store table3
reg cognition_wu Socioeconomic_status $c,cluster( prov ) r // 25分以上
est store table4
reg i.cognition Socioeconomic_status $c,cluster( prov ) r // 全样本
est store table5
outreg2 [table*] using 主成分分析回归.doc,alpha(0.001,0.01,0.05) adjr2 

//outreg2只能输出R方或者调整R方，不能同时输出两个，如果需要同时输出，只能用esttab命令)




*********对比*******
xi: reg cognition i.ses i.ses#cognition








*********异质性分析********
***1、男女*****
reg cognition Socioeconomic_status age marrige hukou1 activitylimit self_health chronic nh social_interaction  if gender == 1 // 男性 if后面的等于符号一般用== ，变成逻辑关系
est store table1
reg cognition Socioeconomic_status age marrige hukou1 activitylimit self_health  chronic nh  social_interaction if gender == 0 // 女性
est store table2
 // outreg2 [table1 table2] using 男女异质性.doc,alpha( 0.001,0.01,0.05) adjr2

******2、年龄****
reg cognition Socioeconomic_status gender marrige hukou1 activitylimit self_health chronic nh social_interaction  if age<80 // 男 性 if后面的等于符号一般用== ，变成逻辑关系
est store table3
reg cognition Socioeconomic_status gender marrige hukou1 activitylimit self_health chronic nh social_interaction  if age >=80 
est store table4
 // outreg2 [table3 table4] using 年龄异质性.doc,alpha( 0.001,0.01,0.05) adjr2

********3、城镇******
reg cognition Socioeconomic_status gender age marrige activitylimit self_health chronic nh social_interaction  if hukou1 ==1 // 城市
est store table5
reg cognition Socioeconomic_status gender age marrige activitylimit self_health chronic nh social_interaction  if hukou1 ==0 // 农村
est store table6
outreg2 [table*] using 异质性分析.doc,bdec(3) tdec(2) alpha( 0.001,0.01,0.05) adjr2

// esttab table1 table2 table3 table4 table5 using 主成分回归.doc, stats(N r2 r2_a) star(* 0.05 ** 0.01 *** 0.001)

//outreg2 [table*] using 4.doc,alpha(0.05,0.01,0.001) r2 adjr2 // alpha跟在outreg2后面 
// outreg2 using xxx.doc,replace tstat bdec(3) tdec(2) ctitle(y) keep(invest mvalue kstock) addtext(Company FE, YES )
//esttab table1 table2 table3 table4 table5 using 多元回归.doc,b(%12.3f) se(%12.3f) nogap compress stats(N r2 r2_a) star(* 0.05 ** 0.01 *** 0.001) //star命令只能跟在esttab后面，跟在outreg则不行，b(%12.3f)表示将系数输出为12.3f格式，se(%12.3f)表示将标准误输出为12.3f格式，nogap表示在表格中不使用空格，compress表示压缩表格以适应页面，stats(N r2 r2_a)表示在表格中包括样本量、R方和调整后的R方，star(* 0.05 ** 0.01 *** 0.001)表示使用星号表示显著性水平，并将显著性水平设置为0.05、0.01和0.001。
//F值是检验是否存在显著的线性关系，R方是检验回归模型拟合的优劣



****画图****
****柱状图****
graph bar cognition_you, over(age) ytitle(cognition_you) // x轴标签最小值10，每10作为1刻度，最大值117，去除网格线//xtitle(age) yrange(0 30) xsize(5) ysize(5) legend(off) // over选项指代分组选项。ytitle和xtitle分别指代y轴和x轴的标签。yrange指定y轴的范围。xsize和ysize分别指代图像的宽度和高度。legend(off)表示不显示图例



xtile age_group = age if age >= 60 & age <= 117, nq(5)
replace age_group = 1 if age_group == 2
replace age_group = 2 if age_group == 3
replace age_group = 3 if age_group == 4
replace age_group = 4 if age_group == 5
replace age_group = 5 if age_group == 6
label define age_group_lbl 1 "60-70岁" 2 "70-80岁" 3 "80-90岁" 4 "90-100岁" 5 "100-117岁"
label values age_group age_group_lbl

graph bar cognition_you, over(age_group) scheme(s1mono) title("认知障碍年龄段分布")bar(1, color("61 131 97") lcolor(black)) blabel(bar, format(%3.0f)) 
//xlabel(60(20)117, nogrid) 
graph bar cognition_you, over(age) ytitle(cognition_you)

graph bar cognition if age_group == 1 | age_group == 2 | age_group == 3 | age_group == 4 | age_group == 5, over(age_group) ytitle("认知功能得分")  xsize(5) ysize(6) ytick(0 30) ylabel(0 "0" 5 "5" 10 "10" 15 "15" 20 "20" 25 "25" 30 "30")
//plotregion(margin(large)  xscale(0.8))

**********稳健性检验*****
// 换模型
ologit cognition Socioeconomic_status $c
outreg2 using 1.doc
exit


********多重共线性检验****
estat vif// 在回归结果后面加，即可显示Vif，表示方差膨胀因子，方差膨胀因子小于10，即不存在多重共线性的问题)


exit
*******中介效应(医保）的实证分析******
*****三步分析法******
reg cognition Socioeconomic_status $c // x对y的直接效应 这一步是c，表示x对y的总效应
est store a1
reg  pay_methods Socioeconomic_status $c // x对m a
est store a2
reg cognition pay_methods $c // m对y b ab的乘积是间接效应，也就是中介效应
est store a3
reg cognition pay_methods Socioeconomic_status  $c  // x通过m 对y c'是直接效应
 est store a4
esttab  a1 a2 a3 a4 using 医保.rtf ,replace

**********bootstrap检验******
bootstrap r(ind_eff) r(dir_eff), reps(1000): sgmediation cognition, mv(pay_methods) iv(Socioeconomic_status) cv( $c ) 

//corr cognition Socioeconomic_status pay_methods
//esttab using 8.doc






*****中介效应(社会参与）的实证分析******
reg cognition Socioeconomic_status $c // x对y的直接效应 这一步是c，表示x对y的总效应
est store a1
reg  social_interaction Socioeconomic_status $c // x对m a
est store a2
reg cognition social_interaction $c // m对y b ab的乘积是间接效应，也就是中介效应
est store a3
reg cognition social_interaction Socioeconomic_status  $c  // x通过m 对y c'是直接效应
 est store a4
esttab  a1 a2 a3 a4 using 社会参与中介检验2.rtf ,replace

**********bootstrap检验******
bootstrap r(ind_eff) r(dir_eff), reps(100): sgmediation cognition, mv(social_interaction) iv(Socioeconomic_status) cv( $c ) 



**********bootstrap检验******
 bootstrap r(ind_eff) r(dir_eff), reps(100): sgmediation cognition, mv(social_interaction) iv(Socioeconomic_status) cv( $c ) 	// bootstrap检验

asdoc sgmediation cognition, mv(total_cost) iv(Socioeconomic_status) cv( $c ) // sobel 检验










exit
*****回归结果输出*****
//esttab m1 m2 m3 m4 m5 m6 using resu.rtf 
// outreg2 [m1 m2 m3 m4 m5 m6] using 3.rtf
exit










//


 
 



// ssc install factortest, replace // 安装命令
// outreg2  using result.doc, replace ctitle(y) bdec(3) tdec(3) 结果输出

/// outreg2 (table*) using result.doc, replace 
// replace 是替换的意思 append 是不替换增加的意思





**********中介变量——生活方式：体育锻炼 吸烟喝酒、是否吃蔬菜和水果 ************
gen exercise = d92
recode exercise 1=1 2=0 8 9=. // 1表示经常锻炼，0表示不进行锻炼
gen smoking = d72
recode smoking 1=1 2=0 8 9=. // 1是吸烟，0不吸烟

gen drinking = d82
recode drinking 1=1 2=0  8 9=. // 1 是喝酒 ，0是不喝酒

gen fruit = d31
recode fruit 8 9 = . 
recode fruit 1 2 = 1 3 4 = 0 // 1是经常吃，0是很少吃或者不吃

gen vgetable = d32
recode vgetable 8 9 =. 
recode vgetable 1 2 =1  3 4 = 0 
// 1是经常吃，0是很少吃或者不吃



***************************************************其他相关
gen prompt_treatment = f61
recode prompt_treatment 8 9 = . 1=1 2=0  // 1表示生重病时可以得到及时的治疗，0表示生重病时不能得到及时的治疗
gen living_arrangement = a51
recode living_arrangement 9=. // 1是和家人同住 2是独自居住 3是住养老院





exit
// 标准化处理PCA
egen education_mean = mean(education)
egen education_sd = sd(education)
gen education_std = (education - education_mean) / education_sd

egen occupation_mean = mean(occupation)
egen occupation_sd = sd(occupation)
gen occupation_std = (occupation - occupation_mean) / occupation_sd


egen log_income_mean = mean(log_income)
egen log_income_sd = sd(log_income)
gen log_income_std = (log_income - log_income_mean) / log_income_sd

factortest education occupation log_income_std  

pca education_std occupation_std log_income_std
factor education_std occupation_std log_income_std, mineigen(1) pcf
rotate,promax(3) factors(1)
predict factor_1 
gen Socioeconomic_status =(0.5603*factor_1)/0.5603
sum Socioeconomic_status
exit