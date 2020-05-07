%clear all
fileName = 'Edep_PhantomXY.csv';
[X, Y, Z, Edep] = importfile(fileName);

NX = 100;
NY = 100;
NZ = 100;
dz = 0.1;
dx = 0.01;
dy = 0.01;

% Reshape correctly
X = permute(reshape(X, [NZ NY NX]), [3 2 1]);
Y = permute(reshape(Y, [NZ NY NX]), [3 2 1]);
Z = permute(reshape(Z, [NZ NY NX]), [3 2 1]);
Edep = permute(reshape(Edep, [NZ NY NX]), [3 2 1]);
% clearvars X Y Z;

x = dx * (0:(NX-1));
y = dy * (0:(NY-1));
z = 10 - dz * (0:(NZ-1));

%% Try plots
hold off
yyaxis left
plot(z, squeeze(sum(sum(Edep,1),2)));

%% Define sigmaX and sigmaY
sigmasX = nan(NZ, 1);
sigmasY = nan(NZ, 1);

for i=1:NZ
    Xsum = sum(Edep(:,:,i),2);
    Ysum = sum(Edep(:,:,i),1);
    Fx = fit(x', Xsum, 'gauss1');
    sigmasX(i) = Fx.c1 / sqrt(2);
    Fy = fit(y', Ysum', 'gauss1');
    sigmasY(i) = Fy.c1 / sqrt(2);    
end
yyaxis right
plot(z, sigmasX, 'r-');
hold on
plot(z, sigmasY, 'r:');