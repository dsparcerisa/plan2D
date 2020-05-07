function figure_sigma(sigmaX,sigmaY,z,nlmX,nlmY)
%% Figura
Q1_Y = [0:0.001:0.2];
Q1_X = ones(1,length(Q1_Y));
Q2_Y = [0:0.001:0.2];
Q2_X = 2*ones(1,length(Q2_Y));
figure (1)
plot(z,sigmaX(:,1),'r+','MarkerSize',10);
hold on
plot(z,sigmaY(:,1),'b+','MarkerSize',10);
hold on
plot(z,feval(nlmX,z),'r')
hold on
plot(z,feval(nlmY,z),'b')
hold on
grid on
hold on
plot(Q1_X,Q1_Y,'k',Q2_X,Q2_Y,'k')
hold on
legend('\sigma_x ','\sigma_y','poly_x' ,'poly_y','Q_1','Q_2','FontSize',15,'Location','NorthWest')
xlabel('Z (cm)','FontSize',20)
ylabel('\sigma (mm)','FontSize',20)
set((1),'Position', [0 0 800 600]);