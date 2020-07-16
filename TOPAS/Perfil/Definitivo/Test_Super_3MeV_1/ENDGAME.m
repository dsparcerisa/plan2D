clear all
close all

[DFN,COMGXFN] = Super_DoseFileNameY2;
%%
numbfig = [ones(1,20)];
numbsubfig = [1:20];
for j = 2 : 45;
    numbfig = [numbfig,j.*ones(1,20)];
    numbsubfig = [numbsubfig,1:20];
end
ResidueXY = nan(length(DFN),2);
Res = nan(length(DFN),1);
LinearX = nan(length(DFN),2);
Xx0 = nan(length(DFN),1);
LinearY = nan(length(DFN),2);
Yx0 = nan(length(DFN),1);

for i = 1 : length(COMGXFN);
    [residue,linearX,linearY,X0,Y0] = INFINITY(DFN(i,:),COMGXFN(i),numbfig(i),numbsubfig(i));
    ResidueXY(i,:) = residue;
    Res(i) = rssq(residue);
    LinearX(i,:) = linearX;
    Xx0(i) = X0;
    LinearY(i,:) = linearY;
    Yx0(i) = Y0;
end
TABLA=table(COMGXFN,Res,ResidueXY,LinearX,Xx0,LinearY,Yx0)
