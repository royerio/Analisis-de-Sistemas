function prueba(block)%plantilla para implementar los modelos en variable de estado

setup(block);

function setup(block)%Funcion setup, para definir las caracteristicas basicas del bloque de la s-function
%A continuacion se van a definir la cantidad de puertos de entrada y salida
block.NumInputPorts = 3;
block.NumOutputPorts = 2;

% El puerto de setup properties, para que las propiedades ya sean heredadas
% o dinamicas; en este caso se eligieron propiedades dinamicas
block.SetPreCompInpPortInfoToDynamic;
block.SetPreCompOutPortInfoToDynamic;

%PROPIEDADES DE LOS PUERTOS DE ENTRADA
block.InputPort(1).Dimensions = 1;
block.InputPort(1).DatatypeID = 0; %double
block.InputPort(1).Complexity = 'Real';
block.InputPort(1).DirectFeedthrough = true;

block.InputPort(2).Dimensions = 1;
block.InputPort(2).DatatypeID = 0; %double
block.InputPort(2).Complexity = 'Real';
block.InputPort(2).DirectFeedthrough = true;

block.InputPort(3).Dimensions = 1;
block.InputPort(3).DatatypeID = 0; %double
block.InputPort(3).Complexity = 'Real';
block.InputPort(3).DirectFeedthrough = true;


%PROPIEDADES DE LOS PUERTOS DE SALIDA
block.OutputPort(1).Dimensions = 1;
block.OutputPort(1).DatatypeID = 0; %double
block.OutputPort(1).Complexity = 'Real';
block.OutputPort(1).SamplingMode = 'Sample';

block.OutputPort(2).Dimensions = 1;
block.OutputPort(2).DatatypeID = 0; %double
block.OutputPort(2).Complexity = 'Real';
block.OutputPort(2).SamplingMode = 'Sample';

%numero de parametros;
block.NumDialogPrms     = 1; % Para definir la cantidad de parametros de entrada. Para este caso se hara un vector de 4 entradas

%Tiempo de muestreo dinámico.
block.SampleTimes = [0,0];

%cantidad de variables de estado
block.NumContStates = 4; %tenemos cuatro variables de estado

block.SimStateCompliance = 'DefaultSimState';

%A CONTINUACION SE REGISTRAN LOS METODOS INTERNOS DE LA S-FUNCTION

block.RegBlockMethod('InitializeConditions', @Inicializacion);
block.RegBlockMethod('Outputs', @Salidas);     
block.RegBlockMethod('Derivatives', @ModeloEstados);
block.RegBlockMethod('SetInputPortSamplingMode',@SetInputPortSamplingMode); % Necesario para tener dos salidas
%end setup

%A continuacion se detallan cada uno de los metodos internos de la
%s-function
function Inicializacion(block)

block.ContStates.Data = block.DialogPrm(1).Data;% esto lo que hace es
%             tomar el valor del estado inicial como si fuera un parámetro
%end Inicializacion

function Salidas(block)
% Acá se escribe las ecuaciones de salida
x = block.ContStates.Data; % el estado actual
block.OutputPort(1).Data = x(1); % En este caso, la salida 1 es y1 = 1*X
block.OutputPort(2).Data = x(3); % En este caso, la salida 2 es y2 = 1*Sorg
%end Salidas

function ModeloEstados(block)
% Acá se escribe la función que calcula las derivadas de las variables de
% estado

%Se definen parametros que identifican las variables de estado

sorgo = block.InputPort(1).Data;
daq = block.InputPort(2).Data;
ds = block.InputPort(3).Data;
x = block.ContStates.Data;% Este es el valor del estado actual


u = ((0.534*x(2))/(0.001+x(2)+(((x(2))^2)/0.470)))*((x(4))/(0.000048+x(4)));
dphenol = 1.215*((9.75*exp(-1.8182*x(3))) - (48.75*(exp(-6.6667*x(3))))+39.0);


dx1dt = u*x(1) - 0.001*x(1) - 0.57*u*x(1) - daq*x(1); % cálculo de la derivada de la primera variable de estado
dx2dt = 250*((x(3)/dphenol)-x(2)) - ((u*x(1))/0.52) - daq*x(2); % cálculo de la derivada de la segunda variable de estado
dx3dt = ds*sorgo - 250*(((x(3)/dphenol)-x(2))*(1/0.5)) - (ds*x(3)); % cálculo de la derivada de la tercera variable de estado
dx4dt = daq*x(4) + 43*(0.0373-x(4)) - (1/0.338)*u*x(1) - daq*x(4);% cálculo de la derivada de la cuarta variable de estado
block.Derivatives.Data = [dx1dt;dx2dt;dx3dt;dx4dt]; % actualizacion del bloque de la S-function
%end ModeloEstados

function SetInputPortSamplingMode(s, port, mode)
s.InputPort(port).SamplingMode = mode;
%end SetInputPortSamplingMode

