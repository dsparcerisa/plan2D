function [sigmaX, sigmaY] = getSigma(PX,PY, E0, z, dTarget)
% double sigma = getSigma (10x3x2 double P, double E0, double z)
% Returns sigma in mm from initial energy E0 (MeV) and distance z (cm)
% P and must be a ix3x2 matrix where the each row corresponds to an energy
% (E0 must be included)
%The columns are the coefficients of the sigma(Z) polynomial for each energy. The second matrix are the errors.


sigmaX = nan(1,2);
sigmaY = nan(1,2);

    
sigmaX(1) = polyval(PX(E0,:,1),z);
sigmaX(2) = rssq([z^2 z 1 (2*z*PX(E0,1,1)+PX(E0,2,1))].*[PX(E0,:,2) dTarget/2]);

sigmaY(1) = polyval(PY(E0,:,1),z);
sigmaY(2) = rssq([z^2 z 1 (2*z*PY(E0,1,1)+PY(E0,2,1))].*[PY(E0,:,2) dTarget/2]);
    

   


