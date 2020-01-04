function [Sigmaflu,SigmaEdep]=SigmaZETester(tblflu,tblEdep,Z,E)
%The Tester eliminates the polynomial of the E energy and calcutes the
%Sigma for a Z plane by interpolating the polynomial with the other
%polynomials. Then calcultes the error by comparing the interpolated result
%with the Sigma calculated by evaluating the Z plane in the previously
%eliminated poluynomial

%Turn the tables into arrays
PFLU=[tblflu.E,tblflu.Afluence,tblflu.Bfluence,tblflu.Cfluence];
PEDEP=[tblEdep.E,tblEdep.AEdep,tblEdep.BEdep,tblEdep.CEdep];

%Calculation of the Sigma with the polynomial 
Sigmaflu1=polyval(PFLU(E,2:4),Z);
SigmaEdep1=polyval(PEDEP(E,2:4),Z);

%Elimination of the polynomial. Not posible to try 1 and 10 energies
PFLU=[PFLU(1:E-1,:);PFLU(E+1:10,:)];
PEDEP=[PEDEP(1:E-1,:);PEDEP(E+1:10,:)];
    
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
Sigmaflu2=polyval(pinterpflu,Z);
SigmaEdep2=polyval(pinterpEdep,Z);

%Sigma=[Sigma , Sigma interpolated, error]
Sigmaflu=[Sigmaflu1,Sigmaflu2,100*abs(1-Sigmaflu1/Sigmaflu2)];
SigmaEdep=[SigmaEdep1,SigmaEdep2,100*abs(1-SigmaEdep1/SigmaEdep2)];

