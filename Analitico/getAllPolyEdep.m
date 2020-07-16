clear all
close all

%%
E = 1 : 8;
Dtype = 1; %1:Energy Deposit 2:Fluence 3:Dose
EdepFileName = {'Resultados/Edep-1.csv','Resultados/Edep-2.csv','Resultados/Edep-3.csv','Resultados/Edep-4.csv','Resultados/Edep-5.csv','Resultados/Edep-6.csv','Resultados/Edep-7.csv','Resultados/Edep-8.csv'};
polyEdepX = nan(length(E),3,2);
polyEdepY = nan(length(E),3,2);
maxIndexEdep = nan(length(E),1);
for i = 1 : length(E);
    [Edep, Edep_STD, x, y, z] = getData(EdepFileName{i});
    [polyEdepX(i,:,:),polyEdepY(i,:,:),maxIndexEdep(i)] = getSinglePoly(Edep, Edep_STD, x, y, z, E(i), Dtype);
    
end