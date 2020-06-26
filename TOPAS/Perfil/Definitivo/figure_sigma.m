function figure_sigma(sigmaX,sigmaY,z)
%% Figura
Q1_Y = [0:0.001:0.2];
Q1_X = 25.7 * ones(1,length(Q1_Y));
Q2_X = 35.7 * ones(1,length(Q1_Y));
Q3_X = 40.2 * ones(1,length(Q1_Y));
Q4_X = 50.2 * ones(1,length(Q1_Y));
N_X = 66.2 * ones(1,length(Q1_Y));

figure (1)
plot(z,sigmaX(:,1),'r+','MarkerSize',10);
hold on
plot(z,sigmaY(:,1),'b+','MarkerSize',10);
hold on
grid on
hold on
plot(Q1_X,Q1_Y,'k',Q2_X,Q1_Y,'k',Q3_X,Q1_Y,'k',Q4_X,Q1_Y,'k',N_X,Q1_Y,'k')
hold on
legend('\sigma_x ','\sigma_y','FontSize',15,'Location','NorthWest')
xlabel('Z (cm)','FontSize',20)
ylabel('\sigma (mm)','FontSize',20)
set((1),'Position', [0 0 800 600]);