%% Figuras individuales P1
%Script para plotear figuras individuales de cada frase de P1, sin
%normalizar

%% Cargo datos

load('D:\Datos Canarios Protocolos\Data procesada\spiketimesraw-P1-SU-all')

%% VeNe.S3 - P1(C)

audio_syll_raw=audio_syll_raw_P1C_VeNe([1:5, 11:13, 15:17, 22:23, 27:28, 30:31]);
onsets=onsets_P1C_VeNe([1:5, 11:13, 15:17, 22:23, 27:28, 30:31]);
offsets=offsets_P1C_VeNe([1:5, 11:13, 15:17, 22:23, 27:28, 30:31]);
binsize=3;

%tiempos para plotear sonido
for g=1:length(audio_syll_raw)
    time{g}=0:1000/sample_rate:length(audio_syll_raw{1,g})*1000/sample_rate;
end
time_max=max(cell2mat(time));

%inicio de la otra silaba
for i= 2:length(onsets_P1C_VeNe)
    ini_syll(i-1)=(onsets_P1C_VeNe(i)-onsets_P1C_VeNe(i-1))*1000;
end 

ini_syll=ini_syll([1:5, 11:13, 15:17, 22:23, 27:28, 30:31]);

% Ploteo

d(1)= subplot(5,1,1);

 window_width=sample_rate/100;   %points
        [~,f,t,p] = spectrogram(frase_P1C_VeNe,...
        gausswin(window_width,5),...
        ceil(0.75*window_width),...
        linspace(0,ceil(sample_rate/2),...
        round(sample_rate/window_width)),...
        sample_rate,'yaxis');
    
        imagesc('XData',t*1000,'YData',f,'CData',10*log10(p(1:100,:)));
        colormap(jet);
        ylim([0 10000]);
        ylabel ({'Espectrograma';'(frase)';'Frecuencia (Hz)'});
        xlabel('Tiempo(ms)')
        
d(2)= subplot(5,1,2);

for g=1:length(audio_syll_raw)
    plot(time{g}(1:end-1), audio_syll_raw{1,g})
    hold on
end
hold off

