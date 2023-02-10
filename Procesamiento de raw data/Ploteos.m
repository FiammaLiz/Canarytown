%Script donde llamo a las distintas funciones para plotear
%los datos preprocesados levantados con Levantar_data.m
%Version 23/04/2021
%Fiamma Liz Leites
%% Cargo el protocolo preprocesado y me voy al directorio de las funciones

path_file= 'G:\Datos Canarios Protocolos\ca001-VioAma\031122';
cd (path_file);
protocolo='mergeprotocolo2-4'; 
load(protocolo); %cargo datos del .mat
path_function ='C:\Users\Ceci\Desktop\Fiamma\Scripts_Fiamma\Procesamiento de raw data';
cd (path_function);
%protocolo='mergeprotocolo1-2';
%file='mergeprotocolo1-2';

%% 1) Visualizar raw data
%Devuelve graficados la senial testigo, el espectograma etiquetado con los
%estimulos y la senial de los cuatro canales del tetrodo con marcas de
%inicio y fin de los estimulos.


%Tetrodos (para la olvidadiza :D)
%desired_channels_neural=8:11; canales= '8 a 11';
%desired_channels_neural=12:15; canales='12 a 15';
%desired_channels_neural= 17:18; canales= '17 a 18';%
%desired_channels_neural= [20 22 23]; canales= '20 a 23';
%desired_channels_neural= 8:23; canales= '12 a 23';

%Implantes mixtos
%Tetrodos (para la olvidadiza :D)
%desired_channels_neural=8:11; canales= '8 a 11'; %Tetrodo 1
%desired_channels_neural= 20:23; canales= '20 a 23'; %Tetrodo 2

%Electrodos gordos
%desired_channels_neural=12:15 ; canales= '12 a 15';

%Todos
%desired_channels_neural=8:11; canales='todos';



numch=length(desired_channels_neural);
trial_i=10;
trial_f=15;
lim_ejey=[-400 400];

%Para poder llamar solo los 4 canales que quiero arriba
%channels_neural=zeros(1,numch);
%for ch = 1:numch
 %   channels_neural(ch)=find(chip_channels==desired_channels_neural(ch));
%end
%clear ch

channels_neural=1:4;
%Extract data from desired channel
channel_neural_data=filtered_neural_data(:,channels_neural);

%Plotear raw data
plotrawdata (lim_ejey, ave, fecha, file, profundidad, canales, numch,t_amplifier, t_board_adc,trial_i,trial_f,channel_neural_data, filtered_audio_data, filtered_stimuli_data, t0s, name_stim, y, sample_rate, desired_channels_neural)
clear canales
clear trial_i
clear trial_f
clear lim_ejey


%% 2) Deteccion de spikes
%Filtra por el umbral seleccionado la raw data y luego los guarda en un
%struct segun el tipo de estimulo y trial al que pertenezcan

%Si extraje un grupo de canales
desired_channel_neural=13; %este es el canal que quiero
channels_neural=(chip_channels==desired_channel_neural); %para llamar al canal que quiero

%Extract data from desired channel
channel_neural_data=filtered_neural_data(:,channels_neural);
clear channels_neural

%Umbral de deteccion
 %Criterio 1: Calculo de umbral con desvio estandar
  std_min=-4; %Desvio estandar
  abs_neural_data= abs(channel_neural_data); %Valor absoluto de los datos
 std_noise_detect=median(abs_neural_data)/0.6745; %Calcula desvio estandar de mediana de los datos
 thr= std_min*std_noise_detect; %calcula thr como x desvios estandar de la mediana
  
  %Criterio 2: Asigno manualmente el umbral
 % thr=-70; 
  maximo= 500; %tamaño del shoulder de arriba
  minimo= -700; %tamaño del spike, para eliminar artefactos de twcnica para spike shape
  %abs_neural_data= abs(channel_neural_data); %Valor absoluto de los datos
  %std_noise_detect=median(abs_neural_data)/0.6745; %Calcula desvio estandar de mediana de los datos
  %std_min= thr/std_noise_detect; %Calculo cuántos desvios estandard representa mi umbral escogido para posterior comparacion
   
  [spike_lcs, spike_times, spike_tot, s, ntrials, duracion_stim, L, spike_stim, spike_lcs_ss]=spikedetection (maximo, minimo, thr,channel_neural_data, sample_rate, num_stim, t0s, t_audio_stim,pausa);
  disp(['std=' num2str(std_min)]);
  clear std_noise_detect
  clear abs_neural_data
  clear maximo
  clear minimo
  
%% 3) Chequeo de la deteccion de spikes
%Devuelve una figura con el canal neuronal seleccionado (raw data) donde marco umbral y eventos
%de spike. Para ver si lo que levanto respeta la actividad de la unidad

trial_i= 40;
trial_f= 50;

spikecheck (trial_f, trial_i, t_board_adc, t_amplifier,t0s, sample_rate, ... 
filtered_audio_data, channel_neural_data, spike_lcs_ss,... 
ave, fecha, file, thr, profundidad, name_stim, desired_channel_neural)

clear trial_i
clear trial_f

%% 4) Ploteo de raster+histograma
%Devuelve tantas figuras como tipos de estimulos haya: sonograma, audio, 
%raster e histograma. 

