clear all; close all

cd '...\Exploration_data'

dinfo = dir;
A = {dinfo.name};
B = {dinfo.name};

A = A(~cellfun('isempty', strfind(A,'pos.txt')));
B = B(~cellfun('isempty', strfind(B,'body.txt')));

A=sort_nat(A);
B=sort_nat(B);

name={};
for i=1:length(A)

file=[char(A(i))];
tr=readtable(file);
bodysize=readmatrix(char(B(i)));
    
blue = tr(tr.id == 1,:);
blue=tr;

activity2=sqrt(diff(blue.x).^2+diff(blue.y).^2);

activity2(isnan(activity2))=0;

activity2=(activity2./nanmean(bodysize))./(1/5);

time=seconds([1:length(activity2)]*1/5);


        name=vertcat(cellstr(name),char(A(i))); % add the name of the m-th time series to the names vector 
        mv=activity2;
        mv(mv<0.5)=[];
        mean_mv(i)=mean(mv);


end


v=table(name, mean_mv');
v.Properties.VariableNames ={'Individual' 'Mean_moving_velocity'}

% writetable(v,'ind_exploration_measurements.csv')
