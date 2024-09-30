clear all; close all

% cd '...\Collective_activity'
% cd '...\Individual_activity'
% cd '...\Disassembly\Collective_time_series'
%cd '...\Disassembly\Individual_time_series'
%cd '...\Small_nest_collective'
cd '...\Small_nest_individual'

dinfo = dir;
A = {dinfo.name};

if contains(cd,'\Individual_activity')
A = A(~cellfun('isempty', strfind(A,'.txt')));
else
A = A(~cellfun('isempty', strfind(A,'.csv')));
end


A=sort_nat(A) %sort files

f12_all=[];
name={};
for i=1:length(A)

    if contains(cd,'\Individual_activity')
        file=[char(A(i))];
tr=readtable(file);
    
blue=tr;

activity2=sqrt(diff(blue.x).^2+diff(blue.y).^2);

nancount(i)=sum(isnan(activity2));

activity2(isnan(activity2))=0;

time=hours(seconds([1:length(activity2)]*30));

f12=smoothdata(activity2,'gaussian',15);

f12=rescale(f12); % rescale time series to fall between 0 and 1 

% f12_all=vertcat(f12_all,f12');

    else

activity = csvread(char(A(i)));

% activity=activity(1:960);
% activity=activity(1:1200);

time=hours(seconds([1:length(activity)]*30));

f12=smoothdata(activity,'gaussian',15);
dz=detrend(activity,4);

f12=rescale(f12); % rescale time series to fall between 0 and 1 

% f12_all=vertcat(f12_all,f12);

    end

        
j=0;
power2=[];
        index1=[];
        q3=[];
        q=[];
        q2=[];
        [dpoaeCWT,f,coi] = cwt(f12, 1/30); % wavelet analysis
        for j=1:length(f12)
            cfsOAE = dpoaeCWT(:,j);
            q=abs(cfsOAE);
            h=horzcat(q,f);
            ex=coi(j);
            q2 = h(:,2) < ex; % exclude data points in the cone of influence 
            q(q2) = NaN;
            q3(:,j) = q;
        end
        
        j=0;
        q=[];
for j=1:length(f)
    q = q3(j,:);
    power2(j)=nansum(q);
end

wperiod=hours(seconds(1./f));

pd(i)=max(power2);
[z98, z99]=max(power2);
period_spectrum(i)=wperiod(z99);
cf_wavelet(i)=pd(i)/mean(power2);
name=vertcat(cellstr(name),char(A(i))); % add the name of the m-th time series to the names vector


tlength(i)=numel(f12);


if strcmp(char(A(i)),'JRCT4_C1_7_29_activity_collective.csv') 
%     figure
subplot(3,2,1)
plot(time,rescale(activity), 'Color' , '#f01818', 'LineWidth', 2)
% xlabel('Hours')
% ylabel('Activity')
title('{\it Temnothorax rudis}')
set(gca,'FontSize',25)
end

if strcmp(char(A(i)),'HM1T8_C2_10_15_activity_collective.csv')
%     figure
subplot(3,2,2)
set(gcf,'units','normalized','outerposition',[0 0 1 1])
plot(time,rescale(activity), 'Color' , '#f01818', 'LineWidth', 2)
% xlabel('Hours')
% ylabel('Activity')
title('{\it Temnothorax adustus}')
set(gca,'FontSize',25)
end

if strcmp(char(A(i)),'PWT2_C3_9_18_activity_collective.csv')
%     figure
subplot(3,2,3)
plot(time,rescale(activity), 'Color' , '#f01818', 'LineWidth', 2)
% xlabel('Hours')
ylabel('Activity')
title('{\it Temnothorax curvispinosus}')
set(gca,'FontSize',25)
end

if strcmp(char(A(i)),'PA2220_C2_10_24_activity_collective.csv')
%     figure
subplot(3,2,4)
plot(time,rescale(activity), 'Color' , '#f01818', 'LineWidth', 2)
% xlabel('Hours')
% ylabel('Activity')
title('{\it Temnothorax ambiguus}')
set(gca,'FontSize',25)
end

if strcmp(char(A(i)),'RNML1_C4_9_2_activity_collective.csv')
% figure
    subplot(3,2,5)
plot(time,rescale(activity), 'Color' , '#f01818', 'LineWidth', 2)
xlabel('Hours')
% ylabel('Activity')
title('{\it Leptothorax crassipilis}')
set(gca,'FontSize',25)
end

if strcmp(char(A(i)),'SHL8_C3_7_14_activity_collective.csv')
%     figure
subplot(3,2,6)
plot(time,rescale(activity), 'Color' , '#f01818', 'LineWidth', 2)
xlabel('Hours')
% ylabel('Activity')
title('{\it Leptothorax athabasca}')
set(gca,'FontSize',25)
end



if strcmp(char(A(i)),'7_17_1.txt')
%     figure
subplot(3,2,1)
plot(time,rescale(activity2), 'Color' , '#56B4E9', 'LineWidth', 2)
% xlabel('Hours')
% ylabel('Activity')
title('{\it Temnothorax rudis}')
set(gca,'FontSize',25)
end

if strcmp(char(A(i)),'6_20_42.txt')
%     figure
subplot(3,2,2)
set(gcf,'units','normalized','outerposition',[0 0 1 1])
plot(time,rescale(activity2), 'Color' , '#56B4E9', 'LineWidth', 2)
% xlabel('Hours')
% ylabel('Activity')
title('{\it Temnothorax adustus}')
set(gca,'FontSize',25)
end

if strcmp(char(A(i)),'9_15_29.txt')
%     figure
subplot(3,2,3)
plot(time,rescale(activity2), 'Color' , '#56B4E9', 'LineWidth', 2)
% xlabel('Hours')
ylabel('Activity')
title('{\it Temnothorax curvispinosus}')
set(gca,'FontSize',25)
end

if strcmp(char(A(i)),'10_3_43.txt')
%     figure
subplot(3,2,4)
plot(time,rescale(activity2), 'Color' , '#56B4E9', 'LineWidth', 2)
% xlabel('Hours')
% ylabel('Activity')
title('{\it Temnothorax ambiguus}')
set(gca,'FontSize',25)
end

if strcmp(char(A(i)),'6_21_2.txt')
% figure
    subplot(3,2,5)
plot(time,rescale(activity2), 'Color' , '#56B4E9', 'LineWidth', 2)
xlabel('Hours')
% ylabel('Activity')
title('{\it Leptothorax crassipilis}')
set(gca,'FontSize',25)
end

if strcmp(char(A(i)),'7_18_41.txt')
%     figure
subplot(3,2,6)
plot(time,rescale(activity2), 'Color' , '#56B4E9', 'LineWidth', 2)
xlabel('Hours')
% ylabel('Activity')
title('{\it Leptothorax athabasca}')
set(gca,'FontSize',25)
end

end

if contains(cd,'Collective')
    v=table(name, minutes(hours(period_spectrum))', cf_wavelet');
    v.Properties.VariableNames ={'Colony' 'Dominant_Period' 'cf_wavelet'}
elseif contains(cd,'Individual_activity')
    v=table(name, minutes(hours(period_spectrum))', cf_wavelet', (nancount./960)');
    v.Properties.VariableNames ={'Individual' 'Dominant_Period' 'cf_wavelet' 'nancount'}
    v(v.nancount>=0.3,:)=[]
else
    v=table(name, minutes(hours(period_spectrum))', cf_wavelet');
    v.Properties.VariableNames ={'Individual' 'Dominant_Period' 'cf_wavelet'}
end
    

% writetable(v,'Colony_activity_measurements_trim.csv')
% writetable(v,'Colony_activity_measurements_trim_10hrs.csv')
% writetable(v,'Colony_activity_measurements.csv')
% writetable(v,'Table_S9_collective_activity_disassembly.csv')
% writetable(v,'Table_S10_individual_activity_disassembly.csv')
% writetable(v,'ind_activity_measurements.csv')
% writetable(v,'Small_nest_colony_activity_measurements_2024.csv')
% writetable(v,'Small_nest_ind_activity_measurements_2024.csv')
