function [Sigmaflu,SigmaEdep]=SigmaZE(Z,E)

%Set the tables of the polynomials into arrays
load('PolynomialEnergyDeposited.mat')
load('PolynomialFluence.mat')
PFLU=[PolynomialFluence.E,PolynomialFluence.Afluence,PolynomialFluence.Bfluence,PolynomialFluence.Cfluence];
PEDEP=[PolynomialEnergyDeposited.E,PolynomialEnergyDeposited.AEdep,PolynomialEnergyDeposited.BEdep,PolynomialEnergyDeposited.CEdep];

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
    
%Caluclation of Sigma in the Z plane    
Sigmaflu=polyval(pinterpflu,Z);
SigmaEdep=polyval(pinterpEdep,Z);

