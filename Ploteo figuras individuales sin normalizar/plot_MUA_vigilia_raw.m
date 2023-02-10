%% Ploteo de histograma- escuchando Vigilia- MUA
%Figura con histograma ponderado de la actividad neuronal al escuchar
%silabas P0 durante la vigilia, sin normalizar
%Matlab 2018a

%% Cargo datos y los proceso

%load('D:\Datos Canarios Protocolos\Data procesada\dataraw-MU-P0')

%Armar spike_train segun lo que se quiera plotear
spike_train=[spike_train_RoNe1 spike_train_RoNe2 spike_train_RoNe3 spike_train_RoNe4 spike_train_RoNe5 spike_train_RoNe8 spike_train_VeNe1 spike_train_VeNe2 spike_train_VeNe3]
    %spike_train_VioAmaM1 spike_train_VioAmaM2 spike_train_VioAmaM3 spike_train_VioAmaM5];

sample_rate=30000;
binsize=5;

%Curva de suavizado
    cst=[];
    for i=1:length(spike_train)
    [ss,tt_v]=ksdensity(spike_train{1,i},-58:binsize:325,'function','pdf','BandWidth',binsize); %hago una curva de suavizado por silaba con los 20 trials
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


%% Ploteo

f1= figure(2); 

%Envolventes de las silabas estimulo apiladas
pl(1)=subplot(5,1,1);

for k=1:3
plot(duration_syllabes{k},envelopes_syllabes_mean{k},'LineWidth',2);
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
hist_spikes_RoNe1= cell2mat(spike_train_RoNe1);
[f,x]=ksdensity(hist_spikes_RoNe1(hist_spikes_RoNe1<5000),-58:binsize:325,'function','pdf','BandWidth',binsize); %funcion de suavizado
plot(x,f,'LineWidth',2,'Color',[colorp{1} 0.5]);
hold on 
clear x
clear f

hist_spikes_RoNe2= cell2mat(spike_train_RoNe2);
[ff2f3,xx2x3]=ksdensity(hist_spikes_RoNe2(hist_spikes_RoNe2<5000),-58:binsize:325,'function','pdf','BandWidth',binsize); %funcion de suavizado
plot(xx2x3,ff2f3,'LineWidth',2,'Color',[colorp{2} 0.5]);
clear xx2x3
clear ff2f3

hist_spikes_RoNe3= cell2mat(spike_train_RoNe3);
[f2f3,x2x3]=ksdensity(hist_spikes_RoNe3(hist_spikes_RoNe3<5000),-58:binsize:325,'function','pdf','BandWidth',binsize); %funcion de suavizado
plot(x2x3,f2f3,'LineWidth',2,'Color',[colorp{3} 0.5]);
clear x2x3
clear f2f3

hist_spikes_RoNe4= cell2mat(spike_train_RoNe4);
[ff2f,xx2x]=ksdensity(hist_spikes_RoNe4(hist_spikes_RoNe4<5000),-58:binsize:325,'function','pdf','BandWidth',binsize); %funcion de suavizado
plot(xx2x,ff2f,'LineWidth',2,'Color',[colorp{4} 0.5]);
clear xx2x
clear ff2f

hist_spikes_RoNe5= cell2mat(spike_train_RoNe5);
[ff23,xx23]=ksdensity(hist_spikes_RoNe5(hist_spikes_RoNe5<5000),-58:binsize:325,'function','pdf','BandWidth',binsize); %funcion de suavizado
plot(xx23,ff23,'LineWidth',2,'Color',[colorp{5} 0.5]);
clear xx23
clear ff23

hist_spikes_RoNe8= cell2mat(spike_train_RoNe8);
[ff2,xx2]=ksdensity(hist_spikes_RoNe8(hist_spikes_RoNe8<5000),-58:binsize:325,'function','pdf','BandWidth',binsize); %funcion de suavizado
plot(xx2,ff2,'LineWidth',2,'Color',[colorp{8} 0.5]);
clear xx2
clear ff2

hist_spikes_VeNe1= cell2mat(spike_train_VeNe1);
[f3,x3]=ksdensity(hist_spikes_VeNe1(hist_spikes_VeNe1<5000),-58:binsize:325,'function','pdf','BandWidth',binsize); %funcion de suavizado
plot(x3,f3,'LineWidth',2,'Color',[colorp{10} 0.5]);
clear x3
clear f3

