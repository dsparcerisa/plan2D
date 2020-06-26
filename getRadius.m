function [Rx,Ry] = getRadius(beamProfile)
% Creates position matriices por a beam Profile
x = [beamProfile.minX : beamProfile.dx : beamProfile.maxX];
y = [beamProfile.minY : beamProfile.dy : beamProfile.maxY];
Rx = repmat(x,beamProfile.NY,1);
Ry = repmat(y',1,beamProfile.NX);