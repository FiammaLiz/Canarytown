%% P1 fasicas - relativizado
   %Plotea onda de sonido, raster con todas las respuestas (20 trials
   %apilados por cada linea), curvas de suavizado individuales y curva
   %promedio de datos de P1, SU fásicas, relativizados a periodo silabico
   
audio_syll_relative= [audio_syll_relative_P1E_VeNe audio_syll_relative_P1H_VeNe audio_syll_relative_P1C_VeNe audio_syll_relative_P1F_VeNe audio_syll_relative_P1K_RoNe audio_syll_relative_P1E2_RoNe audio_syll_relative_P1E1_RoNe audio_syll_relative_P1F1_RoNe audio_syll_relative_P1F2_RoNe];
spiketimes_relative_all=[spiketimes_relative_P1H_VeNeS3 spiketimes_relative_P1G_VeNeS3 spiketimes_relative_P1F_VeNeS3 spiketimes_relative_P1C_VeNeS3 spiketimes_relative_P1F2_RoNeS5 spiketimes_relative_P1F1_RoNeS5 spiketimes_relative_P1F2_RoNeS2 spiketimes_relative_P1E1_RoNeS2 spiketimes_relative_P1E2_RoNeS2 spiketimes_relative_P1K_RoNeS2];

%agrupado de curvas de suavizado
cs=[];
binsize=0.03;
for i=1:length(spiketimes_relative_all)
 [hh,tt]=ksdensity(spiketimes_relative_all{1,i},0:binsize:1,'BandWidth',binsize,'function','pdf');
 hold on
 cs=vertcat(cs,hh);
 plot(tt,cs(i,:))
end
cs_m=mean(cs);
cs_std=std(cs,0,1); %desvio estandard de las curvas de suavizado
   
f1=figure(1);
binsize= 0.03;
d(1)= subplot(5,1,1);
for g=1:length(audio_syll_relative)
    time=(1:length(audio_syll_relative{1,g}))/1000;
    plot(time, audio_syll_relative{1,g})
    hold on
end
hold off
ylabel ('Sonido (u.a.)');

