%% Wing area approximaitons

clear all; close all; clc;

%% Spec numbers
% Max landing speed


%% Take off
lift = 61300*9.81;
density = 1.225;

area_min = 60;
area_max = 110;

CL = 2;
velocity = @(area) sqrt(lift./(0.5*density.*area.*CL));
fplot(velocity, [area_min, area_max])
hold on

CL = 3;
velocity = @(area) sqrt(lift./(0.5*density.*area.*CL));
fplot(velocity, [area_min, area_max])

xlabel("Wing area (m^2)")
ylabel("Velocity (m/s)")
title("MTOM 61300 kg")
yline(72);


x = [0 400 400 0];
y = [72 72 400 400];
patch(x,y,'red','FaceAlpha',.3)
axis([60 105 50 100])



legend("Landing CL = 2", "Landing CL = 3", "Max Landing Speed")