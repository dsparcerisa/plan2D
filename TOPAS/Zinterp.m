PFLU=[PolynomialFluence.E,PolynomialFluence.Afluence,PolynomialFluence.Bfluence,PolynomialFluence.Cfluence];
PEDEP=[PolynomialEnergyDeposited.E,PolynomialEnergyDeposited.AEdep,PolynomialEnergyDeposited.BEdep,PolynomialEnergyDeposited.CEdep];

E=10; %Elegir energía
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
FLUZ=nan(100,100);
EDEPZ=nan(100,100);
for i=1:NX;
    for j=1:NY;
        FLUZ(i,j)=exp(-((Xvalues(i)-0.5)^2/(sqrt(2)*Sigmaflu)^2)-((Yvalues(j)-0.5)^2/(sqrt(2)*Sigmaflu)^2));
    end
end
for i=1:NX;
    for j=1:NY;
        EDEPZ(i,j)=exp(-((Xvalues(i)-0.5)^2/(sqrt(2)*SigmaEdep)^2)-((Yvalues(j)-0.5)^2/(sqrt(2)*SigmaEdep)^2));
    end
end
figure
imagesc(FLUZ);

figure
imagesc(EDEPZ)