clear all
close all

[DFN,COMGXFN] = Super_DoseFileName;
%%
numbfig = [ones(1,20)];
numbsubfig = [1:20];
for j = 2 : 45;
    numbfig = [numbfig,j.*ones(1,20)];
    numbsubfig = [numbsubfig,1:20];
end
ResidueXY = nan(100,2);
LinearX = nan(100,2);
Xx0 = nan(100,1);
LinearY = nan(100,2);
Yx0 = nan(100,1);

for i = 1 : length(COMGXFN);
    [residue,linearX,linearY] = INFINITY(DFN(i,:),COMGXFN(i),numbfig(i),numbsubfig(i));
    ResidueXY(i,:) = residue;
    LinearX(i,:) = linearX;
    Xx0(i) = -linearX(2)/linearX(1);
    LinearY(i,:) = linearY;
    Yx0(i) = -linearY(2)/linearY(1);
end
table(COMGXFN,ResidueXY,LinearX,Xx0,LinearY,Yx0)
