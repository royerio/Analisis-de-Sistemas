function y =salidas(x)
% Aca vamos a escribir la funcion, suponiendo que x es una matriz que tiene
% los valores de las cuatro variables de estado para cada instante de

%
x = x(1);
sorg = x(3);

%
y = [x,sorg];
end