ylabel ({'Sonido'; '(individual)'; '(u.a.)'});

 d(3)= subplot(5,1,3:4);
 
    for k=1:length(spiketimes_raw_trial_P1C_VeNeS3)
        for s=1:length(spiketimes_raw_trial_P1C_VeNeS3{1,k})
  line(spiketimes_raw_trial_P1C_VeNeS3{1,k}(s)'*1000*[1 1],[-0.4 0.4] + k,'LineStyle','-','MarkerSize',15,'Color',[0.5 0 1]); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
        hold on
        end 
        for of=1:length(offsets)
  patch([0 0 (offsets(of)-onsets(of))*1000 (offsets(of)-onsets(of))*1000],[-0.4 0.4 0.4 -0.4] + of,[0.5 0.5 0.5],'FaceAlpha',0.025,'EdgeColor','none'); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
        end  
        for i=1:length(ini_syll)
        patch([ini_syll(i) ini_syll(i) d(2).XLim(2) d(2).XLim(2)],[-0.4 0.4 0.4 -0.4] + i,[0.5 0.7 0.7],'FaceAlpha',0.015,'EdgeColor','none'); 
        end 
    end 
ylabel('#silaba');
        
 d(4)= subplot(5,1,5);
hist_spikes_P1C_VeNeS3= cell2mat(spiketimes_raw_trial_P1C_VeNeS3)*1000;
[f,x]=ksdensity(hist_spikes_P1C_VeNeS3,'BandWidth',binsize,'function','pdf'); %funcion de suavizado
plot(x,f,'LineWidth',1,'Color',[0.5 0 1]);

ylabel({'Curva de'; 'suavizado'});
xlabel('Tiempo(ms)')
linkaxes(d(2:4),'x');

%% VeNe.S3 - P1(F)

audio_syll_raw=audio_syll_raw_P1F_VeNe;
onsets=onsets_P1F_VeNe(1:end-1);
offsets=offsets_P1F_VeNe(1:end-1);
binsize=3;

%tiempos para plotear sonido
for g=1:length(audio_syll_raw)
    time{g}=0:1000/sample_rate:length(audio_syll_raw{1,g})*1000/sample_rate;
end
time_max=max(cell2mat(time));

%inicio de la otra silaba
for i= 2:length(onsets_P1F_VeNe)
    ini_syll(i-1)=(onsets_P1F_VeNe(i)-onsets_P1F_VeNe(i-1))*1000;
end 

ini_syll=ini_syll(1:end-1);

% Ploteo

d(1)= subplot(5,1,1);

 window_width=sample_rate/100;   %points
        [~,f,t,p] = spectrogram(frase_P1F_VeNe,...
        gausswin(window_width,5),...
        ceil(0.75*window_width),...
        linspace(0,ceil(sample_rate/2),...
        round(sample_rate/window_width)),...
        sample_rate,'yaxis');
    
        imagesc('XData',t*1000,'YData',f,'CData',10*log10(p(1:100,:)));
        colormap(jet);
        ylim([0 10000]);
        ylabel ({'Espectrograma';'(frase)';'Frecuencia (Hz)'});
        xlabel('Tiempo(ms)')
        
d(2)= subplot(5,1,2);

for g=1:length(audio_syll_raw)
    plot(time{g}(1:end-1), audio_syll_raw{1,g})
    hold on
end
hold off

ylabel ({'Sonido'; '(individual)'; '(u.a.)'});

 d(3)= subplot(5,1,3:4);
 
    for k=1:length(spiketimes_raw_trial_P1F_VeNeS3)
        for s=1:length(spiketimes_raw_trial_P1F_VeNeS3{1,k})
  line(spiketimes_raw_trial_P1F_VeNeS3{1,k}(s)'*1000*[1 1],[-0.4 0.4] + k,'LineStyle','-','MarkerSize',15,'Color',[0.5 0.8 0]); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
        hold on
        end 
        for of=1:length(offsets)
  patch([0 0 (offsets(of)-onsets(of))*1000 (offsets(of)-onsets(of))*1000],[-0.4 0.4 0.4 -0.4] + of,[0.5 0.5 0.5],'FaceAlpha',0.015,'EdgeColor','none'); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
        end  
        for i=1:length(ini_syll)
        patch([ini_syll(i) ini_syll(i) d(2).XLim(2) d(2).XLim(2)],[-0.4 0.4 0.4 -0.4] + i,[0.5 0.7 0.7],'FaceAlpha',0.015,'EdgeColor','none'); 
        end 
    end 
ylabel('#silaba');
        
 d(4)= subplot(5,1,5);
hist_spikes_P1F_VeNeS3= cell2mat(spiketimes_raw_trial_P1F_VeNeS3)*1000;
[f,x]=ksdensity(hist_spikes_P1F_VeNeS3,'BandWidth',binsize,'function','pdf'); %funcion de suavizado
plot(x,f,'LineWidth',1,'Color',[0.5 0.8 0]);

ylabel({'Curva de'; 'suavizado'});
xlabel('Tiempo(ms)')
linkaxes(d(2:4),'x');

%% VeNe.S3 - P1(G)

audio_syll_raw=audio_syll_raw_P1G_VeNe([1,3,5:8,10:11,16:20,22:23,25:26,30:33,39:42]);
onsets=onsets_P1G_VeNe([1,3,5:8,10:11,16:20,22:23,25:26,30:33,39:42]);
offsets=offsets_P1G_VeNe([1,3,5:8,10:11,16:20,22:23,25:26,30:33,39:42]);
binsize=3;

%tiempos para plotear sonido
for g=1:length(audio_syll_raw)
    time{g}=0:1000/sample_rate:length(audio_syll_raw{1,g})*1000/sample_rate;
end
time_max=max(cell2mat(time));

%inicio de la otra silaba
for i= 2:length(onsets_P1G_VeNe)
    ini_syll(i-1)=(onsets_P1G_VeNe(i)-onsets_P1G_VeNe(i-1))*1000;
end 

ini_syll=ini_syll([1,3,5:8,10:11,16:20,22:23,25:26,30:33,39:42]);

% Ploteo

d(1)= subplot(5,1,1);

 window_width=sample_rate/100;   %points
        [~,f,t,p] = spectrogram(frase_P1G_VeNe,...
        gausswin(window_width,5),...
        ceil(0.75*window_width),...
        linspace(0,ceil(sample_rate/2),...
        round(sample_rate/window_width)),...
        sample_rate,'yaxis');
    
        imagesc('XData',t*1000,'YData',f,'CData',10*log10(p(1:100,:)));
        colormap(jet);
        ylim([0 10000]);
        ylabel ({'Espectrograma';'(frase)';'Frecuencia (Hz)'});
        xlabel('Tiempo(ms)')
        
d(2)= subplot(5,1,2);

for g=1:length(audio_syll_raw)
    plot(time{g}(1:end-1), audio_syll_raw{1,g})
    hold on
end
hold off

ylabel ({'Sonido'; '(individual)'; '(u.a.)'});

 d(3)= subplot(5,1,3:4);
 
    for k=1:length(spiketimes_raw_trial_P1G_VeNeS3)
        for s=1:length(spiketimes_raw_trial_P1G_VeNeS3{1,k})
  line(spiketimes_raw_trial_P1G_VeNeS3{1,k}(s)'*1000*[1 1],[-0.4 0.4] + k,'LineStyle','-','MarkerSize',15,'Color',[0.5 0 0]); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
        hold on
        end 
        for of=1:length(offsets)
  patch([0 0 (offsets(of)-onsets(of))*1000 (offsets(of)-onsets(of))*1000],[-0.4 0.4 0.4 -0.4] + of,[0.5 0.5 0.5],'FaceAlpha',0.015,'EdgeColor','none'); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
        end  
        for i=1:length(ini_syll)
        patch([ini_syll(i) ini_syll(i) d(2).XLim(2) d(2).XLim(2)],[-0.4 0.4 0.4 -0.4] + i,[0.5 0.7 0.7],'FaceAlpha',0.015,'EdgeColor','none'); 
        end 
    end 
ylabel('#silaba');
        
 d(4)= subplot(5,1,5);
hist_spikes_P1G_VeNeS3= cell2mat(spiketimes_raw_trial_P1G_VeNeS3)*1000;
[f,x]=ksdensity(hist_spikes_P1G_VeNeS3,'BandWidth',binsize,'function','pdf'); %funcion de suavizado
plot(x,f,'LineWidth',1,'Color',[0.5 0 0]);

ylabel({'Curva de'; 'suavizado'});
xlabel('Tiempo(ms)')
linkaxes(d(2:4),'x');

%% VeNe.S3 - P1(H)

audio_syll_raw=audio_syll_raw_P1H_VeNe([1:6,11,15:16,19:21]);
onsets=onsets_P1H_VeNe([1:6,11,15:16,19:21]);
offsets=offsets_P1H_VeNe([1:6,11,15:16,19:21]);
binsize=3;

%tiempos para plotear sonido
for g=1:length(audio_syll_raw)
    time{g}=0:1000/sample_rate:length(audio_syll_raw{1,g})*1000/sample_rate;
end
time_max=max(cell2mat(time));

%inicio de la otra silaba
for i= 2:length(onsets_P1H_VeNe)
    ini_syll(i-1)=(onsets_P1H_VeNe(i)-onsets_P1H_VeNe(i-1))*1000;
end 

ini_syll=ini_syll([1:6,11,15:16,19:21]);
    
% Ploteo

d(1)= subplot(5,1,1);

 window_width=sample_rate/100;   %points
        [~,f,t,p] = spectrogram(frase_P1H_VeNe,...
        gausswin(window_width,5),...
        ceil(0.75*window_width),...
        linspace(0,ceil(sample_rate/2),...
        round(sample_rate/window_width)),...
        sample_rate,'yaxis');
    
        imagesc('XData',t*1000,'YData',f,'CData',10*log10(p(1:100,:)));
        colormap(jet);
        ylim([0 10000]);
        ylabel ({'Espectrograma';'(frase)';'Frecuencia (Hz)'});
        xlabel('Tiempo(ms)')
        
d(2)= subplot(5,1,2);

for g=1:length(audio_syll_raw)
    plot(time{g}(1:end-1), audio_syll_raw{1,g})
    hold on
end
hold off

ylabel ({'Sonido'; '(individual)'; '(u.a.)'});

 d(3)= subplot(5,1,3:4);
 
    for k=1:length(spiketimes_raw_trial_P1H_VeNeS3)
        for s=1:length(spiketimes_raw_trial_P1H_VeNeS3{1,k})
  line(spiketimes_raw_trial_P1H_VeNeS3{1,k}(s)'*1000*[1 1],[-0.4 0.4] + k,'LineStyle','-','MarkerSize',15,'Color',[0.2 0.2 0.2]); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
        hold on
        end 
        for of=1:length(offsets)
  patch([0 0 (offsets(of)-onsets(of))*1000 (offsets(of)-onsets(of))*1000],[-0.4 0.4 0.4 -0.4] + of,[0.5 0.5 0.5],'FaceAlpha',0.015,'EdgeColor','none'); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
        end  
        for i=1:length(ini_syll)
        patch([ini_syll(i) ini_syll(i) d(2).XLim(2) d(2).XLim(2)],[-0.4 0.4 0.4 -0.4] + i,[0.5 0.7 0.7],'FaceAlpha',0.015,'EdgeColor','none'); 
        end 
    end 
ylabel('#silaba');
        
 d(4)= subplot(5,1,5);
hist_spikes_P1H_VeNeS3= cell2mat(spiketimes_raw_trial_P1H_VeNeS3)*1000;
[f,x]=ksdensity(hist_spikes_P1H_VeNeS3,'BandWidth',binsize,'function','pdf'); %funcion de suavizado
plot(x,f,'LineWidth',1,'Color',[0.2 0.2 0.2]);

ylabel({'Curva de'; 'suavizado'});
xlabel('Tiempo(ms)')
linkaxes(d(2:4),'x');

%% RoNe.S2 - P1(K)

audio_syll_raw=audio_syll_raw_P1K_RoNe([1:8, 10:12, 14:25]);
onsets=onsets_P1K_RoNe([1:8, 10:12, 14:25]);
offsets=offsets_P1K_RoNe([1:8, 10:12, 14:25]);
binsize=3;

%tiempos para plotear sonido
for g=1:length(audio_syll_raw)
    time{g}=0:1000/sample_rate:length(audio_syll_raw{1,g})*1000/sample_rate;
end
time_max=max(cell2mat(time));

%inicio de la otra silaba
for i= 2:length(onsets_P1K_RoNe)
    ini_syll(i-1)=(onsets_P1K_RoNe(i)-onsets_P1K_RoNe(i-1))*1000;
end 

ini_syll=ini_syll([1:8, 10:12, 14:25]);

% Ploteo

d(1)= subplot(5,1,1);

 window_width=sample_rate/100;   %points
        [~,f,t,p] = spectrogram(frase_P1K_RoNe,...
        gausswin(window_width,5),...
        ceil(0.75*window_width),...
        linspace(0,ceil(sample_rate/2),...
        round(sample_rate/window_width)),...
        sample_rate,'yaxis');
    
        imagesc('XData',t*1000,'YData',f,'CData',10*log10(p(1:100,:)));
        colormap(jet);
        ylim([0 10000]);
        ylabel ({'Espectrograma';'(frase)';'Frecuencia (Hz)'});
        xlabel('Tiempo(ms)')
        
d(2)= subplot(5,1,2);

for g=1:length(audio_syll_raw)
    plot(time{g}(1:end-1), audio_syll_raw{1,g})
    hold on
end
hold off

ylabel ({'Sonido'; '(individual)'; '(u.a.)'});

 d(3)= subplot(5,1,3:4);
 
    for k=1:length(spiketimes_raw_trial_P1K_RoNeS2)
        for s=1:length(spiketimes_raw_trial_P1K_RoNeS2{1,k})
  line(spiketimes_raw_trial_P1K_RoNeS2{1,k}(s)'*1000*[1 1],[-0.4 0.4] + k,'LineStyle','-','MarkerSize',15,'Color','k'); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
        hold on
        end 
        for of=1:length(offsets)
  patch([0 0 (offsets(of)-onsets(of))*1000 (offsets(of)-onsets(of))*1000],[-0.4 0.4 0.4 -0.4] + of,[0.5 0.5 0.5],'FaceAlpha',0.015,'EdgeColor','none'); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
        end 
        for i=1:length(ini_syll)
        patch([ini_syll(i) ini_syll(i) d(2).XLim(2) d(2).XLim(2)],[-0.4 0.4 0.4 -0.4] + i,[0.5 0.7 0.7],'FaceAlpha',0.015,'EdgeColor','none'); 
        end 
    end 
ylabel('#silaba');
        
 d(4)= subplot(5,1,5);
hist_spikes_P1K_RoNeS3= cell2mat(spiketimes_raw_trial_P1K_RoNeS2)*1000;
[f,x]=ksdensity(hist_spikes_P1K_RoNeS3,'BandWidth',binsize,'function','pdf'); %funcion de suavizado
plot(x,f,'LineWidth',1,'Color','k');

ylabel({'Curva de'; 'suavizado'});
xlabel('Tiempo(ms)')
linkaxes(d(2:4),'x');
%% RoNe.S2 - P1(F)

audio_syll_raw=audio_syll_raw_P1F2_RoNe([1:7 10:11 16:end]);
onsets=onsets_P1F2_RoNe([1:7 10:11 16:end]);
offsets=offsets_P1F2_RoNe([1:7 10:11 16:end]);
binsize=3;

%tiempos para plotear sonido
for g=1:length(audio_syll_raw)
    time{g}=0:1000/sample_rate:length(audio_syll_raw{1,g})*1000/sample_rate;
end
time_max=max(cell2mat(time));

for i= 2:length(onsets_P1F2_RoNe)
    ini_syll(i-1)=(onsets_P1F2_RoNe(i)-onsets_P1F2_RoNe(i-1))*1000;
end 

ini_syll=ini_syll([1:7 10:11 16:end]);

% Ploteo

d(1)= subplot(5,1,1);

 window_width=sample_rate/100;   %points
        [~,f,t,p] = spectrogram(frase_P1F2_RoNe,...
        gausswin(window_width,5),...
        ceil(0.75*window_width),...
        linspace(0,ceil(sample_rate/2),...
        round(sample_rate/window_width)),...
        sample_rate,'yaxis');
    
        imagesc('XData',t*1000,'YData',f,'CData',10*log10(p(1:100,:)));
        colormap(jet);
        ylim([0 10000]);
        ylabel ({'Espectrograma';'(frase)';'Frecuencia (Hz)'});
        xlabel('Tiempo(ms)')
        
d(2)= subplot(5,1,2);

for g=1:length(audio_syll_raw)
    plot(time{g}(1:end-1), audio_syll_raw{1,g})
    hold on
end
hold off

ylabel ({'Sonido'; '(individual)'; '(u.a.)'});

 d(3)= subplot(5,1,3:4);
 
    for k=1:length(spiketimes_raw_trial_P1F2_RoNeS2)
        for s=1:length(spiketimes_raw_trial_P1F2_RoNeS2{1,k})
  line(spiketimes_raw_trial_P1F2_RoNeS2{1,k}(s)'*1000*[1 1],[-0.4 0.4] + k,'LineStyle','-','MarkerSize',15,'Color','b'); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
        hold on
        end 
        for of=1:length(offsets)
  patch([0 0 (offsets(of)-onsets(of))*1000 (offsets(of)-onsets(of))*1000],[-0.4 0.4 0.4 -0.4] + of,[0.5 0.5 0.5],'FaceAlpha',0.015,'EdgeColor','none'); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
        end 
        for i=1:length(ini_syll)
        patch([ini_syll(i) ini_syll(i) d(2).XLim(2) d(2).XLim(2)],[-0.4 0.4 0.4 -0.4] + i,[0.5 0.7 0.7],'FaceAlpha',0.015,'EdgeColor','none'); 
        end 
    end 
ylabel('#silaba');
        
 d(4)= subplot(5,1,5);
hist_spikes_P1F2_RoNeS3= cell2mat(spiketimes_raw_trial_P1F2_RoNeS2)*1000;
[f,x]=ksdensity(hist_spikes_P1F2_RoNeS3,'BandWidth',binsize,'function','pdf'); %funcion de suavizado
plot(x,f,'LineWidth',1,'Color','b');

ylabel({'Curva de'; 'suavizado'});
xlabel('Tiempo(ms)')
linkaxes(d(2:4),'x');

%% RoNe.S2 - P1(E)

audio_syll_raw=[audio_syll_raw_P1E1_RoNe([1:4 15:end]) audio_syll_raw_P1E2_RoNe([1:7 16:17])];
onsets=[onsets_P1E1_RoNe([1:4 15:end-1]) onsets_P1E2_RoNe([1:7 16:17])];onsets_P1E1_RoNe
offsets=[offsets_P1E1_RoNe([1:4 15:end-1]) offsets_P1E2_RoNe([1:7 16:17])];
binsize=3;

%tiempos para plotear sonido
for g=1:length(audio_syll_raw)
    time{g}=0:1000/sample_rate:length(audio_syll_raw{1,g})*1000/sample_rate;
end
time_max=max(cell2mat(time));

for i= 2:length(onsets_P1E1_RoNe)
    ini_syll(i-1)=(onsets_P1E1_RoNe(i)-onsets_P1E1_RoNe(i-1))*1000;
end 

ini_syll=ini_syll([1:4 15:end-1]);

for i= 2:length(onsets_P1E2_RoNe)
    ini_syll2(i-1)=(onsets_P1E2_RoNe(i)-onsets_P1E2_RoNe(i-1))*1000;
end 
 ini_syll2= ini_syll2([1:7 16:17]);
 
 ini_syll=[ini_syll 80 ini_syll2];
 clear ini_syll2
 
% Ploteo

d(1)= subplot(5,1,1);

 window_width=sample_rate/100;   %points
        [~,f,t,p] = spectrogram([frase_P1E1_RoNe frase_P1E2_RoNe],...
        gausswin(window_width,5),...
        ceil(0.75*window_width),...
        linspace(0,ceil(sample_rate/2),...
        round(sample_rate/window_width)),...
        sample_rate,'yaxis');
    
        imagesc('XData',t*1000,'YData',f,'CData',10*log10(p(1:100,:)));
        colormap(jet);
        ylim([0 10000]);
        ylabel ({'Espectrograma';'(frase)';'Frecuencia (Hz)'});
        xlabel('Tiempo(ms)')
        
d(2)= subplot(5,1,2);

for g=1:length(audio_syll_raw)
    plot(time{g}(1:end-1), audio_syll_raw{1,g})
    hold on
end
hold off

ylabel ({'Sonido'; '(individual)'; '(u.a.)'});

 d(3)= subplot(5,1,3:4);
 
    for k=1:length(spiketimes_raw_trial_P1E1_RoNeS2)
        for s=1:length(spiketimes_raw_trial_P1E1_RoNeS2{1,k})
  line(spiketimes_raw_trial_P1E1_RoNeS2{1,k}(s)'*1000*[1 1],[-0.4 0.4] + k,'LineStyle','-','MarkerSize',15,'Color',[0,0.3882,0]); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
        hold on
        end 
        for of=1:length(offsets)
  patch([0 0 (offsets(of)-onsets(of))*1000 (offsets(of)-onsets(of))*1000],[-0.4 0.4 0.4 -0.4] + of,[0.5 0.5 0.5],'FaceAlpha',0.025,'EdgeColor','none'); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
        end 
    end 
    for h=1:length(spiketimes_raw_trial_P1E2_RoNeS2)
        for s=1:length(spiketimes_raw_trial_P1E2_RoNeS2{1,h})
  line(spiketimes_raw_trial_P1E2_RoNeS2{1,h}(s)'*1000*[1 1],[-0.4 0.4] + k + h,'LineStyle','-','MarkerSize',15,'Color',[1,0.3,0]); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
        end 
        for i=1:length(ini_syll)
        patch([ini_syll(i) ini_syll(i) d(2).XLim(2) d(2).XLim(2)],[-0.4 0.4 0.4 -0.4] + i,[0.5 0.7 0.7],'FaceAlpha',0.015,'EdgeColor','none'); 
        end 
    end 
    hold off
ylabel('#silaba');
        
 d(4)= subplot(5,1,5);
hist_spikes_P1E1_RoNeS3= cell2mat(spiketimes_raw_trial_P1E1_RoNeS2)*1000;
[f,x]=ksdensity(hist_spikes_P1E1_RoNeS3,'BandWidth',binsize,'function','pdf'); %funcion de suavizado
plot(x,f,'LineWidth',1,'Color',[0,0.3882,0]);
hold on
hist_spikes_P1E2_RoNeS3= cell2mat(spiketimes_raw_trial_P1E2_RoNeS2)*1000;
[f1,x1]=ksdensity(hist_spikes_P1E2_RoNeS3,'BandWidth',binsize,'function','pdf'); %funcion de suavizado
plot(x1,f1,'LineWidth',1,'Color',[1,0.3,0]);

ylabel({'Curva de'; 'suavizado'});
xlabel('Tiempo(ms)')
linkaxes(d(2:4),'x');

%% RoNe.S5 - P1(F)

audio_syll_raw= [audio_syll_raw_P1F1_RoNe([1:4 7:16]) audio_syll_raw_P1F2_RoNe(2:end-1)];
onsets=[onsets_P1E1_RoNe([1:4 7:16]) onsets_P1E2_RoNe(2:end-1)];
offsets=[offsets_P1E1_RoNe([1:4 7:16]) offsets_P1E2_RoNe(2:end-1)];
binsize=3;

%tiempos para plotear sonido
for g=1:length(audio_syll_raw)
    time{g}=0:1000/sample_rate:length(audio_syll_raw{1,g})*1000/sample_rate;
end
time_max=max(cell2mat(time));

for i= 2:length(onsets_P1F1_RoNe)
    ini_syll(i-1)=(onsets_P1F1_RoNe(i)-onsets_P1F1_RoNe(i-1))*1000;
end 

ini_syll=ini_syll([1:4 7:16]);

for i= 2:length(onsets_P1F2_RoNe)
    ini_syll2(i-1)=(onsets_P1F2_RoNe(i)-onsets_P1F2_RoNe(i-1))*1000;
end 
 ini_syll2= ini_syll2(2:end-1);
 
 ini_syll=[ini_syll ini_syll2];
 clear ini_syll2
 
% Ploteo

d(1)= subplot(5,1,1);

 window_width=sample_rate/100;   %points
        [~,f,t,p] = spectrogram([frase_P1F1_RoNe frase_P1F2_RoNe],...
        gausswin(window_width,5),...
        ceil(0.75*window_width),...
        linspace(0,ceil(sample_rate/2),...
        round(sample_rate/window_width)),...
        sample_rate,'yaxis');
    
        imagesc('XData',t*1000,'YData',f,'CData',10*log10(p(1:100,:)));
        colormap(jet);
        ylim([0 10000]);
        ylabel ({'Espectrograma';'(frase)';'Frecuencia (Hz)'});
        xlabel('Tiempo(ms)')
        
d(2)= subplot(5,1,2);

for g=1:length(audio_syll_raw)
    plot(time{g}(1:end-1), audio_syll_raw{1,g})
    hold on
end
hold off

ylabel ({'Sonido'; '(individual)'; '(u.a.)'});

 d(3)= subplot(5,1,3:4);
 
    for k=1:length(spiketimes_raw_trial_P1F1_RoNeS5)
        for s=1:length(spiketimes_raw_trial_P1F1_RoNeS5{1,k})
  line(spiketimes_raw_trial_P1F1_RoNeS5{1,k}(s)'*1000*[1 1],[-0.4 0.4] + k,'LineStyle','-','MarkerSize',15,'Color',[0 1 1]); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
        hold on
        end 
        for of=1:length(offsets)
  patch([0 0 (offsets(of)-onsets(of))*1000 (offsets(of)-onsets(of))*1000],[-0.4 0.4 0.4 -0.4] + of,[0.5 0.5 0.5],'FaceAlpha',0.025,'EdgeColor','none'); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
        end 
    end 
    for h=1:length(spiketimes_raw_trial_P1F2_RoNeS5)
        for s=1:length(spiketimes_raw_trial_P1F2_RoNeS5{1,h})
  line(spiketimes_raw_trial_P1F2_RoNeS5{1,h}(s)'*1000*[1 1],[-0.4 0.4] + k + h,'LineStyle','-','MarkerSize',15,'Color',[1 0 0.5]); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
        end 
        for i=1:length(ini_syll)
        patch([ini_syll(i) ini_syll(i) d(2).XLim(2) d(2).XLim(2)],[-0.4 0.4 0.4 -0.4] + i,[0.5 0.7 0.7],'FaceAlpha',0.015,'EdgeColor','none'); 
        end 
    end 
    hold off
ylabel('#silaba');
        
 d(4)= subplot(5,1,5);
hist_spikes_P1F1_RoNeS5= cell2mat(spiketimes_raw_trial_P1F1_RoNeS5)*1000;
[f,x]=ksdensity(hist_spikes_P1F1_RoNeS5,'BandWidth',binsize,'function','pdf'); %funcion de suavizado
plot(x,f,'LineWidth',1,'Color',[0 1 1]);
hold on
hist_spikes_P1F2_RoNeS5= cell2mat(spiketimes_raw_trial_P1F2_RoNeS5)*1000;
[f1,x1]=ksdensity(hist_spikes_P1F2_RoNeS5,'BandWidth',binsize,'function','pdf'); %funcion de suavizado
plot(x1,f1,'LineWidth',1,'Color',[1 0 0.5]);

ylabel({'Curva de'; 'suavizado'});
xlabel('Tiempo(ms)')
linkaxes(d(2:4),'x');