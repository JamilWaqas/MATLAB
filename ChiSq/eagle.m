% Copyright (C) 1995,1996 by E.A. Catchpole
 % All rights reserved.
 %
 % This software may be freely copied, modified and redistributed without
 % fee for non-commerical purposes provided that this copyright notice is
 % preserved intact on all copies and modified copies.
 % 
 % There is no warranty or other guarantee of fitness of this software.
 % It is provided solely "as is". The author disclaims all
 % responsibility and liability with respect to this software's usage
 % or its effect upon hardware or computer systems.
 
% required files:
% calcsv.m
% chisq.m
% cnvrtnm.m
% grad.m
% ilt.m
% infoT.m
% inputmn.m
% lfact.m
% likT.m
% lt.m
% mexpT.m
% pchisq.m
% preproc.m
% probT.m
% prtupsgn.m
% prtupmat.m
% scoreJT.m
% stretch.m

global Ringed Mobs unrec nrows ncols const Toe ellmax sopts uopts;

% more on
matlab_varlength = 19;   % the maximum length of a variable name in Matlab
maxerr = 0.001;

fprintf('          -----------------------------------------------------------\n')
fprintf('         | Eagle version 1.1 . . . by Ted Catchpole . . . 2001/11/21 |\n')
fprintf('         |                                                           |\n')
fprintf('         |    A program for model selection for ring-recovery data   |\n')
fprintf('         |                                                           |\n')
fprintf('         |    Bug reports, praise, offers of large grants etc, to    |\n')
fprintf('         |                  E.Catchpole@adfa.edu.au                  |\n')
fprintf('          ----------------------------------------------------------- \n\n')

% Introduction
% ^^^^^^^^^^^^
newsession = input('Is this a new session (1), or a continuation session (2)? [1] : ','s');
if ( isempty(newsession) | newsession ~= '2' ),
  newsession = 1;
  fprintf('\n\n')
  fprintf('=================================================================\n')
  fprintf('The data should be stored in a matlab file in the form of a vector\n')
  fprintf('"Ringed" of ringing numbers and a matrix "Mobs" of recovery numbers. \n')
  fprintf('For example the matlab file heron.m might contain the lines\n\n')
  fprintf('Ringed = [1000;1000;1000;1000];\n\n')
  fprintf('Mobs = [35  7  0   1\n')
  fprintf('         0 23 11   3\n')
  fprintf('         0  0 45  13\n')
  fprintf('         0  0  0  33 ];\n')
  fprintf('=================================================================\n\n')

  fprintf('First enter the full path name of the default directory,\n')
  fprintf('in which I will look for the data and store your results.\n')
  fprintf('If you just press <RETURN> you will get the default shown.\n')
  default_dir_exists = 0;
  while ~default_dir_exists,
    a = input(['path name : [',getenv('HOME'),']  '],'s');
    if isempty(a),
      defaultdir = getenv('HOME');
    elseif a(1)=='~',
      defaultdir = [getenv('HOME'), a(2:length(a))];
    else defaultdir = a;
    end
    if exist(defaultdir) ~= 7,
      fprintf('\nThat is not a valid directory name. Please try again.\n');
    else
      default_dir_exists = 1;
    end
  end

%   eagledir = '/usr/work/pgstat/ecol/Eagle';
%   path(path,eagledir)
%   path(path,defaultdir)
%   cd(defaultdir)
%   fprintf('\n')
  
  % Read the data
  % ^^^^^^^^^^^^^
  data_file_exists = 0;
  while  data_file_exists ~= 2,
    fprintf('Enter just the name of the data file, if it is in the default\n')
    fprintf('directory, otherwise give the full path name\n')
    a = input('Name of data file : ','s');
    if a(1)=='~',
      a = [getenv('HOME'), a(2:length(a))];
    end
    if strcmp(a(length(a)-1:length(a)),'.m'),
      a = a(1:length(a)-2);
    end
    datafilefullname = a;
    data_file_exists = exist([datafilefullname,'.m']);
  
    if data_file_exists ~= 2,
      fprintf(['I could not find file ',datafilefullname,'.m, please try again']);
    end
  end;  % while data_file_exists
  fprintf('\n')
  
  b = findstr(a,'/');
  if ~isempty(b),
    datafiledir = a(1:max(b)-1);
    datafilename = a(max(b)+1:length(a));
    cd(datafiledir)
  else
    datafiledir = defaultdir;
    datafilename = a;
  end
  eval(datafilename);
  cd(defaultdir)

  diarydefaultname = [defaultdir,'/',datafilename,'.res'];
  preproc;
  fprintf('\n')

