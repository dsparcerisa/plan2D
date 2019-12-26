PFLU=[PolynomialFluence.E,PolynomialFluence.Afluence,PolynomialFluence.Bfluence,PolynomialFluence.Cfluence];
PEDEP=[PolynomialEnergyDeposited.E,PolynomialEnergyDeposited.AEdep,PolynomialEnergyDeposited.BEdep,PolynomialEnergyDeposited.CEdep];

E=10; %Elegir energÌa
pflu=PFLU(E,2:4);
pEdep=PEDEP(E,2:4);
Z=30; %Elegir plano
Sigmaflu=polyval(pflu,Z);
SigmaEdep=polyval(pEdep,Z);

close all

NX=100;
dX=0.01;
NY=100;
dY=0.01;
Xvalues = dX*(1:NX) - dX/2;
Yvalues = dY*(1:NY) - dY/2;
[X,Y]=meshgrid(Xvalues,Yvalues);

FLUZ=exp(-((X-0.5).^2/(sqrt(2)*Sigmaflu)^2)-((Y-0.5).^2/(sqrt(2)*Sigmaflu)^2));
EDEPZ=exp(-((X-0.5).^2/(sqrt(2)*SigmaEdep)^2)-((Y-0.5).^2/(sqrt(2)*SigmaEdep)^2));
figure
imagesc(FLUZ);
title('Fluence');
xlabel('X(cm)');
ylabel('Y(cm)');

figure
imagesc(EDEPZ)
title('Energydeposited');
xlabel('X(cm)');
ylabel('Y(cm)');