hist_spikes_VeNe2= cell2mat(spike_train_VeNe2);
[f2f3,x2x3]=ksdensity(hist_spikes_VeNe2(hist_spikes_VeNe2<5000),-58:binsize:325,'function','pdf','BandWidth',binsize); %funcion de suavizado
plot(x2x3,f2f3,'LineWidth',2,'Color',[colorp{11} 0.5]);
clear x2x3
clear f2f3

hist_spikes_VeNe3= cell2mat(spike_train_VeNe3);
[rff2f3,rxx2x3]=ksdensity(hist_spikes_VeNe3(hist_spikes_VeNe3<5000),-58:binsize:325,'function','pdf','BandWidth',binsize); %funcion de suavizado
plot(rxx2x3,rff2f3,'LineWidth',2,'Color',[colorp{12} 0.5]);
clear rxx2x3
clear rff2f3

%hist_spikes_VioAmaM1= cell2mat(spike_train_VioAmaM1);
%[ffff2f3,xxxx2x3]=ksdensity(hist_spikes_VioAmaM1,-58:binsize:325,'function','pdf','BandWidth',binsize); %funcion de suavizado
%plot(xxxx2x3,ffff2f3,'LineWidth',2,'Color',[colorp{13} 0.5]);
%clear xxxx2x3
%clear ffff2f3
%hold on

%hist_spikes_VioAmaM2= cell2mat(spike_train_VioAmaM2);
%[ff2f3x,xx2x3f]=ksdensity(hist_spikes_VioAmaM2,-58:binsize:325,'function','pdf','BandWidth',binsize); %funcion de suavizado
%plot(xx2x3f,ff2f3x,'LineWidth',2,'Color',[colorp{14} 0.5]);
%clear xx2x3f
%clear ff2f3x

%hist_spikes_VioAmaM3= cell2mat(spike_train_VioAmaM3);
%[ff2f3,xx2x3]=ksdensity(hist_spikes_VioAmaM3,-58:binsize:325,'function','pdf','BandWidth',binsize); %funcion de suavizado
%plot(xx2x3,ff2f3,'LineWidth',2,'Color',[colorp{15} 0.5]);
%clear xx2x3
%clear ff2f3

%hist_spikes_VioAmaM5= cell2mat(spike_train_VioAmaM5);
%[ff22f3,xx22x3]=ksdensity(hist_spikes_VioAmaM5,-58:binsize:325,'function','pdf','BandWidth',binsize); %funcion de suavizado
%plot(xx22x3,ff22f3,'LineWidth',2,'Color',[colorp{16} 0.5]);
%clear xx22x3
%clear ff22f3



