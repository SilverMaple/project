%% this code consider the three datasets 

%% setup cvx package
cvx_setup

%% read the data with paired (nested) one: choose one of the below three asset sets

%%% choose below for FTSE100
Daily_Adjust_Close=xlsread('FTSE100.xlsx',1);
Daily_Adjust_Close_Larger_Set=xlsread('FTSE250.xlsx',1);

%%% choose below for SP500 with Period 1
%Daily_Adjust_Close=xlsread('SP100.xlsx',1);
%Daily_Adjust_Close_Larger_Set=xlsread('SP500.xlsx',1);

%%% choose below for SP500 with Period 2
%Daily_Adjust_Close=xlsread('SP100_2.xlsx',4);
%Daily_Adjust_Close_Larger_Set=xlsread('SP500_2.xlsx',4);


%% cleaing the data
%%% initial data is collected in reverse order of time, that is the most recent date is located on the first row.

Daily_Adjust_Close=Data_Cleaning_Initial(Daily_Adjust_Close);
Daily_Adjust_Close_Larger_Set=Data_Cleaning_Initial(Daily_Adjust_Close_Larger_Set);


%% cleaning the data with three benchmarks; 1.indx, 2. equally weighted 3. GMVP
Daily_Adjust_Close_Larger_Benchmark=Data_Cleaning_Larger_Benchmark(Daily_Adjust_Close,Daily_Adjust_Close_Larger_Set);
Daily_Adjust_Close_Larger_Equal=Data_Cleaning_Larger_Equal(Daily_Adjust_Close,Daily_Adjust_Close_Larger_Set);
Daily_Adjust_Close_Larger_GMVP=Data_Cleaning_Larger_GMVP(Daily_Adjust_Close,Daily_Adjust_Close_Larger_Set);


%% Calculate the daily and monthly returns.
Daily_Return_Benchmark=Return_Computation_Daily(Daily_Adjust_Close_Larger_Benchmark);
Monthly_Return_Benchmark=Return_Computation_Monthly(Daily_Adjust_Close_Larger_Benchmark);
Daily_Return_Equal=Return_Computation_Daily(Daily_Adjust_Close_Larger_Equal);
Monthly_Return_Equal=Return_Computation_Monthly(Daily_Adjust_Close_Larger_Equal);
Daily_Return_GMVP=Return_Computation_Daily(Daily_Adjust_Close_Larger_GMVP);
Monthly_Return_GMVP=Return_Computation_Monthly(Daily_Adjust_Close_Larger_GMVP);




%% Perturbation: consider 12 perturbations: 
%%% 12=3*2*2 because 3 benchmarks, the 2-type portfolios(West or North), and the 2 CV criterion (mean return or Sharpe ratio)

