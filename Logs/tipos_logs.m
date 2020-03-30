function [tbl_Datos] = tipos_logs(filename)

filetext = fileread(filename);

%Posición de cada toma
P = regexp(filetext,'\n\n')+2; %Principio
F = P-3; %Final
A = [P(1:length(P)-1)',F(2:length(P))']; %Localización de cada una de las tomas
[n,l] = size(A);
Toma_text1 = filetext(A(1,1):A(1,2));%Texto de la toma 1
Moving = regexp(Toma_text1,'Moving');
[u,v] = size(Moving);
Toma_text2 = filetext(A(2,1):A(2,2));%Texto de la toma 2
r = length(regexp(Toma_text2,'r'));




if r == 5;
    if v == 1;
        tbl_Datos = importar_log(filename);
    elseif v == 2;
        tbl_Datos = importar_log2(filename);
    end
elseif r == 3;
        if v == 1;
        tbl_Datos = importar_log_FLASH(filename);
    elseif v == 2;
        tbl_Datos = importar_log2_FLASH(filename);
        end
end
    
        
    