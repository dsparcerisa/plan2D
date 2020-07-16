function [polyX,polyY] = getQuadraticFit(z,sigmaX,sigmaY);
% Returns weighted fits for X and Y axes from sigma distributions

%% Weigthed fit X
wx = (sigmaX(:,2)).^(-2);
PX= fit(z',sigmaX(:,1),'poly2','Weight',wx);
polyX = [PX.p1 PX.p2 PX.p3];
polyX(:,:,2) = max(abs(confint(PX)-polyX(:,:,1)));

%% Weighted fit Y
wy = (sigmaY(:,2)).^(-2);
PY= fit(z',sigmaY(:,1),'poly2','Weight',wy);
polyY = [PY.p1 PY.p2 PY.p3];
polyY(:,:,2) = max(abs(confint(PY)-polyY(:,:,1)));

end