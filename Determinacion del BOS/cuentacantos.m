
function cuentacantos (carpeta)
%Devuelve los porcentajes de cantos en cada franja horaria
%Matlab 2018a
%Fiamma Liz Leites

%% Lista con archivos
a=dir(carpeta); %lista de los nombres de archivos en la carpeta
cd(carpeta)


%Nombres de archivos de la carpeta
for i=3:length(a)-2
cantos{i-2}=a(i).name; %guarda en una celda los nombres de los audios
end

clear i


%Hora de creacion de archivos
for t=1:length(cantos)
    
X=dir(cantos{t}); %Para cada archivo, extraigo datos

XX(t)=str2num(X.date(14:15)); %posicion de la hora de creacion

end

clear X
clear t

%% Conteo de cantos

%Cuento cantidad de archivos creados en cada franja horaria, saco
%porcentaje

%6 a.m. a 11 a.m.
manana= numel(XX(and(XX>=6,XX<11)))*100/length(cantos);

%11 a.m. a 5 p.m.
tarde= numel(XX(and(XX>=11,XX<17)))*100/length(cantos);

%5 p.m. a 8 p.m.
noche= numel(XX(and(XX>=17,XX<=20)))*100/length(cantos);

%Franja donde la luz esta apagada- puede haber un minimo de cantos porque
%quede despierto un rato mas o por la precision del timer
fuera= numel(XX(and(XX>=0,XX<6)));
fuera= (fuera + numel(XX(XX>20)))*100/length(cantos)*100/length(cantos);

clear XX

%Despliego carteles en la command window
disp(['Cantos totales=' num2str(length(cantos))]);
disp(['Cantos por la mañana (6-11)=' num2str(manana)]);
disp(['Cantos por la tarde(11-17)=' num2str(tarde)]);
disp(['Cantos por la noche(17-20)=' num2str(noche)]);
disp(['Cantos con luz apagada=' num2str(fuera)]);
end 
