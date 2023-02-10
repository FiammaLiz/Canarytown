
   %% VioAma.M1

%Oscilogramas
binsize=5;
pl(1)=subplot(4,1,1);
for k=1:length(syllables)-1
plot(duration_syllables{k}*1000,syllables{k});
hold on
end
ylabel ({'Onda de'; 'sonido(u.a.)'})
title('	VioAma.M1-P0-sin normalizar');

pl(2)=subplot(4,1,2);
hist_spikes_VioAmaM1= cell2mat(spike_train_VioAmaM1);
[f,x]=ksdensity(hist_spikes_VioAmaM1,'BandWidth',binsize,'function','pdf'); %funcion de suavizado
plot(x,f,'LineWidth',1,'Color',colorp{21});
ylabel ({'Probabilidad'; 'de disparo'})

pl(3)=subplot(4,1,3:4);

         for h=1:length(spike_train_VioAmaM1)  
  line(spike_train_VioAmaM1{1,h}'*[1 1],[-0.4 0.4] + h,'LineStyle','-','MarkerSize',4,'Color',colorp{21}); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
         hold on
         end 
  hold off 
  ylabel('# de silaba');
  xlabel('Tiempo(ms)');
  linkaxes(pl,'x')
  xlim([-73 325]) 
  
  
    %% VioAma.M3

%Oscilogramas
binsize=5;
pl(1)=subplot(4,1,1);
for k=1:length(syllables)-1
plot(duration_syllables{k}*1000,syllables{k});
hold on
end
ylabel ({'Onda de'; 'sonido(u.a.)'})
title('	VioAma.M3-P0-sin normalizar');

pl(2)=subplot(4,1,2);
hist_spikes_VioAmaM3= cell2mat(spike_train_VioAmaM3);
[f,x]=ksdensity(hist_spikes_VioAmaM3,'BandWidth',binsize,'function','pdf'); %funcion de suavizado
plot(x,f,'LineWidth',1,'Color',colorp{4});
ylabel ({'Probabilidad'; 'de disparo'})

pl(3)=subplot(4,1,3:4);

         for h=1:length(spike_train_VioAmaM3)  
  line(spike_train_VioAmaM3{1,h}'*[1 1],[-0.4 0.4] + h,'LineStyle','-','MarkerSize',4,'Color',colorp{4}); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
         hold on
         end 
  hold off 
  ylabel('# de silaba');
  xlabel('Tiempo(ms)');
  linkaxes(pl,'x')
  xlim([-73 325]) 
  
      %% VioAma.M4

%Oscilogramas
binsize=5;
pl(1)=subplot(4,1,1);
for k=1:length(syllabes)-1
plot(duration_syllables{k}*1000,syllabes{k});
hold on
end
ylabel ({'Onda de'; 'sonido(u.a.)'})
title('	VioAma.M4-P0-sin normalizar');

pl(2)=subplot(4,1,2);
hist_spikes_VioAmaM4= cell2mat(spike_train_VioAmaM4);
[f,x]=ksdensity(hist_spikes_VioAmaM4,'BandWidth',binsize,'function','pdf'); %funcion de suavizado
plot(x,f,'LineWidth',1,'Color',colorp{6});
ylabel ({'Probabilidad'; 'de disparo'})

pl(3)=subplot(4,1,3:4);

         for h=1:length(spike_train_VioAmaM4)  
  line(spike_train_VioAmaM4{1,h}'*[1 1],[-0.4 0.4] + h,'LineStyle','-','MarkerSize',4,'Color',colorp{6}); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
         hold on
         end 
  hold off 
  ylabel('# de silaba');
  xlabel('Tiempo(ms)');
  linkaxes(pl,'x')
  xlim([-73 325]) 
  
  
        %% VioAma.M5

%Oscilogramas
binsize=5;
pl(1)=subplot(4,1,1);
for k=1:length(syllabes)-1
plot(duration_syllables{k}*1000,syllabes{k});
hold on
end
ylabel ({'Onda de'; 'sonido(u.a.)'})
title('	VioAma.M5-P0-sin normalizar');

pl(2)=subplot(4,1,2);
hist_spikes_VioAmaM5= cell2mat(spike_train_VioAmaM5);
[f,x]=ksdensity(hist_spikes_VioAmaM5,'BandWidth',binsize,'function','pdf'); %funcion de suavizado
plot(x,f,'LineWidth',1,'Color',colorp{7});
ylabel ({'Probabilidad'; 'de disparo'})

pl(3)=subplot(4,1,3:4);

         for h=1:length(spike_train_VioAmaM5)  
  line(spike_train_VioAmaM5{1,h}'*[1 1],[-0.4 0.4] + h,'LineStyle','-','MarkerSize',4,'Color',colorp{7}); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
         hold on
         end 
  hold off 
  ylabel('# de silaba');
  xlabel('Tiempo(ms)');
  linkaxes(pl,'x')
  xlim([-73 325]) 
  
        %% VioAma.M6

%Oscilogramas
binsize=5;
pl(1)=subplot(4,1,1);
for k=1:length(syllabes)-1
plot(duration_syllables{k}*1000,syllabes{k});
hold on
end
ylabel ({'Onda de'; 'sonido(u.a.)'})
title('	VioAma.M6-P0-sin normalizar');

pl(2)=subplot(4,1,2);
hist_spikes_VioAmaM6= cell2mat(spike_train_VioAmaM6);
[f,x]=ksdensity(hist_spikes_VioAmaM6,'BandWidth',binsize,'function','pdf'); %funcion de suavizado
plot(x,f,'LineWidth',1,'Color',colorp{8});
ylabel ({'Probabilidad'; 'de disparo'})

pl(3)=subplot(4,1,3:4);

         for h=1:length(spike_train_VioAmaM6)  
  line(spike_train_VioAmaM6{1,h}'*[1 1],[-0.4 0.4] + h,'LineStyle','-','MarkerSize',4,'Color',colorp{8}); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
         hold on
         end 
  hold off 
  ylabel('# de silaba');
  xlabel('Tiempo(ms)');
  linkaxes(pl,'x')
  xlim([-73 325]) 
  
          %% VioAma.M7

%Oscilogramas
binsize=5;
pl(1)=subplot(4,1,1);
for k=1:length(syllabes)-1
plot(duration_syllables{k}*1000,syllabes{k});
hold on
end
ylabel ({'Onda de'; 'sonido(u.a.)'})
title('	VioAma.M6-P0-sin normalizar');

pl(2)=subplot(4,1,2);
hist_spikes_VioAmaM7= cell2mat(spike_train_VioAmaM7);
[f,x]=ksdensity(hist_spikes_VioAmaM7,'BandWidth',binsize,'function','pdf'); %funcion de suavizado
plot(x,f,'LineWidth',1,'Color',colorp{10});
ylabel ({'Probabilidad'; 'de disparo'})

pl(3)=subplot(4,1,3:4);

         for h=1:length(spike_train_VioAmaM7)  
  line(spike_train_VioAmaM7{1,h}'*[1 1],[-0.4 0.4] + h,'LineStyle','-','MarkerSize',4,'Color',colorp{10}); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
         hold on
         end 
  hold off 
  ylabel('# de silaba');
  xlabel('Tiempo(ms)');
  linkaxes(pl,'x')
  xlim([-73 325]) 
  
            %% VioAma.M8

%Oscilogramas
binsize=5;
pl(1)=subplot(4,1,1);
for k=1:length(syllabes)-1
plot(duration_syllables{k}*1000,syllabes{k});
hold on
end
ylabel ({'Onda de'; 'sonido(u.a.)'})
title('	VioAma.M8-P0-sin normalizar');

pl(2)=subplot(4,1,2);
hist_spikes_VioAmaM8= cell2mat(spike_train_VioAmaM8);
[f,x]=ksdensity(hist_spikes_VioAmaM8,'BandWidth',binsize,'function','pdf'); %funcion de suavizado
plot(x,f,'LineWidth',1,'Color',colorp{11});
ylabel ({'Probabilidad'; 'de disparo'})

pl(3)=subplot(4,1,3:4);

         for h=1:length(spike_train_VioAmaM8)  
  line(spike_train_VioAmaM8{1,h}'*[1 1],[-0.4 0.4] + h,'LineStyle','-','MarkerSize',4,'Color',colorp{11}); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
         hold on
         end 
  hold off 
  ylabel('# de silaba');
  xlabel('Tiempo(ms)');
  linkaxes(pl,'x')
  xlim([-73 325]) 
  
              %% VioAma.M9

%Oscilogramas
binsize=5;
pl(1)=subplot(4,1,1);
for k=1:3
plot(duration_syllables{k}*1000,syllabes{k});
hold on
end
ylabel ({'Onda de'; 'sonido(u.a.)'})
title('	VioAma.M9-P0-sin normalizar');

pl(2)=subplot(4,1,2);
hist_spikes_VioAmaM9= cell2mat(spike_train_VioAmaM9);
[f,x]=ksdensity(hist_spikes_VioAmaM9,'BandWidth',binsize,'function','pdf'); %funcion de suavizado
plot(x,f,'LineWidth',1,'Color',colorp{12});
ylabel ({'Probabilidad'; 'de disparo'})

pl(3)=subplot(4,1,3:4);

         for h=1:length(spike_train_VioAmaM9)  
  line(spike_train_VioAmaM9{1,h}'*[1 1],[-0.4 0.4] + h,'LineStyle','-','MarkerSize',4,'Color',colorp{12}); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
         hold on
         end 
  hold off 
  ylabel('# de silaba');
  xlabel('Tiempo(ms)');
  linkaxes(pl,'x')
  xlim([-73 325]) 
  
                %% VioAma.M10

%Oscilogramas
binsize=5;
pl(1)=subplot(4,1,1);
for k=1:3
plot(duration_syllables{k}*1000,syllabes{k});
hold on
end
ylabel ({'Onda de'; 'sonido(u.a.)'})
title('	VioAma.M9-P0-sin normalizar');

pl(2)=subplot(4,1,2);
hist_spikes_VioAmaM10= cell2mat(spike_train_VioAmaM10);
[f,x]=ksdensity(hist_spikes_VioAmaM10,'BandWidth',binsize,'function','pdf'); %funcion de suavizado
plot(x,f,'LineWidth',1,'Color',colorp{13});
ylabel ({'Probabilidad'; 'de disparo'})

pl(3)=subplot(4,1,3:4);

         for h=1:length(spike_train_VioAmaM)  
  line(spike_train_VioAmaM10{1,h}'*[1 1],[-0.4 0.4] + h,'LineStyle','-','MarkerSize',4,'Color',colorp{13}); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
         hold on
         end 
  hold off 
  ylabel('# de silaba');
  xlabel('Tiempo(ms)');
  linkaxes(pl,'x')
  xlim([-73 325]) 
  
%% RoNe.M1

%Oscilogramas normalizados
binsize=5;
pl(1)=subplot(4,1,1);
for k=1:length(syllabes_RoNe)-1
t_audio_stim=(1:length(syllabes_RoNe{k}))*1000/sample_rate; %#ok<SAGROW>
plot(t_audio_stim,syllabes_RoNe{k});
hold on
end
ylabel ({'Envolventes de'; 'sonido(u.a.)'})
title('RoNe.M1-P0-sin normalizar');

pl(2)=subplot(4,1,2);
hist_spikes_RoNe1= cell2mat(spike_train_RoNe1);
[f,x]=ksdensity(hist_spikes_RoNe1(hist_spikes_RoNe1<5000),'BandWidth',binsize,'function','pdf'); %funcion de suavizado
plot(x,f,'LineWidth',1,'Color',colorp{1});
ylabel ({'Probabilidad'; 'de disparo'})

pl(3)=subplot(4,1,3:4);

         for h=1:length(spike_train_RoNe1)  
  line(spike_train_RoNe1{1,h}'*[1 1],[-0.4 0.4] + h,'LineStyle','-','MarkerSize',4,'Color',colorp{1}); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
         hold on
         end 
  line(pl(3).XLim,[0.5 0.5]+2,'LineStyle','--','MarkerSize',4,'Color',[0.5 0.5 0.5]); 
  for o=1:2
  patch([-73 -73 -67 -67],[-0.4 0.4 0.4 -0.4] + o,[0 0.4470 0.7410],'FaceAlpha',0.8,'EdgeColor','none'); 
  end
  for o=3:4
  patch([-73 -73 -67 -67],[-0.4 0.4 0.4 -0.4] + o,[0.8500 0.3250 0.0980],'FaceAlpha',0.8,'EdgeColor','none'); 
  end
  hold off 
  ylabel('# de silaba');
  xlabel('Tiempo(ms)');
  linkaxes(pl,'x')
  xlim([-73 325]) 
  
  %% RoNe.M2

%Oscilogramas normalizados
binsize=5;
pl(1)=subplot(4,1,1);
for k=1:length(syllabes_RoNe)-1
t_audio_stim=(1:length(syllabes_RoNe{k}))*1000/sample_rate; %#ok<SAGROW>
plot(t_audio_stim,syllabes_RoNe{k});
hold on
end
ylabel ({'Envolventes de'; 'sonido(u.a.)'})
title('RoNe.M2-P0-sin normalizar');


pl(2)=subplot(4,1,2);
hist_spikes_RoNe2= cell2mat(spike_train_RoNe2);
[f,x]=ksdensity(hist_spikes_RoNe2(hist_spikes_RoNe2<5000),'BandWidth',binsize,'function','pdf'); %funcion de suavizado
plot(x,f,'LineWidth',1,'Color',colorp{2});
ylabel ({'Probabilidad'; 'de disparo'})

pl(3)=subplot(4,1,3:4);

         for h=1:length(spike_train_RoNe2)  
  line(spike_train_RoNe2{1,h}'*[1 1],[-0.4 0.4] + h,'LineStyle','-','MarkerSize',4,'Color',colorp{2}); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
         hold on
         end 
  line(pl(3).XLim,[0.5 0.5]+2,'LineStyle','--','MarkerSize',4,'Color',[0.5 0.5 0.5]); 
  for o=1:2
  patch([-73 -73 -67 -67],[-0.4 0.4 0.4 -0.4] + o,[0 0.4470 0.7410],'FaceAlpha',0.8,'EdgeColor','none'); 
  end
  for o=3:5
  patch([-73 -73 -67 -67],[-0.4 0.4 0.4 -0.4] + o,[0.8500 0.3250 0.0980],'FaceAlpha',0.8,'EdgeColor','none'); 
  end
  hold off 
  ylabel('# de silaba');
  xlabel('Tiempo(ms)');
  linkaxes(pl,'x')
  xlim([-73 325]) 
  
   %% RoNe.M3

%Oscilogramas normalizados
binsize=5;
pl(1)=subplot(4,1,1);
for k=1:length(syllabes_RoNe)-1
t_audio_stim=(1:length(syllabes_RoNe{k}))*1000/sample_rate; %#ok<SAGROW>
plot(t_audio_stim,syllabes_RoNe{k});
hold on
end
ylabel ({'Envolventes de'; 'sonido(u.a.)'})
title('RoNe.M3-P0-sin normalizar');


pl(2)=subplot(4,1,2);
hist_spikes_RoNe3= cell2mat(spike_train_RoNe3);
[f,x]=ksdensity(hist_spikes_RoNe3(hist_spikes_RoNe3<5000),'BandWidth',binsize,'function','pdf'); %funcion de suavizado
plot(x,f,'LineWidth',1,'Color',colorp{3});
ylabel ({'Probabilidad'; 'de disparo'})

pl(3)=subplot(4,1,3:4);

         for h=1:length(spike_train_RoNe3)  
  line(spike_train_RoNe3{1,h}'*[1 1],[-0.4 0.4] + h,'LineStyle','-','MarkerSize',4,'Color',colorp{3}); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
         hold on
         end 
  line(pl(3).XLim,[0.5 0.5]+3,'LineStyle','--','MarkerSize',4,'Color',[0.5 0.5 0.5]); 
  for o=1:3
  patch([-73 -73 -67 -67],[-0.4 0.4 0.4 -0.4] + o,[0 0.4470 0.7410],'FaceAlpha',0.8,'EdgeColor','none'); 
  end
  for o=4:6
  patch([-73 -73 -67 -67],[-0.4 0.4 0.4 -0.4] + o,[0.8500 0.3250 0.0980],'FaceAlpha',0.8,'EdgeColor','none'); 
  end
  hold off 
  ylabel('# de silaba');
  xlabel('Tiempo(ms)');
  linkaxes(pl,'x')
  xlim([-73 325]) 
  
     %% RoNe.M4

%Oscilogramas normalizados
binsize=5;
pl(1)=subplot(4,1,1);
for k=1:length(syllables)
t_audio_stim=(1:length(syllables{k}))*1000/sample_rate; %#ok<SAGROW>
plot(t_audio_stim,syllables{k});
pause
end
ylabel ({'Envolventes de'; 'sonido(u.a.)'})
title('RoNe.M5-P0-sin normalizar');


pl(2)=subplot(4,1,2);
hist_spikes_RoNe4= cell2mat(spike_train_RoNe4);
[f,x]=ksdensity(hist_spikes_RoNe4(hist_spikes_RoNe4<5000),'BandWidth',binsize,'function','pdf'); %funcion de suavizado
plot(x,f,'LineWidth',1,'Color',colorp{4});
ylabel ({'Probabilidad'; 'de disparo'})

pl(3)=subplot(4,1,3:4);

         for h=1:length(spike_train_RoNe4)  
  line(spike_train_RoNe4{1,h}'*[1 1],[-0.4 0.4] + h,'LineStyle','-','MarkerSize',4,'Color',colorp{4}); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
         hold on
         end 
   for o=1:3
  patch([-73 -73 -67 -67],[-0.4 0.4 0.4 -0.4] + o,[0 0.4470 0.7410],'FaceAlpha',0.8,'EdgeColor','none'); 
   end
  hold off 
  ylabel('# de silaba');
  xlabel('Tiempo(ms)');
  linkaxes(pl,'x')
  xlim([-73 325]) 
  
      %% RoNe.M5

%Oscilogramas normalizados
binsize=5;
pl(1)=subplot(4,1,1);
plot(duration_syllabes{1},envelopes_syllabes_mean{1});
ylabel ({'Envolventes de'; 'sonido(u.a.)'})
title('RoNe.M4-P0-sin normalizar');

pl(2)=subplot(4,1,2);
hist_spikes_RoNe5= cell2mat(spike_train_RoNe5);
[f,x]=ksdensity(hist_spikes_RoNe5,'BandWidth',binsize,'function','pdf'); %funcion de suavizado
plot(x,f,'LineWidth',1,'Color',colorp{5});
ylabel ({'Probabilidad'; 'de disparo'})

pl(3)=subplot(4,1,3:4);

         for h=1:length(spike_train_RoNe5)  
  line(spike_train_RoNe5{1,h}'*[1 1],[-0.4 0.4] + h,'LineStyle','-','MarkerSize',4,'Color',colorp{5}); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
         hold on
         end 
   for o=1:3
  patch([-73 -73 -67 -67],[-0.4 0.4 0.4 -0.4] + o,[0 0.4470 0.7410],'FaceAlpha',0.8,'EdgeColor','none'); 
   end
  hold off 
  ylabel('# de silaba');
  
       %% RoNe.M6

%Oscilogramas normalizados
binsize=5;
pl(1)=subplot(4,1,1);
for k=1:length(envelopes_syllabes_mean)-1
plot(duration_syllabes{k},envelopes_syllabes_mean{k});
hold on
end
ylabel ({'Envolventes de'; 'sonido(u.a.)'})
title('RoNe.M6-P0-sin normalizar');

pl(2)=subplot(4,1,2);
hist_spikes_RoNe6= cell2mat(spike_train_RoNe6);
[f,x]=ksdensity(hist_spikes_RoNe6,'BandWidth',binsize,'function','pdf'); %funcion de suavizado
plot(x,f,'LineWidth',1,'Color',colorp{6});
ylabel ({'Probabilidad'; 'de disparo'})

pl(3)=subplot(4,1,3:4);

         for h=1:length(spike_train_RoNe6)  
  line(spike_train_RoNe6{1,h}'*[1 1],[-0.4 0.4] + h,'LineStyle','-','MarkerSize',4,'Color',colorp{6}); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
         hold on
         line(pl(3).XLim,[0.5 0.5]+4,'LineStyle','--','MarkerSize',4,'Color',[0.5 0.5 0.5]); 
         end 
  for o=1:4
  patch([-73 -73 -67 -67],[-0.4 0.4 0.4 -0.4] + o,[0 0.4470 0.7410],'FaceAlpha',0.8,'EdgeColor','none'); 
  end
  for o=5:7
  patch([-73 -73 -67 -67],[-0.4 0.4 0.4 -0.4] + o,[0.8500 0.3250 0.0980],'FaceAlpha',0.8,'EdgeColor','none'); 
  end
  hold off 
  ylabel('# de silaba');
  xlabel('Tiempo(ms)');
  linkaxes(pl,'x')
  xlim([-73 325]) 
  
  xlabel('Tiempo(ms)');
  linkaxes(pl,'x')
  xlim([-73 325]) 
  
        %% RoNe.M7

%Oscilogramas normalizados
binsize=5;
pl(1)=subplot(4,1,1);
for k=1:length(envelopes_syllabes_mean)-1
plot(duration_syllabes{k},envelopes_syllabes_mean{k});
hold on
end
ylabel ({'Envolventes de'; 'sonido(u.a.)'})
title('RoNe.M7-P0-sin normalizar');

pl(2)=subplot(4,1,2);
hist_spikes_RoNe7= cell2mat(spike_train_RoNe7);
[f,x]=ksdensity(hist_spikes_RoNe7,'BandWidth',binsize,'function','pdf'); %funcion de suavizado
plot(x,f,'LineWidth',1,'Color',colorp{7});
ylabel ({'Probabilidad'; 'de disparo'})

pl(3)=subplot(4,1,3:4);

         for h=1:length(spike_train_RoNe7)  
  line(spike_train_RoNe7{1,h}'*[1 1],[-0.4 0.4] + h,'LineStyle','-','MarkerSize',4,'Color',colorp{7}); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
         hold on
         line(pl(3).XLim,[0.5 0.5]+3,'LineStyle','--','MarkerSize',4,'Color',[0.5 0.5 0.5]); 
         end 
  for o=1:3
  patch([-73 -73 -67 -67],[-0.4 0.4 0.4 -0.4] + o,[0 0.4470 0.7410],'FaceAlpha',0.8,'EdgeColor','none'); 
  end
  for o=3:6
  patch([-73 -73 -67 -67],[-0.4 0.4 0.4 -0.4] + o,[0.8500 0.3250 0.0980],'FaceAlpha',0.8,'EdgeColor','none'); 
  end
  hold off 
  ylabel('# de silaba');
  xlabel('Tiempo(ms)');
  linkaxes(pl,'x')
  xlim([-73 325]) 
  
  xlabel('Tiempo(ms)');
  linkaxes(pl,'x')
  xlim([-73 325]) 
  
   
        %% RoNe.M8

%Oscilogramas normalizados
binsize=5;
pl(1)=subplot(4,1,1);
plot(duration_syllabes{1},envelopes_syllabes_mean{1});
ylabel ({'Envolventes de'; 'sonido(u.a.)'})
title('RoNe.M7-P0-sin normalizar');

pl(2)=subplot(4,1,2);
hist_spikes_RoNe8= cell2mat(spike_train_RoNe8);
[f,x]=ksdensity(hist_spikes_RoNe8,'BandWidth',binsize,'function','pdf'); %funcion de suavizado
plot(x,f,'LineWidth',1,'Color',colorp{8});
ylabel ({'Probabilidad'; 'de disparo'})

pl(3)=subplot(4,1,3:4);

         for h=1:length(spike_train_RoNe8)  
  line(spike_train_RoNe8{1,h}'*[1 1],[-0.4 0.4] + h,'LineStyle','-','MarkerSize',4,'Color',colorp{8}); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
         hold on
         end 
   for o=1:3
  patch([-73 -73 -67 -67],[-0.4 0.4 0.4 -0.4] + o,[0 0.4470 0.7410],'FaceAlpha',0.8,'EdgeColor','none'); 
   end
  hold off 
  ylabel('# de silaba');
  xlabel('Tiempo(ms)');
  linkaxes(pl,'x')
  xlim([-73 325]) 
  
  
%% VeNe.M1

%Oscilogramas normalizados
binsize=5;
pl(1)=subplot(4,1,1);
plot(duration_syllabes{3},envelopes_syllabes_mean{3},'Color',[0.9290 0.6940 0.1250]);
ylabel ({'Envolvente de'; 'sonido(u.a.)'})
title('VeNe.M1-P0-sin normalizar');

pl(2)=subplot(4,1,2);
hist_spikes_VeNe1= cell2mat(spike_train_VeNe1);
[f,x]=ksdensity(hist_spikes_VeNe1,'BandWidth',binsize,'function','pdf'); %funcion de suavizado
plot(x,f,'LineWidth',1,'Color',colorp{10});
ylabel ({'Probabilidad'; 'de disparo'})

pl(3)=subplot(4,1,3:4);

         for h=1:length(spike_train_VeNe1)  
  line(spike_train_VeNe1{1,h}'*[1 1],[-0.4 0.4] + h,'LineStyle','-','MarkerSize',4,'Color',colorp{10}); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
         hold on
         end 
  hold off 
  ylabel('# de silaba');
  xlabel('Tiempo(ms)');
  linkaxes(pl,'x')
  xlim([-58 325]) 
  
  %% VeNe.M2

%Oscilogramas normalizados
binsize=5;
pl(1)=subplot(4,1,1);
plot(duration_syllabes{3},envelopes_syllabes_mean{3},'Color',[0.9290 0.6940 0.1250]);
ylabel ({'Envolvente de'; 'sonido(u.a.)'})
title('VeNe.M2-P0-sin normalizar');

pl(2)=subplot(4,1,2);
hist_spikes_VeNe2= cell2mat(spike_train_VeNe2);
[f,x]=ksdensity(hist_spikes_VeNe2,'BandWidth',binsize,'function','pdf'); %funcion de suavizado
plot(x,f,'LineWidth',1,'Color',colorp{11});
ylabel ({'Probabilidad'; 'de disparo'})

pl(3)=subplot(4,1,3:4);

         for h=1:length(spike_train_VeNe2)  
  line(spike_train_VeNe2{1,h}'*[1 1],[-0.4 0.4] + h,'LineStyle','-','MarkerSize',4,'Color',colorp{11}); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
         hold on
         end 
  hold off 
  ylabel('# de silaba');
  xlabel('Tiempo(ms)');
  linkaxes(pl,'x')
  xlim([-58 325]) 
  
  %% VeNe.M3

%Oscilogramas normalizados
binsize=5;
pl(1)=subplot(4,1,1);
plot(duration_syllabes{3},envelopes_syllabes_mean{3},'Color',[0.9290 0.6940 0.1250]);
ylabel ({'Envolvente de'; 'sonido(u.a.)'})
title('VeNe.M3-P0-sin normalizar');

pl(2)=subplot(4,1,2);
hist_spikes_VeNe3= cell2mat(spike_train_VeNe3);
[f,x]=ksdensity(hist_spikes_VeNe3,'BandWidth',binsize,'function','pdf'); %funcion de suavizado
plot(x,f,'LineWidth',1,'Color',colorp{12});
ylabel ({'Probabilidad'; 'de disparo'})

pl(3)=subplot(4,1,3:4);

         for h=1:length(spike_train_VeNe3)  
  line(spike_train_VeNe3{1,h}'*[1 1],[-0.4 0.4] + h,'LineStyle','-','MarkerSize',4,'Color',colorp{12}); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
         hold on
         end 
  hold off 
  ylabel('# de silaba');
  xlabel('Tiempo(ms)');
  linkaxes(pl,'x')
  xlim([-58 325]) 
  
%% VeNe.M4

%Oscilogramas normalizados
binsize=5;
pl(1)=subplot(4,1,1);
plot(duration_syllabes{3},envelopes_syllabes_mean{3},'Color',[0.9290 0.6940 0.1250]);
ylabel ({'Envolvente de'; 'sonido(u.a.)'})
title('VeNe.M4-P0-sin normalizar');

pl(2)=subplot(4,1,2);
hist_spikes_VeNe4= cell2mat(spike_train_VeNe4);
[f,x]=ksdensity(hist_spikes_VeNe4,'BandWidth',binsize,'function','pdf'); %funcion de suavizado
plot(x,f,'LineWidth',1,'Color',colorp{13});
ylabel ({'Probabilidad'; 'de disparo'})

pl(3)=subplot(4,1,3:4);

         for h=1:length(spike_train_VeNe4)  
  line(spike_train_VeNe4{1,h}'*[1 1],[-0.4 0.4] + h,'LineStyle','-','MarkerSize',4,'Color',colorp{13}); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
         hold on
         end 
  hold off 
  ylabel('# de silaba');
  xlabel('Tiempo(ms)');
  linkaxes(pl,'x')
  xlim([-58 325]) 
  
  %% VeNe.M5

%Oscilogramas normalizados
binsize=5;
pl(1)=subplot(4,1,1);
plot(duration_syllabes{3},envelopes_syllabes_mean{3},'Color',[0.9290 0.6940 0.1250]);
ylabel ({'Envolvente de'; 'sonido(u.a.)'})
title('VeNe.M5-P0-sin normalizar');

pl(2)=subplot(4,1,2);
hist_spikes_VeNe5= cell2mat(spike_train_VeNe5);
[f,x]=ksdensity(hist_spikes_VeNe5,'BandWidth',binsize,'function','pdf'); %funcion de suavizado
plot(x,f,'LineWidth',1,'Color',colorp{14});
ylabel ({'Probabilidad'; 'de disparo'})

pl(3)=subplot(4,1,3:4);

         for h=1:length(spike_train_VeNe5)  
  line(spike_train_VeNe5{1,h}'*[1 1],[-0.4 0.4] + h,'LineStyle','-','MarkerSize',4,'Color',colorp{14}); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
         hold on
         end 
  hold off 
  ylabel('# de silaba');
  xlabel('Tiempo(ms)');
  linkaxes(pl,'x')
  xlim([-58 325]) 
  
  %% VeNe.M6

%Oscilogramas normalizados
binsize=5;
pl(1)=subplot(4,1,1);
plot(duration_syllabes{3},envelopes_syllabes_mean{3},'Color',[0.9290 0.6940 0.1250]);
ylabel ({'Envolvente de'; 'sonido(u.a.)'})
title('VeNe.M4-P0-sin normalizar');

pl(2)=subplot(4,1,2);
hist_spikes_VeNe6= cell2mat(spike_train_VeNe6);
[f,x]=ksdensity(hist_spikes_VeNe6,'BandWidth',binsize,'function','pdf'); %funcion de suavizado
plot(x,f,'LineWidth',1,'Color',colorp{15});
ylabel ({'Probabilidad'; 'de disparo'})

pl(3)=subplot(4,1,3:4);

         for h=1:length(spike_train_VeNe6)  
  line(spike_train_VeNe6{1,h}'*[1 1],[-0.4 0.4] + h,'LineStyle','-','MarkerSize',4,'Color',colorp{15}); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
         hold on
         end 
  hold off 
  ylabel('# de silaba');
  xlabel('Tiempo(ms)');
  linkaxes(pl,'x')
  xlim([-58 325]) 
  
  %% VeNe.M7

%Oscilogramas normalizados
binsize=5;
pl(1)=subplot(4,1,1);
plot(duration_syllabes{3},envelopes_syllabes_mean{3},'Color',[0.9290 0.6940 0.1250]);
ylabel ({'Envolvente de'; 'sonido(u.a.)'})
title('VeNe.M7-P0-sin normalizar');

pl(2)=subplot(4,1,2);
hist_spikes_VeNe7= cell2mat(spike_train_VeNe7);
[f,x]=ksdensity(hist_spikes_VeNe7,'BandWidth',binsize,'function','pdf'); %funcion de suavizado
plot(x,f,'LineWidth',1,'Color',colorp{16});
ylabel ({'Probabilidad'; 'de disparo'})

pl(3)=subplot(4,1,3:4);

         for h=1:length(spike_train_VeNe7)  
  line(spike_train_VeNe7{1,h}'*[1 1],[-0.4 0.4] + h,'LineStyle','-','MarkerSize',4,'Color',colorp{16}); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
         hold on
         end 
  hold off 
  ylabel('# de silaba');
  xlabel('Tiempo(ms)');
  linkaxes(pl,'x')
  xlim([-58 325]) 