binsize=0.005; %tamanio del bin del histograma, en segundos
points_bins= 1000; %puntos por bin para suavizado
rasterplot (num_stim, name_stim, t_audio_stim, audio_stim, L, duracion_stim, sample_rate,... 
ntrials, spike_stim, desired_channel_neural,thr,std_min,points_bins,tg,colorp,... 
binsize, ave, fecha, file, profundidad)

%% Ploteo solo histograma

%Si esta muy ruidoso el raster por mucha densidad de spikes, solo plotear
%histograma

histplot (num_stim, name_stim, t_audio_stim, audio_stim, L, duracion_stim, sample_rate,...  %datos del estimulo
ntrials, spike_stim, desired_channel_neural,thr,std_min,points_bins,tg,colorp,... 
binsize, ave, fecha, file, profundidad) %datos de la tabla

%clear binsize
%clear points_bins

%% Para añadir etiquetas al REV, si fuese necesario

 num_silb=length(tg(1).tier{1,1}.Label);

        for tx=1:num_silb
        patch([duracion_stim(n)-tg(1).tier{1,1}.T1(tx) duracion_stim(n)-tg(1).tier{1,1}.T1(tx) duracion_stim(n)-tg(1).tier{1,1}.T2(tx) duracion_stim(n)-tg(1).tier{1,1}.T2(tx)],[ax(1).YLim(1) ax(1).YLim(2) ax(1).YLim(2) ax(1).YLim(1)],colorp{tx,1},'FaceAlpha',0.15,'EdgeColor','none');
        hold on
        line((duracion_stim(n)-tg(1).tier{1,1}.T1(tx))*[1 1],ax(1).YLim,'LineStyle','-','MarkerSize',4,'Color',[0.5 0.5 0.5]);
        line((duracion_stim(n)-tg(1).tier{1,1}.T2(tx))*[1 1],ax(1).YLim,'LineStyle','-','MarkerSize',4,'Color',[0.5 0.5 0.5]); 
        end
        %Escribe los nombres de las sílabas centrados en el parche a 3/4 de altura
        for k=1:num_silb
        text(duracion_stim(n)-((tg(1).tier{1,1}.T1(k)+tg(1).tier{1,1}.T2(k))/2),(ax(1).YLim(2))*3/4,tg(1).tier{1,1}.Label(k),'FontSize',10,'Interpreter','none');
        end
        hold off
        
%% Spike shape
%Dibuja los spikes que levanto anteriormente

y_lim=[-500 300];
%desired_channels_neural= 8:11; canales= '8 a 11';
%desired_channels_neural= 15; canales= '12 a 15';
%desired_channels_neural= 16:19; canales= '16 a 19';
desired_channels_neural= 20:22; canales= '20 a 22';
w_pre=0.001; %ventana anterior del pico del spike
w_post=0.0015; %ventana posterior del pico del spike
numch=length(desired_channels_neural);

%Para poder llamar solo los 4 canales que quiero arriba
channels_neural= zeros(1,numch);

for ch = 1:numch
    channels_neural(ch)=find(chip_channels==desired_channels_neural(ch));
end
clear numch

%Extract data from desired channel
channel_neural_data=filtered_neural_data(:,channels_neural);
numch=length(desired_channels_neural);

clear channels_neural

%% TODOS LOS SPIKES
spikeshape(desired_channels_neural, num_stim, numch, y_lim,w_pre,w_post,channel_neural_data,spike_lcs_ss,sample_rate, ave, fecha, file, name_stim, profundidad)

clear w_pre
clear w_post
clear y_lim

%% Test con menos spikes
subset_spikes=mat2cell(spike_lcs_ss{1}(1:1000),1);
% spike_lcs_ss{1}(5000:6000) tiene los artefactos
spikeshape(desired_channels_neural, num_stim, numch, y_lim,w_pre,w_post,channel_neural_data,subset_spikes,sample_rate, ave, fecha, file, name_stim, profundidad)

clear subset_spikes
clear w_pre
clear w_post
clear y_lim


%% Histograma ISI
%Para cuantificar los interspikes intervals. Solo tiene sentido para las SU
%(filtradas en los pasos anteriores)

n=1; %nUmero que corresponde al estimulo
binsize= 1; %binsize del histograma en milisegundos
x_lim=[0 50]; %limite del eje x para el histograma en milisegundos

ISIcalculator(n,x_lim, sample_rate, num_stim, name_stim, ave, fecha, file, profundidad, desired_channel_neural, binsize, spike_lcs_ss, thr, std_min)

clear binsize
clear n
clear x_lim


%% Limpio artefactos

thr=[200 -250]; %umbral positivo o negativo para detectar los artefactos
numch=16; %cantidad de canales
noisy=2; %trial mas ruidoso para comparar el antes y el después
[filtered_neural_data_clean]=cleanartifacts(filtered_neural_data,t_board_adc,thr,numch,noisy);

%% Pruebas para verificar que se guardó correctamente el .bin

fid = fopen('protocolo1_CeRo_181126_141225-tetrodo 2.bin','r');
channel_neural_data = fread(fid,[4 inf],'int16')'; 
fclose(fid); 

f1=figure(1);
tr(1)=subplot(2,1,1);
plot(channel_neural_data)
tr(2)=subplot(2,1,2);
plot(dat')
equispace(f1);
linkaxes(tr);

