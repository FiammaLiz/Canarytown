%% Para hacer el raster ingresando el cluster
%Este script llama a funciones varias. Carga raw data del protocolo y la ordenada en variables en la workspace, carga resultados de
%Kilosort, para luego plotear Raster y spikeshape.

%% Cargo datos
addpath('C:\Users\Ceci\Desktop\MATLAB\npy-matlab');
path_file= 'C:\Users\Ceci\Desktop\Fiamma\Concatenado\VeNe\';
cd (path_file);
protocolo='protocolo2_VeNe_181025_103223_181025_104920'; 
load(protocolo); %cargo datos del .mat
%load('VeNe_concatenado.mat');
comienzo_auditivo_samples=comienzo_auditivo*sample_rate;
path_function ='C:\Users\Ceci\Desktop\Fiamma\Scripts_Fiamma\Procesamiento de raw data';
cd (path_function);

%% Cargo clusters y extraigo spike-times en auditivo
tetrode='4';
cd ([path_file 'Tetrodo' tetrode '\Results'])
spike_clusters=readNPY('spike_clusters.npy');
spike_clusters= cast(spike_clusters,'double');
spike_times_t=readNPY('spike_times.npy');
spike_times_t= cast(spike_times_t,'double')-comienzo_auditivo_samples;
cluster_list=unique(spike_clusters);
for k=1:length(cluster_list)
    ID= find(spike_clusters==cluster_list(k));
    spike_lcs_cluster=spike_times_t(ID);
    spikes_auditivo=spike_lcs_cluster(find(spike_lcs_cluster>0));
    if isempty(spikes_auditivo)==0.
    spike_times_cluster= spikes_auditivo/sample_rate;
    spike_times(k).cluster=spike_times_cluster'; %guardo spiketimes por cluster
    spike_lcs(k).cluster=spike_times_cluster'*sample_rate; %guardo localizaciones (indices) por cluster
    end
end 

cd (path_function);
%% Preparando herramientas para alinear el raster

% Asigna inicios al tipo de trial

s=struct('t0s',zeros(1,length(unique(num_stim))));

%Calcula intervalo entre comienzos de audios, por si no tuviese este dato
%("pausa")

for o=1:length(t0s)-2
    pausa_ind(o)=t0s(o+1)-t0s(o);
end
pausa=round(mean(pausa_ind));
clear pausa_ind

for n=1:length(unique(num_stim))  %para todos los estimulos del 1 al n
s(n).t0s= t0s(num_stim==n);  %guarda en un struct todos los t0s en distintos fields por estimulo
end

% CALCULOS PARA RASTER E HISTOGRAMAS ALINEADOS CON LOS T0s
%Tiene en cuenta que el numero de trials puede no ser el mismo
%No pongo identidad de 1, 2 o 3 porque podrian no ser el mismo en todos los
%protocolos, despues los traigo de name_stim

%Cuenta las veces que se hizo cada trial y los guarda

ntrials=zeros(length(unique(num_stim)),1);

for n=1:length(unique(num_stim))  
ntrials(n)= sum(num_stim==n);
end

%Calcula ventana de tiempo hacia atras y hacia adelante del estimulo

duracion_stim=zeros(length(unique(num_stim)));
L1=zeros(1);

for n=1:length(unique(num_stim))
    duracion_stim(n)= length(audio_stim{n})/sample_rate; %calcula la duracion de cada estimulo en segundos
    L1(n)= (pausa-duracion_stim(n))/2; %calcula las ventanas posibles (la mitad de la distancia entre pausa y comienzo del estimulo)
end 
    L=min(L1); %scojo la ventana mas chiquita 

%% Separo los spike times de un cluster

binsize=0.005; %tamanio del bin del histograma, en segundos
points_bins= 1000; %puntos por bin para suavizado
cluster=104;
k=find(cluster_list==cluster);

spikeTrain=spike_times(k).cluster;

%Calculo porcentaje de violaciones al interspike interval (indicativo de cuan
%bueno es el cluster)
refDur=0.002;
minISI=0.0015;
[~, numViolations]=isiViolations(spikeTrain, minISI, refDur);
percent_violations=(numViolations*100)/length(spikeTrain);

disp(['%violaciones=' num2str(percent_violations)]);

%% Preparo elementos para ploteo

 for m=1:(length(unique(num_stim)))  %para cada tipo de estímulo
    for l=1:ntrials(m) %y para todos los trials adentroaudio_stim
    found_trial{l,1}= (spike_times(k).cluster(spike_times(k).cluster<=(s(m).t0s(l)+(duracion_stim(m)+L))))> (s(m).t0s(l)-L); %#ok<*AGROW> %selecciono spikes entre estímulo dentro de mi ventana, retorna valores booleanos
    tstim{l,1} = spike_times(k).cluster(found_trial{l,1})-s(m).t0s(l);%paso a tiempo y lo relativizo a su t0 para alinear, me da tiempo en segundos donde dispara cada spike alineados
    lcstim{l,1}=spike_lcs(k).cluster(found_trial{l,1})'; %indice de spikes encontrados
    end
    spike_stim(m).trial= {tstim{1:ntrials(m),1}}; %voy guardando las celdas en el struct (instancia de spikes en segundos alineados)
    spike_lcs_ss{m}=cell2mat(lcstim)'; %agrupo en celdas todos los indices de spikes por estimulo (para spike shape)
 end 
 
