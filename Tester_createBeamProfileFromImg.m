clear all
close all
dx=0.01;
dy=0.01;
sizeX=10;
sizeY=10;
sigmaX=5;
sigmaY=5;
%la imagen la estoy sacando del perfil gaussiano
beamProfile = createGaussProfile(dx,dy, sizeX, sizeY, sigmaX, sigmaY);
imgPath=beamProfile.data;
sigmaXY=7;
beamProfile = createBeamProfileFromImg(dx,dy, sizeX, sizeY, sigmaXY,imgPath);
Xvalues = [beamProfile.minX]:[beamProfile.dx]:[beamProfile.maxX];
Yvalues = [beamProfile.minY]:[beamProfile.dy]:[beamProfile.maxY];
figure
subplot(1,2,1);
imagesc(Xvalues,Yvalues,imgPath);
title('Original');
xlabel('X(cm)');
ylabel('Y(cm)');
subplot(1,2,2);
imagesc(Xvalues,Yvalues,beamProfile.data);
title('ImgaussFilt');
xlabel('X(cm)');
ylabel('Y(cm)');