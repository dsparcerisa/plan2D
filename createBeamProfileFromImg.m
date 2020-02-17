function [beamProfile, beamProfile2] = createBeamProfileFromImg(dx, dy, sizeX, sizeY, sigmaXY, imgPath)
% CG2D beamProfile = createBeamProfileFromImg(double dxy, double sizeX,
%   double sizeY, XXX imgPath)
% Creates a CG2D object contaning a beam profile from given data.
% Specific implementation to be decided. Sum is NORMALIZED to 1.
if dx~=dy
    warning('dx must be equal to dy');
else
    tic
    emptyCG2D = createEmptyCG2D(dx, dy, sizeX, sizeY);
    data = imgaussfilt(imgPath,sigmaXY/dx);
    beamProfile = CartesianGrid2D(emptyCG2D.minX,emptyCG2D.maxX,emptyCG2D.minY,emptyCG2D.maxY,emptyCG2D.dx,emptyCG2D.dy,emptyCG2D.NX,emptyCG2D.NY,data);
    beamProfile.data = beamProfile.data / sum(beamProfile.data(:));
    toc
    
    tic
    beamProfile2 = createEmptyCG2D(dx, dy, sizeX, sizeY);
    gaussProfile = createGaussProfile(dx, dy, sizeX, sizeY, sigmaXY, sigmaXY);
    beamProfile2.data = conv2(imgPath, gaussProfile.data, 'same');
    beamProfile2.data = beamProfile2.data / sum(beamProfile2.data(:));
    toc
end
end

