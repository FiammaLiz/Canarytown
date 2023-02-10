%% Script para extraer data de P1 sin normalizar

%% Delimito frase
 silaba= 'P1(F)'; %poner identidad de sílaba que me va a interesar
 n=1; %identificador del estimulo (BOS/CON/REV)
 g=1; 
 %Para extraer el momento temporal de la silaba en BOS
 find_sil= strfind(tg(n).tier{1,1}.Label,silaba); %encuentra los indices donde esta la silaba de interes
 frase_position_logical = ~cellfun(@isempty,find_sil); %paso a array logico para poder indexar
 frase_position_init=tg(n).tier{1,1}.T1(frase_position_logical); %encuentro el valor de tiempo inicial de la frase en esos indices
 frase_position_end=tg(n).tier{1,1}.T2(frase_position_logical);  %y el final de la frase
 sound=audio_stim{n}(t_audio_stim{n}>=(frase_position_init(g))& t_audio_stim{n}<=frase_position_end(g));
 times= t_audio_stim{n}(t_audio_stim{n}>=(frase_position_init(g))& t_audio_stim{n}<=frase_position_end(g));
 
fig= figure(1);

 a(1)=subplot(3,1,1);
 %Frase ejemplo
 plot((1:length(frase_P1E1_RoNe))*1000/sample_rate,frase_P1E1_RoNe)
 
 a(2)=subplot(3,1,2);
  %Para extraer spikes de una frase
 for x=1:ntrials(1)
 spikes_frase{x}=(spike_stim(n).trial{1,x}(spike_stim(n).trial{1,x}>=(frase_position_init(g)-0.1)& spike_stim(n).trial{1,x}<=frase_position_end(g))-frase_position_init(g))*1000;
 end 
   for k=1:length(spikes_frase)
   for s=1:length(spikes_frase{1,k})
  line(spikes_frase{1,k}(s)'*[1 1],[-0.4 0.4] + k,'LineStyle','-','MarkerSize',15,'Color',[0.2 0.2 0.2]); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
        hold on
   end
   end
   
  a(3)=subplot(3,1,3);
  binsize=5;
    hist_spikes=cell2mat(spikes_frase); %agrupo las instancias spikes del mismo estimulo en un solo vector para funcion histograma
    histogram(hist_spikes,'BinWidth', binsize,'FaceAlpha',0,'EdgeColor','none'); %segundo eje con valores absolutos
    ylabel ('PSTH(disparos/s)')       
    [xi,f]=ksdensity(hist_spikes,'BandWidth',binsize,'function','pdf'); %funcion de suavizado para histograma
    plot(f,xi,'LineWidth',1,'Color','r')
    hold on
   
linkaxes(a,'x')

 %% Delimitacion de silabas
 
%Detecto inicios y finales de sílaba
params.fs=sample_rate;
params.birdname='BF';

params=def_params(params);
[gtes]=find_gte(sound,params);
onsets=times(gtes.gtes1);
offsets=times(gtes.gtes2);

clear gtes
clear params

%Testeo para ver si me detecto bien los inicios de las silabas

ax(1)=subplot(1,1,1);
plot(times,sound);
hold on
for j=1:length(onsets)
line(onsets(j)*[1 1],ax(1).YLim,'LineStyle','-','MarkerSize',5,'Color',[0.8 0.8 0]);
line(offsets(j)*[1 1],ax(1).YLim,'LineStyle','-','MarkerSize',5,'Color',[0.1 0.1 0]);
end
clear j

    %% Separo sílabas y spiketimes
offsets_samples=round(offsets*sample_rate); %Paso a samples los valores de offsets
onsets_samples=round(onsets*sample_rate);
a=1;

%Obtengo las sílabas (de offset a offset)
for t=1:length(offsets)  
syllables_P1F_VeNe(t)={audio_stim{a}(onsets_samples(t):offsets_samples(t))};
end  
clear t

%Obtengo los spikes de cada sílaba por separado

for h=1:length(offsets)-1
spikes_stim_all=cell2mat(spike_stim(a).trial); %vector con los spiketimes de todos los trials
spike_train{h}=(spikes_stim_all((spikes_stim_all>=onsets(h)+0.02)&(spikes_stim_all<=onsets(h+1)))-onsets(h))*1000; %separo spiketimes de offset a offset y los alineo al 0 con el onset
end 

spiketimes_raw_trial_P1F_VeNe2=spike_train;
offsets_P1F_VeNe=offsets;
%% Corroboro que la detección sea coherente

f1=figure(2);
binsize= 5;
d(1)= subplot(5,1,1);
for g=1:length(syllables_P1F_VeNe)
    time=0:1000/sample_rate:length(syllables_P1F_VeNe{1,g})*1000/sample_rate;
    plot(time(1:end-1), syllables_P1F_VeNe{1,g})
    hold on
end
hold off
ylabel ('Sonido (u.a.)');

d(2)= subplot(5,1,2:3);
    for k=1:length(spiketimes_raw_trial_P1F_VeNe2)
        for t=1:length(spiketimes_raw_trial_P1F_VeNe2{1,k})
  line(spiketimes_raw_trial_P1F_VeNe2{1,k}(t)'*[1 1],[-0.4 0.4] + k,'LineStyle','-','MarkerSize',15,'Color','b'); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
        hold on
        end 
    end 

    linkaxes(d,'x')
    
    %% Save 
    
    save('P1_spiketimes_raw','audio_syll_raw_P1E1_RoNe','frase_P1E1_RoNe','offsets_RoNe_P1E1','spiketimes_raw_trial_P1E1_RoNe1',...
        'audio_syll_raw_P1E2_RoNe','frase_P1E2_RoNe','offsets_RoNe_P1E2','spiketimes_raw_trial_P1E2_RoNe1',...
         'audio_syll_raw_P1F1_RoNe','frase_P1F1_RoNe','offsets_RoNe_P1F1','spiketimes_raw_trial_P1F1_RoNe1',...
         'audio_syll_raw_P1F2_RoNe','frase_P1F2_RoNe','offsets_RoNe_P1F2','spiketimes_raw_trial_P1F2_RoNe1',...
         'audio_syll_raw_P1E_VeNe','frase_P1E_VeNe','offsets_VeNe_P1E','spiketimes_raw_trial_P1E_VeNe1',...
          'offsets_P1H_VeNe','spiketimes_raw_trial_P1H_VeNe', 'offsets_P1F_VeNe','spiketimes_raw_trial_P1F_VeNe2');
