function [polyX,polyY,maxIndex] = getSinglePoly(D, D_STD, x, y, z , E, Dtype)

%%
NZ = length(z);
DZ = nan(NZ,2);
for i = 1 : NZ
   DZ(i,:) = [sum(sum(D(:,:,i))), sum(sum(D_STD(:,:,i)))];
end
DZ_norm = [DZ(:,1)./sum(DZ(:,1)),DZ(:,2)./sum(DZ(:,2))];
DZV = DZ_norm(:,1);

%% Index
maxIndex = find(DZV == max(DZV));  %The interpolation finishes at the maximum deposition
%% Sigma Interpolation
sigmaX = nan(NZ,2);
sigmaY = nan(NZ,2);
for i = maxIndex : NZ;
    try
    [sigmaX(i,:), sigmaY(i,:)] = getSigmaGauss(D(:,:,i), D_STD(:,:,i), x, y);
    catch
    end
end
%% Quadratic Fit
[polyX,polyY] = getQuadraticFit(z(maxIndex:NZ),sigmaX(maxIndex:NZ,:),sigmaY(maxIndex:NZ,:));

%% Plot arrays
zz=[0 :0.001: z(maxIndex)];
YLabelD = {'Energy Deposit (%)', 'Fluence (%/mm^{2})', 'Dose (%)'};
LegendD = {'Energy Deposit', 'Fluence', 'Dose'};


%% Plot Dose distribution
figure (E)
subplot(1,2,1)
%errorbar(z,DoseZ_norm(:,1),DoseZ_norm(:,2),'MarkerSize',15);
plot(z,DZ_norm(:,1),'LineWidth',2)
hold on
xlabel('z (cm)','FontSize',15)
ylabel(YLabelD{Dtype},'FontSize',15)
legend(LegendD{Dtype},'Location','NorthEast','FontSize',15)
grid on

%% Plot Sigma Distribution
subplot (1,2,2)
errorbar(z,sigmaX(:,1),sigmaX(:,2),'r.','MarkerSize',1)
hold on
errorbar(z,sigmaY(:,1),sigmaY(:,2),'b.','MarkerSize',1)
hold on
plot(zz,polyval(polyX,zz),'r','LineWidth',1)
hold on
plot(zz,polyval(polyY,zz),'b','LineWidth',1)
grid on
xlabel('z (cm)','FontSize',15)
ylabel('\sigma (mm)','FontSize',15)
legend('\sigma _{X}','\sigma _{Y}','P_{X}','P_{Y}','FontSize',15,'Location','northwest')

set((E),'Position', [0 0 800 600]);

