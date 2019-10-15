%% Turboprop investigation
%      Tom Gilbert

clear all; close all; clc;

%% Aircraft constants
M_empty = 55000;                % MTOM - fuel mass
range = 1000 * 1852;            % 1000nm in metres
g = 9.81;                       % Gravity
SREF = 122;                     % Wing Area
ARW = 9;                        % Aspect ratio

%% Turboprop SFCs
p_alt0  = [0.0314405006535948, 0.0370662406181015, 0.043565856, 0.052188265, 0.060356863, NaN];
p_alt5  = [0.0308472836601307, 0.0370662406181015, 0.042658234, 0.050826832, 0.0587231434, 0.065802595];
p_alt10 = [0.0302540666666667, 0.0365653454746137, 0.041750612, 0.04991921, 0.057180186, 0.065348784];
p_alt15 = [NaN, 0.029602999152, 0.04084299, 0.0487393014, 0.056272564, 0.0631704912];
p_alt20 = [NaN, 0.0350626600441501, 0.040389179, 0.048103966, 0.054911131, 0.0619905826];
p_alt25 = [NaN, 0.0345617649006623, 0.039935368, 0.047196344, 0.05445732, 0.0609921984];
p_alt30 = [NaN, 0.0345617649006623, 0.039481557, 0.046742533, 0.054911131, 0.059903052];

p_SFC = [p_alt0; p_alt5; p_alt10; p_alt15; p_alt20; p_alt25; p_alt30];

%% Turbofan SFCs
f_alt0  = [0.0400346977338441, 0.0452693723715734, 0.050975330315314, NaN, NaN, NaN, NaN, NaN];
f_alt10 = [NaN, 0.0434850561986312, 0.0485569728343026, 0.0601076967215667, 0.066078598921086, NaN, NaN, NaN];
f_alt20 = [NaN, NaN, 0.0470093796650854, 0.0567222073143182, 0.0617367279087274, 0.0644301236266313, 0.0655119952012648, 0.0666164073909517];
f_alt25 = [NaN, NaN, 0.0468559261233926, 0.0557758305784765, 0.0603708180313543, 0.0627493150436612, 0.0637151247827964, 0.0647054193762781];
f_alt31 = [NaN, NaN, NaN, 0.0553369704974229, 0.0597516068495495, 0.0617268327778065, 0.062500097595561, 0.0632938242936834];
f_alt35 = [NaN, NaN, NaN, 0.0546774456236333, 0.0590807746912273, 0.0612976595099268, 0.0621935339611044, 0.0630966843598368];
f_alt39 = [NaN, NaN, NaN, 0.0551660717534006, 0.059557895243282, 0.0616667051983144, 0.0625452735922811, 0.0634151793532949];
f_alt41 = [NaN, NaN, NaN, 0.0555963113351152, 0.0599301137541601, 0.0621027054657041, 0.0629030160527231, 0.0636982345587722]; 

f_SFC = [f_alt0; f_alt10; f_alt20; f_alt25; f_alt31; f_alt35; f_alt39; f_alt41];

%% Turboprop - Mach numbers, Velocities and Altitudes, Densities
p_mach = [0.2: 0.1:0.7];
p_speed_of_sound = [340.3, 334.4, 328.4, 322.2, 316.0, 309.6, 303.1];           %https://www.fighter-planes.com/jetmach1.htm
p_velocity = p_speed_of_sound'*p_mach;

p_altitude = [0:5000:30000];
p_density(1, 1:6) = 1;
p_density(2, 1:6) = 0.8617;
p_density(3, 1:6) = 0.7386;
p_density(4, 1:6) = 0.6295;
p_density(5, 1:6) = 0.5332;
p_density(6, 1:6) = 0.4486;
p_density(7, 1:6) = 0.3747;
p_density = 1.225*p_density;

