function [linearX,linearY] = linearfit(z,sigmaX,sigmaY);

%% Weigthed fit X
wx = (sigmaX(:,2)).^(-2);
PX= fit(z',sigmaX(:,1),'poly1','Weight',wx);
linearX = [PX.p1 PX.p2];
%polyX(:,:,2) = max(abs(confint(PX)-polyX(:,:,1)));
%% Weighted fit Y
wy = (sigmaY(:,2)).^(-2);
PY= fit(z',sigmaY(:,1),'poly1','Weight',wy);
linearY = [PY.p1 PY.p2];
%polyY(:,:,2) = max(abs(confint(PY)-polyY(:,:,1)));