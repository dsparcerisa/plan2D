clear all
close all
%%
%filename='irrLog_2020_02_06_11_47_28'; j = 0; %CONV
filename='irrLog_2020_02_06_11_27_09'; j = 1; %FLASH
Plan = readPlanLog(filename)
%% Movement
load('tablas_logs_NON_FLASH')
load('tablas_logs_FLASH')
Plan_table = eval(['tabl_',filename]);
AX1 = Plan_table.Moving_to_cm;
[n,l] = size(AX1);
AX = rssq(AX1(2:n,:)-AX1(1:n-1,:),2);
load('Linear_AX')
T_AX = sum(polyval(lin_AX,AX));
%% Time
load('Linear_T_CONV')
load('Linear_T_FLASH')
if j == 0;
    T_T = sum(polyval(lin_T,Plan_table.Tiempo_apertura_teorico_s));
elseif j == 1;
    T_T = sum(polyval(lin_T,Plan_table.FLASH_shots));
end
%% Comparacion 
T_Plan = T_AX + T_T
T_Real = Plan.Total_time

