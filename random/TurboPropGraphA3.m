%% Code to generate graphs for wing loading vs power requirements from specs for Turboprops
close all; clear all

%% Setup - move all aircraft factors here

% Aircraft values
MTOW            = 67000 ;           %[kg]
CLmax           = 2.45 ;               %[-]
alt_cruise      = ft2m(29000); %[m] flight ceiling

[T0,a0,P0,rho0]         = atmosisa(0);
[T_C,a_C,P_C,rho_C]     = atmosisa(alt_cruise);

rhoRatio        = rho_C/rho0; %[-]
M_max           = 0.52; %[-]
V_max           = a_C*(M_max+0.04); %[m/s]

% Extras
g               = 9.81; %[m/s^2]


% Initial graph vectors
xWingLoading    = linspace(0,7000,300); %[N/m^2]
yPowerLoading   = linspace(0,100e-3,300); %[N/W]
legend_string   = [""];
%% Stall Speed Requirement - MLW, SL, ISA



V_stall         = kts2mps(140)/1.1 ;    %[m/s]

SS_WL           = 0.5*rho0*V_stall^2*CLmax; %[N/m^2]
Line1x          = [SS_WL; SS_WL];
Line1y          = [0 max(yPowerLoading)];   
legend_string(1)= "Stall Speed - met to the left";
%% Maximum Speed Requirement



eta_P           = 0.82; %[-] guess
C_D0            = 0.023; %[-] est from a320 drag data - clean wing
K               = 0.0334; %[-] est from a320 drag data
Line2y          = eta_P./[0.5*rho0*V_max^3*C_D0./xWingLoading + 2*K/(rho_C*rhoRatio*V_max).*xWingLoading];
Line2x          = xWingLoading;
legend_string(2)= "Max Speed - met below";

%% Take off Requirement
C_L_TO          = 0.3 + 0.6; % complete guess - book suggests CL_cruise ~ 0.3 plus CL_Flaps_TO ~ 0.3-0.8
C_D0_TO         = 0.078; %[-] est from a320 drag data - TO
mu              = 0.04; %[-]
C_D_G           = C_D0_TO - mu*C_L_TO; %[-]
V_rot           = V_stall*1.2; %[m/s]
C_L_R           = 2/(rho0*V_rot^2)*9.81*MTOW/125;%*xWingLoading; %[-]
S_TO            = 2000 ; %[m]
V_TO            = V_rot; %[m/s] assumed same as V_rot but probs slightly higher

TO_dist_num     = 1-exp(0.6*rho0*g*C_D_G*S_TO./xWingLoading);
TO_dist_denom   = mu - (mu + C_D_G./C_L_R).*exp(0.6*rho0*g*C_D_G*S_TO./xWingLoading);

Line3y          = 
Line3x          = xWingLoading;
legend_string(3)= "Take off length - met below";

%% ROC at Cruise Ceiling Requirement
ROC_req         = ft2m(300/60); %[m/s] (alt_cruise - ft2m(1500))/(25*60);
L_D_max         = 18;

Line4y          = rhoRatio./[ROC_req/eta_P + sqrt(xWingLoading*2/(rho_C*sqrt(3*C_D0/K)))*(1.155/L_D_max/eta_P)];
Line4x          = xWingLoading;
legend_string(4)= "Cruise Ceiling ROC - met below";

%% Plotting
figure(1)
hold on

plot(Line1x,Line1y)
plot(Line2x,Line2y)
plot(Line3x,Line3y)
plot(Line4x,Line4y)
legend(legend_string)

axis([min(xWingLoading) max(xWingLoading) min(yPowerLoading) max(yPowerLoading)])
xlabel('Wing Loading [N/m^2]')
ylabel('Power Loading [N/W]')






