function NZAll=Rangeallenergies(E)
%E must be the matrix from Importallenergies
NZAll=nan(1,10);
for j=1:10;
    Ei=E(:,j);
    NZ=0;
    for i=1:length(Ei);    
     if Ei(i)==0;
         break
     end
     NZ=NZ+1;
    end
    NZAll(j)=NZ;
end