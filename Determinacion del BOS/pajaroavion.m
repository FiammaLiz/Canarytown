%% Pajaro-avion version Matlab
%Traducción del script pajaro-avion xD para usar en Matlab como funcion,
%contempla diferentes tamaños de audios
%Input: direccion de la carpeta y un threshold, 
%Output: mueve posibles cantos a una carpeta "cantos" dentro de la carpeta
%especificada

%% 
function pajaroavion(carpeta, thr)

%% Lista con archivos
a=dir(carpeta); %lista de los nombres de archivos en la carpeta
cd(carpeta)

%Nombres de archivos
for i=3:length(a)-2
archivos{i-2}=a(i).name; %guarda en una celda los nombres de los audios
end

%Onda de sonido y frecuencia de sampleo
for i=3:length(a)-2
[data{i-2},fs(i-2)]=audioread(a(i).name);
end

cd('F:\Datos Canarios Protocolos\Scripts\Determinacion del BOS'); 


%% Defino rangos de frecuencias 

%Vector de frecuencias para FFT 
for i=1:length(data)
    
    L(i) = length(data{i}); 
    df(i)=fs(i)/L(i); %calculo el intervalo entre frecuencias del vector f

%Intervalo 1200-6000 Hz (canto)
    fr_min=1200;
    fr_max=6000;
    f1(i)=round(fr_min/df(i)); %posición de frecuencia minima en vector de frecuencias f
    f2(i)=round(fr_max/df(i));%posición de frecuencia maxima en vector de frecuencias f


%Intervalo 15000-20000 Hz (ruido)
    fr_min2=15000;
    fr_max2=20000;
    f3(i)=round(fr_min2/df(i)); %posicion de frecuencia minima en vector de frecuencias f
    f4(i)=round(fr_max2/df(i));%posicion de frecuencia manima en vector de frecuencias f

end 

%% Comparación de promedios

%Promedio de las transformadas en intervalo de interes
promedios=[];

%Promedios en el intervalo de alta frecuencia
promediosAltos = [];

%Guardo el cociente entre las listas
cociente= [];

for i=1:length(data)
    %Transformada de Fourier
f{i}= fs(i)*(0:(L(i)/2))/L(i);
audio_ff{i} = fft(data{i});
P2{i} = abs(audio_ff{i}/L(i));
P1{i} = P2{i}(1:L(i)/2+1);
P1{i}(2:end-1) = 2*P1{i}(2:end-1);

    %Promedios
promedios(i)= mean(P1{i}(f1(i):f2(i))); %canto
promediosAltos(i)=mean(P1{i}(f3(i):f4(i))); %ruido
cociente(i)=promedios(i)/promediosAltos(i);
end 


%Guardo los nombres de los posibles archivos con cantos

N=1;
for i=1:length(data)
    if cociente(i)>thr %umbral a decidir, puede hacerse un histograma de cocientes o usarse el ojimetro
    cantos(N)=archivos(i);
    N = N+1;
    end
end

clear N
clear i

%% Muevo los posibles cantos a una nueva carpeta

mkdir ([carpeta '\cantos']);
cd(carpeta)

for u=1:length(cantos)
status (u)= movefile(cantos{1,u},[carpeta '\cantos\']);
end 
disp(['Cantos aislados=' num2str(u)]);
clear u
end
