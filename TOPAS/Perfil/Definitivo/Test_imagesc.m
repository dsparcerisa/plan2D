clear all
close all
EdepFileName = 'Edep_3MeV_NO_PP.csv';
Edep_STDFileName = 'Edep_STD_3MeV_NO_PP.csv';
CodeFileName = 'Test_8MeV_NO_DIF.txt';

%% Import Data
[Edep, Edep_STD, NX, NY, NZ, dx, dy, dz, Spread, AngularSpread, MagneticGradient1,MagneticGradient2, energy] = importData(EdepFileName,Edep_STDFileName,CodeFileName);

 %Reshape 
Edep = permute(reshape(Edep, [NZ NY NX]), [3 2 1]);
Edep_STD = permute(reshape(Edep_STD, [NZ NY NX]), [3 2 1]);

%% Bin positions
x = dx * [-(NX/2-1/2):(NX/2-1/2)]*10;
y = dy * [-(NY/2-1/2):(NY/2-1/2)]*10;
z = dz * [NZ-1/2:-1:1/2];
%%
figure(4)
subplot(4,4,1)
imagesc(x,y,Edep(:,:,500))
title('z_{cannon}=0.1 cm')
subplot(4,4,2)
imagesc(x,y,Edep(:,:,499))
title('z_{cannon}=0.3 cm')
subplot(4,4,3)
imagesc(x,y,Edep(:,:,498))
title('z_{cannon}=0.5 cm')
subplot(4,4,4)
imagesc(x,y,Edep(:,:,495))
title('z_{cannon}=1.1 cm')
subplot(4,4,5)
imagesc(x,y,Edep(:,:,400))
title('z_{cannon}=20.1 cm')
subplot(4,4,6)
imagesc(x,y,Edep(:,:,347))
title('Q1; z_{cannon}=30.7 cm')
subplot(4,4,7)
imagesc(x,y,Edep(:,:,311))
title('z_{cannon}=37.9 cm')
subplot(4,4,8)
imagesc(x,y,Edep(:,:,280))
title('Q2; z_{cannon}=44.1 cm')
subplot(4,4,9)
imagesc(x,y,Edep(:,:,210))
title('z_{Cannon}=58.1 cm')
subplot(4,4,10)
imagesc(x,y,Edep(:,:,169))
title('Nozzle; z_{Cannon}=66.3 cm')
subplot(4,4,11)
imagesc(x,y,Edep(:,:,154))
title('z_{air}=2.1 cm')
subplot(4,4,12)
imagesc(x,y,Edep(:,:,145))
title('z_{air}=4.9 cm')
subplot(4,4,13)
imagesc(x,y,Edep(:,:,138))
title('z_{air}=6.3 cm')
subplot(4,4,14)
imagesc(x,y,Edep(:,:,130))
title('z_{air}=7.9 cm')
subplot(4,4,15)
imagesc(x,y,Edep(:,:,122))
title('z_{air}=9.5 cm')
subplot(4,4,16)
imagesc(x,y,Edep(:,:,115))
title('z_{air}=10.9 cm')
set((4),'Position', [0 0 800 600]);