function [FluenceProfile] = createFluenceProfile(dx,dy, sizeX, sizeY,sigmaX,sigmaY,X0,Y0)
% Creates a gaussian fluence profile

FluenceProfile = createGaussProfile(dx,dy, sizeX, sizeY, sigmaX, sigmaY,X0,Y0);