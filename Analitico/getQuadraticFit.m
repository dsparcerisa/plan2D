function [polyX,polyY] = getQuadraticFit(z,sigmaX,sigmaY);
% Interpolates a weighted quadratic polynomial for sigmaX and sigmaY distributions.

%% Weigthed fit X
polyX = nan(1,3,2);
polyY = nan(1,3,2);

wx = (sigmaX(:,2)).^(-2);
PX= fit(z',sigmaX(:,1),'poly2','Weight',wx);
polyX(:,:,1) = [PX.p1 PX.p2 PX.p3];
polyX(:,:,2) = max(abs(confint(PX)-polyX(:,:,1)));
%% Weighted fit Y
wy = (sigmaY(:,2)).^(-2);
PY= fit(z',sigmaY(:,1),'poly2','Weight',wy);
polyY(:,:,1) = [PY.p1 PY.p2 PY.p3];
polyY(:,:,2) = max(abs(confint(PY)-polyY(:,:,1)));