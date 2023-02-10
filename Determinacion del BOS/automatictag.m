%% Automatic tag of phrases (determination of bird's own song -BOS-)
%Inputs:
%Outputs:

%% Read and prepare PitchTier, Textgrid and Audio
clear 

praat_scripts='G:\Datos Canarios Protocolos\Scripts\mPraat-master';
files_directory='G:\Audios VioAma\Seleccionados\Done\';
load([files_directory 'BOS_VioAma'])
audioname='2022-10-07_17_38_08';
sample_rate=30000;

cd(praat_scripts)

pitch=ptRead([files_directory audioname '.PitchTier']); %read pitchtier
tg=tgRead([files_directory audioname '.TextGrid']); %read textgrid
[audio_file,fs_audio_file]=audioread([files_directory audioname '.WAV']); %read denoised audio file
audio_file=resample(audio_file,sample_rate,fs_audio_file); %Resampling of audio file
t_audio_file=(1:length(audio_file))/sample_rate; %Time vector of audio file

%Volume normalization
audio_file = audio_file/sqrt(mean(audio_file.^2));

%% Phrase limits

phrase= 'M'; %Letter used in textgrid

 %Extract individual phrase
 
 find_sil= strfind(tg.tier{1,1}.Label,phrase); %localization of phrase
 phrase_position_logical = ~cellfun(@isempty,find_sil);
 phrase_position_init=tg.tier{1,1}.T1(phrase_position_logical); %onset
 phrase_position_end=tg.tier{1,1}.T2(phrase_position_logical);  %offset
 sound=audio_file(t_audio_file>=(phrase_position_init)& t_audio_file<=phrase_position_end);
 times= t_audio_file(t_audio_file>=(phrase_position_init)& t_audio_file<=phrase_position_end);

%% Syllable's onsets and offsets

cd('C:\Users\Ceci\Desktop\Fiamma\Scripts_Fiamma\Determinacion del BOS');
params.fs=sample_rate;
params.birdname='BF';
params=def_params(params);
[gtes]=find_gte(sound,params);
onsets=times(gtes.gtes1);
offsets=times(gtes.gtes2);

clear gtes
clear params

%Test of detection
ax(1)=subplot(1,1,1);
plot(times,sound);
hold on
for j=1:length(onsets)
line(onsets(j)*[1 1],ax(1).YLim,'LineStyle','-','MarkerSize',5,'Color',[0.8 0.8 0]);
line(offsets(j)*[1 1],ax(1).YLim,'LineStyle','-','MarkerSize',5,'Color',[0.1 0.1 0]);
end
clear j

%Remember to correct onsets and offsets of syllables of more than one
%note before continue!!

%% Clasification of syllables

%Syllabic rate calculation

diff_onsets=zeros(1,length(onsets)-1);
for i=1:length(onsets)-1
    diff_onsets(i)=onsets(i+1)-onsets(i); %onset to onset distancy (syllabic period)
end

mean_diff_onsets=mean(diff_onsets); %mean of distancies
frecuency=1/mean_diff_onsets; %syllabic rate (Hz)

disp(['Syllabic rate= '  num2str(frecuency)])


%Syllable type
if frecuency>25
    disp('Syllable type= Pul')
    syllable_type='Pul';
elseif frecuency<=25 && frecuency>12
    disp('Syllable type= P1')
    syllable_type='P1';
elseif frecuency<=12 && frecuency>5
    disp('Syllable type= P2') 
    syllable_type='P2';
elseif frecuency<=5 
    disp('Syllable type= P0')
    syllable_type='P0'; 
end 

%% Place individual syllables in cell array

%Individual oscillograms
figure(1)
individual_syllables_osc{length(onsets)}=[];

a(1)=subplot(2,1,1);
for i=1:length(onsets)
lcs_individual_syllables_osc=times>=onsets(i)& times<=offsets(i);
individual_syllable_osc=sound(lcs_individual_syllables_osc);
plot(individual_syllable_osc) %see what's going on
hold on
individual_syllables_osc{i}=individual_syllable_osc;
end
hold off
clear i

a(2)=subplot(2,1,2);
individual_syllables_pitch{length(onsets)}=[];
%Individual pitch contour
for i=1:length(onsets)
lcs_individual_syllables_pitch=pitch.t>=onsets(i)& pitch.t<=offsets(i);
individual_syllable_pitch=pitch.f(lcs_individual_syllables_pitch);
plot(individual_syllable_pitch,'-o') %see what's going on
hold on
individual_syllables_pitch{i}=individual_syllable_pitch;
end

hold off
clear individual_syllable_osc
clear lcs_individual_syllables_osc
clear individual_syllable_pitch
clear lcs_individual_syllables_pitch

%% First save (to write a new row in the struct)

n=length(BOS_VioAma)+1; 
BOS_VioAma(n).ID='M';
BOS_VioAma(n).SyllableType=syllable_type;
BOS_VioAma(n).SyllabicRate=frecuency;
BOS_VioAma(n).SyllabesOsc=individual_syllables_osc;
BOS_VioAma(n).SyllabesPitch=individual_syllables_pitch;
BOS_VioAma(n).ModelPhrase=sound;

%% Find the tag phrase for me

%Find most similars pitch contours

lcs_maximum_corr_pitch=zeros(1,3);
    for n=1:length(BOS_VioAma)  %for each ID syllable
        individual_corrs_pitch=[];
        for t=1:length(BOS_VioAma(n).SyllabesPitch)
            for s=1:length(onsets) %for each syllable in the phrase
 %   figure(1)
    sizeofsyllable1=length(BOS_VioAma(n).SyllabesPitch{t});
    sizeofsyllable2=length(individual_syllables_pitch{s});
    if sizeofsyllable1>=sizeofsyllable2
        diff=round((sizeofsyllable1-sizeofsyllable2)/2);
        syllablemodel=[zeros(1,diff) individual_syllables_pitch{s} zeros(1,diff)];
        stretchedsyllablemodel=interp1(1:size(syllablemodel,2),syllablemodel,linspace(1,size(syllablemodel,2),sizeofsyllable1)); %stretch for comparision purposes
    %    plot(stretchedsyllablemodel,'o')
    %    hold on
    %    plot(BOS_VioAma(n).SyllabesPitch{t},'o')
    %    hold off
        [individual_corrs_p,lags_p]= crosscorr(BOS_VioAma(n).SyllabesPitch{t},stretchedsyllablemodel); %compare the syllable to each syllable in the database with that ID
        lag_zero_value_p=find(lags_p==0);
        individual_corrs_pitch=[individual_corrs_pitch individual_corrs_p(lag_zero_value_p)];
    else
        diff=round((sizeofsyllable2-sizeofsyllable1)/2);
        syllablemodel=[zeros(1,diff) BOS_VioAma(n).SyllabesPitch{t} zeros(1,diff)];
        stretchedsyllablemodel=interp1(1:size(syllablemodel,2),syllablemodel,linspace(1,size(syllablemodel,2),sizeofsyllable2)); %stretch for comparision purposes
        [individual_corrs_p,lags_p]= crosscorr(individual_syllables_pitch{s},stretchedsyllablemodel); %compare the syllable to each syllable in the database with that ID
   %     plot(stretchedsyllablemodel,'o')
   %     hold on
   %     plot(individual_syllables_pitch{s},'o')
   %     hold off
        lag_zero_value_p=find(lags_p==0);
        individual_corrs_pitch=[individual_corrs_pitch individual_corrs_p(lag_zero_value_p)];
    end 
            end 
        end 
    corr_ID_pitch(n)=mean(individual_corrs_pitch,'omitnan'); %mean of all the comparisions
    end
    
    
    order_corr_pitch=sort(corr_ID_pitch,'descend','MissingPlacement','last'); %sort coeficients (max to minor)
    
    %Top 5 most similar phrases by pitch
    for x=1:3
    lcs_maximum_corr_pitch(x)=find(corr_ID_pitch==order_corr_pitch(x)); %find row of ID with max correlation 
    end    
    
 clear individual_corrs_pitch
 clear sizeofsyllable
 clear stretched_syllable_model
 clear order_corr_pitch
 clear maximum_corr_pitch
 clear n
 clear t
 clear s
 clear x

%Find most similars oscilograms

lcs_maximum_corr_osc=zeros(1,3);
individual_corrs_osc=[];
    for n=1:length(BOS_VioAma)  %for each ID syllable
        for t=length(BOS_VioAma(n).SyllabesOsc)
            for s=1:length(onsets) %for each syllable in the phrase
    %figure(2)
    sizeofsyllable1=length(BOS_VioAma(n).SyllabesOsc{t});
    sizeofsyllable2=length(individual_syllables_osc{s});
    if sizeofsyllable1>=sizeofsyllable2
        diff=round((sizeofsyllable1-sizeofsyllable2)/2);
        syllablemodel=[zeros(diff,1); individual_syllables_osc{s}; zeros(diff,1)];
        stretchedsyllablemodel=interp1(1:size(syllablemodel,1),syllablemodel,linspace(1,size(syllablemodel,1),sizeofsyllable1)); %stretch for comparision purposes
  %      plot(stretchedsyllablemodel)
   %     hold on
 %       plot(BOS_VioAma(n).SyllabesOsc{t})
   %     hold off
        [individual_corrs_o,lags_o]= crosscorr(BOS_VioAma(n).SyllabesOsc{t},stretchedsyllablemodel); %compare the syllable to each syllable in the database with that ID
        lag_zero_value_o=find(lags_o==0);
        individual_corrs_osc=[individual_corrs_osc individual_corrs_o(lag_zero_value_o)];  
    else
        diff=round((sizeofsyllable2-sizeofsyllable1)/2);
        syllablemodel=[zeros(diff,1); BOS_VioAma(n).SyllabesOsc{t}; zeros(diff,1)];
        stretchedsyllablemodel=interp1(1:size(syllablemodel,1),syllablemodel,linspace(1,size(syllablemodel,1),sizeofsyllable2)); %stretch for comparision purposes
        [individual_corrs_o,lags_o]= crosscorr(individual_syllables_osc{s},stretchedsyllablemodel); %compare the syllable to each syllable in the database with that ID
    %    plot(stretchedsyllablemodel)
      %  hold on
       % plot(individual_syllables_osc{s})
        %hold off
        lag_zero_value_o=find(lags_o==0);
        individual_corrs_osc=[individual_corrs_osc individual_corrs_o(lag_zero_value_o)]; 
    end
            end
        end 
    corr_ID_osc(n)=mean(individual_corrs_osc,'omitnan'); %mean of all the comparision
    end 
    order_corr_osc=sort(corr_ID_osc,'descend','MissingPlacement','last'); %sort coeficients (max to minor)
    
    %Top 3 most similar phrases by oscilogram
    for x=1:3
    lcs_maximum_corr_osc(x)=find(corr_ID_osc==order_corr_osc(x)); %find row of ID with max correlation 
    end
    
 clear individual_corrs_osc
 clear order_corr_osc
 clear maximum_corr_osc
 clear n
 clear t
 clear s
 clear x
 
 %Find most similar syllabic rate

diff_syllabicrate=zeros(1,length(BOS_VioAma));

    for n=1:length(BOS_VioAma)  %for each ID syllable
        diff_syllabicrate(n)=abs(BOS_VioAma(n).SyllabicRate-frecuency);
    end 
    find_ID_syllabicrate= find(diff_syllabicrate<3); %3 Hz of tolerance
    
 %Tell me to which ID is most similar
 

 disp(['ID most similar (pitch)= ' num2str(lcs_maximum_corr_pitch)]);
 disp(['ID most similar (oscilogram)= ' num2str(lcs_maximum_corr_osc)]);
 disp(['ID most similar (frecuency)= ' num2str(find_ID_syllabicrate)]);
 disp(['Differences of frecuency= ' num2str(diff_syllabicrate(find_ID_syllabicrate))]);
 
 %% Compare phrases found
 cd('C:\Users\Ceci\Desktop\Fiamma\Scripts_Fiamma\Determinacion del BOS');
 
 p=6; %lcs of ID to test
 
 f3=figure(3);
 
 w(1)=subplot(2,2,1);
 times_model=0:1/fs_audio_file:(length(BOS_VioAma(p).ModelPhrase)-1)/fs_audio_file;
 plot(times_model,BOS_VioAma(p).ModelPhrase);
 title('Model phrase')
 
 w(2)=subplot(2,2,3);
 plot(times-(times(1)),sound);
 title('New phrase')
 
 w(3)=subplot(2,2,2);
     %Espectograma
        window_width=sample_rate/100;   %points
        [~,f,t,pp] = spectrogram(BOS_VioAma(p).ModelPhrase,...
        gausswin(window_width,5),...
        ceil(0.75*window_width),...
        linspace(0,ceil(fs_audio_file/2),...
        round(sample_rate/window_width)),...
        sample_rate,'yaxis');
        imagesc('XData',t,'YData',f,'CData',10*log10(pp(1:100,:)));
        colormap(jet);
        ylim([0 10000]);
 title('Model phrase')
 
w(4)=subplot(2,2,4);
     %Espectograma
        window_width=sample_rate/100;   %points
        [~,f2,t2,p2] = spectrogram(sound,...
        gausswin(window_width,5),...
        ceil(0.75*window_width),...
        linspace(0,ceil(fs_audio_file/2),...
        round(sample_rate/window_width)),...
        sample_rate,'yaxis');
        imagesc('XData',t2,'YData',f2,'CData',10*log10(p2(1:100,:)));
        colormap(jet);
        ylim([0 10000]);
        
 title('New phrase') 
 
 linkaxes(w,'x')
 
 %Reproduce audio
 audiomodel=audioplayer(BOS_VioAma(p).ModelPhrase,sample_rate);
 disp('Playing phrase model');
 play(audiomodel)

 pause %press any button to reproduce next audio
 
 audio=audioplayer(sound,sample_rate);
 disp('Playing phrase to tag');
 play(audio)
 
     
 %% Save more syllables in database 
 disp(['ID identified= ' num2str(BOS_VioAma(p).ID)]); %What's the name of the phrase?
 BOS_VioAma(p).SyllabesPitch=[BOS_VioAma(p).SyllabesPitch individual_syllables_pitch];
 BOS_VioAma(p).SyllabesOsc=[BOS_VioAma(p).SyllabesOsc individual_syllables_osc];
 BOS_VioAma(p).SyllabicRate=(BOS_VioAma(p).SyllabicRate+frecuency)/2;  
 
 %% Save database
cd(files_directory);
save('BOS_VioAma','BOS_VioAma');
cd('C:\Users\Ceci\Desktop\Fiamma\Scripts_Fiamma\Determinacion del BOS');
 
 