clear all
MyFolderInfo = dir('Logs');
for i = 4:160;
    filename = MyFolderInfo(i).name;
    filename2 = ['Logs/',filename];
    tbl_Datos = tipos_logs(filename2);
    filename3 = ['tabl_',filename(1:26)];
    str=[filename3,'=tbl_Datos;'];
    eval(str);
    
end

clear i filename filename2 filename3 MyFolderInfo str tbl_Datos