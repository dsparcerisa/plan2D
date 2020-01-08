function [Sigmaflu,SigmaEdep]=SigmaZE(PFLU,PEDEP,Z,E)
%PFLU and PEDEP must 10x4 matrices where the first column is an array
%containing the energies. The second, thrid and fourth coluumn must be each
%coefficient of the sigma(Z) polynomial for each energy. 

%Interpolated polynomials for E
Ainterpflu=interp1(PFLU(:,1),PFLU(:,2),E);
Binterpflu=interp1(PFLU(:,1),PFLU(:,3),E);
Cinterpflu=interp1(PFLU(:,1),PFLU(:,4),E);
pinterpflu=[Ainterpflu,Binterpflu,Cinterpflu];

AinterpEdep=interp1(PEDEP(:,1),PEDEP(:,2),E);
BinterpEdep=interp1(PEDEP(:,1),PEDEP(:,3),E);
CinterpEdep=interp1(PEDEP(:,1),PEDEP(:,4),E);
pinterpEdep=[AinterpEdep,BinterpEdep,CinterpEdep];
    
%Caluclation of Sigma in the Z plane    
Sigmaflu=polyval(pinterpflu,Z);
SigmaEdep=polyval(pinterpEdep,Z);

