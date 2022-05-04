function dxdt = variablesdeestado(tiempo,x,in)
% Este modelo implementa la función de los estados de nuestro sistema.

%Formulamos el tipo de entrada que despues sera llamada por la funcion
%principal
sorgo=in(1)*heaviside(tiempo);

% Se definen los parámetros del modelo
kd = 0.001;
ke = 0.57;
ki = 0.470;
kla = 250;
klao2 = 43;
ko = 0.000048;
ks = 0.001;
vaq = 1.0;
vorg = 0.5;
yo2x = 1/0.338;
yxs = 0.52;
umax = 0.534;
co2 = 0.0373;

%Se agregan otras subfunciones necesarias para los estados
dphenol = 1.215*((9.75*(exp(-1.8182*(x(3))))) - (48.75*(exp(-6.6667*(x(3)))))+39.0);
u = ((umax*(x(2)))/(ks+(x(2))+(((x(2))^2)/ki)))*((x(4))/(ko+(x(4))));

% Ecuaiones de los estados derivados
dxdt = u*(x(1)) - kd*(x(1)) - ke*u*(x(1)) - 0.205*(x(1)); % Cálculo de la derivada de la primera variable de estado
dsaqdt = kla*(((x(3))/dphenol)-(x(2))) - ((u*(x(1)))/yxs) - 0.205*(x(2)); % Cálculo de la derivada de la segunda variable de estado
dsorgdt = 0.55*sorgo - kla*((((x(3))/dphenol)-(x(2)))*(vaq/vorg)) - (0.55*(x(3))); % Cálculo de la derivada de la tercera variable de estado
dco2dt = 0.205*(x(4)) + klao2*(co2-(x(4))) - yo2x*u*(x(1)) - 0.205*(x(4));% Cálculo de la derivada de la cuarta variable de estado

% Se retorna el valor de los estados derivados para ser utilizados por la
% funcion principal
dxdt=[dxdt;dsaqdt;dsorgdt;dco2dt];
end