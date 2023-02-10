%% Ploteo de histograma- escuchando Vigilia- SU
%Figura con histograma ponderado de la actividad neuronal al escuchar
%silabas P0 durante la vigilia, data sin normalizar
%Matlab 2018a

load('D:\Datos Canarios Protocolos\Data procesada\dataraw-SU-P0') %cargo datos

    binsize=5;
    
    %Curvas de suavizado
    cst=[];
    %calculo de curvas de suavizado individuales
    for i=1:length(spike_train_P0)
    [ss,tt_s]=ksdensity(spike_train_P0{1,i},-58:0.3:325,'function','pdf','BandWidth',binsize); %hago una curva de suavizado por silaba con los 20 trials
    hold on
    cst=vertcat(cst,ss);
    end
    hold off
    cs_s=mean(cst); %promedio las curvas de suavizado
    cs_std= std(cst,1,1); %desvio estandard
    
    %Histograma
    hbc_FiSu=[];
    for i=1:length(spike_train_P0)
    hh=histogram(spike_train_P0{1,i},-57.9:binsize:325,'Normalization','pdf');
    hold on
    hbc_FiSu=vertcat(hbc_FiSu,hh.Values);
    end
    
    %% Ploteo figura 

f1= figure(1); 

%Oscilogramas normalizados
pl(1)=subplot(5,1,1);
for k=1:length(envelopes_syllabes_mean)
plot(duration_syllabes{k},envelopes_syllabes_mean{k});
hold on
end
ylabel 'Envolventes de sonido(u.a.)'

%Histograma ponderado + curva de suavizado
pl(2)=subplot(5,1,2);
plot(tt_s,cs_s,'Color',[0 0 1 0.5],'LineWidth',2.5); %curva de suavizado
hold on
v=bar(-57.9:binsize:(325-binsize),sum(hbc_FiSu,1)/size(hbc_FiSu,1),'histc'); %histograma
v.FaceColor='none';
v.EdgeColor='b';
v.LineWidth=1;
hold off
ylabel({'Probabilidad de'; 'disparo'});

%Curvas de suavizado individuales

pl(3)=subplot(5,1,3);
hist_spikes_VioAzuS2= cell2mat(spike_train_VioAzuS2);
[f,x]=ksdensity(hist_spikes_VioAzuS2,'BandWidth',binsize,'function','pdf'); %funcion de suavizado
plot(x,f,'LineWidth',1,'Color',[colorp{4} 0.5]);
hold on 
clear x
clear f

hist_spikes_RoNeS2= cell2mat(spike_train_RoNeS2);
[ff2f3,xx2x3]=ksdensity(hist_spikes_RoNeS2,'BandWidth',binsize,'function','pdf'); %funcion de suavizado
plot(xx2x3,ff2f3,'LineWidth',1,'Color',[colorp{1} 0.5]);
clear xx2x3
clear ff2f3

hist_spikes_RoNeS4= cell2mat(spike_train_RoNeS4);
[ff2f,xx2x]=ksdensity(hist_spikes_RoNeS4,'BandWidth',binsize,'function','pdf'); %funcion de suavizado
plot(xx2x,ff2f,'LineWidth',1,'Color',[colorp{2} 0.5]);
clear xx2x
clear ff2f

hist_spikes_RoNeS5= cell2mat(spike_train_RoNeS5);
[ff23,xx23]=ksdensity(hist_spikes_RoNe5,'BandWidth',binsize,'function','pdf'); %funcion de suavizado
plot(xx23,ff23,'LineWidth',1,'Color',[colorp{3} 0.5]);
clear xx23
clear ff23

%Raster histogramas promediados
pl(4)=subplot(5,1,4:5);
        
         for l=1:length(spike_train_RoNeS2)  
  line(spike_train_RoNeS2{1,l}'*[1 1],[-0.4 0.4] + l,'LineStyle','-','MarkerSize',4,'Color',colorp{1}); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
         end 
      
         for f=1:length(spike_train_RoNeS4)  
  line(spike_train_RoNeS4{1,f}'*[1 1],[-0.4 0.4] + l +f ,'LineStyle','-','MarkerSize',4,'Color',colorp{2}); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
         end 
         for o=1:length(spike_train_RoNeS5)  
  line(spike_train_RoNeS5{1,o}'*[1 1],[-0.4 0.4] + l +f + o ,'LineStyle','-','MarkerSize',4,'Color',colorp{3}); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
         end
         
  line([new_onset_ini new_onset_b+anchor_points(4)/sample_rate],[0.6 0.6] + l +f + o ,'LineStyle','-','MarkerSize',4,'Color','k'); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial   
         
         for h=1:length(spike_train_VioAzuS2)  
  line(spike_train_VioAzuS2{1,h}'*[1 1],[-0.4 0.4] + h + l +f + o,'LineStyle','-','MarkerSize',4,'Color',colorp{4}); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
         end 
         hold on

%Parches de colores para indicar de que ave y frase proviene el dato
%(coincidente con colores de las curvas, ingresado a mano)

patch([-73 -73 -67 -67],[-0.4 0.4 0.4 -0.4] + 1,[0.9290 0.6940 0.1250],'FaceAlpha',0.8,'EdgeColor','none'); 
patch([-73 -73 -67 -67],[-0.4 0.4 0.4 -0.4] + 4,[0.4940 0.1840 0.5560],'FaceAlpha',0.8,'EdgeColor','none'); 
patch([-73 -73 -67 -67],[-0.4 0.4 0.4 -0.4] + 6,[0.8500 0.3250 0.0980],'FaceAlpha',0.8,'EdgeColor','none'); 
patch([-73 -73 -67 -67],[-0.4 0.4 0.4 -0.4] + 15,[0.8500 0.3250 0.0980],'FaceAlpha',0.8,'EdgeColor','none'); 
patch([-73 -73 -67 -67],[-0.4 0.4 0.4 -0.4] + 9,[0 0.4470 0.7410],'FaceAlpha',0.8,'EdgeColor','none'); 
patch([-73 -73 -67 -67],[-0.4 0.4 0.4 -0.4] + 12, [0 0.4470 0.7410],'FaceAlpha',0.8,'EdgeColor','none'); 
patch([-73 -73 -67 -67],[-0.4 0.4 0.4 -0.4] + 19, [0 0.4470 0.7410],'FaceAlpha',0.8,'EdgeColor','none'); 

 
ylabel '# de silaba' 
xlabel 'Tiempo(ms)'
linkaxes(pl,'x');
hold off