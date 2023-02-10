function spikecheck_concatenado ( t_board_adc, t_amplifier, sample_rate, ... 
filtered_audio_data, channel_neural_data, spike_lcs_ss,... 
comienzo_auditivo,thr) 
%Check spike detection
%Devuelve una figura con el canal neuronal seleccionado (raw data) donde marco umbral y eventos
%de spike
%Matlab 2017a
%Fiamma Liz Leites

spike_times= cell2mat(spike_lcs_ss)/sample_rate;
f1=figure(1);
%Canal de audio 
h(1)=subplot(2,1,1);
plot(t_board_adc,filtered_audio_data);  %Audio filtrado de estimulos pasados
ylabel 'Canal audio'
title 'Chequeo de deteccion de spikes'

%Raw data con marquitas de spikes
h(2)=subplot(2,1,2);
plot(t_amplifier,channel_neural_data,'Color','k') %Canal neuronal
hold on

%Agrego lineas con spikes detectados (rojas, verticales)
line((spike_times'*[1 1])',[thr+10 thr+50],'LineStyle','-','MarkerSize',4,'Color','r','LineWidth',0.05); 
hold off
ylabel 'Raw data con spikes marcados'
xlabel 'tiempo/[s]'

linkaxes(h,'x'); %alinea los ceros
equispace(f1); %pega los ejes
end 