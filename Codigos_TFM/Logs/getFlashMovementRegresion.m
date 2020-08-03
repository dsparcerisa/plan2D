%% Carga
clear all
close all
load('tablas_logs_FLASH')
TABLA = who;

%% Distances-Time
AX = [];
Time_AX = [];
for i = 1:length(TABLA)
     tbl = evalin('base',TABLA{i});
     AX1 = tbl.Moving_to_cm;
     [n,l] = size(AX1);
     AX1 = rssq(AX1(2:n,:)-AX1(1:n-1,:),2);
     AX = [AX;AX1];
     Time_AX1 = [tbl.Arrived_at_s-tbl.Moving_to_s];
     Time_AX = [Time_AX;Time_AX1(2:length(Time_AX1))];
     
end

validPoints = ~isoutlier(Time_AX,'percentiles', [1 99]);
validAX = AX(validPoints);
validTime_AX = Time_AX(validPoints);

lin = polyfit(validAX,validTime_AX,1)
F = 0:0.01:15;
FF = polyval(lin,F);

subplot(2,1,1)
plot(validAX,validTime_AX,'bx','MarkerSize',5)
hold on
plot(F,FF,':','LineWidth',1)

subplot(2,1,2)
residue = (validTime_AX - polyval(lin, validAX)).^2; 
stdResidue_AX_FLASH = std(residue)
hold off;
plot(validAX, residue, 'bx','MarkerSize',5);
outlierMask = residue>2*stdResidue_AX_FLASH;
hold on
plot(validAX(outlierMask), residue(outlierMask), 'ro','MarkerSize',10)
plot([0 15], [stdResidue_AX_FLASH stdResidue_AX_FLASH], 'k:','LineWidth',1);
subplot(2,1,1)
hold on
plot(validAX(outlierMask), validTime_AX(outlierMask), 'ro','MarkerSize',10)

subplot(2,1,1)
xlabel('|\Deltax| (cm)','FontSize',15)
ylabel('t_{m} (s)','FontSize',15)
legend('Spots','Linear fit','Outliers','FontSize',12,'Location','northwest')
title('a)','FontSize',12)
set((1),'Position', [0 0 800 600]);
grid on

subplot(2,1,2)
xlabel('|\Deltax| (cm)','FontSize',15)
ylabel('Residue^2 (s^2)','FontSize',15)
legend('Spots','Outliers','\sigma','FontSize',12,'Location','northwest')
title('b)','FontSize',12)
grid on

%%  Save distances-Time_residues
for i = 1:length(TABLA);
    tbl = evalin('base',TABLA{i});
    AX1 = tbl.Moving_to_cm;
    [n,l] = size(AX1);
    AX = sum(abs(AX1(2:n,:)-AX1(1:n-1,:)),2);
    
    Time_AX = [tbl.Arrived_at_s-tbl.Moving_to_s];
    Time_AX = Time_AX(2:length(Time_AX));
    residue = (Time_AX - polyval(lin, AX)).^2;
    outlier = residue>2*stdResidue_AX_FLASH;
    Numero_exposiciones = tbl.Numero_exposiciones;
    Numero_exposiciones = Numero_exposiciones(2:length(Numero_exposiciones));
    R = table(Numero_exposiciones,Time_AX,AX,residue,outlier);
    Failed_Exposure = Numero_exposiciones(outlier);
    F = table(Failed_Exposure);
    eval([['res_AX_',TABLA{i}],'=R;']);
    eval([['failed_exposures_AX_',TABLA{i}],'=F;']);
end
clear tbl AX Time_AX residue outlier R Failed_Exposure F TABLA
save('residues_AX_FLASH.mat','res_AX_*','stdResidue_AX_FLASH');
save('failed_exposures_AX_FLASH.mat','failed_exposures_AX_*');