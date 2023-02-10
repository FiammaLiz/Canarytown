%% Script para explorar archivos de presion + neuronas
%Abre los archivos .rhd, los lee y genera figuras de sonido-presion que se
%guardan automaticamente
%La seccion de abajo es para archivos de solo presion, con un adicional
%para guardar en formato .wav

%% Cargo datos

path='G:\Datos_Canarios_2018-2019\ca188-RoNe\190125\';
a=dir(path); %lista de los nombres de archivos en la carpeta
for i=4:length(a)
archivos{i-3}=a(i).name; %guarda en una celda los nombres de los audios
end
%% Leo archivos y hago figuras con neuronas

for y=5:length(archivos)
    
read_Intan_RHD2000_file([path archivos{y}]) % INTAN data file
sample_rate=30000;

%% Filtros canales analogicos

 %Filtros para datos 
 
d1 = designfilt('lowpassiir','FilterOrder',3,'HalfPowerFrequency',100,...
    'DesignMethod','butter','SampleRate',sample_rate);

d2 = designfilt('highpassiir','FilterOrder',3,'HalfPowerFrequency',60,...
    'DesignMethod','butter','SampleRate',sample_rate);



%A filtrar:

sound_channel= board_adc_data(2,:); %Canal del sonido
filtered_audio_data=filtfilt(d2,sound_channel); %filtfilt=zero-phase filtering, canal de audio filtrado
clear d2

pressure_channel=-board_adc_data(1,:);
b=max(-pressure_channel); 
c=b-0.7; %correccion para que Matlab pueda guardar los archivos
pressure_channel=pressure_channel+c;
filtered_pressure_channel=filtfilt(d1,pressure_channel);

 cd('F:\Datos Canarios Protocolos\Scripts\Procesamiento de raw data')
 
%% Filtros canales neuronales

 %Filtros para datos de senial neuronal
 %Design filters
    %Third order Butterworth highpass filter for neural signal
cutoff_freq=300; % Neural signal filter cutoff frequency in Hz
d3 = designfilt('highpassiir','FilterOrder',3,'HalfPowerFrequency',cutoff_freq,...
'DesignMethod','butter','SampleRate',30000);    


%A filtrar:
%filt_neural_data=cell(1,numch);
for k=1:15
filt_neural_data{1,k}=filtfilt(d3,amplifier_data(k,:)); %filtfilt=zero-phase filtering, canal neuronal filtrado
end
clear d3
clear channel_neural_data
clear cutoff_freq
channel_neural_data=cell2mat(filt_neural_data');


%% Ploteo con neuronas
q=[2 7 11 14];

f1=figure(1);
ax(1)=subplot(3+length(q),1,1);
plot(t_board_adc,filtered_audio_data);


window_width=30000/100;   %points
        [~,f,t,p] = spectrogram(filtered_audio_data,...
        gausswin(window_width,5),...
        ceil(0.75*window_width),...
        linspace(0,ceil(30000/2),...
        round(30000/window_width)),...
        30000,'yaxis');
    
ax(2)=subplot(3+length(q),1,2);
        imagesc('XData',t_board_adc,'YData',f,'CData',10*log10(p(1:100,:)));
        colormap(jet);
        ylim([0 10000]);
        
        
ax(3)=subplot(3+length(q),1,3);
plot(t_board_adc,filtered_pressure_channel);

for i=1:length(q)
ax(3+i)=subplot(3+length(q),1,3+i);
 plot(t_amplifier,channel_neural_data(q(i),:))
 ylabel(['Ch=' num2str(q(i)+7)]);
end


linkaxes(ax,'x')
equispace(f1)

cd([path '\Sesion screenshots 20-12-22'])
saveas(f1,[archivos{y} '.png'],'png')
cd('F:\Datos Canarios Protocolos\Scripts\Procesamiento de raw data')
end


%% A partir de aqui es archivos solo presion

%% Filtros canales analogicos

for i=5:length(archivos)
    
read_Intan_RHD2000_file([path archivos{y}]) % INTAN data file
sample_rate=30000;

 %Filtros para datos 
% a=dir(path); %lista de los nombres de archivos en la carpeta

 %    current_file=a(i).name;
     
 %read_Intan_RHD2000_file([path current_file]) % INTAN data file
 
%d1 = designfilt('lowpassiir','FilterOrder',3,'HalfPowerFrequency',100,...
%    'DesignMethod','butter','SampleRate',sample_rate);

%d2 = designfilt('highpassiir','FilterOrder',3,'HalfPowerFrequency',60,...
%    'DesignMethod','butter','SampleRate',sample_rate);


%A filtrar:

%sound_channel= board_adc_data(2,:); %Canal del sonido
%filtered_audio_data=filtfilt(d2,sound_channel); %filtfilt=zero-phase filtering, canal de audio filtrado
%clear d2

%pressure_channel=-board_adc_data(1,:);
%b=max(-pressure_channel);
%c=b-0.7;
%pressure_channel=pressure_channel+c;
%filtered_pressure_channel=filtfilt(d1,pressure_channel);

%cd(path)
 %audiowrite([current_file '-audio.wav'],filtered_audio_data,30000);
 %audiowrite([current_file '-pressure.wav'],filtered_pressure_channel,30000)

 %cd('F:\Datos Canarios Protocolos\Scripts\Procesamiento de raw data')
 %end
end
