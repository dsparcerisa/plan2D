clear all
close all

%% Import Data

[Dose, Dose_STD, x, y, z] = importData('Dose_MG_3D-0.35-0.75-0.12-0.12-0.5-0.5.csv');
%%
    X = sum(Dose(:,:,227),2);
    X_norm = X/sum(X);
    X_STD = sum(Dose_STD(:,:,227),2);
    X_STD_norm = X_STD/sum(X_STD);
    
    maskX = X_norm > 0.1;
    xx = x(maskX);
    FWHMX = [(abs(min(xx))+abs(max(xx))),0.2]; 

    Y = sum(Dose(:,:,227),1);
    Y_norm = Y/sum(Y);
    Y_STD = sum(Dose_STD(:,:,227),1);
    Y_STD_norm = Y_STD/sum(Y_STD);
    
    maskY = Y_norm > 0.1;
    yy = y(maskY);
    FWHMY = [(abs(min(yy))+abs(max(yy))),0.2];

 
figure(2)
subplot(2,2,[1 2])
imagesc(x,y,Dose(:,:,227))
grid on
subplot(2,2,3)
errorbar(x,X_norm,X_STD_norm,'r.')
grid on
subplot(2,2,4)
errorbar(y,Y_norm,Y_STD_norm,'b.')

grid on
set((2),'Position', [0 0 800 600]);