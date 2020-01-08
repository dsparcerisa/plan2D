function beamProfile = createGaussProfile(dxy, sizeX, sizeY, sigmaX, sigmaY)
% CG2D beamProfile = createPinHole(double dxy, double sizeX, 
%   double sizeY, double sigmaX, double sigmaY) 
% Creates a CG2D object contaning a beam profile with Gaussian shape
% and given sigmaX / sigmaY values. Sum is NORMALIZED to 1.
emptyCG2D = createEmptyCG2D(dxy, sizeX, sizeY);
Xvalues = [emptyCG2D.minX]:[emptyCG2D.dx]:[emptyCG2D.maxX];
Yvalues = [emptyCG2D.minY]:[emptyCG2D.dy]:[emptyCG2D.maxY];
[X,Y]=meshgrid(Xvalues,Yvalues);
X0=Xvalues(length(Xvalues)/2);
Y0=Yvalues(length(Yvalues)/2);             
data=exp(-((X-X0).^2/(sqrt(2)*sigmaX)^2)-((Y-Y0).^2/(sqrt(2)*sigmaY)^2));
beamProfile = CartesianGrid2D(emptyCG2D.minX,emptyCG2D.maxX,emptyCG2D.minY,emptyCG2D.maxY,emptyCG2D.dx,emptyCG2D.dy,emptyCG2D.NX,emptyCG2D.NY,data);
end

