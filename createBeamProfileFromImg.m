function beamProfile = createBeamProfileFromImg(dx,dy, sizeX, sizeY, sigmaXY,imgPath)
% CG2D beamProfile = createBeamProfileFromImg(double dxy, double sizeX, 
%   double sizeY, XXX imgPath) 
% Creates a CG2D object contaning a beam profile from given data. 
% Specific implementation to be decided. Sum is NORMALIZED to 1.
if dx~=dy
    warning('dx must be equal to dy');
else
    emptyCG2D = createEmptyCG2D(dx,dy, sizeX, sizeY);
    data= imgaussfilt(imgPath,sigmaXY/dx); 
    beamProfile = CartesianGrid2D(emptyCG2D.minX,emptyCG2D.maxX,emptyCG2D.minY,emptyCG2D.maxY,emptyCG2D.dx,emptyCG2D.dy,emptyCG2D.NX,emptyCG2D.NY,data);    
end
end

