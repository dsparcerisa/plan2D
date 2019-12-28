%Import the Fluence, the Edep and the interpolated polynomials for the simulated energies if it has not
%been done yet

%tablepolinomia

%Set the tables of the polynomials into arrays
PFLU=[PolynomialFluence.E,PolynomialFluence.Afluence,PolynomialFluence.Bfluence,PolynomialFluence.Cfluence];
PEDEP=[PolynomialEnergyDeposited.E,PolynomialEnergyDeposited.AEdep,PolynomialEnergyDeposited.BEdep,PolynomialEnergyDeposited.CEdep];

%Choose energy
E=1.5; 

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

%Choose Z plane
Z=5; 

%Comprobation that the chosen Z plane does not exceed the range of the
%chosen energy. The script estimates the range by interpolating between the
%upper and the lower simulated range energies
dZ=0.02;
Elimits=[round(E-0.5),round(E+0.5)];
Zrangeinterp=dZ*[Range(EDEP(:,Elimits(1))),Range(EDEP(:,Elimits(2)))]-dZ/2;
ZrangeE=interp1(Elimits,Zrangeinterp,E);
if Z>ZrangeE
    disp('Z greater than the range for this energy')
else
    
%Caluclation of Sigma in the Z plane    
Sigmainterpflu=polyval(pinterpflu,Z);
SigmainterpEdep=polyval(pinterpEdep,Z);

%Blurred image of the Fluence and Edep in the Z plane
close all
NX=100;
dX=0.01;
NY=100;
dY=0.01;
Xvalues = dX*(1:NX) - dX/2;
Yvalues = dY*(1:NY) - dY/2;
[X,Y]=meshgrid(Xvalues,Yvalues);

FLUZ=exp(-((X-0.5).^2/(sqrt(2)*Sigmainterpflu)^2)-((Y-0.5).^2/(sqrt(2)*Sigmainterpflu)^2));
EDEPZ=exp(-((X-0.5).^2/(sqrt(2)*SigmainterpEdep)^2)-((Y-0.5).^2/(sqrt(2)*SigmainterpEdep)^2));

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

clear  dZ Elimits Zrangeinterp NX dX NY dY Xvalues Yvalues X Y