else % if newsession=='2'

% Load the old results
% ^^^^^^^^^^^^^^^^^^^^
  load_file_exists = 0;
  while  load_file_exists ~= 2,
    fprintf('Enter just the (.mat) name of the file of stored results, if it is\n')
    fprintf('in the default directory, otherwise give the full path name\n')
    a = input(['".mat" file name = : '],'s');
    if a(1)=='~',
      a = [getenv('HOME'), a(2:length(a))];
    end
    if strcmp(a(length(a)-3:length(a)),'.mat'),
      a = a(1:length(a)-4);
    end
    loadfilename = a;
    load_file_exists = exist([loadfilename,'.mat']);
    if load_file_exists ~= 2,
      fprintf(['\nI could not find file ',loadfilename,'.mat, please try again\n']);
    end
  end;  % while load_file_exists
  fprintf('\n')

  eval(['load ',loadfilename])
  fprintf(['Previous results and data from ',loadfilename,'.mat now loaded\n'])

  diarydefaultname = [defaultdir,'/',loadfilename,'.res'];

end  % if newsession

fprintf('Enter the name of the (.res) file to store session transcript.\n')
fprintf('If it is in the default directory, just give the name, otherwise\n')
fprintf('give the full path name. For the default name, just hit <RETURN>.\n')
% fprintf(['The default name is ' diarydefaultname, '\n'])
a = input('Name of ".res" file : ','s');
if isempty(a),
  diaryname = diarydefaultname;
else
  if a(1)=='~',
    a = [getenv('HOME'), a(2:length(a))];
  end
  if strcmp(a(length(a)-3:length(a)),'.res'),
    a = a(1:length(a)-4);
  end
  diaryname = [a, '.res'];
end
diary(diaryname);
diarybox = '--';
for i = 1:length(diaryname),
  diarybox = ['-',diarybox];
end
fprintf([' ',diarybox,'\n'])
fprintf(['| ',diaryname,' |\n'])
fprintf([' ',diarybox,'\n\n'])

if newsession==1,
  fprintf('\nModel names use the Catchpole-Freeman-Morgan notation x/y/z\n')
  fprintf('where x = C      if first-year survival probabilities are constant\n')
  fprintf('          T      if they vary with time (year of ringing)\n')
  fprintf('          V(...) if they depend on one or more time-dependent covariates\n\n')
  fprintf('      y = C      if adult survival probabilities are constant\n')
  fprintf('          A      if they are fully age dependent\n')
  fprintf('          An     if they vary with age up to age n\n')
  fprintf('          T      if they vary with time (year of recovery)\n')
  fprintf('          V(...) if they depend on one or more time-dependent covariates\n\n')
  fprintf('      z = C      if recovery probabilities are constant\n')
  fprintf('          T      if they vary with time (year of recovery)\n')
  fprintf('          V(...) if they depend on one or more time-dependent covariates\n\n')
  fprintf('The covariate names should be specified inside the parentheses,\nseparated by commas.\n')
  fprintf('For example, if the 1st-year survival probabilities depend on covariates\n')
  fprintf('"January" and "February", the adult survival probabilities vary with age\n')
  fprintf('up to age 3 (i.e. have the same value in the 4th, 5th,... years of life),\n')
  fprintf('and the recovery probability is constant,\n')
  fprintf('then the model should be specified as V(January,February)/A3/C\n\n')
  fprintf('Do not use covariate name that include spaces.\n\n')
  fprintf('Press any key when ready . . .\n')
  pause
end

% sopts=optimset('GradObj','off','HessUpdate','dfp','MaxIter',100000000,'LargeScale','off',...
%          'TolFun',.000000001,'TolX',.000000001, 'DerivativeCheck','on','MaxFunEvals',500000000);         

