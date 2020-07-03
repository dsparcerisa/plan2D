function [FluenceProfile] = createFluenceProfile(dx,dy, sizeX, sizeY,sigmaX,sigmaY)
% Creates a gaussian fluence profile

FluenceProfile = createGaussProfile(dx,dy, sizeX, sizeY, sigmaX, sigmaY);