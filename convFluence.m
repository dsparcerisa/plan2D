function NZ = convFluence(N0, sigma)
% CartesianGrid2D NZ = convFluence(CartesinGrid2D N0, double sigma)
% Returns 2D fluence distribution as a CartesianGrid2D object, 
% from initial distribution No (also as CG2S), convoluted
% with sigma in cm.
NZ = CartesianGrid2D(N0); 
NZ.data = imgaussfilt(N0.data, sigma/N0.dx);
NZ.data = NZ.data / sum(NZ.data(:)); % Renormalizar
end