%% Turbofan - Mach numbers, Velocities and Altitudes, Densities
f_mach = [0.25, 0.35, 0.45, 0.65, 0.75, 0.80, 0.82, 0.84];
f_speed_of_sound = [340.3, 328.4, 316.0, 309.6, 301.56, 295.4, 295.0, 294.9];
f_velocity = f_speed_of_sound'*f_mach;

f_altitude = [0, 10000, 20000, 25000, 31000, 35000, 39000, 41000];
f_density(1, 1:8) = 1;
f_density(2, 1:8) = 0.7386;
f_density(3, 1:8) = 0.5332;
f_density(4, 1:8) = 0.4486;
f_density(5, 1:8) = 0.1741;
f_density(6, 1:8) = 0.3106;
f_density(7, 1:8) = 0.2592;
f_density(8, 1:8) = 0.2354;
f_density = 1.225*f_density;

%% Plot turboprop SFC, against altitude and Mach number
figure("name", "Turboprop SFCs")
surf(p_mach,p_altitude,p_SFC)
xlabel("Mach number")
ylabel("Altitude (ft)")
zlabel("SFC (kg/N/hr)")

%% Plot turbofan SFC, against altitude and Mach number
figure("name", "Turbofan SFCs")
surf(f_mach,f_altitude,f_SFC)
xlabel("Mach number")
ylabel("Altitude (ft)")
zlabel("SFC (kg/N/hr)")

%% Turboprop - L/D approximations for various Mach numbers and altitudes
p_C_L = ((M_empty-0.5*4000)*9.81)./(0.5*p_density.*p_velocity.^2*SREF);

C_D_0 = 0.016;                  % Guesed from wiki page about drag coefficients (boeing 787 then minus estimated a320 induced drag)
p_C_D_i = (p_C_L.^2)./(pi.*ARW);
p_C_D = C_D_0 + p_C_D_i;

%% Turbofan - L/D approximations for various Mach numbers and altitudes
f_C_L = ((M_empty-0.5*4000)*9.81)./(0.5*f_density.*f_velocity.^2*SREF);
 
f_C_D_i = (f_C_L.^2)./(pi.*ARW);
f_C_D = C_D_0 + f_C_D_i;

%% Turboprop - Fuel mass
p_M_fuel = M_empty .* exp( (range*g.*(p_SFC./60^2))./(p_velocity .* (p_C_L./p_C_D)) ) - M_empty;

%% Turbofan - Fuel mass
f_M_fuel = M_empty .* exp( (range*g.*(f_SFC./60^2))./(f_velocity .* (f_C_L./f_C_D)) ) - M_empty;

%% Plot turboprop fuel burn against Mach numbers and altitudes
figure("name", "Turboprop fuel burn")
surf(p_mach,p_altitude,log(p_M_fuel))
xlabel("Mach number")
ylabel("Altitude (ft)")
zlabel("LOG(Fuel Mass) (kg)")

%% Plot turbofan fuel burn against Mach numbers and altitudes
figure("name", "Turbofan fuel burn")
surf(f_mach,f_altitude,log(f_M_fuel))
xlabel("Mach number")
ylabel("Altitude (ft)")
zlabel("LOG(Fuel Mass) (kg)")

%% Print out minimum fuel burn values for turboprop
[r,c]=find(p_M_fuel==min(min(p_M_fuel)));
fprintf("PROP: Min fuel %f kg at SFC %f kg/N/hr, Mach %f, Velocity %f m/s, and Altitude %d ft. \n", p_M_fuel(r,c), p_SFC(r,c), p_mach(c), p_velocity(r,c), p_altitude(r))

%% Print out minimum fuel burn values for turboprop
[r,c]=find(f_M_fuel==min(min(f_M_fuel)));
fprintf("FAN:  Min fuel %f kg at SFC %f kg/N/hr, Mach %f, Velocity %f m/s, and Altitude %d ft. \n", f_M_fuel(r,c), f_SFC(r,c), f_mach(c), f_velocity(r,c), f_altitude(r))
