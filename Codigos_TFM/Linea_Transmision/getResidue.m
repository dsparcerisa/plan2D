function [Res] = getResidue(sigmaX_exp, sigmaY_exp, sigmaX, sigmaY)
% Calculates the residue of the sigma between the experimental and the simulated distributions

%% Residue
wiX = (sigmaX_exp(:,2).^2+sigmaX(:,2).^2).^(-1);
resiX2 = wiX.*((sigmaX_exp(:,1)-sigmaX(:,1)).^2);
residueX = sqrt((sum(resiX2))/sum(wiX));

wiY = (sigmaY_exp(:,2).^2+sigmaY(:,2).^2).^(-1);
resiY2 = wiY.*(sigmaY_exp(:,1)-sigmaY(:,1)).^2;
residueY = sqrt((sum(resiY2))/sum(wiY)); 

Res = [residueX,residueY];

end