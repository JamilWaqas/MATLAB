% calculate starting values
      npar1 = eval(['length(',X1name,'(1,:))']);
      npara = eval(['length(',Xaname,'(1,:))']);
      nparlam = eval(['length(',Xlamname,'(1,:))']);
      npars = npar1 + npara + nparlam;
      beta_def = zeros(npars,1);
      if exist('beta_C_C_C')
        if model1name(1)=='V'
          Xtend1 = zeros(npar1,3);
          Xtend1(1,1) = 1;
        else %  model1name(1)=='V'
          Xtend1 = ones(npar1,1)*[1,0,0];
        end %  model1name(1)=='V'
        if modelaname(1)=='V'
          Xtenda = zeros(npara,3);
          Xtenda(1,2) = 1;
        else %  modelaname(1)=='V'
          Xtenda = ones(npara,1)*[0,1,0];
        end %  modelaname(1)=='V'

        if modellamname(1)=='V'
          Xtendlam = zeros(nparlam,3);
          Xtendlam(1,3) = 1;
        else % modellamname(1)=='V'
          Xtendlam = ones(nparlam,1)*[0,0,1];
        end  % modellamname(1)=='V'

        Xtend = [Xtend1;Xtenda;Xtendlam];
        beta_def = Xtend*eval('beta_C_C_C');
      end  % exist('beta_C_C_C')

      if strcmp(modelname,'C_C_C')
        def_st_vals = 'Y';
        beta_def = [0;0;0];
      else % modelname == 'C_C_C'
        def_st_vals = input('Do you want to use the default starting parameter values? [Y]','s');
      end  % modelname == 'C_C_C'

      if isempty(def_st_vals)
        betastart = beta_def;
      elseif (def_st_vals(1)=='Y'|def_st_vals(1)=='y')
        betastart = beta_def;
      else  % def_st_vals=='N'
        betastart = beta_def;
% 1st year survival
        if model1name(1)=='V'
          fprintf('\nenter the starting values for the regression parameters\n')
          fprintf('for the first year survival probabilities\n')
          fprintf('constant term: [%5.3f] ',beta_def(1))
          tmp = input('?');
          if tmp == []
             betastart(1) = beta_def(1);
          else
             betastart(1) = tmp;
          end
          for i = 2:npar1
            fprintf('regression coeff %2.0f : [%5.3f] ',i-1,beta_def(i))
            tmp = input('?');
            if tmp == []
               betastart(i) = beta_def(i);
            else
              betastart(i) = tmp;
            end
          end
        else
          fprintf('\nenter the starting values for the first year survival probabilities\n')
          for i = 1:npar1
            fprintf('survival probability %2.0f : [%5.3f] ',i,ilt(beta_def(i)))
            tmp = input('?');
            if tmp == []
               betastart(i) = beta_def(i);
            else
              betastart(i) = lot(tmp);
            end
          end
        end
% adult survival
        if modelaname(1)=='V'
          fprintf('\nenter the starting values for the regression parameters\n')
          fprintf('for the adult survival probabilities\n')
          fprintf('constant term: [%5.3f] ',beta_def(npar1+1))
          tmp = input('?');
          if tmp == []
             betastart(npar1+1) = beta_def(npar1+1);
          else
            betastart(npar1+1) = tmp;
          end
          for i = npar1+2:npar1+npara
            fprintf('regression coeff %2.0f : [%5.3f] ',i-npar1-1,beta_def(i))
            tmp = input('?');
            if tmp == []
               betastart(i) = beta_def(i);
            else
              betastart(i) = tmp;
            end
          end
        else
          fprintf('\nenter the starting values for the adult survival probabilities\n')
          for i = npar1+1:npar1+npara
            fprintf('survival probability %2.0f : [%5.3f] ',i-npar1,ilt(beta_def(i)))
            tmp = input('?');
            if tmp == []
               betastart(i) = beta_def(i);
            else
              betastart(i) = lot(tmp);
            end
          end
        end
% recovery
        if modellamname(1)=='V'
          fprintf('\nenter the starting values for the regression parameters\n')
          fprintf('for the recovery probabilities\n')
          fprintf('constant term: [%5.3f] ',beta_def(npar1+npara+1))
          tmp = input('?');
          if tmp == []
             betastart(npar1+npara+1) = beta_def(npar1+npara+1);
          else
            betastart(npar1+npara+1) = tmp;
          end
          for i = npar1+npara+2:npars
            fprintf('regression coeff %2.0f : [%5.3f] ',i-npar1-npara-1,beta_def(i))
            tmp = input('?');
            if tmp == []
               betastart(i) = beta_def(i);
            else
              betastart(i) = tmp;
            end
          end
        else
          fprintf('\nenter the starting values for the recovery probabilities\n')

          for i = npar1+npara+1:npars
            fprintf('recovery probability %2.0f : [%5.3f] ',i-npar1-npara,ilt(beta_def(i)))
            tmp = input('?');

            if tmp == []
               betastart(i) = beta_def(i);
            else
              betastart(i) = lot(tmp);
            end

          end  % for i

        end  % if modellamname

      end  % def_st_vals=='N'