uopts=optimset('Largescale','off','TolFun',.00001);         

while 1,
    fprintf('--------------------------------------------------------------------\n')
    fprintf('\nDo you want to (1) fit a model\n')
    fprintf('               (2) perform a score test comparison of two models\n')
    fprintf('or             (0) quit from this program ?\n\n')
    dofit = input('Please type 0 or 1 or 2 : ');
    
    if dofit == 0,
      diary off;
      a = input('Do you want to store the results of this session in a ".mat" file? [Y] : ','s');
      if isempty(a),
        b = 1;
      elseif a(1)=='y' | a(1)=='Y',
        b = 1;
      else b = 0;
      end
      if b, 
          if newsession==1,
            matfilename = datafilename;
          else
            matfilename = loadfilename;
          end
          fprintf('Enter name of (.mat) file to store results in\n')
          a = input(['File name = [',matfilename,'] : '],'s');
          if isempty(a),
            savefilename = matfilename;
          else
            if a(1)=='~',
              a = [getenv('HOME'), a(2:length(a))];
            end
            if strcmp(a(length(a)-3:length(a)),'.mat'),
              savefilename = a(1:length(a)-4);
            else
              savefilename = a;
            end
          end
          clear a b loadfilename datafiledir datafilename newsession
          eval(['save ',savefilename])
          fprintf(['Results saved in ',savefilename,'.mat\n'])
        end
      fprintf('\nThank you for flying Eagle.\n')
      return

    elseif dofit == 1,
      % Input the model name
      % ^^^^^^^^^^^^^^^^^^^^
      prefix = '';
      inputmn;
      
      % Calculating starting values
      % ^^^^^^^^^^^^^^^^^^^^^^^^^^^
      calcsv;

      % Fit the model
      % ^^^^^^^^^^^^^
      fprintf('Estimating the parameters, please wait . . .\n\n')
      betaname = ['b_',modelname];
      pname = ['p_',modelname];
      temptime = clock;
