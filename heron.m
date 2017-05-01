Ringed = [237 434 648 740 1014 777 1100]';  % number ringed

Mobs = [ 20  4  0  2  2  0  0
          0 32 13 12  0  3  4
          0  0 35 13  7  0  2
          0  0  0 43  5  6  1
          0  0  0  0 41 12  3
          0  0  0  0  0 31  7
          0  0  0  0  0  0 63 ];              % number recovered


%         Dec    Jan    Feb    Mar     Year of ringing = year of Dec Temp)
%         ^^^    ^^^    ^^^    ^^^     ^^^^
 Temp = [ 3.9   -0.4    1.2    4.7    %1978
          5.8    2.3    5.7    4.7
          5.6    4.9    3.0    7.9
          0.3    2.7    4.8    6.1
          4.4    6.8    1.8    6.5
          5.7    3.9    3.4    4.8
          5.3    0.9    2.2    4.8 ]; %1984

Dec = Temp(:,1); Jan = Temp(:,2); Feb = Temp(:,3); Mar = Temp(:,4);
