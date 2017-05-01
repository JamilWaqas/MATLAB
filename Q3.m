

y=[0	0	0	0	1	0	0	1	0	2	3	4	0	0	0	2	4	1	3	1	1	4	1	1	1	0	2	2	3	4	0	0	1	0	4];
m=[4	3	5	7	7	5	5	6	5	6	7	7	5	6	10	12	12	14	11	10	4	6	3	4	6	3	7	5	8	9	7	5	6	3	9];
x1=[12	15	17	25	35	23	25	41	13	29	43	45	23	19	14	15	23	19	23	17	27	42	41	39	19	16	42	32	18	28	23	15	24	27	34];
%breed=[	A	A	A	A	A	A	A	A	A	A	A	A	B	B	B	B	B	B	B	B	B	B	C	C	C	C	C	C	C	C	C	C	C	C	C]
x21=[1	1	1	1	1	1	1	1	1	1	1	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0];
x22=[0	0	0	0	0	0	0	0	0	0	0	0	1	1	1	1	1	1	1	1	1	1	0	0	0	0	0	0	0	0	0	0	0	0	0];


display('Constant model')
[b,dev,stats]=glmfit(ones(1,35),[y' m'],'binomial','constant','off');
parsse=[stats.beta stats.se]
tstat=[stats.t stats.p]
devDF=[dev stats.dfe]

display('1 covariate x1')
[b,dev,stats] = glmfit(x1',[y' m'],'binomial');
parsse=[stats.beta stats.se]
tstat=[stats.t stats.p]
devDF=[dev stats.dfe]

display('1 covariate x21')
[b,dev,stats] = glmfit(x21',[y' m'],'binomial');
parsse=[stats.beta stats.se]
tstat=[stats.t stats.p]
devDF=[dev stats.dfe]

display('1 covariate x22')
[b,dev,stats] = glmfit(x22',[y' m'],'binomial');
parsse=[stats.beta stats.se]
tstat=[stats.t stats.p]
devDF=[dev stats.dfe]

display('2 covariate x1 x21')
[b,dev,stats] = glmfit([x1' x21'],[y' m'],'binomial');
parsse=[stats.beta stats.se]
tstat=[stats.t stats.p]
devDF=[dev stats.dfe]


display('2 covariate x1 x22')
[b,dev,stats] = glmfit([x1' x22'],[y' m'],'binomial');
parsse=[stats.beta stats.se]
tstat=[stats.t stats.p]
devDF=[dev stats.dfe]

display('2 covariate x21 x22')
[b,dev,stats] = glmfit([x21' x22'],[y' m'],'binomial');
parsse=[stats.beta stats.se]
tstat=[stats.t stats.p]
devDF=[dev stats.dfe]


display('3 covariates x1+x21+x22')
[b,dev,stats] = glmfit([x1' x21' x22'],[y' m'],'binomial');
parsse=[stats.beta stats.se]
tstat=[stats.t stats.p]
devDF=[dev stats.dfe]
