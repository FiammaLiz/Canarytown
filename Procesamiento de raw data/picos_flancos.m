binsize=5;
 colorp= {[1 1 0]; [1 0 1]; [0 1 1]; [1 0 0]; [0 1 0]; [0 0 1]; [0.5 0.5 0.5]; [0.7 0.7 0]; [0.7 0 0.7];...
[0 0.7 0.7]; [0.7 0 0]; [0 0.7 0]; [0 0 0.7]; [0.3 0.3 0]; [0.3 0 0.3]; [0 0.3 0.3]; [0.3 0 0]; [0 0.3 0]; [0 0 0.3];...
[0.5 0.5 0]; [0.5 0 0.5]; [0 0.5 0.5]; [0.5 0 0]; [0 0.5 0]; [0 0 0.5]};

for i=1:length(spike_train_RoNe8)
    [curvas_RoNe8(i,:),t_RoNe8(i,:)]=ksdensity(spike_train_RoNe8{1,i},-58:binsize:350,'function','pdf','BandWidth',binsize); %funcion de suavizado
    derivadas_RoNe8(i,:)=diff(curvas_RoNe8(i,:));
    [pks,locs,w] = findpeaks(derivadas_RoNe8(i,:));
    ordeno=sort(pks,'descend');
    maximos(1)=locs(pks==ordeno(1));
    maximos(2)=locs(pks==ordeno(2));
    w_flancos_RoNe8(i,1)=w(pks==ordeno(1));
    w_flancos_RoNe8(i,2)=w(pks==ordeno(2));
    flanco_max_RoNe8(i,:)=t_RoNe8(i,maximos);
    valor_max(i,:)=curvas_RoNe8(i,maximos);
   
    
   [pks2,locs2,w2] = findpeaks(curvas_RoNe8(i,:),t_RoNe8(i,:));   
   ordeno2=sort(pks2,'descend');
   lcs_RoNe8(i,1)=locs2(pks2==ordeno2(1));
   lcs_RoNe8(i,2)=locs2(pks2==ordeno2(2));
   picos_RoNe8(i,1)=pks2(pks2==ordeno2(1));
   picos_RoNe8(i,2)=pks2(pks2==ordeno2(2));
   w_picos_RoNe8(i,1)=w2(pks2==ordeno2(1));
   w_picos_RoNe8(i,2)=w2(pks2==ordeno2(2));

    fig= figure(i);

    a(1)=subplot(2,1,1);
    plot(t_RoNe8(i,:),curvas_RoNe8(i,:),'Color',colorp{15});
    hold on
    scatter(flanco_max_RoNe8(i,1),valor_max(i,1),'filled');
    scatter(flanco_max_RoNe8(i,2),valor_max(i,2));
    scatter(lcs_RoNe8(i,1),picos_RoNe8(i,1),'filled');
    scatter(lcs_RoNe8(i,2),picos_RoNe8(i,2));    
    ylabel({'Curva individual' ; 'con flancos y picos'})
    
    a(2)=subplot(2,1,2);
  line(spike_train_RoNe8{1,i}'*[1 1],[-0.4 0.4],'LineStyle','-','MarkerSize',4,'Color',colorp{15}); %extrae las instancias de disparo y hace lineas azules, apilándolas por cada trial 
  ylabel('Raster individual')
  xlabel('Tiempo desde el comienzo de la sílaba (ms)')
  
  xlim([-58 350])
  linkaxes(a,'x')
  equispace(fig)
  
%  cd('F:\Datos Canarios Protocolos\Figuras\P0\Curvas con deteccion de flancos y picos')
 % saveas(fig,['RoNe8-Curva individual-' num2str(i) '.png'])
  
 % cd('F:\Datos Canarios Protocolos\Scripts\Procesamiento de raw data')
end