function [FluenceProfile] = createFluenceProfile(dx,dy, sizeX, sizeY, E0, z)
% Creates a gaussian fluence profile

load('polyFlu')
[sigmaX, sigmaY] = getSigma(polyFlu, E0, z);
FluenceProfile = createGaussProfile(dx,dy, sizeX, sizeY, sigmaX, sigmaY);