close all
clear
clc

mypath = 'F:/DriveC/Copy/Semester 7/Pattern Recognition/Assignments/Assignment 1/5 Objects';
mypathSave = 'F:/DriveC/Copy/Semester 7/Pattern Recognition/Assignments/Assignment 1/';
mypathSaveVar = 'C:/Users/Praneeth A S/Desktop/Final Codes/';
d = dir(mypath);
isub = [d(:).isdir]; 
nameFolds = {d(isub).name}';
nameFolds(ismember(nameFolds,{'.','..'})) = [];
sizeDir = size(nameFolds);

% for i=1:sizeDir
%     myNewPath = strcat(mypath,'/',nameFolds(i),'/');
%     mPath = num2str(cell2mat(myNewPath));
%     resize(mPath);
% end

%% FOR INPUT DATA

newTrain = '/Resize/Training/';
fprintf('PCA Application for Input Data\n');
init=0;
featureVector = {};
for i=1:sizeDir
    myNewPath = strcat(mypath,'/',nameFolds(i),newTrain);
    tmPath = num2str(cell2mat(myNewPath));
    fprintf('PCA for Cat: %d\n',i);
    featureVector{i} = featureCal(tmPath);
    fprintf('Calculating Labels\n');
    sizec = size(featureVector{i},2);
    inputLabel(i,init+1:init+sizec) = 1;
    init = init+sizec;
end
features = [featureVector{1},featureVector{2},featureVector{3},featureVector{4},featureVector{5}];
mu = mean(features,2);
[row,col] = size(features);
featuresCentre = zeros(row,col);
for i=1:row
    for j=1:col
        featuresCentre(i,j) = features(i,j)-mu(i);
    end
end

% METHOD 1
% [redEigVec, redEigVal, mu] = pcaCalculateHighDim(features);
% [projectVector, newDimEigVector] = projectVec(redEigVec, features);
% [reconstructVector] = reconstructVec(projectVector, newDimEigVector, mu);
% [rowr,colr]=size(reconstructVector);

% METHOD 2
[coeff,score,latent] = princomp(features);
%XCentre = score*coeff';
XCentre = score(:,1:100)*coeff(:,1:100)';
[rowi,coli]=size(XCentre);
for i=1:rowi
    for j=1:coli
        XCentre(i,j) = XCentre(i,j)+mu(i);
    end
end
pathSave = strcat(mypathSaveVar,'TrainData.mat');
save(pathSave, 'features', 'inputLabel','score','mu','coeff','sizeDir');



%% FOR TEST DATA

newTest = '/Resize/Testing/';
fprintf('PCA Application for Test Data\n');
init=0;
featureVectorTest = {};
for i=1:sizeDir
    myNewPath = strcat(mypath,'/',nameFolds(i),newTest);
    tmPath = num2str(cell2mat(myNewPath));
    fprintf('PCA for Cat: %d\n',i);
    featureVectorTest{i} = featureCal(tmPath);
    fprintf('Calculating Labels\n');
    sizec = size(featureVectorTest{i},2);
    testLabel(i,init+1:init+sizec) = 1;
    init = init+sizec;
end
featuresTest = [featureVectorTest{1},featureVectorTest{2},featureVectorTest{3},featureVectorTest{4},featureVectorTest{5}];
muTest = mean(featuresTest,2);
[row,col] = size(featuresTest);
featuresTestCentre = zeros(row,col);
for i=1:row
    for j=1:col
        featuresTestCentre(i,j) = featuresTest(i,j)-muTest(i);
    end
end
pathSave = strcat(mypathSaveVar,'SavePath.mat');
save(pathSave, 'mypathSaveVar');

[coeffTest,scoreTest,latentTest] = princomp(featuresTest);
%XCentreTest = scoreTest*coeffTest';
XCentreTest = scoreTest(:,1:50)*coeffTest(:,1:50)';
[rowt,colt]=size(XCentreTest);
for i=1:rowt
    for j=1:colt
        XCentreTest(i,j) = XCentreTest(i,j)+muTest(i);
    end
end
pathSave = strcat(mypathSaveVar,'TestData.mat');
save(pathSave, 'featuresTest', 'testLabel','scoreTest','muTest','coeffTest','sizeDir');


% disp(size(features));
% disp(size(XCentre));
% disp(size(featuresTest));
% disp(size(XCentreTest));

%% RECONSTRUCTION OF IMAGES

k=1;
reImage = zeros(100,100);
oImage = zeros(100,100);
reImageTest = zeros(100,100);
oImageTest = zeros(100,100);
k=1;
for i=1:100
    for j=1:100
        reImage(i,j) = XCentre(k,100);
        oImage(i,j) = features(k,100);
        reImageTest(i,j) = XCentreTest(k,100);
        oImageTest(i,j) = featuresTest(k,100);
        k=k+1;
    end
end
figure; imshow(uint8(reImage));
figure; imshow(uint8(oImage));
figure; imshow(uint8(reImageTest));
figure; imshow(uint8(oImageTest));



%% SVM

% performSVM(score,inputLabel,scoreTest,testLabel);


%% Neural Network
% COEFFNNSimple