d(2)= subplot(5,1,2:3);
    for k=1:length(spiketimes_relative_P1F2_RoNeS2)
        for t=1:length(spiketimes_relative_P1F2_RoNeS2{1,k})
  line(spiketimes_relative_P1F2_RoNeS2{1,k}(t)'*[1 1],[-0.4 0.4] + k,'LineStyle','-','MarkerSize',15,'Color','b'); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
        hold on
        end 
    end 
    
     for i=1:length(spiketimes_relative_P1E1_RoNeS2) 
         for t=1:length(spiketimes_relative_P1E1_RoNeS2{1,i})
  line(spiketimes_relative_P1E1_RoNeS2{1,i}(t)'*[1 1],[-0.4 0.4]+ i + k,'LineStyle','-','MarkerSize',15,'Color',[0,0.3882,0]); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
         end 
     end 
     
     for m=1:length(spiketimes_relative_P1E2_RoNeS2) 
         for t=1:length(spiketimes_relative_P1E2_RoNeS2{1,m})
  line(spiketimes_relative_P1E2_RoNeS2{1,m}(t)'*[1 1],[-0.4 0.4]+ m + i + k,'LineStyle','-','MarkerSize',15,'Color',[1,0.3,0]); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
         end 
     end 
     
     for n=1:length(spiketimes_relative_P1K_RoNeS2) 
         for t=1:length(spiketimes_relative_P1K_RoNeS2{1,n})
  line(spiketimes_relative_P1K_RoNeS2{1,n}(t)'*[1 1],[-0.4 0.4]+ n + m + i + k,'LineStyle','-','MarkerSize',15,'Color','k'); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
         end 
     end 
    
     for o=1:length(spiketimes_relative_P1F1_RoNeS5) 
         for t=1:length(spiketimes_relative_P1F1_RoNeS5{1,o})
  line(spiketimes_relative_P1F1_RoNeS5{1,o}(t)'*[1 1],[-0.4 0.4]+ o + n + m + i + k,'LineStyle','-','MarkerSize',15,'Color',[0 1 1]); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
         end 
     end 
    
       for p=1:length(spiketimes_relative_P1F2_RoNeS5) 
         for t=1:length(spiketimes_relative_P1F2_RoNeS5{1,p})
  line(spiketimes_relative_P1F2_RoNeS5{1,p}(t)'*[1 1],[-0.4 0.4]+ p + o + n + m + i + k,'LineStyle','-','MarkerSize',15,'Color',[1 0 0.5]); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
         end 
       end 

line([0 1],[0.5 0.5] + k + i + m + n + o + p,'LineStyle','-','MarkerSize',4,'Color','k');

       for q=1:length(spiketimes_relative_P1C_VeNeS3) 
         for t=1:length(spiketimes_relative_P1C_VeNeS3{1,q})
  line(spiketimes_relative_P1C_VeNeS3{1,q}(t)'*[1 1],[-0.4 0.4]+ q + p + o + n + m + i + k,'LineStyle','-','MarkerSize',15,'Color',[0.5 0 1]); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
         end 
       end 
       
       for r=1:length(spiketimes_relative_P1F_VeNeS3) 
         for t=1:length(spiketimes_relative_P1F_VeNeS3{1,r})
  line(spiketimes_relative_P1F_VeNeS3{1,r}(t)'*[1 1],[-0.4 0.4]+ r + q + p + o + n + m + i + k,'LineStyle','-','MarkerSize',15,'Color',[0.5 0.8 0]); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
         end 
       end 
       
       for s=1:length(spiketimes_relative_P1G_VeNeS3) 
         for t=1:length(spiketimes_relative_P1G_VeNeS3{1,s})
  line(spiketimes_relative_P1G_VeNeS3{1,s}(t)'*[1 1],[-0.4 0.4]+ s+ r + q + p + o + n + m + i + k,'LineStyle','-','MarkerSize',15,'Color',[0.5 0 0]); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
         end 
       end 
       
       for v=1:length(spiketimes_relative_P1H_VeNeS3) 
         for t=1:length(spiketimes_relative_P1H_VeNeS3{1,v})
  line(spiketimes_relative_P1H_VeNeS3{1,v}(t)'*[1 1],[-0.4 0.4]+ v+ s+ r + q + p + o + n + m + i + k,'LineStyle','-','MarkerSize',15,'Color','k'); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
         end 
       end 
       
 
ylim([0, 0.5 + k + i + m + n + o + p + q + r + s + v ])
ylabel('#Silaba');

d(3)= subplot(5,1,4);

hist_spikes_P1F2_RoNeS2= cell2mat(spiketimes_relative_P1F2_RoNeS2);
b=histogram(hist_spikes_P1F2_RoNeS2,'BinWidth',binsize,'Normalization','pdf');
b.FaceColor='none';
b.EdgeColor='none';
hold on
[ff,xx]=ksdensity(hist_spikes_P1F2_RoNeS2,'BandWidth',binsize,'function','pdf'); %funcion de suavizado
plot(xx,ff,'LineWidth',1,'Color','b');

hist_spikes_P1E1_RoNeS2= cell2mat(spiketimes_relative_P1E1_RoNeS2);
f=histogram(hist_spikes_P1E1_RoNeS2,'BinWidth',binsize,'Normalization','pdf');
f.FaceColor='none';
f.EdgeColor='none';
hold on
[ff2,xx2]=ksdensity(hist_spikes_P1E1_RoNeS2,'BandWidth',binsize,'function','pdf'); %funcion de suavizado
plot(xx2,ff2,'LineWidth',1,'Color',[0,0.3882,0]);

hist_spikes_P1E2_RoNeS2= cell2mat(spiketimes_relative_P1E2_RoNeS2);
f=histogram(hist_spikes_P1E2_RoNeS2,'BinWidth',binsize,'Normalization','pdf');
f.FaceColor='none';
f.EdgeColor='none';
hold on
[fff2,xxx2]=ksdensity(hist_spikes_P1E2_RoNeS2,'BandWidth',binsize,'function','pdf'); %funcion de suavizado
plot(xxx2,fff2,'LineWidth',1,'Color',[1,0.3,0]);

hist_spikes_P1K_RoNeS2= cell2mat(spiketimes_relative_P1K_RoNeS2);
f=histogram(hist_spikes_P1K_RoNeS2,'BinWidth',binsize,'Normalization','pdf');
f.FaceColor='none';
f.EdgeColor='none';
hold on
[fff3,xxx3]=ksdensity(hist_spikes_P1K_RoNeS2,'BandWidth',binsize,'function','pdf'); %funcion de suavizado
plot(xxx3,fff3,'LineWidth',1,'Color','k');

hist_spikes_P1F1_RoNeS5= cell2mat(spiketimes_relative_P1F1_RoNeS5);
f=histogram(hist_spikes_P1F1_RoNeS5,'BinWidth',binsize,'Normalization','pdf');
f.FaceColor='none';
f.EdgeColor='none';
hold on
[ffff3,xxxx3]=ksdensity(hist_spikes_P1F1_RoNeS5,'BandWidth',binsize,'function','pdf'); %funcion de suavizado
plot(xxxx3,ffff3,'LineWidth',1,'Color',[0 1 1]);

hist_spikes_P1F2_RoNeS5= cell2mat(spiketimes_relative_P1F2_RoNeS5);
f=histogram(hist_spikes_P1F2_RoNeS5,'BinWidth',binsize,'Normalization','pdf');
f.FaceColor='none';
f.EdgeColor='none';
hold on
[ffff33,xxxx33]=ksdensity(hist_spikes_P1F2_RoNeS5,'BandWidth',binsize,'function','pdf'); %funcion de suavizado
plot(xxxx33,ffff33,'LineWidth',1,'Color',[1 0.5 0]);

hist_spikes_P1C_VeNeS3= cell2mat(spiketimes_relative_P1C_VeNeS3);
f=histogram(hist_spikes_P1C_VeNeS3,'BinWidth',binsize,'Normalization','pdf');
f.FaceColor='none';
f.EdgeColor='none';
hold on
[f33,x33]=ksdensity(hist_spikes_P1C_VeNeS3,'BandWidth',binsize,'function','pdf'); %funcion de suavizado
plot(x33,f33,'LineWidth',1,'Color',[0 0.5 1]);

hist_spikes_P1F_VeNeS3= cell2mat(spiketimes_relative_P1F_VeNeS3);
f=histogram(hist_spikes_P1F_VeNeS3,'BinWidth',binsize,'Normalization','pdf');
f.FaceColor='none';
f.EdgeColor='none';
hold on
[f2f33,x2x33]=ksdensity(hist_spikes_P1F_VeNeS3,'BandWidth',binsize,'function','pdf'); %funcion de suavizado
plot(x2x33,f2f33,'LineWidth',1,'Color',[0.5 0.8 1]);

hist_spikes_P1G_VeNeS3= cell2mat(spiketimes_relative_P1G_VeNeS3);
f=histogram(hist_spikes_P1G_VeNeS3,'BinWidth',binsize,'Normalization','pdf');
f.FaceColor='none';
f.EdgeColor='none';
hold on
[ff2f33,xx2x33]=ksdensity(hist_spikes_P1G_VeNeS3,'BandWidth',binsize,'function','pdf'); %funcion de suavizado
plot(xx2x33,ff2f33,'LineWidth',1,'Color',[0.5 0 0]);

hist_spikes_P1H_VeNeS3= cell2mat(spiketimes_relative_P1H_VeNeS3);
f=histogram(hist_spikes_P1H_VeNeS3,'BinWidth',binsize,'Normalization','pdf');
f.FaceColor='none';
f.EdgeColor='none';
hold on
[ff2f3,xx2x3]=ksdensity(hist_spikes_P1H_VeNeS3,'BandWidth',binsize,'function','pdf'); %funcion de suavizado
plot(xx2x3,ff2f3,'LineWidth',1,'Color','k');

d(4)= subplot(5,1,5);
plot(tt,cs_m,'Color','b','LineWidth',1); 
hold on
plot(tt,cs_m+cs_std,'Color','b','LineWidth',1,'LineStyle','-.'); 
plot(tt,cs_m-cs_std,'Color','b','LineWidth',1,'LineStyle','-.'); 

ylabel ({'Curva de suavizado promedio'});
xlabel('Tiempo normalizado (periodo silábico)');

linkaxes(d,'x');