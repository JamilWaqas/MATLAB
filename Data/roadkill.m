data=[
22	250.214	0.583	2
14	741.179	1.419	2
65	1240.08	2.005	2
55	1739.885	1.924	1
88	2232.13	2.167	2
104	2724.089	2.391	2
49	3215.511	1.165	1
66	3709.401	2.428	0
26	4206.477	2.416	1
47	4704.176	0.211	1
35	5202.328	0.292	1
55	5700.669	0.65	1
44	6199.342	1.896	0
30	6698.151	2.194	0
33	7187.762	1.375	1
29	7668.833	0	1
34	8152.155	1.655	2
64	8633.224	1.702	2
76	9101.411	2.721	1
32	9573.578	1.694	0
34	10047.63	1.192	0
32	10523.939	0.589	1
35	11002.496	0.476	0
22	11482.896	0.345	0
34	11976.232	1.621	0
25	12470.968	1.023	0
18	12968.285	0.357	1
14	13465.914	0	0
14	13961.321	0	0
7	14432.954	0.007	0
7	14904.995	0.878	1
17	15377.983	0.883	0
10	15854.389	1.921	1
3	16335.936	1.479	0
6	16810.109	1.237	0
5	17235.045	1.898	0
2	17673.064	3.951	0
3	18167.269	1.931	1
2	18656.949	1.365	0
2	19149.507	0.591	1
7	19645.717	0.868	0
3	20141.987	1.198	0
5	20640.729	2.334	1
4	21138.903	3.525	1
7	21631.542	3.087	2
12	22119.102	2.444	2
7	22613.647	3.087	2
14	23113.45	3.934	0
10	23606.088	2.214	0
4	24046.886	2.122	2
11	24444.874	1.29	2
3	24884.803	2.471	2
];
y=data(:,1); % number of road kills
n=length(y); % size of data
x1=data(:,2)/1000; %distance to natural park in km (in m above)
x2=data(:,3); % distance to water
% data(:,4) is a factor measuing how urban an area is
% 0 = not urban, 1 = some urban, 2 = mostly urban
u1=data(:,4)==1; % variable 1 if some urban, 0 otherwise
u2=data(:,4)==2; % variable 2 if mostly urban, 0 otherwise


display('Constant model')
[b,dev,stats] = glmfit(ones(n,1),y,'poisson','constant','off');
parsse=[stats.beta stats.se]
tstat=[stats.t stats.p]
devDF=[dev stats.dfe]

display('1 covariate x1')
[b,dev,stats] = glmfit(x1,y,'poisson');
parsse=[stats.beta stats.se]
tstat=[stats.t stats.p]
devDF=[dev stats.dfe]

display('1 covariate x2')
[b,dev,stats] = glmfit(x2,y,'poisson');
parsse=[stats.beta stats.se]
tstat=[stats.t stats.p]
devDF=[dev stats.dfe]

display('1 covariate u')
[b,dev,stats] = glmfit([u1 u2],y,'poisson');
parsse=[stats.beta stats.se]
tstat=[stats.t stats.p]
devDF=[dev stats.dfe]

display('2 covariates x1+x2')
[b,dev,stats] = glmfit([x1 x2],y,'poisson');
parsse=[stats.beta stats.se]
tstat=[stats.t stats.p]
devDF=[dev stats.dfe]

display('2 covariates x1+u')
[b,dev,stats] = glmfit([x1 u1 u2],y,'poisson');
parsse=[stats.beta stats.se]
tstat=[stats.t stats.p]
devDF=[dev stats.dfe]

display('2 covariates x2+u')
[b,dev,stats] = glmfit([x2 u1 u2],y,'poisson');
parsse=[stats.beta stats.se]
tstat=[stats.t stats.p]
devDF=[dev stats.dfe]

display('3 covariates x1+x2+u')
[b,dev,stats] = glmfit([x1 x2 u1 u2],y,'poisson');
parsse=[stats.beta stats.se]
tstat=[stats.t stats.p]
devDF=[dev stats.dfe]
