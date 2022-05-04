function dxdt = funcF(t,x,u, parametros)

% Se reciben los valores actuales de los estados
theta1 = x(1);
theta2 = x(2);
omega1 = x(3);
omega2 = x(4);

% Se reciben algunos parametros del modelo
m1 = parametros(1); % kg
m2 = parametros(2); % kg
l1 = parametros(3); % m
l2 = parametros(4); % m
g  = 9.81; % Gravedad 

% Se reciben los valores deseados de entrada para el torque
tau1 = u(1);
tau2 = u(2);

% Calculo de algunas subfunciones del modelo
sig1 = ((l1^2) * (m1 + m2)) + ((l2^2) * m2) + (2 * l1 * l2 * m2 * cos(theta2));
sig2 = (l2^2) * m2;

f1 = (tau1 / sig1) + ((l1 * l2 * m2 * ((2 * omega1 * omega2) + ((theta1)^2)) * sin(theta2)) / sig1) + ((g * (m1 + m2) * l1 * sin(theta1)) / sig1) + ((g * m2 * l2 * sin (theta1 + theta2)) / sig1);
f2 = (tau2 / sig2) + ((l1 * l2 * m2 * omega1 * omega2 * sin(theta2)) / sig2) + ((g* l2 * m2 * sin(theta1 + theta2)) / sig2);
alpha1 = ((m2 * ((l2)^2)) + (m2 *l1 *l2 * cos(theta2))) / (sig1);
alpha2 = ((m2 * ((l2)^2)) + (m2 *l1 *l2 * cos(theta2))) / (sig2);
g1 = (f1 - (alpha1 * f2)) / (1 - (alpha1 * alpha2));
g2 = (f2 - (alpha2 * f1)) / (1 - (alpha1 * alpha2));

% Finalmente se definen los valores de los estados derivados
theta1dot = omega1;
theta2dot = omega2;
omega1dot = g1;
omega2dot = g2;

dxdt = [theta1dot; theta2dot; omega1dot; omega2dot];
end

