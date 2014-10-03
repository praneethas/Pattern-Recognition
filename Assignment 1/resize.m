function [] = resize(directory)

cd(directory);
mkdir('Resize');
mkdir('Resize','Training');
mkdir('Resize','Testing');

A=dir(directory); 

img = cell(length(A)-3,1);
img_rz = cell(length(A)-3,1);
name = 'Resize/Training/imager_';
len = length(A);
len1 = int16(0.7*len);
for n=4:len1-1   
    img{n} = imread(A(n).name);
    img_rz{n} = imresize(img{n},[100 100]);
    k = sprintf('%04d.jpg',n-3);
    l = strcat(name,k);
    imwrite(img_rz{n},l);
end
name = 'Resize/Testing/imager_';
for n=len1:len 
    img{n} = imread(A(n).name);
    img_rz{n} = imresize(img{n},[100 100]);
    k = sprintf('%04d.jpg',n-3);
    l = strcat(name,k);
    imwrite(img_rz{n},l);
end

% resize('F:/DriveC/Copy/Semester 7/Pattern Recognition/Assignments/Assignment 1/5 Objects/bonsai');