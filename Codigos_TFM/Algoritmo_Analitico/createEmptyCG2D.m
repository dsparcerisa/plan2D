function emptyCG2D = createEmptyCG2D(dx,dy, sizeX, sizeY)
% CG2D emptyCG2D = createEmptyCG2D(double dxy, double sizeX, double sizeY)
NX = round(sizeX/dx);
NY = round(sizeY/dy);
maxX = (NX*dx/2) - dx/2;
maxY = (NY*dy/2) - dy/2;
emptyCG2D = CartesianGrid2D(-maxX,maxX,-maxY,maxY,dx,dy,NX,NY);
end

