%% Code to generate graphs of wing loading vs thrust requirements from specs for Turboprops
close all; clear all

%% Setup - move all aircraft factors here
% Aircraft values

% Extras
g               = 9.81; %[m/s^2]


% Initial graph vectors
xWingLoading    = linspace(0,7000,300); %[N/m^2]
yThrust2Weight  = linspace(0,0.8,300); %[-]
legend_string   = "";

%% Stall Speed Requirement - MLW, SL, ISA

[T0,a0,P0,rho0] = atmosisa(0);

MTOW            = 61209 ;           %[kg]
V_stall         = kts2mps(140)/1.3 ;    %[m/s]
CLmax           = 3 ;               %[-]

SS_WL           = 0.5*rho0*V_stall^2*CLmax; %[N/m^2]

%line
Line1x          = [SS_WL; SS_WL];
Line1y          = [0 max(yThrust2Weight)];  
legend_string(1)= "Stall Speed - met to the left";

%% Maximum Speed Requirement
alt_cruise      = ft2m(30000); %[m] flight ceiling
[T_C,a_C,P_C,rho_C]     = atmosisa(alt_cruise);
rhoRatio        = rho_C/rho0; %[-]

V_max           = correctairspeed(kts2mps(250),a_C,P_C,'CAS','TAS'); %[m/s]
eta_P           = 0.82; %[-] guess
C_D0            = 0.023; %[-] est from a320 drag data - clean wing
K               = 0.0334; %[-] est from a320 drag data
Line2y          = 0.5*rho0*V_max^2*C_D0./xWingLoading + 2*K/(rho_C*rhoRatio*V_max^2).*xWingLoading;
Line2x          = xWingLoading;
legend_string(2)= "Max Speed - met above";


%% Take off Requirement
C_L_TO          = 0.7 + 0.8; % complete guess - book suggests CL_cruise ~ 0.3 plus CL_Flaps_TO ~ 0.3-0.8
C_D0_TO         = 0.078; %[-] est from a320 drag data - TO
mu              = 0.05; %[-]
C_D_G           = C_D0_TO - mu*C_L_TO; %[-]
V_rot           = V_stall*1.2; %[m/s]
C_L_R           = 2/(rho0*V_rot^2)*9.81*MTOW/118;%*xWingLoading; %[-]
S_TO            = 2000 ;%[m]

TO_dist_num     = mu - (mu + C_D_G./C_L_R).*exp(0.6*rho0*g*C_D_G*S_TO./xWingLoading);
TO_dist_denom   = 1-exp(0.6*rho0*g*C_D_G*S_TO./xWingLoading);

Line3y          = TO_dist_num./TO_dist_denom;
Line3x          = xWingLoading;
legend_string(3)= "Take off length - met above";

%% ROC at Cruise Ceiling Requirement
ROC_req         = ft2m(300/60); %[m/s](alt_cruise - ft2m(1500))/(25*60);
L_D_max         = 18;

Line4y          = ROC_req./sqrt(xWingLoading*2/(rho_C*sqrt(C_D0/K)))+1/L_D_max;
Line4x          = xWingLoading;
legend_string(4)= "Cruise Ceiling ROC - met above";

%% Plotting
figure(1)
hold on
plot(Line1x,Line1y)
plot(Line2x,Line2y)
plot(Line3x,Line3y)
plot(Line4x,Line4y)
legend(legend_string)

axis([min(xWingLoading) max(xWingLoading) min(yThrust2Weight) max(yThrust2Weight)])
xlabel('Wing Loading [N/m^2]')
ylabel('Thrust to Weight Ratio [-]')




