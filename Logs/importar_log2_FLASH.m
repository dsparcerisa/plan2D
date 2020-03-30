function  tbl_Datos=importar_log2_FLASH(filename)

%filename tiene que venir entre comillas

filetext = fileread(filename);

%Posición de cada toma
P = regexp(filetext,'\n\n')+2; %Principio
F = P-3; %Final
A = [P(1:length(P)-1)',F(2:length(P))']; %Localización de cada una de las tomas
[n,l] = size(A);

Numero_flash = nan(n,1);
Tiempo_apertura= nan(n,1);
Tiempo_cierre = nan(n,1);
Tiempo_posicion_inicial = nan(n,1);
Posicion_inicial = nan(n,3);
Tiempo_posicion_final = nan(n,1);
Posicion_final = nan(n,3);

for i = 1:n;
    
    if i==1;
    Toma_text = filetext(A(i,1):A(i,2)); %Texto de la toma i
    
    %Tiempo de exposición teorico
    [a,b] = regexp(Toma_text,'er: ');
    c = regexp(Toma_text,' FLASH');
    t = Toma_text(b+1:c-1);
    Numero_flash(i,1) = str2num(t);
    
    %Tiempo de exposición real
    a = regexp(Toma_text,'[');
    b = regexp(Toma_text,']');
        
        %Apertura
        Apertura_text = Toma_text([a(7)+1:b(7)-1]);
        sep = regexp(Apertura_text,':');
        h = Apertura_text(1:sep(1)-1);
        min = Apertura_text(sep(1)+1:sep(2)-1);
        seg = Apertura_text(sep(2)+1:length(Apertura_text));
        AP = 360*str2num(h)+60*str2num(min)+str2num(seg);
        Tiempo_apertura(i,1)=AP;
        %Cierre
        Cierre_text = Toma_text([a(8)+1:b(8)-1]);
        sep = regexp(Cierre_text,':');
        h = Cierre_text(1:sep(1)-1);
        min = Cierre_text(sep(1)+1:sep(2)-1);
        seg = Cierre_text(sep(2)+1:length(Cierre_text));
        CR = 360*str2num(h)+60*str2num(min)+str2num(seg);
        Tiempo_cierre(i,1) = CR;
    
    %Posiciones
        %Inicial
        
        Inicial_text = Toma_text([a(3)+1:b(3)-1]);
        sep = regexp(Inicial_text,':');
        h = Inicial_text(1:sep(1)-1);
        min = Inicial_text(sep(1)+1:sep(2)-1);
        seg = Inicial_text(sep(2)+1:length(Inicial_text));
        IN = 360*str2num(h)+60*str2num(min)+str2num(seg);
        
        
        Tiempo_posicion_inicial(i,1)=IN;
        
        %Vector Posición inicial
        Inicial_vector_text=Toma_text(a(4)+1:b(4)-1);
        Inicial_vec=str2num(Inicial_vector_text);
        Posicion_inicial(i,:)=Inicial_vec;
        
        %Final
        Final_text = Toma_text([a(5)+1:b(5)-1]);
        sep = regexp(Final_text,':');
        h = Final_text(1:sep(1)-1);
        min = Final_text(sep(1)+1:sep(2)-1);
        seg = Final_text(sep(2)+1:length(Final_text));
        IN = 360*str2num(h)+60*str2num(min)+str2num(seg);
        Tiempo_posicion_final(i,1)=IN;
        
        %Vector Posición final
        Final_vector_text=Toma_text(a(6)+1:b(6)-1);
        Final_vec=str2num(Final_vector_text);
        Posicion_final(i,:)=Final_vec;
    else
    Toma_text = filetext(A(i,1):A(i,2)); %Texto de la toma i
    
    %Tiempo de exposición teorico
    [a,b] = regexp(Toma_text,'er: ');
    c = regexp(Toma_text,' FLASH');
    t = Toma_text(b+1:c-1);
    Numero_flash(i,1) = str2num(t);
    
    %Tiempo de exposición real
    a = regexp(Toma_text,'[');
    b = regexp(Toma_text,']');
        
        %Apertura
        Apertura_text = Toma_text([a(5)+1:b(5)-1]);
        sep = regexp(Apertura_text,':');
        h = Apertura_text(1:sep(1)-1);
        min = Apertura_text(sep(1)+1:sep(2)-1);
        seg = Apertura_text(sep(2)+1:length(Apertura_text));
        AP = 360*str2num(h)+60*str2num(min)+str2num(seg);
        Tiempo_apertura(i,1)=AP;
        %Cierre
        Cierre_text = Toma_text([a(6)+1:b(6)-1]);
        sep = regexp(Cierre_text,':');
        h = Cierre_text(1:sep(1)-1);
        min = Cierre_text(sep(1)+1:sep(2)-1);
        seg = Cierre_text(sep(2)+1:length(Cierre_text));
        CR = 360*str2num(h)+60*str2num(min)+str2num(seg);
        Tiempo_cierre(i,1) = CR;
    
    %Posiciones
        %Inicial
        Inicial_text = Toma_text([a(1)+1:b(1)-1]);
        sep = regexp(Inicial_text,':');
        h = Inicial_text(1:sep(1)-1);
        min = Inicial_text(sep(1)+1:sep(2)-1);
        seg = Inicial_text(sep(2)+1:length(Inicial_text));
        IN = 360*str2num(h)+60*str2num(min)+str2num(seg);
        Tiempo_posicion_inicial(i,1)=IN;
        
        %Vector Posición inicial
        Inicial_vector_text=Toma_text(a(2)+1:b(2)-1);
        Inicial_vec=str2num(Inicial_vector_text);
        Posicion_inicial(i,:)=Inicial_vec;
        
        %Final
        Final_text = Toma_text([a(3)+1:b(3)-1]);
        sep = regexp(Final_text,':');
        h = Final_text(1:sep(1)-1);
        min = Final_text(sep(1)+1:sep(2)-1);
        seg = Final_text(sep(2)+1:length(Final_text));
        IN = 360*str2num(h)+60*str2num(min)+str2num(seg);
        Tiempo_posicion_final(i,1)=IN;
        
        %Vector Posición final
        Final_vector_text=Toma_text(a(4)+1:b(4)-1);
        Final_vec=str2num(Final_vector_text);
        Posicion_final(i,:)=Final_vec;  
    end
        
        
end
tbl_Datos = table([1:n]',Numero_flash,Tiempo_apertura,Tiempo_cierre,Posicion_inicial,Tiempo_posicion_inicial,Posicion_final,Tiempo_posicion_final);
tbl_Datos.Properties.VariableNames = {'Numero_exposiciones','FLASH_shots','Apertura_s','Cierre_s','XYZ_inicial_cm','Tiempo_posicion_inicial_s','XYZ_final_cm','Tiempo_posicion_final_s'};    