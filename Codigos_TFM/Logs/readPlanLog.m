function Plan = readPlanLog(filename)
%%
filename2 = ['Logs/',filename,'.log'];
[tbl_Datos,j] = tipos_logs(filename2);
load('TR_NON_FLASH.mat')
load('TR_FLASH.mat')
%%
 if j == 0  %0 for CONV
    [Plan] = readPlanCONV0(filename2);
    Plan.numSpots = tbl_Datos.Numero_exposiciones(end);
    Plan.X = tbl_Datos.Arrived_at_cm(:,1);
    Plan.Y = tbl_Datos.Arrived_at_cm(:,2);
    Plan.Z = tbl_Datos.Arrived_at_cm(:,3);
    Plan.t_s = tbl_Datos.Cierre_s - tbl_Datos.Apertura_s-TR_NON_FLASH;
 end

if j == 1; %1 for FLASH
    [Plan]=readPlanFLASH0(filename2);
    Plan.numSpots = tbl_Datos.Numero_exposiciones(end);
    Plan.X = tbl_Datos.Arrived_at_cm(:,1);
    Plan.Y = tbl_Datos.Arrived_at_cm(:,2);
    Plan.Z = tbl_Datos.Arrived_at_cm(:,3);
    Plan.t_s = tbl_Datos.Cierre_s - tbl_Datos.Apertura_s-TR_FLASH;
    Plan.Nshots = tbl_Datos.FLASH_shots;
end   
%% Outliers

load('failed_exposures_AX_FLASH.mat')
load('failed_exposures_AX_NON_FLASH.mat')
AX = eval(['failed_exposures_AX_tabl_',filename]);
Plan.Movement_Outlier = AX.Failed_Exposure; 
load('failed_exposures_FLASH.mat')
load('failed_exposures_NON_FLASH.mat')
AT = eval(['failed_exposures_tabl_',filename]);
Plan.Shutter_Outlier = AT.Failed_Exposure; 
