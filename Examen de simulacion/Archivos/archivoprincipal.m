clc; clear;
%Se define el tiempo de simulacion
tiempo = 0:0.01:800;
x0 = [0.4225;0.0415;2.0535;0.0234]; % Condiciones iniciales de los estados

%Sorg con +0.2
amplitud1=3.7;

%Sorg con -0.2
amplitud2=3.3;

%A continuacion se definen las entradas
entrada1= [amplitud1];
entrada2= [amplitud2];

% ------------------- Simulacion --------------------------

%Se define la simulacion por medio de la funcion ODE45
[t,x] = ode45(@(tiempo,x) variablesdeestado(tiempo,x,entrada1),tiempo,x0);%Aca se simulan las variables de estado con la variacion de +2 en la entrada Sorg
[t2,x2] = ode45(@(tiempo,x) variablesdeestado(tiempo,x,entrada2),tiempo,x0);%Aca se simulan las variables de estado con la variacion de -2 en la entrada Sorg

%A continuacion se definen las salidas
y=x(:,1);
sorg=x(:,3);
y2=x2(:,1);
sorg2=x2(:,3);

%Graficamos para las salidas cuando se le aplico la variacion de +2 a la
%entrada Sorg
subplot(2,1,1)
plot (t,y,'r',t,sorg,'b','Linewidth',1.5)
grid on
legend("X","Sorg 3.5+0.2");
title("Salidas");
xlabel("Tiempo (h)");
ylabel("X(g/litro)  Sorg(g/litro)");


%Graficamos para las salidas cuando se le aplico la variacion de +2 a la
%entrada Sorg
subplot(2,1,2)
plot (t,y2,'m',t,sorg2,'g','Linewidth',1.5)
grid on
legend("X","Sorg 3.5-0.2");
title("Salidas");
xlabel("Tiempo (h)");
ylabel("X(g/litro)  Sorg(g/litro)");

