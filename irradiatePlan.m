function irradiatePlan(COMstage, COMshutter, plan, vector2startPoint, app)
% void irradiatePlan(app)
% Launches plan irradiation
% TODO: outputLOG!!!!!
if (exist('app'))
    app.logLine('Starting plan irradiation...');
end

%% Irradiate plan
tic
for i=1:numel(plan.X)
    absPos = [plan.X(i) plan.Y(i) plan.Z(i)] + vector2startPoint
    finished = stageControl_moveToAbsPos(COMstage, absPos);
    
    if strcmp(plan.mode, 'FLASH')
        Shutter(COMshutter, 'f', plan.Nshots(i));
    elseif strcmp(plan.mode, 'CONV')
        Configure_shutter(COMshutter, 't', plan.t_s(i))
        %pause(1);
        Shutter(COMshutter,'n',1);
    else
        error('Unrecognized plan type (%s)', plan.mode);
    end
    

    
    fprintf('Irradiated spot %i\n', i);
end
toc

if (exist('app'))
    app.logLine('Plan irradiation finished.');
end

end

