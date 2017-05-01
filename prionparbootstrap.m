%
% Parametric Bootstrap for prion example
%

global data

data1=[66
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

%data_or=[496 733 489 497 221 406 531 269 533 287 521 517 596 741 549 730 606 862 929 419 338 622 528 520 589 524 589 708];
data=data1;
pars=fminsearch('gammalike1',[65 10]);
n0=pars(1);
k=pars(2);
p=k/(n0+k);

nb=1000;
n=length(data1);

for i=1:nb
    data= gamrnd(k,p,1,n);
    pars=fminsearch('gammalike1',[65 1.5]);
    x1(i)=pars(1);
    x2(i)=pars(2);
       
end

parbootstrapmean_n0=mean(x1)
parbootstrapSE_n0=std(x1)
parbootstrapmean_k=mean(x2)
parbootstrapSE_k=std(x2)

colormap([1 1 1])
subplot(1,2,1); hist(x1); xlabel('n_0'); ylabel('freq')
subplot(1,2,2); hist(x2); xlabel('k'); ylabel('freq')

