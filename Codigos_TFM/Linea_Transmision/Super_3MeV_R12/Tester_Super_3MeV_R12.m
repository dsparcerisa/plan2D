clear all
close all

%[DFN,COMGXFN] = Super_DoseFileNameX0;
%[DFN,COMGXFN] = Super_DoseFileNameX1;
%[DFN,COMGXFN] = Super_DoseFileNameX2;
%[DFN,COMGXFN] = Super_DoseFileNameY1;
%[DFN,COMGXFN] = Super_DoseFileNameY2;
[DFN,COMGXFN] = Super_DoseFileNameMega;
%%
ResidueXY = nan(length(DFN),2);
PolyX = nan(length(DFN),3);
PolyY = nan(length(DFN),3);

for i = 1 : length(COMGXFN);
    [Res,polyX,polyY] = getSuperResidue(DFN(i,:));
    ResidueXY(i,:) = Res;
    PolyX(i,:) = polyX(:,:,1);
    PolyY(i,:) = polyY(:,:,1);
end
TABLA = table(COMGXFN,ResidueXY,PolyX,PolyY)
