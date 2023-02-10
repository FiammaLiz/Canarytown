%% Script para explorar archivos trigger
%Abre los archivos .rhd, los lee y realiza una figura sonido-ch neuronal

%% Cardo datos y filtro


file='trigger_VioAma_221228_1142321.rhd';
path='F:\Datos Canarios Protocolos\ca001-VioAma\122822\';
read_Intan_RHD2000_file([path file]) % INTAN data file
sample_rate=30000;

 %Filtros para datos de senial neuronal
 %Design filters
    %Third order Butterworth highpass filter for neural signal
cutoff_freq=300; % Neural signal filter cutoff frequency in Hz
d1 = designfilt('highpassiir','FilterOrder',3,'HalfPowerFrequency',cutoff_freq,...
'DesignMethod','butter','SampleRate',30000);    
    %Third order Butterworth highpass filter for audio signal
d2 = designfilt('highpassiir','FilterOrder',3,'HalfPowerFrequency',60,...
    'DesignMethod','butter','SampleRate',sample_rate);


%A filtrar:
%filt_neural_data=cell(1,numch);
for k=1:15
filt_neural_data{1,k}=filtfilt(d1,amplifier_data(k,:)); %filtfilt=zero-phase filtering, canal neuronal filtrado
end
clear d1
clear channel_neural_data
clear cutoff_freq
channel_neural_data=cell2mat(filt_neural_data');

sound_channel= board_adc_data(2,:); %Canal del sonido
filtered_audio_data=filtfilt(d2,sound_channel); %filtfilt=zero-phase filtering, canal de audio filtrado
clear d2

%% Ploteo

%Ch que me interesa (un tetrodo o un ch representativo que se observa in
%situ)

q=[3 7 12 14];
%q=1:4;
%q=5:8;
%q=[9 11 12];
%q=13:15;

f2=figure(2);

%Onda de sonido
ax(1)=subplot(6,1,1);
plot(t_amplifier,filtered_audio_data);

%Espectrograma
window_width=30000/100;   %points
        [~,f,t,p] = spectrogram(filtered_audio_data,...
        gausswin(window_width,5),...
        ceil(0.75*window_width),...
        linspace(0,ceil(30000/2),...
        round(30000/window_width)),...
        30000,'yaxis');
    
ax(2)=subplot(6,1,2);
        imagesc('XData',t_amplifier,'YData',f,'CData',10*log10(p(1:100,:)));
        colormap(jet);
        ylim([0 10000]);

%Un subplot por cada ch neuronal seleccionado
for i=1:length(q)
ax(2+i)=subplot(6,1,2+i);
 plot(t_amplifier,channel_neural_data(q(i),:))
 ylabel(['Ch=' num2str(q(i)+7)]);
end

 linkaxes(ax,'x');
 equispace(f1)
 