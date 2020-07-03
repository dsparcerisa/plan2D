function [PlanCONV0]=readPlanCONV0(filename);

filetext = fileread(filename);

%% Comment
[D1_comment,D2_comment] = regexp(filetext,'comment');
[D3_comment,D4_comment] = regexp(filetext,'Plan type');
PlanCONV0.Comment = filetext(D2_comment+3:D3_comment-3);
%% Plan name
if isempty(PlanCONV0.Comment) == 1
    [D1_planName,D2_planName] = regexp(filetext,'Plan name');
    [D3_planName,D4_planName] = regexp(filetext,'Plan type');
    PlanCONV0.name = filetext(D2_planName+3:D3_planName-3);

else isempty(PlanCONV0.Comment) == 0
    [D1_planName,D2_planName] = regexp(filetext,'Plan name');
    [D3_planName,D4_planName] = regexp(filetext,'Plan comment');
    PlanCONV0.name = filetext(D2_planName+3:D3_planName-3);
end   
    
%% Plan type
[D1_planType,D2_planType] = regexp(filetext,'Plan type');
PlanCONV0.mode = filetext(D2_planType+3:D2_planType+6);

%% PepperPot Code
[D1_PP,D2_PP] = regexp(filetext,'PepperPot code');
[D3_PP,D4_PP] = regexp(filetext,'Air');
PlanCONV0.PP_code = filetext(D2_PP+3:D3_PP-3);

%% Air depth at stage Position
[D1_Air,D2_Air] = regexp(filetext,'position');
[D3_Air,D4_Air] = regexp(filetext,'Absolut');
PlanCONV0.Air_Depth_Stage_Position = str2double(filetext(D2_Air+7:D3_Air-7));

%% Absolut shift
[D1_shift,D2_shift] = regexp(filetext,'well:');
[D3_shift,D4_shift] = regexp(filetext,'Current');
PlanCONV0.absolut_Shift = str2num(filetext(D2_shift+3:D3_shift-4));

%% Intensity
[D1_Intensity,D2_Intensity] = regexp(filetext,'intensity');
[D3_Intensity,D4_Intensity] = regexp(filetext,'nA (pl');
PlanCONV0.I = str2double(filetext(D2_Intensity+3:D3_Intensity-2));

%% Intensity planned
[D1_IntensityP,D2_IntensityP] = regexp(filetext,'planned for');
[D3_IntensityP,D4_IntensityP] = regexp(filetext,'nA)');
PlanCONV0.I_planned = str2double(filetext(D2_IntensityP+2:D3_IntensityP-2));

