%energy = csvread('C:\Users\ire-cris\Documents\GitHub\plan2D\energy.csv');

%Para obtener la dosis en Gy pasamos la energía a Julios
energyW = energyW*1.602*10^(-13);

%Para la masa necesitamos la densidad de la lámina (agua) y sus dimensiones
rho_W = 10^(-3); %en kg/cm3 para obtener Gy
dZ = 0.001; %cm
X = 0.01;
Y = 0.01;
m = rho_W*(dZ*X*Y); %masa, kg

Z = 5; %cm
N = 10^6; %número de protones 
Cp = 1.6*10^(-19); %carga de cada protón en C
C = N*Cp; %carga total

fluency = eye(5); 
dose = (energyW*N*fluency)/(rho_W*Z); %J/kg = Gy bien de unidades pero mal de dimensiones


%[f,c] = size(fluency);
%dose0 = zeros(f);
% for j = 1:c
%     for i = 1:f
%        dose = (energy*N*fluency(i,j))/(rho_W*Z);  
%     end 
% end



