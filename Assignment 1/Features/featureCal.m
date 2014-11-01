function[H]=featureCal(myPath)
fprintf(myPath);
%myPath= 'C:/Users/pvivek/Documents/MATLAB/PR/Pattern-Recognition-master/Pattern-Recognition-master/Assignment 1/5 Objects/brain/Resize/Training';
fileNames=dir(fullfile(myPath,'*.jpg'));
cd(myPath);
H=[];
for k = 1:length(fileNames)
    filename = [fileNames(k).name];  
    %fprintf(filename);
    I=imread(filename);
    if ndims(I)==3
        I=rgb2gray(I);
    end
    %fprintf('%d,%d\n',size(I));
    g=reshape(I,10000,1);
    %fprintf('%d,%d\n',size(g));
    H=[H,g];
end
    
end



