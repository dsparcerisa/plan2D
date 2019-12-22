function [pflu,pEdep]=Sigmapolynomial(flu,Edep)
NR = 100;
NZ=2000;
dR = 0.01;
dZ = 0.02;


flu = reshape(flu, [NZ NR]);
Edep = reshape(Edep, [NZ NR]);

% Calculate Range
sumEdep=sum(Edep,2);
NZ=Range(sumEdep);

flu=flu(1:NZ,:);
Edep=Edep(1:NZ,:);

Rvalues = dR*(1:NR) - dR/2;
Zvalues = dZ*(1:NZ) - dZ/2;


%% Fit
Sflu = nan(1, NZ);
SEdep = nan(1, NZ);
maxFitIgnored = 0;
for i=1:NZ
    try
        F1 = fit(Rvalues', flu(i,:)', 'gauss1');
        Sflu(i) = F1.c1 / sqrt(2);        
    catch
        maxFitIgnored = i;
    end
end
maxFitIgnored = maxFitIgnored + 15;
Sflu(1:maxFitIgnored) = dR;
fprintf('Ignoring fits at positions Z <= %f... \n', Zvalues(maxFitIgnored));

% pflu=polyfit(Zvalues,Sflu,2); %% polyfit no permite restringir valores
F = fit(Zvalues', Sflu', 'poly2', 'Lower', [0 0 0]);
pflu = coeffvalues(F);

%% Sigma for the Edep

for i=1:NZ
    try
        F1 = fit(Rvalues', Edep(i,:)', 'gauss1');
        SEdep(i) = F1.c1 / sqrt(2);        
    catch
        maxFitIgnored = i;
    end
end
maxFitIgnored = maxFitIgnored + 15;
SEdep(1:maxFitIgnored) = dR;
fprintf('Ignoring fits at positions Z <= %f... \n', Zvalues(maxFitIgnored));

F=fit(Zvalues',SEdep','poly2', 'Lower', [0 0 0]);
pEdep = coeffvalues(F);