%% Ploteo raster
 
rasterplot_clusters (num_stim, name_stim, t_audio_stim, audio_stim, L, duracion_stim, sample_rate,... 
ntrials, spike_stim,tetrode,cluster,points_bins,tg,colorp,... 
binsize, ave, fecha, file, profundidad)

 %% Chequeo como fue el clustereo en la raw data
 %Señala con lineas rojas donde se detecto un spike en la raw data

desired_channels_neural=16:19;
%Opcion 1: con raw data del .mat, verificacion de que este detectandose
%adecuadamente el spiketime
%Para poder llamar solo los 4 canales que quiero arriba
numch=length(desired_channels_neural);
channels_neural= zeros(1,numch);

for ch = 1:numch
    channels_neural(ch)=find(chip_channels==desired_channels_neural(ch));
end
clear numch

%Extract data from desired channel
channel_neural_data=neural_data(channels_neural,:);

clear channels_neural

%% 
%Opcion 2: con raw data del .bin, verificacion de que suceda lo mismo en el
%archivo que le pase a Kilosort

cd ([path_file '31-10-18\protocolo1\Tetrodo' tetrode])

fid = fopen('protocolo1-tetrodo2.bin','r');
channel_neural_data2 = fread(fid,[4 inf],'*int16')'; 
fclose(fid); 

%% Ploteo de instancias de disparo en cantando
clear spike_lcs_ss
clear spike_lcs

cluster=60;
tetrode='4';
desired_channels_neural=20:23;
numch=length(desired_channels_neural);
channels_neural= zeros(1,numch);

for ch = 1:numch
    channels_neural(ch)=find(chip_channels==desired_channels_neural(ch));
end
clear numch

%Extract data from desired channel
channel_neural_data=neural_data(channels_neural,:);

clear channels_neural

%Filtros para datos de senial neuronal
 %Design filters
    %Third order Butterworth highpass filter for neural signal
cutoff_freq=300; % Neural signal filter cutoff frequency in Hz
d1 = designfilt('highpassiir','FilterOrder',3,'HalfPowerFrequency',cutoff_freq,...
'DesignMethod','butter','SampleRate',sample_rate);    

numch=length(desired_channels_neural);

%A filtrar:
filt_neural_data=cell(1,numch);
for k=1:numch
filt_neural_data{1,k}=filtfilt(d1,channel_neural_data(k,:)); %filtfilt=zero-phase filtering, canal neuronal filtrado
end
clear d1
clear channel_neural_data
clear cutoff_freq
channel_neural_data=cell2mat(filt_neural_data');

%Spike times para cantando
cd ([path_file 'Tetrodo' tetrode '\Results'])
spike_clusters=readNPY('spike_clusters.npy');
spike_clusters= cast(spike_clusters,'double');
spike_times_t=readNPY('spike_times.npy');
spike_times_t= cast(spike_times_t,'double');
cluster_list=unique(spike_clusters);
spike_times_t=readNPY('spike_times.npy');
spike_times_t= cast(spike_times_t,'double');
cluster_list=unique(spike_clusters);

for k=1:length(cluster_list)
    ID= find(spike_clusters==cluster_list(k));
    spike_lcs_cluster=spike_times_t(ID);
    spike_times_cluster= spike_lcs_cluster/sample_rate;
    spike_times(k).cluster=spike_times_cluster'; %guardo spiketimes por cluster
    spike_lcs(k).cluster=spike_times_cluster'*sample_rate; %guardo localizaciones (indices) por cluster
end 

% Separo los spike times de un cluster

binsize=0.005; %tamanio del bin del histograma, en segundos
points_bins= 1000; %puntos por bin para suavizado
k=find(cluster_list==cluster);

spikeTrain=spike_times(k).cluster;

cd(path_function);
spike_lcs_ss={spike_lcs(k).cluster}; %agrupo en celdas todos los indices de spikes por estimulo (para spike shape)
 
%Ploteo
thr=-150;
sound_cantando=sound_channel(1:comienzo_auditivo_samples);
neural_data_cantando=channel_neural_data(1:comienzo_auditivo_samples);
times_cantando=times(1:comienzo_auditivo_samples);

spikecheck_concatenado (times_cantando,times_cantando,sample_rate, ... 
sound_cantando, neural_data_cantando, spike_lcs_ss,... 
comienzo_auditivo,thr);  
 
%% Waveform
%Dibuja los spikes provenientes del clustereo, con la raw data

y_lim=[-400 300];
%desired_channels_neural= 8:11; canales= '8 a 11';
%desired_channels_neural= 12:15; canales= '12 a 15';
%desired_channels_neural= 16:19; canales= '16 a 19';
desired_channels_neural= 20:23; canales= '20 a 23';
w_pre=0.001; %ventana anterior del pico del spike
w_post=0.0015; %ventana posterior del pico del spike
stims=1;
cd(path_function);
numch=4;

%Hago un subset de spikes
subset_spikes=mat2cell(spike_lcs_ss{1}(1:1000),1);
spikeshape(desired_channels_neural, num_stim, numch, y_lim,w_pre,w_post,channel_neural_data,subset_spikes,sample_rate, ave, fecha, file, name_stim, profundidad)

clear subset_spikes
clear w_pre
clear w_post
clear y_lim
clear w_pre
clear w_post
clear y_lim


