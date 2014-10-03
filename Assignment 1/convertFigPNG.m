%The following function will convert all the fig files in a folder to png
%files

clear all; close all; clc
% Searching using wildcards

cd('C:/Users/Praneeth A S/Desktop/Final Codes/Figures');

fig_files=dir(fullfile(pwd,'\*.fig'));

for i=1:length(fig_files)
open(fig_files(i).name);
saveas(gcf,strcat(fig_files(i).name(1:end-4),'.png'));
close all;
end