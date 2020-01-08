clear all
dxy=0.01;
sizeX=10;
sizeY=10;
sigmaX=5;
sigmaY=5;
beamProfile = createGaussProfile(dxy, sizeX, sizeY, sigmaX, sigmaY);
imagesc(beamProfile.data);