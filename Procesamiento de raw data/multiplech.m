%% MULTIPLECH
%Para hacer  histogramas de todos los canales con un mismo umbral (std 5,
%consolidación)
%Fiamma Liz Leites
%Script para Matlab 2017a
%Version 23/04/2021

%% Selecciono canal y umbrales

%desired_channels_neural= 8:11; canales= '8 a 11';
desired_channels_neural= 12:15; canales= '12 a 15';
%desired_channels_neural= 16:19; canales= '16 a 19';
%desired_channels_neural= 20:23; canales= '20 a 23';
numch=length(desired_channels_neural);

%Para poder llamar solo los 4 canales que quiero arriba
channels_neural= zeros(1,numch);

for ch = 1:numch
    channels_neural(ch)=find(chip_channels==desired_channels_neural(ch));
end


%Extract data from desired channel
channel_neural_data=filtered_neural_data(:,channels_neural);

maximo= 500; %tamaño del shoulder de arriba
minimo= -800; %tamaño del spike, para eliminar artefactos de twcnica para spike shape
std_min=-4; %Desvio estandar
binsize= 0.005;

%% Detecto los spikes


spikesperchannel=struct('stim', cell(1,length(unique(num_stim))));
for i=1:length(desired_channels_neural) %para todos los canales
    abs_neural_data= abs(channel_neural_data(:,i)); %Valor absoluto de los datos
    std_noise_detect=median(abs_neural_data)/0.6745; %Calcula desvio estandar de mediana de los datos
    thr= std_min*std_noise_detect; %calcula thr como x desvios estandar de la mediana
    clear abs_neural_data
    clear std_noise_detect
    [spike_lcs, spike_times, spike_tot, s, ntrials, duracion_stim, L, spike_stim, spike_lcs_ss]=spikedetection (maximo,minimo,thr, channel_neural_data(:,i), sample_rate, num_stim, t0s, t_audio_stim, pausa); %levanto los spikes
    for a=1:length(unique(num_stim))
        for k=1:ntrials(a)
    spikesperchannel(a).stim(i).ch{k}=spike_stim(a).trial{1,k}; %los guardo en un struct por estimulo y ch
        end 
    end
    clear thr
end 

%% Ploteo

for n=1:length(unique(num_stim)) %para cada estimulo
    f1= figure(n); %hace una figura
    
    h(1)=subplot(3+numch,1,1);
      %Espectograma del estimulo
        window_width=sample_rate/100;   %points
        [~,f,t,p] = spectrogram(audio_stim{n},...
        gausswin(window_width,5),...
        ceil(0.75*window_width),...
        linspace(0,ceil(sample_rate/2),...
        round(sample_rate/window_width)),...
        sample_rate,'yaxis');
    
        imagesc('XData',t,'YData',f,'CData',10*log10(p(1:100,:)));
        colormap(jet);
        ylim([0 10000]);
        xlim([-L duracion_stim(1)+L]); %limite de ventana en x
        hold on
        line([0 0],h(1).YLim,'LineStyle','-','MarkerSize',4,'Color',[0.5 0.5 0.5]); %linea de principio de estimulo
        line((t_audio_stim{n}(length(t_audio_stim{n}))*[1 1])',h(1).YLim,'LineStyle','-','MarkerSize',4,'Color',[0.5 0.5 0.5 0.6]); %linea de fin de estimulo
        hold off
        ylabel ('Espectograma', 'FontSize', 10);
        title 'Histogramas de un tetrodo'
        
     h(2)=subplot(3+numch,1,2);
        %Audio del estimulo
        plot(t_audio_stim{n}, audio_stim{n}); %grafico el audio
        hold on
        line([0 0],h(2).YLim,'LineStyle','-','MarkerSize',4,'Color',[0.5 0.5 0.5]); %linea de principio de estimulo
        line((t_audio_stim{n}(length(t_audio_stim{n}))*[1 1])',h(2).YLim,'LineStyle','-','MarkerSize',4,'Color',[0.5 0.5 0.5 0.6]); %linea de fin de estimulo
        hold off
        xlim([-L duracion_stim(n)+L]); %pongo de limite a la ventana seleccionada
        ylabel ('Estimulo', 'FontSize', 10);
        
    hist_spike_ch=cell(1,numch);
for ch = 1:numch %para cada umbral
    hist_spike_ch{ch}=spikesperchannel(n).stim(ch); %junta los datos para hacer el histograma
    
     h(2+ch)= subplot(3+numch,1,2+ch);
         histogram(cell2mat(hist_spike_ch{1,ch}.ch),'BinWidth',binsize,'Normalization','pdf'); %hago histograma, convirtiendo mis datos en un solo vector para que histogram lo tome
         hold on
         [f,xi]=ksdensity(cell2mat(hist_spike_ch{1,ch}.ch),'BandWidth',binsize,'NumPoints',100000, 'function', 'pdf');
         plot(xi,f,'LineWidth',1,'Color','r')
         line([0 0],h(2+ch).YLim,'LineStyle','-','MarkerSize',4,'Color',[0.5 0.5 0.5]); %linea de principio de estimulo
         line((duracion_stim(n)*[1 1])',h(2+ch).YLim,'LineStyle','-','MarkerSize',4,'Color',[0.5 0.5 0.5 0.6]); %linea de fin de estimulo
         xlim([-L duracion_stim(n)+L]); %Pongo de limite a la ventana seleccionada
         ylabel(['Ch=' num2str(desired_channels_neural(ch))], 'FontSize', 10); %Nombro el umbral usado en el eje y
         %ylim([0 1])
end 
        xlabel ('tiempo/[s]');
        %Tabla con datos
        estimulo=name_stim(num_stim==n); %nombre del estimulo
        estimulo=char(estimulo(1)); %para tenerlo una sola vez
        
        colnames={'Ave', 'Fecha', 'Protocolo', 'Estimulo','Repeticiones','Profundidad', 'Canal', 'Binsize histograma'};
        valuetable={ave, fecha, file, estimulo, ntrials(n), profundidad, canales, binsize};       
        t = uitable(f1,'Data', valuetable, 'RowName', [], 'ColumnName', colnames,'Position', [250 30 920 40.5]);
        
        equispace(f1)  
        linkaxes(h,'x');
        
end 