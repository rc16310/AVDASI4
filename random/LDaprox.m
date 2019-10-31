close all; clear all;

WingLoading = 5089;%*57080/61209;
%K = 0.0334;
AR = 17.5; 

K = 1/(pi*AR*0.9225);
CD_0 = 0.0197;
%CD_0 = 0.0498;
CL_max = 3;
[T,a,P,rho] = atmosisa(ft2m(29000));

V = 60:0.1:200;
dynP = 0.5*rho.*V.^2;

CL = WingLoading./dynP;
D_i = K*CL.^2.*dynP;
D_p = CD_0*dynP;
figure(1)
plot(V,D_i,V,D_p,V,D_p+D_i)
axis([60 200 0 800])

figure(2)
plot(V,CL)
    
CD = CD_0*ones(size(CL)) + K.*CL.^2;

LoD = CL./CD;
[maxLD,V_maxLD] = max(LoD);

figure(3)
plot(CD,CL) 
axis([0 0.2 0 3])
disp(['Max L/D is ' num2str(maxLD) ' at V = ' num2str(V(V_maxLD)) ' m/s'])
