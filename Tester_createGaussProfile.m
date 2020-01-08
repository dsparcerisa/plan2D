clear all
close all
dx=0.01;
dy=0.01;
sizeX=10;
sizeY=10;
sigmaX=5;
sigmaY=5;
beamProfile = createGaussProfile(dx,dy, sizeX, sizeY, sigmaX, sigmaY);
Xvalues = [beamProfile.minX]:[beamProfile.dx]:[beamProfile.maxX];
Yvalues = [beamProfile.minY]:[beamProfile.dy]:[beamProfile.maxY];
imagesc(Xvalues,Yvalues,beamProfile.data);
title('Gaussian Profile');
xlabel('X(cm)');
ylabel('Y(cm)');