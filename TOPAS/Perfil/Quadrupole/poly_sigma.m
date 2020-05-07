function [nlmX,nlmY] = poly_sigma(z ,sigmaX ,sigmaY,z0)

%Acotar límites de interpolacion (despues del cuadrupolo)
NZ0 = find(abs(z-z0)<0.01);
z = z(1:NZ0);
sigmaX = sigmaX(1:NZ0,:);
sigmaY = sigmaY(1:NZ0,:);


modelFun = @(b,x) b(1)*x.^2 + b(2)*x + b(3); 

wx = (sigmaX(:,2)).^(-2);
polyFX = fit(z', sigmaX(:,1),'poly2');
polyFX = [polyFX.p1 polyFX.p2 polyFX.p3];
nlmX = fitnlm(z,sigmaX(:,1),modelFun,polyFX,'Weight',wx);

wy = (sigmaY(:,2)).^(-2);
polyFY = fit(z', sigmaY(:,1),'poly2');
polyFY = [polyFY.p1 polyFY.p2 polyFY.p3];
nlmY = fitnlm(z,sigmaY(:,1),modelFun,polyFY,'Weight',wx);