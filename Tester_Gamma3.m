clear all
close all

%%
Dc1Profile = createEmptyCG2D(1,1, 3, 3);
Dc1Profile.data = [1 3 1;3 5 3;1 3 1];
Dm1Profile = createEmptyCG2D(1,1, 3, 3);
Dm1Profile.data = [300 3 1;5 6 4;1 2 40];
[G1] = Gamma3(Dc1Profile,Dm1Profile);

%% Comparativa imgaussfilt-gaussiana

beamProfile = createGaussProfile(0.2,0.2, 20, 20, 5, 5);
[imgaussfiltProfile, gaussProfile] = createBeamProfileFromImg(0.2, 0.2, 20,20, 5, beamProfile.data);
[G2] = Gamma3(imgaussfiltProfile, gaussProfile);

%% Comparativa diferente bineado

beamProfile1 = createGaussProfile(0.2,0.2, 20, 20, 5, 5);
beamProfile2 = createGaussProfile(0.3,0.3, 20, 20, 5, 5);
[G3] = Gamma3(beamProfile1, beamProfile2);


