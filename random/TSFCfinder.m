[T,a,P,rho]     = atmosisa(ft2m(30000));
V               = a*0.49;
CD0             = 0.0197;
S               = 118;
AR              = 17.5;
e               = 0.9225;
k               = 1/(pi*AR*e);
CL              = 2*56260*9.81/(rho*S*V^2);
CD              = CD0 + k*CL^2;
D               = CD * 0.5 * rho * S * V^2;
T_per_eng       = D/2;


[mach,alt,throt]=meshgrid([0.4 0.5],[25000 30000],[0 1]);

Tsettings(:,:,1) = [8896 8896; 6227 4448];
Tsettings(:,:,2) = [13010 12276; 9434 9176];
%Tsettings(:,:,1) = [0.0419 0.0490; 0.0422 0.0506];
%Tsettings(:,:,2) = [0.0399 0.0472; 0.0395 0.0467];


out = interp3(mach,alt,throt,Tsettings*1.18,0.49,29000,0.87) %*2.20462/0.224809

