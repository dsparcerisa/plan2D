%Import the Fluence, the Edep and the interpolated polynomials for the simulated energies if it has not
%been done yet

%tablepolinomia

%Set the tables of the polynomials into arrays
PFLU=[PolynomialFluence.E,PolynomialFluence.Afluence,PolynomialFluence.Bfluence,PolynomialFluence.Cfluence];
PEDEP=[PolynomialEnergyDeposited.E,PolynomialEnergyDeposited.AEdep,PolynomialEnergyDeposited.BEdep,PolynomialEnergyDeposited.CEdep];

%Choose energy (MeV)
E=5.3; 

%Interpolated polynomials for E
Ainterpflu=interp1(PFLU(:,1),PFLU(:,2),E);
Binterpflu=interp1(PFLU(:,1),PFLU(:,3),E);
Cinterpflu=interp1(PFLU(:,1),PFLU(:,4),E);
pinterpflu=[Ainterpflu,Binterpflu,Cinterpflu];

AinterpEdep=interp1(PEDEP(:,1),PEDEP(:,2),E);
BinterpEdep=interp1(PEDEP(:,1),PEDEP(:,3),E);
CinterpEdep=interp1(PEDEP(:,1),PEDEP(:,4),E);
pinterpEdep=[AinterpEdep,BinterpEdep,CinterpEdep];

clear PEDEP PFLU Ainterpflu Binterpflu Cinterpflu AinterpEdep BinterpEdep CinterpEdep

%Choose Z plane (cm)
Z=20; 
    
%Caluclation of Sigma in the Z plane    
Sigmainterpflu=polyval(pinterpflu,Z);
SigmainterpEdep=polyval(pinterpEdep,Z);

%Blurred image of the Fluence and Edep in the Z plane
close all
rho=1;
NX=100;
dX=0.01;
NY=100;
dY=0.01;
NZ=2000;
dZ=0.02;
Xvalues = dX*(1:NX) - dX/2;
Yvalues = dY*(1:NY) - dY/2;
[X,Y]=meshgrid(Xvalues,Yvalues);

FLUZ=exp(-((X-0.5).^2/(sqrt(2)*Sigmainterpflu)^2)-((Y-0.5).^2/(sqrt(2)*Sigmainterpflu)^2));
EDEPZ=exp(-((X-0.5).^2/(sqrt(2)*SigmainterpEdep)^2)-((Y-0.5).^2/(sqrt(2)*SigmainterpEdep)^2));
DOSEZ=EDEPZ./(rho*dX*dY*dZ);

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

figure
imagesc(DOSEZ)
title('Dose');
xlabel('X(cm)');
ylabel('Y(cm)');

clear  dZ  NX dX NY dY NZ dZ Xvalues Yvalues X Y

