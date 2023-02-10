%% Obtener picos y flancos de P1-pulsatiles-transiciones
%Script para obtener los valores de picos y flancos de P1, pulsátiles y
%transiciones y sus errores respectivos. Los guarda en .mat y hace figuras
%de la deteccion.

%% Para P1
path_datos='F:\Datos Canarios Protocolos\Data procesada\';
%cargo datos
load([path_datos 'P1_spiketimes_raw')
%P1F_VeNe %utilizar esta linea para cambiarle el nombre a todo

binsize=5;
colorp= {[1 1 0]; [1 0 1]; [0 1 1]; [1 0 0]; [0 1 0]; [0 0 1]; [0.5 0.5 0.5]; [0.7 0.7 0]; [0.7 0 0.7];...
[0 0.7 0.7]; [0.7 0 0]; [0 0.7 0]; [0 0 0.7]; [0.3 0.3 0]; [0.3 0 0.3]; [0 0.3 0.3]; [0.3 0 0]; [0 0.3 0]; [0 0 0.3];...
[0.5 0.5 0]; [0.5 0 0.5]; [0 0.5 0.5]; [0.5 0 0]; [0 0.5 0]; [0 0 0.5]}; %mapa de colores

for i=1:length(spiketimes_raw_trial_P1F_VeNe2)
    
    %Flancos
    %primero hago curva de suavizado de spiketimes
    [curvas_P1F_VeNe2(i,:),t_P1F_VeNe2(i,:)]=ksdensity(spiketimes_raw_trial_P1F_VeNe2{1,i},-20:binsize:90,'function','pdf','BandWidth',binsize);
    %calculo la derivada
    derivadas_P1F_VeNe2(i,:)=diff(curvas_P1F_VeNe2(i,:));
    %detecto de los picos de las derivadas, para saber el punto de
    %inflexion
    [pks,locs,w] = findpeaks(derivadas_P1F_VeNe2(i,:));
    ordeno=sort(pks,'descend'); %ordeno de mayor a menor estos picos
    maximos(1)=locs(pks==ordeno(1));
    w_flancos_P1F_VeNe2(i,1)=w(pks==ordeno(1))/2; %error asociado a la deteccion
    flanco_max_P1F_VeNe2(i,:)=t_P1F_VeNe2(i,maximos); %valor de flanco
    valor_max(i,:)=curvas_P1F_VeNe2(i,maximos); %para plot
    
    %Picos
    %encuentro picos en la curva de suavizado de spiketimes
   [pks2,locs2,w2] = findpeaks(curvas_P1F_VeNe2(i,:),t_P1F_VeNe2(i,:));   
   ordeno2=sort(pks2,'descend'); %ordeno de mayor a menor esos picos
   lcs_P1F_VeNe2(i,1)=locs2(pks2==ordeno2(1));
   picos_P1F_VeNe2(i,1)=pks2(pks2==ordeno2(1));
   w_picos_P1F_VeNe2(i,1)=w2(pks2==ordeno2(1))/2; %error asociado (ancho a media altura)
   
   %Ploteo figura de deteccion (curva de derivadas con picos) y guardo un
   %.png
    fig=figure(i)
    plot(t_P1F_VeNe2(i,:),curvas_P1F_VeNe2(i,:),'Color',colorp{4});
    hold on
    scatter(flanco_max_P1F_VeNe2(i,1),valor_max(i,1),'filled');
    scatter(lcs_P1F_VeNe2(i,1),picos_P1F_VeNe2(i,1),'filled');
    findpeaks(derivadas_P1F_VeNe2(i,:),t_P1F_VeNe2(i,1:end-1),'Annotate','extents');
    cd('F:\Datos Canarios Protocolos\Figuras\Curvas de flancos')
    saveas(fig,['P1F_VeNe2-Curva de flancos-' num2str(i) '.png'])
  
  cd('F:\Datos Canarios Protocolos\Scripts\Procesamiento de raw data')
  
end
 
%% Para transicion/pulsátiles
%cargo datos
path_datos='F:\Datos Canarios Protocolos\Data procesada\';
%cargo datos
load([path_datos 'transiciondefrase')
%P1F2_RoNe1 %utilizar esta linea para cambiarle el nombre a todo

binsize=5;
colorp= {[1 1 0]; [1 0 1]; [0 1 1]; [1 0 0]; [0 1 0]; [0 0 1]; [0.5 0.5 0.5]; [0.7 0.7 0]; [0.7 0 0.7];...
[0 0.7 0.7]; [0.7 0 0]; [0 0.7 0]; [0 0 0.7]; [0.3 0.3 0]; [0.3 0 0.3]; [0 0.3 0.3]; [0.3 0 0]; [0 0.3 0]; [0 0 0.3];...
[0.5 0.5 0]; [0.5 0 0.5]; [0 0.5 0.5]; [0.5 0 0]; [0 0.5 0]; [0 0 0.5]}; %mapa de colores

spikes_raw_trial_P1F2_RoNe1_filtered=[];

%Primero recorto los spikes hasta valores de 350 ms, para que sean
%comparables a P0

for j=1:20
    spikes_raw_trial_P1F2_RoNe1_filtered=[spikes_raw_trial_P1F2_RoNe1_filtered spikes_raw_trial_P1F2_RoNe1{j}(spikes_raw_trial_P1F2_RoNe1{1,j}<350)];
end
%Ploteo la curva que aislé
[k,l]=ksdensity(spikes_raw_trial_P1F2_RoNe1_filtered,-58:binsize:350,'function','pdf','BandWidth',binsize); %funcion de suavizado
plot(l,k)

%Flancos
    %Calculo curva de suavizado
    [curvas_P1F2_RoNe1,t_P1F2_RoNe1]=ksdensity(spikes_raw_trial_P1F2_RoNe1_filtered,-58:binsize:350,'function','pdf','BandWidth',binsize); %funcion de suavizado
    %Y ahora las derivadas
    derivadas_P1F2_RoNe1=diff(curvas_P1F2_RoNe1);
    %Encuentro los maximos en las derivadas
    [pks,locs,w] = findpeaks(derivadas_P1F2_RoNe1);
    ordeno=sort(pks,'descend'); %ordeno de mayor a menor
    %Me quedo con los primeros dos valores (por las dudas si hay alguna deteccion rara)
    maximos(1)=locs(pks==ordeno(1));
    maximos(2)=locs(pks==ordeno(2));
    w_flancos_P1F2_RoNe1(1)=w(pks==ordeno(1))/2; %errores asociados
    w_flancos_P1F2_RoNe1(2)=w(pks==ordeno(2))/2;
    flanco_max_P1F2_RoNe1=t_P1F2_RoNe1(maximos); %valores de flancos
    valor_max=curvas_P1F2_RoNe1(maximos);
    
 %Picos
   %Encuentro picos
   [pks2,locs2,w2] = findpeaks(curvas_P1F2_RoNe1,t_P1F2_RoNe1);   
   ordeno2=sort(pks2,'descend'); %los ordeno de mayor a menor
   lcs_P1F2_RoNe1(1)=locs2(pks2==ordeno2(1));
   lcs_P1F2_RoNe1(2)=locs2(pks2==ordeno2(2));
   picos_P1F2_RoNe1(1)=pks2(pks2==ordeno2(1));
   picos_P1F2_RoNe1(2)=pks2(pks2==ordeno2(2));
   w_picos_P1F2_RoNe1(1)=w2(pks2==ordeno2(1))/2; %errores asociados a la deteccion
   w_picos_P1F2_RoNe1(2)=w2(pks2==ordeno2(2))/2;
   
  %Ahora ploteo las curvas de deteccion para guardarlas
    fig=figure(2);
      plot(t_P1F2_RoNe1,curvas_P1F2_RoNe1,'Color',colorp{4});
    hold on
    scatter(flanco_max_P1F2_RoNe1(1),valor_max(1),'filled');
    scatter(flanco_max_P1F2_RoNe1(2),valor_max(2));
    scatter(lcs_P1F2_RoNe1(1),picos_P1F2_RoNe1(1),'filled');
    scatter(lcs_P1F2_RoNe1(2),picos_P1F2_RoNe1(2));    
    findpeaks(derivadas_P1F2_RoNe1,t_P1F2_RoNe1(1:end-1),'Annotate','extents');
  
  %Cartelito con los valores
    display(['Flancos='  num2str(flanco_max_P1F2_RoNe1)])
    display(['Errores flancos=' num2str(w_flancos_P1F2_RoNe1)])
    display(['Picos=' num2str(lcs_P1F2_RoNe1)])
    display(['Errores picos=' num2str(w_picos_P1F2_RoNe1)])
  
  %Guardo figuras de deteccion
  cd('F:\Datos Canarios Protocolos\Figuras\P0\Curvas con deteccion de flancos y picos\Curvas de flancos')
  saveas(fig,['Transicion_P1F2_RoNe1-Curva de flancos.png'])
  
  cd('F:\Datos Canarios Protocolos\Scripts\Procesamiento de raw data')

