PFLU=[PolynomialFluence.E,PolynomialFluence.Afluence,PolynomialFluence.Bfluence,PolynomialFluence.Cfluence];
PEDEP=[PolynomialEnergyDeposited.E,PolynomialEnergyDeposited.AEdep,PolynomialEnergyDeposited.BEdep,PolynomialEnergyDeposited.CEdep];
%Elegir energia
E=7.75; 
%polinomios interpolado para la energia E
Ainterpflu=interp1(PFLU(:,1),PFLU(:,2),E);
Binterpflu=interp1(PFLU(:,1),PFLU(:,3),E);
Cinterpflu=interp1(PFLU(:,1),PFLU(:,4),E);
pinterpflu=[Ainterpflu,Binterpflu,Cinterpflu];

AinterpEdep=interp1(PEDEP(:,1),PEDEP(:,2),E);
BinterpEdep=interp1(PEDEP(:,1),PEDEP(:,3),E);
CinterpEdep=interp1(PEDEP(:,1),PEDEP(:,4),E);
pinterpEdep=[AinterpEdep,BinterpEdep,CinterpEdep];
%Elegir plano
Z=500; 
dZ=0.02;

Zrange=dZ*NZAll-dZ/2;
Einterp=[round(E-0.5),round(E+0.5)];
Zrangeinterp=[Zrange(Einterp(1)),Zrange(Einterp(2))];
ZrangeE=interp1(Einterp,Zrangeinterp,E);

if Z>ZrangeE
    disp('Z greater than the range for this energy')
else
Sigmaflu=polyval(pinterpflu,Z);
SigmaEdep=polyval(pinterpEdep,Z);

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
end

