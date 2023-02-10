%% Picos-flancos plot
%Script para realizar la figura scatter de picos y flancos, sale una sola
%figura con las envelopes, el scatter de los valores de picos y los flancos
%con su error y los histogramas y curvas de suavizado
%Fiamma Liz Leites, Matlab 2018a

%% Cargo los datos
path_datos='F:\Datos Canarios Protocolos\Data procesada\';
load([path_datos 'picos_flancos.mat'])

%% Ploteo

binsize=5;

f1=figure(1);

%Envelopes de silabas P0 (como referencia)
a(1)=subplot(5,1,1);
for i=1:length(duration_syllabes)
    plot(duration_syllabes{i},envelopes_syllabes_mean{i},'LineWidth',2.5)
    hold on
end 
ylabel({'Envolvente de'; 'sonido(u.a.)'})


%Scatter de valores de picos
a(2)=subplot(5,1,2);

%Picos a nota B, alineados a onset B
errorbar(diffonsetB_picos,segundo_pico_grupo,err_segundo_pico,'horizontal','o')
hold on
scatter(diffonsetB_picos,segundo_pico_grupo,'filled','MarkerFaceColor','b')

%Picos a nota A
errorbar(primer_pico,primer_pico_grupo,err_primer_pico,'horizontal','o')
scatter(primer_pico,primer_pico_grupo,'filled','MarkerFaceColor','r')

%Picos a P1
errorbar(picos_p1,p1_grupo,err_picos_p1,'horizontal','o')
scatter(picos_p1,p1_grupo,'filled','MarkerFaceColor',[0.4660 0.6740 0.1880])

%Picos de transiciones
errorbar(picos_transicion,transicion_grupo,err_picos_transicion,'horizontal','o')
scatter(picos_transicion,transicion_grupo,'filled','MarkerFaceColor',[0.8500 0.3250 0.0980])

%Picos a pulsátiles
errorbar(picos_pul,pul_grupo,err_picos_pul,'horizontal','o')
scatter(picos_pul,pul_grupo,'filled','MarkerFaceColor',[0.4940 0.1840 0.5560])

xlim([-58 350])
ylim([-0.5 46])
ylabel({'Valores de pico'})
hold off 

%Histogramas y curvas de suavizados del scatter de picos
a(3)=subplot(5,1,3);

%Nota A
counts=histogram(primer_pico,'BinWidth', binsize, 'Normalization','pdf','EdgeColor','r','FaceColor','none');
hold on
[f,xi]=ksdensity(primer_pico,'BandWidth', binsize);
plot(xi,f,'LineWidth',1,'Color','r','LineWidth',2)

%Nota B alineada a onset B
counts2=histogram(diffonsetB_picos,'BinWidth', binsize, 'Normalization','pdf','EdgeColor','b','FaceColor','none');
[f2,xi2]=ksdensity(diffonsetB_picos,'BandWidth',binsize);
plot(xi2,f2,'LineWidth',1,'Color','b','LineWidth',2)

%P1
counts4=histogram(picos_p1,'BinWidth', binsize, 'Normalization','pdf','EdgeColor',[0.4660 0.6740 0.1880],'FaceColor','none');
[f4,xi4]=ksdensity(picos_p1,'BandWidth', binsize);
plot(xi4,f4,'LineWidth',2,'Color',[0.6350 0.0780 0.1840])

%Transiciones
counts5=histogram(picos_transicion,'BinWidth', binsize, 'Normalization','pdf','EdgeColor',[0.8500 0.3250 0.0980],'FaceColor','none');
[f5,xi5]=ksdensity(picos_transicion,'BandWidth', binsize);
plot(xi5,f5,'LineWidth',2,'Color',[0.8500 0.3250 0.0980])
ylabel({'Histograma'})

%Pulsátiles
counts6=histogram(picos_pul,'BinWidth', binsize, 'Normalization','pdf','EdgeColor',[0.4940 0.1840 0.5560],'FaceColor','none');
[f6,xi6]=ksdensity(picos_pul,'BandWidth', binsize);
plot(xi6,f6,'LineWidth',2,'Color',[0.4940 0.1840 0.5560])
ylabel({'Histograma'})
hold off

%Scatter de valores de flancos
a(4)=subplot(5,1,4);

%Flancos a nota B, alineados a onset B
errorbar(diffonsetB_flancos,segundo_pico_grupo,err_segundo_flanco,'horizontal','o')
hold on
scatter(diffonsetB_flancos,segundo_pico_grupo,'filled','MarkerFaceColor','b')

%Flancos a nota A
errorbar(primer_flanco,primer_pico_grupo,err_primer_flanco,'horizontal','o')
scatter(primer_flanco,primer_pico_grupo,'filled','MarkerFaceColor','r')

%Flancos a P1
errorbar(flancos_p1,p1_grupo,err_flancos_p1,'horizontal','o')
scatter(flancos_p1,p1_grupo,'filled','MarkerFaceColor',[0.4660 0.6740 0.1880])

%Flancos a transiciones
errorbar(flancos_transicion,transicion_grupo,err_flancos_transicion,'horizontal','o')
scatter(flancos_transicion,transicion_grupo,'filled','MarkerFaceColor',[0.8500 0.3250 0.0980])

%Flancos a pulsátiles
errorbar(flancos_pul,pul_grupo,err_flancos_pul,'horizontal','o')
scatter(flancos_pul,pul_grupo,'filled','MarkerFaceColor',[0.4940 0.1840 0.5560])

xlim([-58 350])
ylim([-0.5 46])
ylabel({'Valores de flancos'})
hold off

%Histogramas y curvas de suavizados del scatter de flancos
a(5)=subplot(5,1,5);

%Nota A
counts=histogram(primer_flanco,'BinWidth', binsize, 'Normalization','pdf','EdgeColor','r','FaceColor','none');
hold on
[f,xi]=ksdensity(primer_flanco,'BandWidth', binsize);
plot(xi,f,'LineWidth',1,'Color','r','LineWidth',2);

%Nota B alineada a onset B
counts2=histogram(diffonsetB_flancos,'BinWidth', binsize, 'Normalization','pdf','EdgeColor','b','FaceColor','none');
[f2,xi2]=ksdensity(diffonsetB_flancos,'BandWidth', binsize);
plot(xi2,f2,'LineWidth',2,'Color','b')

%P1
counts4=histogram(flancos_p1,'BinWidth', binsize, 'Normalization','pdf','EdgeColor',[0.4660 0.6740 0.1880],'FaceColor','none');
[f4,xi4]=ksdensity(flancos_p1,'BandWidth', binsize);
plot(xi4,f4,'LineWidth',2,'Color',[0.4660 0.6740 0.1880])

%Transiciones
counts5=histogram(flancos_transicion,'BinWidth', binsize, 'Normalization','pdf','EdgeColor',[0.8500 0.3250 0.0980],'FaceColor','none');
[f5,xi5]=ksdensity(flancos_transicion,'BandWidth', binsize);
plot(xi5,f5,'LineWidth',2,'Color',[0.8500 0.3250 0.0980])

%Pulsátiles 
counts6=histogram(flancos_pul,'BinWidth', binsize, 'Normalization','pdf','EdgeColor',[0.4940 0.1840 0.5560],'FaceColor','none');
[f6,xi6]=ksdensity(flancos_pul,'BandWidth', binsize);
plot(xi6,f6,'LineWidth',2,'Color',[0.4940 0.1840 0.5560])
ylabel({'Histograma'})
xlabel('Tiempo desde el onset(ms)')
hold off

linkaxes(a,'x')
equispace(f1)




