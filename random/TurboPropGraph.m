%% Code to generate graphs for wing loading vs power requirements from specs for Turboprops
close all; clear all

%% Setup - move all aircraft factors here

% Aircraft values
MTOW            = 61209;         %[kg]
CLmax           = 3 ;               %[-]
alt_cruise      = ft2m(29000); %[m] flight ceiling

[T_0,a_0,P_0,rho_0]         = atmosisa(0);
[T_C,a_C,P_C,rho_C]     = atmosisa(alt_cruise);

rhoRatio        = rho_C/rho_0; %[-]
M_cruise        = 0.54; %[-]
V_cruise        = a_C*M_cruise; %[m/s]
M_max           = M_cruise + 0.04; %[-]
V_max           = a_C*M_max; %[m/s]

% Extras
g               = 9.81; %[m/s^2]
etaPoly         = [0.03537,0.05957]; % polynomial for estimation of prop overall efficiency at various mach

% Initial graph vectors
xWingLoading    = linspace(0,8000,1000); %[N/m^2]
yPowerLoading   = linspace(0,150e-3,1000); %[N/W]
legend_string   = [""];
%% Stall Speed Requirement - MLW, SL, ISA



V_stall         = kts2mps(140)/1.3 ;    %[m/s]

SS_WL           = [1;1]*0.5*rho_0*V_stall^2*CLmax; %[N/m^2]
Line1x          = [SS_WL];
Line1y          = [0 max(yPowerLoading)];   
legend_string(1)= "Stall Speed - met to the left";
%% Maximum Speed Requirement



eta_P           = 0.82; %[-] guess
C_D0            = 0.0209; %[-] est from a320 drag data - clean wing
AR              = 17;
K               = 1/(pi*AR*0.9225); %[-] est from a320 drag data
Line2y          = PowerEtaLookup(M_max,alt_cruise)./[0.5*rho_C*V_max^3*C_D0./xWingLoading + 2*K/(rho_C*V_max).*xWingLoading];
Line2x          = xWingLoading;
legend_string(2)= "Max Speed - met below";

%% Take off Requirement
C_L_TO          = 1.5; % complete guess - book suggests CL_cruise ~ 0.3 plus CL_Flaps_TO ~ 0.3-0.8
C_D0_TO         = 0.078; %[-] est from a320 drag data - TO
mu              = 0.04; %[-] (0.05 wet runway, 0.02-0.04)
C_D_G           = C_D0_TO - mu*C_L_TO; %[-]
V_rot           = V_stall*1.1; %[m/s]
C_L_R           = 2/(rho_0*V_rot^2)*9.81*MTOW/118;%
S_TO            = 2000 ; %[m]
V_TO            = V_rot; %[m/s] assumed same as V_rot but probs slightly higher
M_TO            = V_TO/a_0;

TO_dist_num     = 1-exp(0.6*rho_0*g*C_D_G*S_TO./xWingLoading);
TO_dist_denom   = mu - (mu + C_D_G./C_L_R).*exp(0.6*rho_0*g*C_D_G*S_TO./xWingLoading);

Line3y          = TO_dist_num./TO_dist_denom * 0.67/V_TO; 
Line3x          = xWingLoading;
legend_string(3)= "Take off length - met below";

%% ROC at TO Requirement
ROC_req_TO      = 0.04*V_TO; %[m/s] (alt_cruise - ft2m(1500))/(25*60);
L_D_max         = 18;

Line4y          = PowerEtaLookup(M_TO,0)./[ROC_req_TO + sqrt(xWingLoading*2/(rho_0*sqrt(3*C_D0/K)))*(1.155/L_D_max)];
Line4x          = xWingLoading;
legend_string(4)= "TO ROC - met below";

%% ROC at Cruise Ceiling Requirement
ROC_req_C       = ft2m(300)/60; %[m/s] (alt_cruise - ft2m(1500))/(25*60);
L_D_max         = 18;

Line5y          = PowerEtaLookup(M_cruise,alt_cruise)./[ROC_req_C + sqrt(xWingLoading*2/(rho_C*sqrt(3*C_D0/K)))*(1.155/L_D_max)];
Line5x          = xWingLoading;
legend_string(5)= "Cruise Ceiling ROC - met below";

%% Plotting
figure(1)
hold on

plot(Line1x,Line1y)
plot(Line2x,Line2y)
plot(Line3x,Line3y)
plot(Line4x,Line4y)
plot(Line5x,Line5y)
plot(MTOW*9.81/118,MTOW*9.81/4.847e6/2.36,'rx','MarkerSize',10)
legend_string(6) = "Our Design Point";
plot(MTOW*9.81/118,MTOW*9.81/4.847e6/3,'bx','MarkerSize',10)
legend_string(7) = "With 3 engines";
plot(MTOW*9.81/118,MTOW*9.81/4.847e6/4,'gx','MarkerSize',10)
legend_string(8) = "With 4 engines";
legend(legend_string,'Location','northeast');


axis([min(xWingLoading) max(xWingLoading) min(yPowerLoading) max(yPowerLoading)])
xlabel('Wing Loading [N/m^2]')
ylabel('Power Loading [N/W]')









