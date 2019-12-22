function NZ=Range(E)
NZ=0;
for i=1:length(E);    
    if E(i)==0;
        break
    end
    NZ=NZ+1;
end
    