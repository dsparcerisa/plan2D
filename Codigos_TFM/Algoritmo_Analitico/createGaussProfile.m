function beamProfile = createGaussProfile(dx,dy, sizeX, sizeY, sigmaX, sigmaY,X0,Y0)
% CG2D beamProfile = createPinHole(double dxy, double sizeX, 
%   double sizeY, double sigmaX, double sigmaY) 
% Creates a CG2D object contaning a beam profile with Gaussian shape
% and given sigmaX / sigmaY values. Sum is NORMALIZED to 1.
beamProfile = createEmptyCG2D(dx,dy, sizeX, sizeY);
Xvalues = beamProfile.getAxisValues('X');
Yvalues = beamProfile.getAxisValues('Y');
[X,Y]=meshgrid(Xvalues,Yvalues);      
beamProfile.data = exp(-((X-X0).^2/(sqrt(2)*sigmaX)^2)-((Y-Y0).^2/(sqrt(2)*sigmaY)^2));
beamProfile.data = (beamProfile.data / sum(beamProfile.data(:)))';
end

