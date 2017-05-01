      % Input the model name
      % ^^^^^^^^^^^^^^^^^^^^
      inputstring = ['Enter the name of the ',prefix,' model : '];
      b1 = 1; b2 = 1; b3 = 1; b4 = 1;
    while b4        % check for parameter-redundant models
      while b3      % check that any covariates exist and are of the right length
        while b2,   % check for reasonable model name
          while b1, % check for 2 slashes in the model name
            b1 = 0; b2 = 0; b3 = 0; b4 = 0;
            modelname = input(inputstring,'s');
            slash = findstr(modelname,'/');
            if length(slash) ~= 2,
              b1 = 1;
              fprintf('Model name must consist of 3 submodels separated by slashes\n\n')
            end 
          end  % while b1
         
          b1 = 1;

          model1_orig_name = modelname(1:slash(1)-1);
          modela_orig_name = modelname(slash(1)+1:slash(2)-1);
          modellam_orig_name = modelname(slash(2)+1:length(modelname));
        
        model1name = cnvrtnm(model1_orig_name);
        modelaname = cnvrtnm(modela_orig_name);
        modellamname = cnvrtnm(modellam_orig_name);
        modelname = [model1name,'_',modelaname,'_',modellamname];

          
          s = model1name;
          if length(s)==1,
            if s~='C' & s~='T',
              b2 = 1;
            end
          elseif s(1)~='V',
              b2 = 1;
          end
          if b2 == 1,            
            fprintf('The model name for 1st-year survival must be C or T\n')
            fprintf('or be of the form V(covariate list)\n\n')
          end
        
          s = modelaname;
          phiatype = 'age';
          if length(s)==1,
            if s~='C' & s~='T' & s~='A',
              b2 = 1;
            end
          elseif s(1)~='V' & s(1)~='A',
              b2 = 1;
          end
          if s == 'T' | s(1) == 'V', 
            phiatype = 'time';
          elseif s == 'A',
            amax = ncols-1;
          elseif s(1) == 'A',
            x = abs(s(2:length(s))) - 48;
            amax = sum(x.*10.^(length(x)-1:-1:0));
            if amax > ncols-1,
              b2 = 1;
            end
          end
          if b2 == 1,            
            fprintf('The model name for adult survival must be C or T or A or\n')
            fprintf('An for some integer n, or be of the form V(covariate list)\n\n')
          end
        
          s = modellamname;
          if length(s)==1,
            if s~='C' & s~='T',
              b2 = 1;
            end
          elseif length(s)==2,
            if ~strcmp(s,'T1'),
              b2 = 1;
            end
          elseif s(1)~='V',
              b2 = 1;
          end
          if b2 == 1,            
            fprintf('The model name for recoveries must be C or T or T1\n')
            fprintf('or be of the form V(covariate list)\n\n')
          end
        
        end % while b2
    
        b2 = 1;
        
        % Calculate the X matrices for the model
        % ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        % Calculate X1
        % ^^^^^^^^^^^^
        X1name = ['X1_',model1name];
        eval([X1name,'=[];'])

        X1_C = ones(nrows,1);
        X1_T = eye(nrows);
        
        if  model1name(1)=='V',
          if length(findstr(model1_orig_name,'(')) ~= length(findstr(model1_orig_name,')')),
            fprintf('Unmatched parentheses in covariate expression\n')
            b3 = 1;
          else
            splits1 = findstr(model1_orig_name,',');
            ncovs1 = length(splits1)+1;
            splits1 = [2, splits1, length(model1_orig_name)];
            eval([X1name,'(:,1) = ones(nrows,1);'])
            for i=1:ncovs1,
              s = model1_orig_name(splits1(i)+1:splits1(i+1)-1);
              paren_op = findstr(s,'(');
              if isempty(paren_op),
                paren_op = length(s) + 1;
              end
              cov_name = s(1:paren_op-1);
              if ~exist(cov_name),
                b3 = 1;
                fprintf(['There is no such covariate as ',s,' Check spelling.\n'])
              elseif length(eval(s)) ~= nrows,
                b3 =1;
                fprintf('covariate %2.0f for 1st year survival should be of length %2.0f\n',i,nrows)
              else
                eval([X1name,'(:,i+1) = ',s,'-mean(',s,');']);
              end
            end
          end
        end
        eval(['X1 = ',X1name,';'])
  
        % Calculate Xa
        % ^^^^^^^^^^^^
        Xaname = ['Xa_',modelaname];
        eval([Xaname,'=[];'])

        Xa_C = ones(ncols-1,1);
        Xa_T = eye(ncols-1);

        if modelaname(1)=='A',
          eval([Xaname,'= [eye(amax); zeros(ncols-1-amax,amax-1), ones(ncols-1-amax,1)];'])
        elseif  modelaname(1)=='V',
          if length(findstr(modela_orig_name,'(')) ~= length(findstr(modela_orig_name,')')),
            fprintf('Unmatched parentheses in covariate expression\n')
            b3 = 1;
          else
            splitsa = findstr(modela_orig_name,',');
            ncovsa = length(splitsa)+1;
            splitsa = [2, splitsa, length(modela_orig_name)];
            eval([Xaname,'(:,1) = ones(ncols-1,1);'])
            for i=1:ncovsa,
              s = modela_orig_name(splitsa(i)+1:splitsa(i+1)-1);
              paren_op = findstr(s,'(');
              if isempty(paren_op),
                paren_op = length(s) + 1;
              end
              cov_name = s(1:paren_op-1);
              if ~exist(cov_name),
                b3 = 1;
                fprintf(['There is no such covariate as ',s,' Check spelling.'])
              elseif length(eval(s)) ~= ncols-1,
                b3 =1;
                fprintf('Covariate %2.0f for adult survival should be of length %2.0f\n',i,ncols-1)
                if length(eval(s)) == ncols,
                  fprintf('Don''t forget that there is no adult survival parameter for the first year\n')
                  fprintf(['You can use ',s,'(2:',ncols,') as a covariate'])
                end
              else
                eval([Xaname,'(:,i+1) = ',s,'-mean(',s,');']);
              end
            end
          end
        end
        eval(['Xa = ',Xaname,';'])
        
        % Calculate Xlam
        % ^^^^^^^^^^^^^^
        Xlamname = ['Xlam_',modellamname];
        eval([Xlamname,'=[];'])

        Xlam_C = ones(ncols,1);
        Xlam_T = eye(ncols);
        Xlam_T1 = [eye(ncols-1);ones(1,ncols-1)/(ncols-1)];
        
        if  modellamname(1)=='V',
          if length(findstr(modellam_orig_name,'(')) ~= length(findstr(modellam_orig_name,')')),
            fprintf('Unmatched parentheses in covariate expression \n')
            b3 = 1;
          else
            splitslam = findstr(modellam_orig_name,',');
            ncovslam = length(splitslam)+1;
            splitslam = [2, splitslam, length(modellam_orig_name)];        
            eval([Xlamname,'(:,1) = ones(ncols,1);'])
            for i=1:ncovslam,
              s = modellam_orig_name(splitslam(i)+1:splitslam(i+1)-1);
              paren_op = findstr(s,'(');
              if isempty(paren_op),
                paren_op = length(s) + 1;
              end
              cov_name = s(1:paren_op-1);
              if ~exist(cov_name),
                b3 = 1;
                fprintf(['There is no such covariate as ',s,' Check spelling.'])
              elseif length(eval(s)) ~= ncols,
                b3 =1;
                fprintf('covariate %2.0f for recovery probabilities should be of length %2.0f\n',i,ncols)
              else
                eval([Xlamname,'(:,i+1) = ',s,'-mean(',s,');']);
              end
            end
          end
        end
        eval(['Xlam = ',Xlamname,';'])
      
      end    % while b3

      b3 = 1;    

      if strcmp(modelname,'C_A_C') | (strcmp(modelaname,'T') & strcmp(modellamname,'T')),
        fprintf(['Sorry, model ',modelname,' is not identifiable\n\n'])
        b4 = 1;
      end
    end  % while b4

    b4 = 1;

