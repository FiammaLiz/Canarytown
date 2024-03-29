%Para levantar raw data, Version 23/04/2021
% Fiamma Liz Leites
%Modificado por Ceci Herbert 10/07/2020
%Guarda un "archivo.mat" con datos levantados y pre-procesados


%% Defino cosas
%clear
%close

% cd 'C:\Users\Ceci\Desktop\' %con esto navegas hasta la ubicacion del arcivo
path = 'F:\Datos Canarios Protocolos\ca001-VioAma\111122\';
% path = 'G:\Datos_Canarios_2018-2019\ca313-VioAzu\190308\';
file = 'protocolo6_VioAma_221111_144858';
fecha='11.11.2022';
path_estimulos= [path fecha '-6\'];
file_estimulos= 'estimulos.txt';

ave='VioAma';
desired_channels_neural=[8:23]; %Cual es el canal neuronal que quiero
desired_sound_channel= 2; %Canal del sonido
desired_witness_channel= 1; %Canal de la senial testigo
numch=length(desired_channels_neural); %cuantos canales son
profundidad= '485';
pausa=19;
%Cargo archivos de audio
stim_path='F:\Datos Canarios Protocolos\ca001-VioAma\Estimulos\BOS2\';

[stim_file_BOS,fs_stim_BOS]=audioread([stim_path 'BOS2_VioAma.WAV']);
stim_file_BOS=resample(stim_file_BOS,30000,fs_stim_BOS);

%[stim_file_firstP0,fs_stim_firstP0]=audioread([stim_path 'Ca170-VioVe_protoBOS_20k.WAV']);
%stim_file_firstP0=resample(stim_file_firstP0,30000,fs_stim_firstP0);

[stim_file_CON,fs_stim_CON]=audioread([stim_path 'CON2_VioAma.wav']);
%[stim_file_CON,fs_stim_CON]=audioread([stim_path 'BOS2P0-BlaRo.wav']);
stim_file_CON=resample(stim_file_CON,30000,fs_stim_CON); %#ok<*NASGU>

[stim_file_REV,fs_stim_REV]=audioread([stim_path 'REV2_VioAma.wav']);
stim_file_REV=resample(stim_file_REV,30000,fs_stim_REV);

%audio_stim={stim_file_CON',stim_file_REV',stim_file_BOS'};
audio_stim={stim_file_BOS',stim_file_CON',stim_file_REV'};

%audio_stim={stim_file_firstP0'};

clear stim_file_BOS
clear fs_stim_BOS
clear stim_file_firstP0
clear fs_stim_firstP0
clear fs_stim_CON
clear stim_file_CON
clear stim_file_REV2
clear fs_stim_REV2

%TextGrid
%Ingresar aqui para armar el struct que lleva el dato de las silabas

cd 'F:\Datos Canarios Protocolos\Scripts\mPraat-master'
BOS_tg= 'BOS2_VioAma.TextGrid';
%BOS_tg= 'BOS1-VeAma-Armado.TextGrid';
%firstP0_tg= 'CON2_VioAma.TextGrid';
%firstP0_tg= 'CON1-BlaRo.TextGrid';
tg = tgRead([stim_path BOS_tg]);
%tg2 = tgRead ([stim_path firstP0_tg]);
%tg= [tg tg2];
clear tg2
clear tg1
clear BOS_tg
clear firstP0_tg


colorp= {[1 1 0]; [1 0 1]; [0 1 1]; [1 0 0]; [0 1 0]; [0 0 1]; [0.5 0.5 0.5]; [0.7 0.7 0]; [0.7 0 0.7];...
[0 0.7 0.7]; [0.7 0 0]; [0 0.7 0]; [0 0 0.7]; [0.3 0.3 0]; [0.3 0 0.3]; [0 0.3 0.3]; [0.3 0 0]; [0 0.3 0]; [0 0 0.3];...
[0.5 0.5 0]; [0.5 0 0.5]; [0 0.5 0.5]; [0.5 0 0]; [0 0.5 0]; [0 0 0.5]};


%% Cargo los datos que necesito

path_function ='F:\Datos Canarios Protocolos\Scripts\Procesamiento de raw data\';
cd (path_function);

filename = [path,file '.rhd'];
read_Intan_RHD2000_file(filename); %Levanto datos con el Read_Intan
sample_rate=frequency_parameters.amplifier_sample_rate; %frecuencia de sampleo
sound_channel= board_adc_data(desired_sound_channel,:); %Canal del sonido
witness_channel= board_adc_data(desired_witness_channel,:); %Canal de la senial testigo
%t_stim_BOS = (1:length(stim_file_BOS))/sample_rate; %tiempos para plotear estimulos
%t_stim_CON = (1:length(stim_file_CON))/sample_rate;
%t_stim_REV = (1:length(stim_file_REV))/sample_rate;
clear notes
clear desired_sound_channel
clear desired_witness_channel
clear board_adc_data

for n=1:(length(audio_stim))
t_audio_stim(n)={(1:length(audio_stim{n}))/sample_rate}; %#ok<SAGROW>
end
clear n

%% Preparando los canales
%Para hallar el canal deseado en amplifier_channels
chip_channels=[amplifier_channels.chip_channel];

channels_neural= zeros(1,numch);
for ch = 1:numch
    channels_neural(ch)=find(chip_channels==desired_channels_neural(ch));
end

%Extract data from desired channel
channel_neural_data=amplifier_data(channels_neural,:)';
clear amplifier_data

%% Filtrado de seniales

%Filtros para datos de senial neuronal
 %Design filters
    %Third order Butterworth highpass filter for neural signal
cutoff_freq=100; % Neural signal filter cutoff frequency in Hz
d1 = designfilt('highpassiir','FilterOrder',3,'HalfPowerFrequency',cutoff_freq,...
'DesignMethod','butter','SampleRate',sample_rate);    

%Filtros para canal de audio
    %Third order Butterworth highpass filter for audio signal
d2 = designfilt('highpassiir','FilterOrder',3,'HalfPowerFrequency',60,...
    'DesignMethod','butter','SampleRate',sample_rate);

%Filtro para canal testigo
 % filtro pasabandas pulsos audio: 4th order butter, 1000-4000 Hz    
 d3=designfilt('bandpassiir','designmethod','butter','halfpowerfrequency1'...
        ,1000,'halfpowerfrequency2',4000,'filterorder',4,'samplerate',sample_rate);
    
%A filtrar:
filtered_neural_data=cell(1,numch);
for k=1:numch
filtered_neural_data{1,k}=filtfilt(d1,channel_neural_data(:,k)); %filtfilt=zero-phase filtering, canal neuronal filtrado
end
clear d1
clear channel_neural_data
clear cutoff_freq
filtered_neural_data=cell2mat(filtered_neural_data);

filtered_audio_data=filtfilt(d2,sound_channel); %filtfilt=zero-phase filtering, canal de audio filtrado
clear d2
clear sound_channel
filtered_stimuli_data=filtfilt(d3,witness_channel); %filtfilt=zero-phase filtering, canal testigo filtrado
clear d3
clear witness_channel
% Si quiero ver los resultados filtrados
% figure()
% plot(witness_channel)
% hold on
% plot(filtered_stimuli_data)

%ojo Fiamma pensar en agregar chequeo de canales desconectados
% Sacando valores del amplifier_data que sean propios de canales
% desconectados, que me tire cual tiene ese valor en un cartelito

%% Preparando elementos para graficar

%Para encontrar inicios y finales de estimulos

 estimulos=readtable([path_estimulos,file_estimulos],... %Importa a matlab los datos de estimulos en un tabla
 'Delimiter','\t','ReadVariableNames',false);   %tomando como separacion espacio en blanco
name_stim_prev=table2array(estimulos(:,2))'; %Pasa datos de la tabla a una matriz
num_stim_prev=table2array(estimulos(:,1))'; %vector con numeros asociados a tipo de trial
ntrials=length(name_stim_prev)/length(unique(name_stim_prev)); %calcula el numero de trials dividiendo 
                                                            %el numero total de estimulos con el numero de estimulos diferentes.                                                          
 clear estimulos
 
 [pks,lcs]=findpeaks(filtered_stimuli_data'); %encuentra maximos locales en canal testigo filtrado
   test=diff(pks); %calcula la diferencia entre picos adyacentes
   found=find(test>0.15)+1; %selecciono aquellos picos que tengan una diferencia mayor a 0.5 (se que me extrae solo el comienzo de la senial testigo)
   if length(found)>length(num_stim_prev) %me avisa si llega a haber algun trial fallido
        disp('REVISAR QUE HAY ALG�N INICIO FALLIDO')
   end
   meanCycle = mean(diff(found)); %calcula la media de la diferencia entre los picos, esto daría una idea del ancho del trial sin hardcodeo
   found2=find(diff(found)>120*meanCycle/128)+1; %selecciono picos que estan distanciados por lo menos la mitad de un ancho promedio de trial
   t0s=([lcs(found(found2(1)-1));lcs(found(found2))]/sample_rate)'; %instantes donde comenzo el estimulo en segundos. El primer instante va a ser found2(1)-1, porque found2 me calcula aquellos que tienen una diferencia de al menos la mitad del ciclo, por ende su t0 anterior lo cumple
   
   num_t0s=length(t0s);
   num_stim= num_stim_prev(:,1:num_t0s); %correccion por si fue un protocolo cortado
   name_stim = name_stim_prev (:,1:num_t0s); %correccion por si fue un protocolo cortado
   clear num_stim_prev
clear test
clear meanCycle
clear found
clear found2
clear pks
clear lcs

h = 8000; %"altura" donde quiero que aparezcan las etiquetas de estimulo
y= repmat(h,1,num_t0s); %vector con alturas para poner en funcion text

clear h

   %Chequeo numero de etiquetas encontradas:
   %Si bien corrijo arriba, esta bueno saber que ese protocolo se supondria
   %que tenia mas
   
   if num_t0s>ntrials*length(unique(name_stim)) %cuando hay de mas
     disp('ERROR EN CANTIDAD DE T0s')
   end
   
   if num_t0s<length(name_stim) %si hay menos
      disp('NO HAY LA CANTIDAD DE ESTIMULOS PLANIFICADA')
   end
   
   if num_t0s== ntrials*length(unique(name_stim)) %si las cosas salieron bien
       disp('TODO OK CON LOS T0s, SIGAMOS')
   end
clear numch
clear amplifier_data
clear board_adc_data
clear board_adc_channels
clear num_t0s

%% Guardo en un .mat

%cd (path)
%save ([file '.mat'],'-v7.3')
%cd (path_function);