%Raster de cada silaba
%Comentar y descomentar las MUA que se quiera
pl(4)=subplot(5,1,4:5);

         for h=1:length(spike_train_RoNe1)  
  line(spike_train_RoNe1{1,h}'*[1 1],[-0.4 0.4] + h,'LineStyle','-','MarkerSize',4,'Color',colorp{1}); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
         end                 
         hold on
         
         for j=1:length(spike_train_RoNe2)  
  line(spike_train_RoNe2{1,j}'*[1 1],[-0.4 0.4] + h + j ,'LineStyle','-','MarkerSize',4,'Color',colorp{2}); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
         end 
         
         for k=1:length(spike_train_RoNe3)  
  line(spike_train_RoNe3{1,k}'*[1 1],[-0.4 0.4] + h +j +k ,'LineStyle','-','MarkerSize',4,'Color',colorp{3}); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
         end 

         for l=1:length(spike_train_RoNe4)  
  line(spike_train_RoNe4{1,l}'*[1 1],[-0.4 0.4] + h +j +k + l,'LineStyle','-','MarkerSize',4,'Color',colorp{4}); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
         end 
  
         for m=1:length(spike_train_RoNe5)  
  line(spike_train_RoNe5{1,m}'*[1 1],[-0.4 0.4] + h +j +k + l + m ,'LineStyle','-','MarkerSize',4,'Color',colorp{5}); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
         end
  
 %        for f=1:length(spike_train_RoNe6)  
 % line(spike_train_RoNe6{1,f}'*[1 1],[-0.4 0.4] + h +j +k + l + m +f,'LineStyle','-','MarkerSize',4,'Color',colorp{6}); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
 %        end
 %        clear f
 
%         for o=1:length(spike_train_RoNe7)  
%  line(spike_train_RoNe7{1,o}'*[1 1],[-0.4 0.4] + f + h +j +k + l + m + o,'LineStyle','-','MarkerSize',4,'Color',colorp{7}); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
%         end 
%         clear o

         for a1=1:length(spike_train_RoNe8)  
  line(spike_train_RoNe8{1,a1}'*[1 1],[-0.4 0.4]  + h +j +k + l + m +a1,'LineStyle','-','MarkerSize',4,'Color',colorp{8}); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
         end 

         line([new_onset_ini new_onset_b+anchor_points(4)/sample_rate],[0.6 0.6]  + h +j +k + l + m +a1 ,'LineStyle','-','MarkerSize',4,'Color','k'); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial   
         
         for c1=1:length(spike_train_VeNe1)  
  line(spike_train_VeNe1{1,c1}'*[1 1],[-0.4 0.4]  + h +j +k + l + m +a1 +c1 ,'LineStyle','-','MarkerSize',4,'Color',colorp{10}); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
         end

         for d1=1:length(spike_train_VeNe2)  
  line(spike_train_VeNe2{1,d1}'*[1 1],[-0.4 0.4]  +d1 + h +j +k + l + m +a1 +c1,'LineStyle','-','MarkerSize',4,'Color',colorp{11}); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
         end

         for e1=1:length(spike_train_VeNe3)  
  line(spike_train_VeNe3{1,e1}'*[1 1],[-0.4 0.4]  +e1 +d1 + h +j +k + l + m +a1 +c1,'LineStyle','-','MarkerSize',4,'Color',colorp{12}); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
         end

 %        for f1=1:length(spike_train_VioAmaM1)  
  %line(spike_train_VioAmaM1{1,f1}'*[1 1],[-0.4 0.4] +f1 +e1 +d1 + h +j +k + l + m  +a1 +c1,'LineStyle','-','MarkerSize',4,'Color',colorp{13}); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
         %end
   
 %        for h1=1:length(spike_train_VioAmaM2)  
  %line(spike_train_VioAmaM2{1,h1}'*[1 1],[-0.4 0.4] + h1 +f1 +e1 +d1 + h +j +k + l + m  +a1  +c1,'LineStyle','-','MarkerSize',4,'Color',colorp{14}); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
  %       end

  %       for i1=1:length(spike_train_VioAmaM3)  
  %line(spike_train_VioAmaM3{1,i1}'*[1 1],[-0.4 0.4] + i1+ h1 +f1 +e1 +d1 + h +j +k + l + m  +a1  +c1,'LineStyle','-','MarkerSize',4,'Color',colorp{15}); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
   %      end

   %      for j1=1:length(spike_train_VioAmaM5)  
  %line(spike_train_VioAmaM5{1,j1}'*[1 1],[-0.4 0.4] +j1 + i1+ h1   +f1 +e1 +d1 + h +j +k + l + m   +a1  +c1,'LineStyle','-','MarkerSize',4,'Color',colorp{16}); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
    %     end
 
 %Parches de colores (escritos a mano) para señalizar ave y frase
 patch([-73 -73 350 350],[-0.4 0.4 0.4 -0.4] + 1,[0 0.4470 0.7410],'FaceAlpha',0.25,'EdgeColor','none'); 
 patch([-73 -73 350 350],[-0.4 0.4 0.4 -0.4] + 7,[0 0.4470 0.7410],'FaceAlpha',0.25,'EdgeColor','none'); 
 patch([-73 -73 350 350],[-0.4 0.4 0.4 -0.4] + 13,[0 0.4470 0.7410],'FaceAlpha',0.25,'EdgeColor','none'); 
 patch([-73 -73 350 350],[-0.4 0.4 0.4 -0.4] + 20,[0 0.4470 0.7410],'FaceAlpha',0.25,'EdgeColor','none'); 
 patch([-73 -73 350 350],[-0.4 0.4 0.4 -0.4] + 24,[0 0.4470 0.7410],'FaceAlpha',0.25,'EdgeColor','none'); 
 patch([-73 -73 350 350],[-0.4 0.4 0.4 -0.4] + 4,[0.8500 0.3250 0.0980],'FaceAlpha',0.25,'EdgeColor','none');
 patch([-73 -73 350 350],[-0.4 0.4 0.4 -0.4] + 10,[0.8500 0.3250 0.0980],'FaceAlpha',0.25,'EdgeColor','none'); 
 patch([-73 -73 350 350],[-0.4 0.4 0.4 -0.4] + 17,[0.8500 0.3250 0.0980],'FaceAlpha',0.25,'EdgeColor','none'); 
 patch([-73 -73 350 350],[-0.4 0.4 0.4 -0.4] + 28,[0.9290 0.6940 0.1250],'FaceAlpha',0.25,'EdgeColor','none'); 
 patch([-73 -73 350 350],[-0.4 0.4 0.4 -0.4] + 32,[0.9290 0.6940 0.1250],'FaceAlpha',0.25,'EdgeColor','none'); 
 patch([-73 -73 350 350],[-0.4 0.4 0.4 -0.4] + 36,[0.9290 0.6940 0.1250],'FaceAlpha',0.25,'EdgeColor','none'); 
 patch([-73 -73 350 350],[-0.4 0.4 0.4 -0.4] + 42,[0.9290 0.6940 0.1250],'FaceAlpha',0.25,'EdgeColor','none'); 
 patch([-73 -73 350 350],[-0.4 0.4 0.4 -0.4] + 44,[0.4940 0.1840 0.5560],'FaceAlpha',0.25,'EdgeColor','none'); 
 patch([-73 -73 350 350],[-0.4 0.4 0.4 -0.4] + 47,[0.4940 0.1840 0.5560],'FaceAlpha',0.25,'EdgeColor','none'); 
 patch([-73 -73 350 350],[-0.4 0.4 0.4 -0.4] + 50,[0.4660 0.6740 0.1880],'FaceAlpha',0.25,'EdgeColor','none'); 
 patch([-73 -73 350 350],[-0.4 0.4 0.4 -0.4] + 53,[0.3010 0.7450 0.9330],'FaceAlpha',0.25,'EdgeColor','none'); 

ylim([0 50])

ylabel '# de silaba' 
xlabel 'Tiempo (ms)'

linkaxes(pl,'x');
xlim([-73 350])
hold off

%% Plot con onset B corridos e intercalados


f1= figure(3); 

%Envolventes de las silabas estimulo apiladas
pl(1)=subplot(5,1,1);

for k=1:length(envelopes_syllabes_mean)
plot(duration_syllabes{k},envelopes_syllabes_mean{k},'LineWidth',2);
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
hist_spikes_RoNe1= cell2mat(spike_train_RoNe1);
[f,x]=ksdensity(hist_spikes_RoNe1(hist_spikes_RoNe1<5000),-58:binsize:325,'function','pdf','BandWidth',binsize); %funcion de suavizado
plot(x,f,'LineWidth',2,'Color',[colorp{1} 0.5]);
hold on 

hist_spikes_RoNe2= cell2mat(spike_train_RoNe2);
[ff2f3,xx2x3]=ksdensity(hist_spikes_RoNe2(hist_spikes_RoNe2<5000),-58:binsize:325,'function','pdf','BandWidth',binsize); %funcion de suavizado
plot(xx2x3,ff2f3,'LineWidth',2,'Color',[colorp{2} 0.5]);


hist_spikes_RoNe3= cell2mat(spike_train_RoNe3);
[f2f3,x2x3]=ksdensity(hist_spikes_RoNe3(hist_spikes_RoNe3<5000),-58:binsize:325,'function','pdf','BandWidth',binsize); %funcion de suavizado
plot(x2x3,f2f3,'LineWidth',2,'Color',[colorp{3} 0.5]);


hist_spikes_RoNe4= cell2mat(spike_train_RoNe4);
[ff2f,xx2x]=ksdensity(hist_spikes_RoNe4(hist_spikes_RoNe4<5000),-58:binsize:325,'function','pdf','BandWidth',binsize); %funcion de suavizado
plot(xx2x,ff2f,'LineWidth',2,'Color',[colorp{4} 0.5]);

hist_spikes_RoNe5= cell2mat(spike_train_RoNe5);
[ff23,xx23]=ksdensity(hist_spikes_RoNe5(hist_spikes_RoNe5<5000),-58:binsize:325,'function','pdf','BandWidth',binsize); %funcion de suavizado
plot(xx23,ff23,'LineWidth',2,'Color',[colorp{5} 0.5]);

hist_spikes_RoNe8= cell2mat(spike_train_RoNe8);
[ff2,xx2]=ksdensity(hist_spikes_RoNe8(hist_spikes_RoNe8<5000),-58:binsize:325,'function','pdf','BandWidth',binsize); %funcion de suavizado
plot(xx2,ff2,'LineWidth',2,'Color',[colorp{8} 0.5]);

hist_spikes_VeNe1= cell2mat(spike_train_VeNe1);
[f3,x3]=ksdensity(hist_spikes_VeNe1(hist_spikes_VeNe1<5000),-58:binsize:325,'function','pdf','BandWidth',binsize); %funcion de suavizado
plot(x3,f3,'LineWidth',2,'Color',[colorp{10} 0.5]);

hist_spikes_VeNe2= cell2mat(spike_train_VeNe2);
[f2f3,x2x3]=ksdensity(hist_spikes_VeNe2(hist_spikes_VeNe2<5000),-58:binsize:325,'function','pdf','BandWidth',binsize); %funcion de suavizado
plot(x2x3,f2f3,'LineWidth',2,'Color',[colorp{11} 0.5]);

hist_spikes_VeNe3= cell2mat(spike_train_VeNe3);
[rff2f3,rxx2x3]=ksdensity(hist_spikes_VeNe3(hist_spikes_VeNe3<5000),-58:binsize:325,'function','pdf','BandWidth',binsize); %funcion de suavizado
plot(rxx2x3,rff2f3,'LineWidth',2,'Color',[colorp{12} 0.5]);

hist_spikes_VioAmaM1= cell2mat(spike_train_VioAmaM1);
[ffff2f3,xxxx2x3]=ksdensity(hist_spikes_VioAmaM1,-58:binsize:325,'function','pdf','BandWidth',binsize); %funcion de suavizado
plot(xxxx2x3,ffff2f3,'LineWidth',2,'Color',[colorp{13} 0.5]);

hist_spikes_VioAmaM2= cell2mat(spike_train_VioAmaM2);
[ff2f3x,xx2x3f]=ksdensity(hist_spikes_VioAmaM2,-58:binsize:325,'function','pdf','BandWidth',binsize); %funcion de suavizado
plot(xx2x3f,ff2f3x,'LineWidth',2,'Color',[colorp{14} 0.5]);

hist_spikes_VioAmaM3= cell2mat(spike_train_VioAmaM3);
[ff2f3,xx2x3]=ksdensity(hist_spikes_VioAmaM3,-58:binsize:325,'function','pdf','BandWidth',binsize); %funcion de suavizado
plot(xx2x3,ff2f3,'LineWidth',2,'Color',[colorp{15} 0.5]);

hist_spikes_VioAmaM5= cell2mat(spike_train_VioAmaM5);
[ff22f3,xx22x3]=ksdensity(hist_spikes_VioAmaM5,-58:binsize:325,'function','pdf','BandWidth',binsize); %funcion de suavizado
plot(xx22x3,ff22f3,'LineWidth',2,'Color',[colorp{16} 0.5]);

curva_promedio=mean([f; ff2f3; f2f3; ff2f; ff23; ff2; f3; rff2f3; ffff2f3; ff2f3x; ff2f3; ff22f3]);



pl(4)=subplot(5,1,4);

hist_spikes_RoNe1=[];
for i=1:length(spike_train_RoNe1)
hist_spikes_RoNe1=[hist_spikes_RoNe1 spike_train_RoNe1{1,i}-onset_B_RoNe(i)];
end
[f,x]=ksdensity(hist_spikes_RoNe1(hist_spikes_RoNe1<5000),-58:binsize:325,'function','pdf','BandWidth',binsize); %funcion de suavizado
plot(x,f,'LineWidth',2,'Color',[colorp{1} 0.5]);
hold on 


hist_spikes_RoNe2=[];
for i=1:length(spike_train_RoNe2)
hist_spikes_RoNe2=[hist_spikes_RoNe2 spike_train_RoNe2{1,i}-onset_B_RoNe(i)];
end
[ff2f3,xx2x3]=ksdensity(hist_spikes_RoNe2(hist_spikes_RoNe2<5000),-58:binsize:325,'function','pdf','BandWidth',binsize); %funcion de suavizado
plot(xx2x3,ff2f3,'LineWidth',2,'Color',[colorp{2} 0.5]);


hist_spikes_RoNe3=[];
for i=1:length(spike_train_RoNe3)
hist_spikes_RoNe3=[hist_spikes_RoNe3 spike_train_RoNe3{1,i}-onset_B_RoNe(i)];
end
[f2f3,x2x3]=ksdensity(hist_spikes_RoNe3(hist_spikes_RoNe3<5000),-58:binsize:325,'function','pdf','BandWidth',binsize); %funcion de suavizado
plot(x2x3,f2f3,'LineWidth',2,'Color',[colorp{3} 0.5]);



hist_spikes_VeNe1=[];
for i=1:length(spike_train_VeNe1)
hist_spikes_VeNe1=[hist_spikes_VeNe1 spike_train_VeNe2{1,i}-onset_B_VeNe(i)];
end
[f3,x3]=ksdensity(hist_spikes_VeNe1(hist_spikes_VeNe1<5000),-58:binsize:325,'function','pdf','BandWidth',binsize); %funcion de suavizado
plot(x3,f3,'LineWidth',2,'Color',[colorp{10} 0.5]);


hist_spikes_VeNe2=[];
for i=1:length(spike_train_VeNe2)
hist_spikes_VeNe2=[hist_spikes_VeNe2 spike_train_VeNe2{1,i}-onset_B_VeNe(i)];
end
[f2f3,x2x3]=ksdensity(hist_spikes_VeNe2(hist_spikes_VeNe2<5000),-58:binsize:325,'function','pdf','BandWidth',binsize); %funcion de suavizado
plot(x2x3,f2f3,'LineWidth',2,'Color',[colorp{11} 0.5]);

hist_spikes_VeNe3=[];
for i=1:length(spike_train_VeNe3)
hist_spikes_VeNe3=[hist_spikes_VeNe3 spike_train_VeNe3{1,i}-onset_B_VeNe(i)];
end
[rff2f3,rxx2x3]=ksdensity(hist_spikes_VeNe3(hist_spikes_VeNe3<5000),-58:binsize:325,'function','pdf','BandWidth',binsize); %funcion de suavizado
plot(rxx2x3,rff2f3,'LineWidth',2,'Color',[colorp{12} 0.5]);

hist_spikes_VioAmaM2=[];
for i=1:length(spike_train_VioAmaM2)
hist_spikes_VioAmaM2=[hist_spikes_VioAmaM2 spike_train_VioAmaM2{1,i}-onset_B_VioAma(i)];
end
[ff2f3x,xx2x3f]=ksdensity(hist_spikes_VioAmaM2,-58:binsize:325,'function','pdf','BandWidth',binsize); %funcion de suavizado
plot(xx2x3f,ff2f3x,'LineWidth',2,'Color',[colorp{14} 0.5]);

hist_spikes_VioAmaM3=[];
for i=1:length(spike_train_VioAmaM3)
hist_spikes_VioAmaM3=[hist_spikes_VioAmaM3 spike_train_VioAmaM3{1,i}-onset_B_VioAma(i+3)];
end
[ff2f3,xx2x3]=ksdensity(hist_spikes_VioAmaM3,-58:binsize:325,'function','pdf','BandWidth',binsize); %funcion de suavizado
plot(xx2x3,ff2f3,'LineWidth',2,'Color',[colorp{15} 0.5]);

curva_promedio2=mean([f; ff2f3; f2f3; f3; rff2f3; ff2f3x; ff2f3]);

pl(5)=subplot(5,1,5);
plot(xx22x3,curva_promedio,'Color','k','LineWidth',2);
hold on
plot(xx22x3,curva_promedio2,'Color','r','LineWidth',2);

ylabel '# de silaba' 
xlabel 'Tiempo (ms)'

linkaxes(pl,'x');
xlim([-73 350])
hold off
