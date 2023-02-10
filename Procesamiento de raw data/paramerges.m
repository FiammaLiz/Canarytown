%% Dejo escrito algunas lineas que me ayudan a unir protocolos
%En caso de que haya hecho protocolos de N=10 y valga la pena unirlos
%¡Podria iterarse para automatizar resolver el problema de protocolos de files de 1 min!
%Recordar primero usar Levantar_data para el primer protocolo y correr la
%primera seccion

%% Seccion 1: primer protocolo 

filtered_audio_data1=filtered_audio_data;
filtered_stimuli_data1=filtered_stimuli_data;
filtered_neural_data1=filtered_neural_data;
name_stim1=name_stim;
num_stim1=num_stim;
t0s1=t0s;
t_amplifier1=t_amplifier;
t_board_adc1=t_board_adc;
y1=y;
ntrials1=ntrials;

%% Seccion 2: segundo protocolo
%Correr una vez levantado los datos del segundo protocolo


 filtered_audio_data=[filtered_audio_data1 filtered_audio_data];
 clear filtered_audio_data1
 filtered_stimuli_data=[filtered_stimuli_data1 filtered_stimuli_data];
 clear filtered_stimuli_data1
 filtered_neural_data=[filtered_neural_data1; filtered_neural_data];
 clear filtered_neural_data1
 
 name_stim=[name_stim1 name_stim];
 clear name_stim1
 num_stim=[num_stim1 num_stim];
 clear num_stim1
 
t0s=[t0s1 t0s+t_board_adc1(end)];
clear t0s1
t_amplifier=[t_amplifier1 t_amplifier+t_amplifier1(end)];
clear t_amplifier1
t_board_adc=[t_board_adc1 t_board_adc+t_board_adc1(end)];
clear t_board_adc1
y=[y1 y];
clear y1
ntrials= ntrials1 +ntrials;
clear ntrials1

file= 'mergeprotocolo5-6';
protocolo= 'mergeprotocolo5-6';

%% Guardo en un .mat

cd (path)
save ([file '.mat'],'-v7.3')
cd(path_function)
