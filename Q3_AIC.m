y=[0	0	0	0	1	0	0	1	0	2	3	4	0	0	0	2	4	1	3	1	1	4	1	1	1	0	2	2	3	4	0	0	1	0	4];
m=[4	3	5	7	7	5	5	6	5	6	7	7	5	6	10	12	12	14	11	10	4	6	3	4	6	3	7	5	8	9	7	5	6	3	9];
x1=[12	15	17	25	35	23	25	41	13	29	43	45	23	19	14	15	23	19	23	17	27	42	41	39	19	16	42	32	18	28	23	15	24	27	34];
%breed=[	A	A	A	A	A	A	A	A	A	A	A	A	B	B	B	B	B	B	B	B	B	B	C	C	C	C	C	C	C	C	C	C	C	C	C]
x21=[1	1	1	1	1	1	1	1	1	1	1	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0];
x22=[0	0	0	0	0	0	0	0	0	0	0	0	1	1	1	1	1	1	1	1	1	1	0	0	0	0	0	0	0	0	0	0	0	0	0];


display('Constant model')
[betas dev stats]= glmfit(ones(1,35),[y' m'],'binomial', 'link', 'logit');
[b,dev,stats]=glmfit(ones(1,35),[y' m'],'binomial','constant','off');
parsse=[stats.beta stats.se]
tstat=[stats.t stats.p]
devDF=[dev stats.dfe]
fitted = glmval(betas,ones(1,35),'logit');
LL=sum(log( binopdf( y', m',fitted)));
AIC = -2*LL + 2*numel(betas)

display('1 covariate x1')
[b,dev,stats] = glmfit(x1',[y' m'],'binomial','link','logit');
parsse=[stats.beta stats.se]
tstat=[stats.t stats.p]
devDF=[dev stats.dfe]
[yfit,ylo,yhi] = glmval(b,x1,'logit',stats);
LL=sum(log( binopdf( y', m',yfit')));
AIC = -2*LL + 2*numel(b)

display('2 covariate x21 x22')
[b,dev,stats] = glmfit([x21' x22'],[y' m'],'binomial','link','logit');
parsse=[stats.beta stats.se]
tstat=[stats.t stats.p]
devDF=[dev stats.dfe]
fitted = glmval(betas,[x21 x22] ,'logit');
LL=sum(log( binopdf( y', m',fitted)));
AIC = -2*LL + 2*numel(betas)

display('3 covariates x1+x21+x22')
[b,dev,stats] = glmfit([x1' x21' x22'],[y' m'],'binomial','link','logit');
parsse=[stats.beta stats.se]
tstat=[stats.t stats.p]
devDF=[dev stats.dfe]
fitted = glmval(betas,[x1 x21 x22],'logit');
LL=sum(log( binopdf( y', m',fitted)));
AIC = -2*LL + 2*numel(betas)