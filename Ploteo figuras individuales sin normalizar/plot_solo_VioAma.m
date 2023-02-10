
spike_train=[spike_train_VioAmaM1 spike_train_VioAmaM2 spike_train_VioAmaM3 spike_train_VioAmaM5];

%Curva de suavizado
    binsize=5;
    cst=[];
    for i=1:length(spike_train)
    [ss,tt_v]=ksdensity(spike_train{1,i},-58:0.3:325,'function','pdf','BandWidth',binsize); %hago una curva de suavizado por silaba con los 20 trials
    hold on
    cst=vertcat(cst,ss);
    end
    hold off
    cs=mean(cst); %promedio las curvas de suavizado
    cs_std= std(cst,1,1); %desvio estandar de las curvas de suavizado
    
    %Histograma
    hbc_MU=[];
    for i=1:length(spike_train)
    hh=histogram(spike_train{1,i},-57.9:binsize:325,'Normalization','pdf');
    hold on
    hbc_MU=vertcat(hbc_MU,hh.Values); %histograma ponderado
    end
    
    colorp= {[1 1 0]; [1 0 1]; [0 1 1]; [1 0 0]; [0 1 0]; [0 0 1]; [0.5 0.5 0.5]; [0.7 0.7 0]; [0.7 0 0.7];...
[0 0.7 0.7]; [0.7 0 0]; [0 0.7 0]; [0 0 0.7]; [0.3 0.3 0]; [0.3 0 0.3]; [0 0.3 0.3]; [0.3 0 0]; [0 0.3 0]; [0 0 0.3];...
[0.5 0.5 0]; [0.5 0 0.5]; [0 0.5 0.5]; [0.5 0 0]; [0 0.5 0]; [0 0 0.5]};
    
    %% Ploteo

f1= figure(2); 

%Envolventes de las silabas estimulo apiladas
pl(1)=subplot(5,1,1);
for k=1:length(envelopes_VioAma)
plot(duration_syllables{k}*1000,envelopes_VioAma{k});
hold on
end
ylabel 'Envolventes de sonido(u.a.)'

%Histograma ponderado + curva de suavizado

pl(2)=subplot(5,1,2);
plot(tt_v,cs,'Color',[0 0 1 0.5],'LineWidth',2.5); %curva de suavizado
hold on
v=bar(-57.9:binsize:(325-binsize),sum(hbc_MU,1)/size(hbc_MU,1),'histc'); %histograma
v.FaceColor='none';
v.EdgeColor='b';
v.LineWidth=1;
hold off
ylabel({'Probabilidad de'; 'disparo'});
 
%Curvas de suavizado individuales
%Aca dejo para comentar y descomentar todas

pl(3)=subplot(5,1,3);
hist_spikes_VioAmaM1= cell2mat(spike_train_VioAmaM1);
[VioAma_M1,x_M1]=ksdensity(hist_spikes_VioAmaM1,'BandWidth',binsize,'function','pdf'); %funcion de suavizado
plot(x_M1,VioAma_M1,'LineWidth',1,'Color',[colorp{21} 0.5]);
hold on 


hist_spikes_spike_train_VioAmaM2= cell2mat(spike_train_VioAmaM2);
[VioAma_M2,x_M1]=ksdensity(hist_spikes_spike_train_VioAmaM2,'BandWidth',binsize,'function','pdf'); %funcion de suavizado
plot(x_M1,VioAma_M2,'LineWidth',1,'Color',[colorp{4} 0.5]);


hist_spikes_spike_train_VioAmaM3= cell2mat(spike_train_VioAmaM3);
[VioAma_M3,x_M3]=ksdensity(hist_spikes_spike_train_VioAmaM3,'BandWidth',binsize,'function','pdf'); %funcion de suavizado
plot(x_M3,VioAma_M3,'LineWidth',1,'Color',[colorp{6} 0.5]);


hist_spikes_spike_train_VioAmaM5= cell2mat(spike_train_VioAmaM5);
[VioAma_M5,x_M5]=ksdensity(hist_spikes_spike_train_VioAmaM5,'BandWidth',binsize,'function','pdf'); %funcion de suavizado
plot(x_M5,VioAma_M5,'LineWidth',1,'Color',[colorp{8} 0.5]);


