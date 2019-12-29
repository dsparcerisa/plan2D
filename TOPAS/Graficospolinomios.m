%Import the Fluence, the Edep and the interpolated polynomials for the simulated energies if it has not
%been done yet

%tablepolinomia
PFLU=[PolynomialFluence.E,PolynomialFluence.Afluence,PolynomialFluence.Bfluence,PolynomialFluence.Cfluence];
PEDEP=[PolynomialEnergyDeposited.E,PolynomialEnergyDeposited.AEdep,PolynomialEnergyDeposited.BEdep,PolynomialEnergyDeposited.CEdep];
NZ=2000;
dZ=0.02;
Zvalues = dZ*(1:NZ) - dZ/2;
figure
for i=1:10;
    SfluInterp=polyval(PFLU(i,2:4),Zvalues);
    plot(Zvalues,SfluInterp)
    hold on
end
title('Fluence');
xlabel('Z(cm)');
ylabel('Sigma(cm)');
legend('1MeV','2MeV','3MeV','4MeV','5MeV','6MeV','7MeV','8MeV','9MeV','10MeV');
figure
for i=1:10;
    SEdepInterp=polyval(PEDEP(i,2:4),Zvalues);
    plot(Zvalues,SEdepInterp)
    hold on
end
title('Energy Deposited');
xlabel('Z(cm)');
ylabel('Sigma(cm)');
legend('1MeV','2MeV','3MeV','4MeV','5MeV','6MeV','7MeV','8MeV','9MeV','10MeV');



