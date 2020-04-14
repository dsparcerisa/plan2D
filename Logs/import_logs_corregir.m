%irrLog_2020_02_06_10_55_51
%[10:56:09.176] Moving to: [-1.944 -1.147 0.000]
%[10:56:14.886] Moving to: [-1.944 -1.147 0.000]
%[10:56:15.376] Arrived at: [-1.944 -1.147 0.000]
%[10:56:15.947] Open shutter for 0.040s
%[10:56:16.018] Shutter closed.

Numero_exposiciones = 1;
Tiempo_apertura_teorico = 0.040;
Apertura_s = 10*360+60*56+15.947;
Cierre_s = 10*360+60*56+16.018;
Moving_to_cm = [-1.944 -1.147 0.000];
Moving_to_s = 10*360+60*56+14.886;
Arrived_at_cm = [-1.944 -1.147 0.000];
Arrived_at_s = 10*360+60*56+15.376;


tabl_irrLog_2020_02_06_10_55_51 = table(Numero_exposiciones,Tiempo_apertura_teorico,Apertura_s,Cierre_s,Moving_to_cm,Moving_to_s,Arrived_at_cm,Arrived_at_s);
clear Tiempo_apertura_teorico Apertura_s Cierre_s Moving_to_cm Moving_to_s Arrived_at_cm Arrived_at_s Numero_exposiciones