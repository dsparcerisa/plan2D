function [polyXW,polyYW] = getQuadraticFit(z,sigmaX,sigmaY);
% Interpolates a weighted quadratic polynomial for sigmaX and sigmaY distributiones.
% z array must be in increasing order: z(1) < z(length(z))


modelFun = @(b,x) b(1)*x.^2 + b(2)*x+b(3);

polyX = polyfit(z',sigmaX(:,1),2);
wx = (sigmaX(:,2)).^(-2);
nlmX = fitnlm(z,sigmaX(:,1),modelFun,polyX,'Weight',wx);
polyXW = nlmX.Coefficients.Estimate';

polyY = polyfit(z',sigmaY(:,1),2);
wy = (sigmaY(:,2)).^(-2);
nlmY = fitnlm(z,sigmaY(:,1),modelFun,polyY,'Weight',wy);
polyYW = nlmY.Coefficients.Estimate';