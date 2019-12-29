clear all
%Import the simulated energies
Importallenergies

PFLU=nan(10,4);
PEDEP=nan(10,4);
PFLU(:,1)=[1:10]';
for i=1:10;
    [pflu,pEdep]=Sigmapolynomial(FLU(:,i),EDEP(:,i));
    PFLU(i,(2:4))=pflu;
    PEDEP(i,(2:4))=pEdep;
end

E=PFLU(:,1);Afluence=PFLU(:,2);Bfluence=PFLU(:,3);Cfluence=PFLU(:,4);
PolynomialFluence=table(E,Afluence,Bfluence,Cfluence);

E=PFLU(:,1);AEdep=PEDEP(:,2);BEdep=PEDEP(:,3);CEdep=PEDEP(:,4);
PolynomialEnergyDeposited=table(E,AEdep,BEdep,CEdep);