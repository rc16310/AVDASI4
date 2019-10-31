%function AvailPower
% Power reduction estimation
clc;clear all;close all;
Engine = TP_Scaled_118;
i = 1;
data = Engine.Climb;
P = 4.847e6;
rho_0 = 1.225;
thrustcount = 0;
thrustcountold = -1;
for i = 2:length(Engine.Climb)
    thrustcountold = data(i,
    thrustcount = data(i+1,3);
    if thrustcount < thrustcountold
        [~,a_i,~,rho_i] = atmosisa(ft2m(data(i,1)));    % Atmospheric data at height
        out(i,3) = a_i*data(i,2);                       % Flight Speed
        out(i,4) = data(i,3)*out(i,3)/P;                % Propulsive Power over rated power
        out(i,5) = rho_i/rho_0;                         % Expected power decrease
        out(i,6) = P*out(i,4)/(42798*1000*data(i,4)/3600);
        out(i,7) = data(i,3);% eta_ov 
    end
end
out(:,[1 2]) = data(:,[1 2]);


X = 0.2:0.1:0.7;
Y = 0:5000:30000;
n = 7;
surface = [ out([1:5],n)'    NaN ;
              out([6:11],n)'     ;
              out([12:17],n)'    ;
            NaN out([18:22],n)'  ;
            NaN out([23:27],n)'  ;
            NaN out([28:32],n)'  ;
            NaN out([33:37],n)'  ];
        
        
%etaPoly = polyfit(X,mean(surface,'omitnan'),1)
% for i = 1:6
%     surface(:,i) = surface(:,i)/polyval(etaPoly,X(i));
% end


surf(X,Y,surface,'FaceColor','interp')
xlabel('Mach')
ylabel('Alt')
%save('powersurface.mat','X','Y','surface')
            