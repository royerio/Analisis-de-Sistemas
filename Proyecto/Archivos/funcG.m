function y = funcG(x, parametros)
% Se definen las salidas del sistema, en este caso los angulos del brazo
theta1 = x(:,1);
theta2 = x(:,2);

y = [theta1, theta2];
end