for i=1:12
    
	if i==1 %% Index-WR
        al_list=[0.86,0.88,0.9,0.92,0.94,0.96,0.98];
        c_i_list=0.60:0.1:1.00; 
        [al{i},de{i},monthly_return{i},monthly_return_benchmark{i}]=...
            Perturbation_West_Mean_Return(Daily_Return_Benchmark,Monthly_Return_Benchmark,al_list,c_i_list);
        [Mean_Return{i},Sharpe_Ratio{i},Short{i},Turnover{i},Ratio_of_Active_P{i},Stability{i}]=... 
            Output(al{i},de{i},monthly_return{i},monthly_return_benchmark{i});
    elseif i==2 %% Index-WS
        al_list=[0.86,0.88,0.9,0.92,0.94,0.96,0.98]; 
        c_i_list=0.60:0.1:1.00; 
        [al{i},de{i},monthly_return{i},monthly_return_benchmark{i}]=...
            Perturbation_West_Sharpe_Ratio(Daily_Return_Benchmark,Monthly_Return_Benchmark,al_list,c_i_list);
        [Mean_Return{i},Sharpe_Ratio{i},Short{i},Turnover{i},Ratio_of_Active_P{i},Stability{i}]=... 
            Output(al{i},de{i},monthly_return{i},monthly_return_benchmark{i});
    elseif i==3  %% Index-NR
        al_list=[0.86,0.88,0.9,0.92,0.94,0.96,0.98]; 
        c_i_list=0:0.2:0.8; 
        [al{i},de{i},monthly_return{i},monthly_return_benchmark{i}]=...
            Perturbation_North_Mean_Return(Daily_Return_Benchmark,Monthly_Return_Benchmark,al_list,c_i_list);
        [Mean_Return{i},Sharpe_Ratio{i},Short{i},Turnover{i},Ratio_of_Active_P{i},Stability{i}]=... 
            Output(al{i},de{i},monthly_return{i},monthly_return_benchmark{i}); 
    elseif i==4 %% Index-NS
        al_list=[0.86,0.88,0.9,0.92,0.94,0.96,0.98];
        c_i_list=0:0.2:0.8;
        [al{i},de{i},monthly_return{i},monthly_return_benchmark{i}]=...
            Perturbation_North_Sharpe_Ratio(Daily_Return_Benchmark,Monthly_Return_Benchmark,al_list,c_i_list);
        [Mean_Return{i},Sharpe_Ratio{i},Short{i},Turnover{i},Ratio_of_Active_P{i},Stability{i}]=... 
            Output(al{i},de{i},monthly_return{i},monthly_return_benchmark{i}); 
    elseif i==5  %% Equal-WR
        al_list=[0.86,0.88,0.9,0.92,0.94,0.96,0.98]; 
        c_i_list=0.60:0.1:1.00; 
        [al{i},de{i},monthly_return{i},monthly_return_benchmark{i}]=...
            Perturbation_West_Mean_Return(Daily_Return_Equal,Monthly_Return_Equal,al_list,c_i_list);
        [Mean_Return{i},Sharpe_Ratio{i},Short{i},Turnover{i},Ratio_of_Active_P{i},Stability{i}]=...  
            Output(al{i},de{i},monthly_return{i},monthly_return_benchmark{i});
    elseif i==6 %% Equal-WS
        al_list=[0.86,0.88,0.9,0.92,0.94,0.96,0.98]; 
        c_i_list=0.60:0.1:1.00;
        [al{i},de{i},monthly_return{i},monthly_return_benchmark{i}]=...
            Perturbation_West_Sharpe_Ratio(Daily_Return_Equal,Monthly_Return_Equal,al_list,c_i_list);
        [Mean_Return{i},Sharpe_Ratio{i},Short{i},Turnover{i},Ratio_of_Active_P{i},Stability{i}]=... 
            Output(al{i},de{i},monthly_return{i},monthly_return_benchmark{i}); 
    elseif i==7  %% Equal-NR
        al_list=[0.86,0.88,0.9,0.92,0.94,0.96,0.98];
        c_i_list=0:0.2:0.8;
        [al{i},de{i},monthly_return{i},monthly_return_benchmark{i}]=...
            Perturbation_North_Mean_Return(Daily_Return_Equal,Monthly_Return_Equal,al_list,c_i_list);
        [Mean_Return{i},Sharpe_Ratio{i},Short{i},Turnover{i},Ratio_of_Active_P{i},Stability{i}]=... 
            Output(al{i},de{i},monthly_return{i},monthly_return_benchmark{i});
    elseif i==8 %% Equal-NS
        al_list=[0.86,0.88,0.9,0.92,0.94,0.96,0.98]; 
        c_i_list=0:0.2:0.8; 
        [al{i},de{i},monthly_return{i},monthly_return_benchmark{i}]=...
            Perturbation_North_Sharpe_Ratio(Daily_Return_Equal,Monthly_Return_Equal,al_list,c_i_list);
        [Mean_Return{i},Sharpe_Ratio{i},Short{i},Turnover{i},Ratio_of_Active_P{i},Stability{i}]=...  
            Output(al{i},de{i},monthly_return{i},monthly_return_benchmark{i});
    elseif i==9  %% GMVP-WR
        al_list=[0.86,0.88,0.9,0.92,0.94,0.96,0.98]; 
        c_i_list=0.60:0.1:1.00; 
        [al{i},de{i},monthly_return{i},monthly_return_benchmark{i}]=...
            Perturbation_West_Mean_Return(Daily_Return_GMVP,Monthly_Return_GMVP,al_list,c_i_list);
        [Mean_Return{i},Sharpe_Ratio{i},Short{i},Turnover{i},Ratio_of_Active_P{i},Stability{i}]=... 
            Output(al{i},de{i},monthly_return{i},monthly_return_benchmark{i});
    elseif i==10  %% GMVP-WS
        al_list=[0.86,0.88,0.9,0.92,0.94,0.96,0.98]; 
        c_i_list=0.60:0.1:1.00;
        [al{i},de{i},monthly_return{i},monthly_return_benchmark{i}]=...
            Perturbation_West_Sharpe_Ratio(Daily_Return_GMVP,Monthly_Return_GMVP,al_list,c_i_list);
       [Mean_Return{i},Sharpe_Ratio{i},Short{i},Turnover{i},Ratio_of_Active_P{i},Stability{i}]=...  
            Output(al{i},de{i},monthly_return{i},monthly_return_benchmark{i});
    elseif i==11  %% GMVP-NR
        al_list=[0.86,0.88,0.9,0.92,0.94,0.96,0.98]; 
        c_i_list=0:0.2:0.8;
        [al{i},de{i},monthly_return{i},monthly_return_benchmark{i}]=...
            Perturbation_North_Mean_Return(Daily_Return_GMVP,Monthly_Return_GMVP,al_list,c_i_list);
       [Mean_Return{i},Sharpe_Ratio{i},Short{i},Turnover{i},Ratio_of_Active_P{i},Stability{i}]=...  
            Output(al{i},de{i},monthly_return{i},monthly_return_benchmark{i});
    elseif i==12  %% GMVP-NS
        al_list=[0.86,0.88,0.9,0.92,0.94,0.96,0.98]; 
        c_i_list=0:0.2:0.8; 
        [al{i},de{i},monthly_return{i},monthly_return_benchmark{i}]=...
            Perturbation_North_Sharpe_Ratio(Daily_Return_GMVP,Monthly_Return_GMVP,al_list,c_i_list);
        [Mean_Return{i},Sharpe_Ratio{i},Short{i},Turnover{i},Ratio_of_Active_P{i},Stability{i}]=... 
            Output(al{i},de{i},monthly_return{i},monthly_return_benchmark{i});
    end
 
%% save the data during parfor : choose one of the below three asset sets accordingly

save('Fin_Fin_ftse250_P1.mat','al','de','monthly_return','monthly_return_benchmark', ...
'Mean_Return','Sharpe_Ratio','Short','Turnover','Ratio_of_Active_P','Stability');

%save('Fin_Fin_sp500_P1.mat','al','de','monthly_return','monthly_return_benchmark', ...
%'Mean_Return','Sharpe_Ratio','Short','Turnover','Ratio_of_Active_P','Stability');

%save('Fin_Fin_sp500_P2.mat','al','de','monthly_return','monthly_return_benchmark', ...
%'Mean_Return','Sharpe_Ratio','Short','Turnover','Ratio_of_Active_P','Stability');

end



