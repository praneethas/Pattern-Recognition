close all
clear all
clc

load('TrainData.mat');
load('TestData.mat');

[rowtr,coltr]=size(coeff);
[rowtt,coltt]=size(coeffTest);

sumE = [];
x=10:10:coltr;
fprintf('Calculating for train\n');
for i=10:10:coltr
    fprintf('With eigenvalues %d\n',i);
    XCentre = score(:,1:i)*coeff(:,1:i)';
    [row,col]=size(XCentre);
    for j=1:row
        for k=1:col
            XCentre(j,k) = XCentre(j,k)+mu(j);
        end
    end
    %imshow(uint8(reshape(XCentre(:,i),[100 100])));
    %disp(size(features));
    %disp(size(XCentre));
    Diff = abs(features)-abs(XCentre);
    Diff = abs(Diff);
    k=i/10;
    maxE(k) = sum(sum(Diff));
end
%figure;
%plot(x,maxE,'r-');
% 10000 329 329 329


sumET = [];
fprintf('Calculating for test\n');
x=10:10:coltt;
for i=10:10:coltt
    fprintf('With eigenvalues %d\n',i);
    XCentreTest = scoreTest(:,1:i)*coeffTest(:,1:i)';
    [row,col]=size(XCentreTest);
    for j=1:row
        for k=1:col
            XCentreTest(j,k) = XCentreTest(j,k)+muTest(j);
        end
    end
    %imshow(uint8(reshape(XCentreTest(:,i),[100 100])));
    %disp(size(featuresTest));
    %disp(size(XCentreTest));
    DiffTest = abs(featuresTest)-abs(XCentreTest);
    DiffTest = abs(DiffTest);
    k=i/10;
    maxET(k) = sum(sum(DiffTest));
end
%figure;
%plot(x,maxET,'r-');


k=1;
reImage = zeros(100,100);
oImage = zeros(100,100);
reImageTest = zeros(100,100);
oImageTest = zeros(100,100);
k=1;
for i=1:100
    for j=1:100
        reImage(i,j) = XCentre(k,120);
        oImage(i,j) = features(k,120);
        reImageTest(i,j) = XCentreTest(k,10);
        oImageTest(i,j) = featuresTest(k,10);
        k=k+1;
    end
end
figure; imshow(uint8(reImage));
figure; imshow(uint8(oImage));
figure; imshow(uint8(reImageTest));
figure; imshow(uint8(oImageTest));