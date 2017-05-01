global data
data=[66
84
72
96
81
66
78
90
78
84
56
62
66
68
68
86
56
70
78
92
74
70
52
64
64
74
72
68
48
56
68
64
82
72
64
82
74
62
74
70
82
62
72
74
64
58
70
74
52
80
70
76
68
110
66
80
72
74
70
68
116
56
92
56
64
74
76
68
72
64
76
66
80
62
76
70
68
68
64
54
58
76
70
64
74
62
88
64
72
62
76
64
66
54
60
72
54
72
68
66
64
60
58
60
66
76
62
72
78
62
58
72
64
56
70
52
68
68
86
68
70
94
82
74
84
70
52
76
58
66
66
62
60
68
74
48
64
70
72];

% Finding maximum likelihood estimates and standard error using similar
% code to fmax.m
[pars l]=fminsearch('gammalike1',[70 2]);
h=hessian('gammalike1',pars);
cov=inv(h);
se=sqrt(diag(cov));



% Setting up the grid of values and finding the maximum likelihood
% estimates
[mu,beta]=meshgrid(65:0.1:90, 0.5:0.1:3);
nn=size(mu);
lik=zeros(nn);
for i=1:nn(1)
    for j=1:nn(2)
        lik(i,j)=gammalike1([mu(i,j) beta(i,j)]);
    end
end

%A contour plot at spefied values only, which are 50%, 95% and 100% CIs
contour(mu,beta,lik,[l+0.5*1.386 l+0.5*5.991 l+0.5*9.210])
axis([65 90 0.5 3])
hold on

%Marks MLE with x
plot(pars(1),pars(2),'x')

%Changes colour of contours
colormap(jet)

%labels axis
xlabel('\mu')
ylabel('\beta')

data=[
78
69
63
90
72
84
90
66
66
87
90
78
81
69
72
69
87
99
98
93
78
78
66
90
81
93
78
69
63
90
72
84
90
66
66
87
90
78
81
69
72
69
87
99
98
93
78
78
66
90
81
93
78
69
63
90
72
84
90
66
66
87
90
78
81
69
72
69
87
99
98
93
78
78
66
90
81
93
];

% Finding maximum likelihood estimates and standard error using similar
% code to fmax.m
[pars l]=fminsearch('gammalike1',[70 2]);
h=hessian('gammalike1',pars);
cov=inv(h);
se=sqrt(diag(cov));



% Setting up the grid of values and finding the maximum likelihood
% estimates
[mu,beta]=meshgrid(65:0.1:90, 0.5:0.1:3);
nn=size(mu);
lik=zeros(nn);
for i=1:nn(1)
    for j=1:nn(2)
        lik(i,j)=gammalike1([mu(i,j) beta(i,j)]);
    end
end

%A contour plot at spefied values only, which are 50%, 95% and 100% CIs
contour(mu,beta,lik,[l+0.5*1.386 l+0.5*5.991 l+0.5*9.210])

%Marks MLE with x
plot(pars(1),pars(2),'x')

%labels axis
xlabel('\mu')
ylabel('\beta')

