function [G] = Gamma3(DcProfile,DmProfile)
% Generates the Gamma matrix for qualitative evaluations of dose
% distributions. Source: Low, Daniel A., et al. "A technique for the quantitative evaluation of dose distributions." Medical physics 25.5 (1998): 656-661.
% The bin Profile must be in mm and the dose must be relative
%%
[Rcx,Rcy] = getRadius(DcProfile);
[Rmx,Rmy] = getRadius(DmProfile);
%%
Dc = DcProfile.data;
Dm = DmProfile.data;
ADm = 1; % Percentage
Adm = 1; % mm
G = nan(DmProfile.NY,DmProfile.NX);
%%
for i = 1:numel(G);
    rmi = [Rmx(i) Rmy(i)];
    Dmi = Dm(i);
    T = nan(DcProfile.NY,DcProfile.NX);
    for j = 1:numel(T);
        rcj = [Rcx(j) Rcy(j)];
        Dcj = Dc(j);
        r = sqrt(sum((rcj-rmi).^2));
        d = Dcj-Dmi;
        T(j) = sqrt((r/Adm)^2+(d/ADm)^2);
    end
    G(i) = min(min(T));
end