pl(4)=subplot(5,1,4:5);

         for h=1:length(spike_train_VioAmaM1)  
  line(spike_train_VioAmaM1{1,h}'*[1 1],[-0.4 0.4] + h,'LineStyle','-','MarkerSize',4,'Color',colorp{21}); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
         end                 
         hold on

         for j=1:length(spike_train_VioAmaM2)  
  line(spike_train_VioAmaM2{1,j}'*[1 1],[-0.4 0.4] + h + j,'LineStyle','-','MarkerSize',4,'Color',colorp{4}); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
         end 
 
         for k=1:length(spike_train_VioAmaM3)  
  line(spike_train_VioAmaM3{1,k}'*[1 1],[-0.4 0.4] + h +j +k,'LineStyle','-','MarkerSize',4,'Color',colorp{6}); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
         end 
         
         for l=1:length(spike_train_VioAmaM5)  
  line(spike_train_VioAmaM5{1,l}'*[1 1],[-0.4 0.4] + h +j +k + l,'LineStyle','-','MarkerSize',4,'Color',colorp{8}); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
         end 
         

ylim([0 length(spike_train)+8+0.5])
ylabel '# de silaba' 
xlabel 'Tiempo (ms)'

linkaxes(pl,'x');
hold off

%% Normalizada
stretched_spike_train_sil_VioAma=[stretched_spike_train_sil_VioAma_M1 stretched_spike_train_sil_VioAma_M2,...
 stretched_spike_train_sil_VioAma_M3 stretched_spike_train_sil_VioAma_M5];
   binsize=5;
%Curva de suavizado
    cst=[];
    for i=1:length(stretched_spike_train_sil_VioAma)
    [ss,tt_v]=ksdensity(stretched_spike_train_sil_VioAma{1,i},-57.9:5:272,'function','pdf','BandWidth',binsize); %hago una curva de suavizado por silaba con los 20 trials
    hold on
    cst=vertcat(cst,ss);
    end
    hold off
    cs=mean(cst); %promedio las curvas de suavizado
    cs_std= std(cst,1,1); %desvio estandar de las curvas de suavizado
    
    %Histograma
    hbc_MU=[];
    for i=1:length(stretched_spike_train_sil_VioAma)
    hh=histogram(stretched_spike_train_sil_VioAma{1,i},-57.9:binsize:272,'Normalization','pdf');
    hold on
    hbc_MU=vertcat(hbc_MU,hh.Values); %histograma ponderado
    end
    
anchor_points=[1737, 903, 510, 6681]; %anchor points para P0
%Duraciones maximas
max_ini_length=anchor_points(1);
max_note_a_length=anchor_points(2);
max_gap_length=anchor_points(3);       
max_note_b_length=anchor_points(4); 
sample_rate=30000;
%Onsets
new_onset_a=0;
new_onset_gap=anchor_points(2)/sample_rate;
new_onset_b=sum(anchor_points(2:3))/sample_rate;
new_onset_ini=-anchor_points(1)/sample_rate;
list_anchors=([anchor_points(1),sum(anchor_points(1:2)),sum(anchor_points(1:3)),sum(anchor_points(1:4))]-anchor_points(1))*1000/sample_rate;

    %% Ploteo

f1= figure(2); 
   
duration_syllabe= (1:length(stretched_syllabes_VioAma))*1000/sample_rate; %para el plot de la onda de sonido de las silabas

%Envolventes de las silabas estimulo apiladas
pl(1)=subplot(5,1,1);
for t= 1:size(stretched_syllabes_VioAma,2)
plot(duration_syllabe,stretched_syllabes_VioAma(:,t))
hold on
end
%lineas con anchor points y sus valores
line(list_anchors'*[1 1],[pl(1).YLim],'color',[0.4 0.4 0.4 0.8]);
text(list_anchors(1)-30,pl(1).YLim(2)*0.85,sprintf('%.2f',0),'color','k');
text(list_anchors(2)-20,pl(1).YLim(2)*0.85,sprintf('%.2f',list_anchors(2)),'color','k');
text(list_anchors(3)+2,pl(1).YLim(2)*0.85,sprintf('%.2f',list_anchors(3)),'color','k');
ylabel 'Ondas de sonido normalizadas(u.a.)'

%Histograma ponderado + curva de suavizado

pl(2)=subplot(5,1,2);
plot(tt_v,cs,'Color',[0 0 1 0.5],'LineWidth',2.5); %curva de suavizado
hold on
v=bar(-57.9:binsize:(272-binsize),sum(hbc_MU,1)/size(hbc_MU,1),'histc'); %histograma
v.FaceColor='none';
v.EdgeColor='b';
v.LineWidth=1;
%lineas con anchor points y sus valores
line(list_anchors'*[1 1],[pl(2).YLim],'color',[0.4 0.4 0.4 0.8]);
text(list_anchors(1)-30,pl(2).YLim(2)*0.85,sprintf('%.2f',0),'color','k');
text(list_anchors(2)-20,pl(2).YLim(2)*0.85,sprintf('%.2f',list_anchors(2)),'color','k');
text(list_anchors(3)+2,pl(2).YLim(2)*0.85,sprintf('%.2f',list_anchors(3)),'color','k');
hold off
ylabel({'Probabilidad de'; 'disparo'});
 
%Curvas de suavizado individuales
%Aca dejo para comentar y descomentar todas

pl(3)=subplot(5,1,3);
hist_spikes_VioAmaM1= cell2mat(stretched_spike_train_sil_VioAma_M1);
[VioAma_M1,x_M1]=ksdensity(hist_spikes_VioAmaM1,'BandWidth',binsize,'function','pdf'); %funcion de suavizado
plot(x_M1,VioAma_M1,'LineWidth',1,'Color',[colorp{21} 0.5]);
hold on 
clear x
clear f

hist_spikes_spike_train_VioAmaM2= cell2mat(stretched_spike_train_sil_VioAma_M2);
[VioAma_M2,x_M1]=ksdensity(hist_spikes_spike_train_VioAmaM2,'BandWidth',binsize,'function','pdf'); %funcion de suavizado
plot(x_M1,VioAma_M2,'LineWidth',1,'Color',[colorp{4} 0.5]);
clear xx2x3
clear ff2f3

hist_spikes_spike_train_VioAmaM3= cell2mat(stretched_spike_train_sil_VioAma_M3);
[f2f3,x_M3]=ksdensity(hist_spikes_spike_train_VioAmaM3,'BandWidth',binsize,'function','pdf'); %funcion de suavizado
plot(x_M3,f2f3,'LineWidth',1,'Color',[colorp{6} 0.5]);
clear x2x3
clear f2f3

hist_spikes_spike_train_VioAmaM5= cell2mat(stretched_spike_train_sil_VioAma_M5);
[VioAma_M5,x_M5]=ksdensity(hist_spikes_spike_train_VioAmaM5,'BandWidth',binsize,'function','pdf'); %funcion de suavizado
plot(x_M5,VioAma_M5,'LineWidth',1,'Color',[colorp{8} 0.5]);
clear xx2x
clear ff2f

pl(4)=subplot(5,1,4:5);

         for h=1:length(stretched_spike_train_sil_VioAma_M1)  
  line(stretched_spike_train_sil_VioAma_M1{1,h}'*[1 1],[-0.4 0.4] + h,'LineStyle','-','MarkerSize',4,'Color',colorp{21}); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
         end                 
         hold on

         for j=1:length(stretched_spike_train_sil_VioAma_M2)  
  line(stretched_spike_train_sil_VioAma_M2{1,j}'*[1 1],[-0.4 0.4] + h + j,'LineStyle','-','MarkerSize',4,'Color',colorp{4}); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
         end 
 
         for k=1:length(stretched_spike_train_sil_VioAma_M3)  
  line(stretched_spike_train_sil_VioAma_M3{1,k}'*[1 1],[-0.4 0.4] + h +j +k,'LineStyle','-','MarkerSize',4,'Color',colorp{6}); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
         end 
         
         for l=1:length(stretched_spike_train_sil_VioAma_M5)  
  line(stretched_spike_train_sil_VioAma_M5{1,l}'*[1 1],[-0.4 0.4] + h +j +k + l,'LineStyle','-','MarkerSize',4,'Color',colorp{8}); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
         end 
         

ylim([0 length(stretched_spike_train_sil_VioAma)+8+0.5])
ylabel '# de silaba' 
xlabel 'Tiempo (ms)'

linkaxes(pl,'x');
hold off
