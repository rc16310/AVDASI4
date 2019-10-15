%% Rearranged Breguet range fuel minimisation attempt
% In this code empty means MTOW - fuel
%   Tom Gilbert
% Need to check area and span
clear all; close all; clc;

%% Fixed constants
g = 9.81;

%% Airbus defined specificaiton
rng = 1000 * 1852;

%% Optimisation parameters
SFC = 1.686e-5;
%SFC = 0.0308472836601307/(60^2);
V_D = 230;
SREF = 120;
TRW = 0.24;
TCW = 0.15; 
WSWEEP = 25;
span = [20:100];
density = 0.4671;

%% Simimalrity terms
ARW = span.^2./SREF;


%% Empty weight
% Payload weight
M_payload = 105 * 190;

% Fuselage mass - Jenkinson
L_F = 37.57; % http://www.fly-car.de/local/media/formulare/airbusindustries.pdf
D_F = 4; % http://www.modernairliners.com/airbus-a320-introduction/airbus-a320-specs/
M_fuselage = (0.039 * (L_F * 2 * D_F .* V_D.^0.5).^1.5) .* 1.08;

%% Iteration scheme
MTOM = 60995;
MTOM_old = 0;

while abs(MTOM - MTOM_old) > 0.0000001
    MTOM_old = MTOM;
    %% Wing group -  Howe - Pg 157 to 158
    C_1 = 0.009;

    M_wing = C_1 .* (ARW.^0.5 .* SREF .* sec((pi/180).*WSWEEP) .* ((1+2.*TRW)/(3+3.*TRW)) ...
        .* (MTOM./SREF) .* (1.65 .* 3.5).^0.3 .* (V_D/TCW).^0.5).^0.9;

    %% L/D stuff
    C_L = ((MTOM-0.5*3187)*9.81)./(0.5*density.*V_D.^2.*SREF);

    C_D_0 = 0.016; % Guesed from wiki page adbout drag coefficients (boeing 787 then minus estimated a320 induced drag)
    C_D_i = (C_L.^2)./(pi.*ARW);
    C_D = C_D_0 + C_D_i;
    %fprintf("L/D %f \n", C_L./C_D)
    %% Summation
    M_empty = M_payload + M_fuselage + M_wing + 25000;
    M_fuel = M_empty .* exp( (rng*g*SFC)./(V_D .* (C_L./C_D)) ) - M_empty;

    MTOM = M_empty + M_fuel;

end

%% Plotting
plot(span, M_fuel)
ylabel("Fuel mass (kg)")
xlabel("Wing span (m)")
hold on

%% Plot ICAO requirements
icaoCx = [36, 36];
icaoy = [3500, max(M_fuel)];
plot(icaoCx,icaoy)

icaoDx = [52, 52];
plot(icaoDx,icaoy)

legend("Span", "ICAO C", "ICAO D")

%% Read-outs
% fprintf("L/D %f \n", C_L./C_D)
fprintf("Mass of fuel required %f kg \n", M_fuel)
% fprintf("MTOM %f kg \n", MTOM)

