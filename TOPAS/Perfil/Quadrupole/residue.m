function [residue] = residue(z_exp,sigmaX_exp,sigmaY_exp,nlm_exp_X,nlm_exp_Y,nlmX,nlmY)

sigmaX_inter = feval(nlmX,z_exp);
sigmaX_STD_inter = sqrt((nlmX.Coefficients.SE(1).*(sigmaX_inter.^2)).^2+(nlmX.Coefficients.SE(2).*sigmaX_inter).^2+(nlmX.Coefficients.SE(3)).^2);
sigmaY_inter = feval(nlmY,z_exp);
sigmaY_STD_inter = sqrt((nlmY.Coefficients.SE(1).*(sigmaY_inter.^2)).^2+(nlmY.Coefficients.SE(2).*sigmaY_inter).^2+(nlmY.Coefficients.SE(3)).^2);

residueX = sum((sigmaX_inter-sigmaX_exp(1,:)).^2);
residueY = sum((sigmaY_inter-sigmaY_exp(1,:)).^2);

residue = [residueX;residueY];
z = [4 : 0.1 : 12.5];
X = feval(nlmX,z);
Y = feval(nlmY,z);
X_exp = feval(nlm_exp_X,z);
Y_exp = feval(nlm_exp_Y,z);
figure (2)
errorbar(z_exp,sigmaX_exp(1,:),sigmaX_exp(2,:),'ro','MarkerSize',5)
hold on
errorbar(z_exp,sigmaY_exp(1,:),sigmaY_exp(2,:),'bo','MarkerSize',5);
hold on
errorbar(z_exp,sigmaX_inter,sigmaX_STD_inter,'rx','MarkerSize',5);
errorbar(z_exp,sigmaY_inter,sigmaY_STD_inter,'bx','MarkerSize',5);
hold on
plot(z,X_exp,'r.')
hold on
plot(z,Y_exp,'b.')
hold on
plot(z,X,'r')
hold on
plot(z,Y,'b')
hold on
grid on
hold on

legend('\sigma_x exp','\sigma_y exp','\sigma_x sim','\sigma_y sim','poly_x exp' ,'poly_y exp','poly_x sim' ,'poly_y sim','FontSize',15,'Location','NorthWest')
xlabel('Z (cm)','FontSize',20)
ylabel('\sigma (mm)','FontSize',20)
set((2),'Position', [0 0 800 600]);