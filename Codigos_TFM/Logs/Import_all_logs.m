clear all
MyFolderInfo = dir('Logs');
for i = 3:159;
    filename = MyFolderInfo(i).name;
    filename2 = ['Logs/',filename];
    [tbl_Datos,j] = tipos_logs(filename2);
    if j == 0  %Set 1 for FLASH and 0 for non_FLASH
    filename3 = ['tabl_',filename(1:26)];
    str = [filename3,'=tbl_Datos;'];
    eval(str);
    end
        
end

clear i j filename filename2 filename3 MyFolderInfo str tbl_Datos