%      eval([betaname,' = powell(''likT'',betastart,',X1name,',',Xaname,',',Xlamname,',''',phiatype,''');'])
%       if strcmp(modelname,'C_C_C'),
%         eval([betaname,' = fminsearch(''likT'',betastart,sopts,',X1name,',',Xaname,',',Xlamname,',''',phiatype,''');'])
%       elseif exist('fminunc')==2,
        eval([betaname,' = fminunc(''likT'',betastart,uopts,',X1name,',',Xaname,',',Xlamname,',''',phiatype,''');'])
%       else
%         eval([betaname,' = fminsearch(''likT'',betastart,uopts,[],',X1name,',',Xaname,',',Xlamname,',''',phiatype,''');'])
%       end
      runtime = etime(clock,temptime);
      fprintf('time taken =%8.2f secs\n\n',runtime)
      fprintf('Checking for convergence\n')
      fprintf('and calculating standard errors, please wait . . .\n\n')
      temptime = clock;
      eval([pname,' = ilt(',betaname,');'])
      eval(['g = grad(''likT'',',betaname,',X1,Xa,Xlam,phiatype);'])
      eval(['jay = infoT(',betaname,',',X1name,',',Xaname,',',Xlamname,',''',phiatype,''');'])
      runtime = etime(clock,temptime);
      fprintf('time taken =%8.2f secs\n\n',runtime)
      fprintf('gradient = %8.4g\n\n',norm(g))
      errb = jay\g;
      eval(['beta = ',betaname,';'])
      errp = ilt(beta) - ilt(beta-errb);

      newsopts = sopts;
      newuopts = uopts;
      while max(errp) > maxerr,
        fprintf('This gradient is too large. The likelihood maximisation has not converged\n')
        fprintf('fully. This introduces an extra error into the parameter estimates,\n')
        fprintf('of the order of %6.4f\n\n',max(errp))
        another_run = input('Would you like a new run with a smaller tolerance? [No] ','s');
        if isempty(another_run),
          break
        elseif another_run(1)=='N'| another_run(1)=='n',
          break
        else 
%           newsopts(2) = newsopts(2)/sqrt(10);
%           newsopts(3) = newsopts(3)/sqrt(10);
%           newuopts(2) = newuopts(2)/sqrt(10);
%           newuopts(3) = newuopts(3)/sqrt(10);
%           if strcmp(modelname,'C_C_C'),
%             eval([betaname,' = fminsearch(''likT'',betastart,newsopts,',X1name,',',Xaname,',',Xlamname,',''',phiatype,''');'])
%           else
            eval([betaname,' = fminunc(''likT'',betastart,newuopts,',X1name,',',Xaname,',',Xlamname,',''',phiatype,''');'])
%           end
          runtime = etime(clock,temptime);
          fprintf('time taken =%8.2f secs\n\n',runtime)
          fprintf('Checking for convergence\n')
          fprintf('and calculating standard errors, please wait . . .\n\n')
          temptime = clock;
          eval([pname,' = ilt(',betaname,');'])
          eval(['g = grad(''likT'',',betaname,',X1,Xa,Xlam,phiatype);'])
          eval(['jay = infoT(',betaname,',',X1name,',',Xaname,',',Xlamname,',''',phiatype,''');'])
          runtime = etime(clock,temptime);
          fprintf('time taken =%8.2f secs\n\n',runtime)
          fprintf('gradient = %8.4g\n\n',norm(g))
          errb = jay\g;
          eval(['beta = ',betaname,';'])
          errp = ilt(beta) - ilt(beta-errb);
        end % if another_run
      end % while max(errp) > maxerr

%     jay = eval(['infoT(',betaname,',',X1name,',',Xaname,',',Xlamname,',''',phiatype,''')']);
      seb = sqrt(diag(inv(jay)));
      eval(['sep = (ilt(',betaname,'+0.5*seb)-ilt(',betaname,'-0.5*seb));'])

      % Correlation matrix
      corname = ['cor_',modelname];
      V = inv(jay);
      D = diag(seb.^(-1));
      C = D*V*D;
      eval([corname,' = C;']);

%     Output the results
%     ^^^^^^^^^^^^^^^^^^
      if model1name(1)=='V',

        fprintf('The logistic regression parameter estimates for 1st-year survival are\n')
        fprintf('Constant        %8.4f\t\tst.err = %7.4f\n', eval([betaname,'(1)']),seb(1))
        for i=1:ncovs1,
          s = model1_orig_name(splits1(i)+1:splits1(i+1)-1);
          blanks = [];
          for blanksi = 1:16-length(s)
            blanks = [blanks,' '];
          end
          fprintf([s,blanks,'%8.4f\t\tst.err = %7.4f\n'],eval([betaname,'(i+1)']),seb(i+1))
        end
        fprintf('\n')
        eval(['beta1 = ',betaname,'(1:npar1);'])
        V1 = V(1:npar1,1:npar1);
        yhat = X1*beta1;
        phi1hat = ilt(yhat);
        sey = sqrt(diag(X1*V1*X1'));
        sephi1 = ilt(yhat + 0.5*sey) - ilt(yhat - 0.5*sey);
        eval(['phi1_',modelname,'=phi1hat;'])
        fprintf('The corresponding 1st-year survival probabilities will be saved')
        a = input(['as phi1_',modelname,'. Want to see them now? [N] :'],'s');
        if isempty(a),
          a = 'N';
        elseif a(1)=='y' | a(1)=='Y',
          a = 'Y';;
        end
        if a == 'Y',
           for i = 1:nrows,
             fprintf('%2.0f:\t\t%8.4f\t\tst.err = %7.4f\n',i,phi1hat(i),sephi1(i))
           end
        end

      else
        fprintf('The estimated 1st-year survival probabilities are\n')
        for i = 1:npar1,
          fprintf('\t\t%8.4f\t\tst.err = %7.4f\n',eval([pname,'(i)']),sep(i));
        end
      end
      fprintf('\n')

      if modelaname(1)=='V',
        fprintf('The logistic regression parameter estimates for adult survival are\n')
        fprintf('Constant        %8.4f\t\tst.err = %7.4f\n', eval([betaname,'(npar1+1)']),seb(npar1+1))
        for i=1:ncovsa,
          s = modela_orig_name(splitsa(i)+1:splitsa(i+1)-1);
          blanks = [];
          for blanksi = 1:16-length(s)
            blanks = [blanks,' '];
          end
          fprintf([s,blanks,'%8.4f\t\tst.err = %7.4f\n'],eval([betaname,'(npar1+i+1)']),seb(npar1+i+1))
        end
        fprintf('\n')
        eval(['betaa = ',betaname,'(npar1+1:npar1+npara);'])
        Va = V(npar1+1:npar1+npara,npar1+1:npar1+npara);
        yhat = Xa*betaa;
        phiahat = ilt(yhat);
        sey = sqrt(diag(Xa*Va*Xa'));
        sephia = ilt(yhat + 0.5*sey) - ilt(yhat - 0.5*sey);
        eval(['phia_',modelname,'=phiahat;'])
        fprintf('The corresponding adult survival probabilities will be saved')
        a = input(['as phia_',modelname,'. Want to see them now? [N] :'],'s');
        if isempty(a),
          a = 'N';
        elseif a(1)=='y' | a(1)=='Y',
          a = 'Y';;
        end
        if a == 'Y',
           for i = 1:ncols-1,
             fprintf('%2.0f:\t\t%8.4f\t\tst.err = %7.4f\n',i,phiahat(i),sephia(i))
           end
        end

      else
        fprintf('The estimated adult survival probabilities are\n')
        for i = npar1+1:npar1+npara,
          fprintf('\t\t%8.4f\t\tst.err = %7.4f\n',eval([pname,'(i)']),sep(i));
        end
      end
      fprintf('\n')

      if modellamname(1)=='V',
        fprintf('The logistic regression parameter estimates for recovery rates are\n')
        fprintf('Constant        %8.4f\t\tst.err = %7.4f\n', eval([betaname,'(npar1+npara+1)']),seb(npar1+npara+1))
        for i=1:ncovslam,
          s = modellam_orig_name(splitslam(i)+1:splitslam(i+1)-1);
          blanks = [];
          for blanksi = 1:16-length(s)
            blanks = [blanks,' '];
          end
          fprintf([s,blanks,'%8.4f\t\tst.err = %7.4f\n'],eval([betaname,'(npar1+npara+i+1)']),seb(npar1+npara+i+1))
        end
        fprintf('\n')
        eval(['betalam = ',betaname,'(npar1+npara+1:npars);'])
        Vlam = V(npar1+npara+1:npars,npar1+npara+1:npars);
        yhat = Xlam*betalam;
        lamhat = ilt(yhat);
        sey = sqrt(diag(Xlam*Vlam*Xlam'));
        selam = ilt(yhat + 0.5*sey) - ilt(yhat - 0.5*sey);
        eval(['lam_',modelname,'=lamhat;'])
        fprintf('The corresponding recovery probabilities will be saved')
        a = input(['as lam_',modelname,'. Want to see them now? [N] :'],'s');
        if isempty(a),
          a = 'N';
        elseif a(1)=='y' | a(1)=='Y',
          a = 'Y';;
        end
        if a == 'Y',
           for i = 1:ncols,
             fprintf('%2.0f:\t\t%8.4f\t\tst.err = %7.4f\n',i,lamhat(i),selam(i))
           end
        end

      else
        fprintf('The estimated recovery probabilities are\n')
        for i = npar1+npara+1:npars,
          fprintf('\t\t%8.4f\t\tst.err = %7.4f\n',eval([pname,'(i)']),sep(i));
        end
      end
      fprintf('\n')


%     Print correlation matrix
%     ^^^^^^^^^^^^^^^^^^^^^^^^
      fprintf('\n')
      fprintf(['The estimated parameter correlations are stored in the matrix ',corname,'\n'])
      a = input('Do you want to view them now [N] ? ','s');
      if ~isempty(a),
        if a(1)=='y' | a(1)=='Y'
          fprintf(['The parameters appear in ',corname,' in the order\n'])
          fprintf('first-year survival, adult survival, recovery probabilities\n')
          prtupmat(C,2);
        end
      end
      fprintf('\n')

%     Print max loglik and AIC
%     ^^^^^^^^^^^^^^^^^^^^^^^^
      likname = ['lik_',modelname];
      eval([likname,' = -likT(',betaname,',',X1name,',',Xaname,',',Xlamname,',''',phiatype,''');'])
      fprintf('The maximized loglikelihood is %-10.4f\n',eval(likname))
        
      AIC = 2*(npars-eval(likname));
      fprintf('The Akaike information criterion is %-10.3f\n\n',AIC)
    
      Mexp = mexpT(eval(betaname),eval(X1name),eval(Xaname),eval(Xlamname),phiatype);
      X2 = chisq(Mobs,Mexp);
      df = nrows*(2*ncols-nrows+1)/2 - npars;
      pval = pchisq(X2,df);
      fprintf('The naive Pearson chi-square goodness-of-fit statistic is \n')
      fprintf('           X2 = %-8.4g on %3d degrees of freedom;  p-value = %6.3g\n',X2,df,pval)
      dev = 2*(lik_max - eval(likname));
      pval = pchisq(dev,df);
      fprintf('The deviance is %-8.4g on %3d degrees of freedom;  p-value = %6.3g\n\n',dev,df,pval)

%     Print fitted values and residual pattern
%     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
      a = input('Do you want to see the matrix of fitted values [N] ? ','s');
      if ~isempty(a),
        if a(1)=='y' | a(1)=='Y',
          prtupmat(Mexp,2);
        end
      end

      resid = Mobs - Mexp;
      signres = (resid>1) - (resid<-1);
      a = input('Do you want to see the pattern of residuals [N] ? ','s');
      if ~isempty(a),
        if a(1)=='y' | a(1)=='Y',
          fprintf(' + denotes a residual >  1,\n')
          fprintf(' - denotes a residual < -1,\n')
          fprintf(' . denotes a residual with absolute value < 1\n\n')
          prtupsgn(signres);
        end
      end
     
    elseif dofit == 2,
      % Start of score test
      % ^^^^^^^^^^^^^^^^^^^
      % Input the null model
      % ^^^^^^^^^^^^^^^^^^^^
      prefix = 'null';
      inputmn;
      nm = modelname;
      nm1 = model1name;
      nma = modelaname;
      nmlam = modellamname;
      parname = ['b_',nm];
      pnl = min(length(parname),matlab_varlength);
      if exist(parname(1:pnl)),
        nparnull1 = length(eval(['X1_',nm1,'(1,:)']));
        nparnulla = length(eval(['Xa_',nma,'(1,:)']));
        nparnulllam = length(eval(['Xlam_',nmlam,'(1,:)']));
        nparnull = nparnull1 + nparnulla + nparnulllam;
    
        % Input the alternative model
        % ^^^^^^^^^^^^^^^^^^^^^^^^^^^
        prefix = 'alt';
        inputmn;
        am = modelname;
        am1 = model1name;
        ama = modelaname;
        amlam = modellamname;
        nparalt1 = length(eval(['X1_',am1,'(1,:)']));
        nparalta = length(eval(['Xa_',ama,'(1,:)']));
        nparaltlam = length(eval(['Xlam_',amlam,'(1,:)']));
        nparalt = nparalt1 + nparalta + nparaltlam;
      
        % Do the score test
        % ^^^^^^^^^^^^^^^^^
        starttime = clock;
        eval(['scorevalue=scoreJT(b_',nm,',X1_',nm1,',Xa_',nma,',Xlam_',nmlam,',X1_',am1,',Xa_',ama,',Xlam_',amlam,',''',phiatype,''');'])
        runtime = etime(clock,starttime);
        fprintf('\ntime taken = %5.1f secs\n',runtime)
        df = nparalt - nparnull;
        p_val = pchisq(scorevalue,df);
        fprintf(['\nThe score statistic for testing the alternative model ',am,'\n'])
        fprintf(['against the null model ',nm,'\n'])
        fprintf('is %8.4f on %2.0f degrees of freedom     (p-val = %8.5g)\n\n',scorevalue,df,p_val)

    else % if not exist beta_nullmodelname

      fprintf('You must fit the null model before you can use it in a score test.\n\n')    

    end % if not exist beta_nullmodelname

  end %  if dofit == 2
  
end % endless while loop

