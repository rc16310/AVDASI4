% input
x = 5502;%5631;
y = 0.3034;%0.05179;

p = polyfit([3348 5525],[0.2048 0.3044],1);

x = 4800;
y = polyval(p,x);

% calcs
MTOW = 65000;

Wing_area = MTOW*9.81/x;

No_of_engines = MTOW*9.81*y/66700; %MTOW*9.81/4.748e6/y;

Scaling = No_of_engines/4;


disp(['Wing area = ' num2str(Wing_area)])
disp(['No of engines = ' num2str(No_of_engines)])
disp(['Scaling for 4 engines = ' num2str(Scaling)]) 
