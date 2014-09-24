close all
clear
clc

mypath = 'F:/DriveC/Copy/Semester 7/Pattern Recognition/Assignments/Assignment 1/5 Objects';
mypathSave = 'F:/DriveC/Copy/Semester 7/Pattern Recognition/Assignments/Assignment 1/';
mypathSaveVar = 'C:/Users/Praneeth A S/Documents/MATLAB/Assignment 1/';

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

newTrain = '/Resize/Training';

reducedVector = {};
fprintf('PCA Application 1\n');
init=0;
for i=1:sizeDir
    myNewPath = strcat(mypath,'/',nameFolds(i),newTrain);
    tmPath = num2str(cell2mat(myNewPath));
    fprintf('PCA for Cat: %d\n',i);
    reducedVector{i} = inputVec1(tmPath);
    sizec = size(reducedVector{i},2);
    inputLabel(i,init+1:init+sizec) = 1;
    init = init+sizec;
end
matL = [reducedVector{1},reducedVector{2},reducedVector{3},reducedVector{4},reducedVector{5}];
mypathSaveVar = strcat(mypathSaveVar,'inputLabel.mat');
save(mypathSaveVar, 'inputLabel', 'matL');

newTest = '/Resize/Testing';
reducedVector1 = {};
init = 0;
fprintf('PCA Application 2\n');
for i=1:sizeDir
    myNewPath1 = strcat(mypath,'/',nameFolds(i),newTest);
    tmPath1 = num2str(cell2mat(myNewPath1));
    fprintf('PCA for Category: %d\n',i);
    reducedVector1{i} = inputVec1(tmPath);
    sizec = size(reducedVector1{i},2);
    testOutLabel(i,init+1:init+sizec) = 1;
    init = init+sizec;
end
matL1 = [reducedVector1{1},reducedVector1{2},reducedVector1{3},reducedVector1{4},reducedVector1{5}];


% matL = reducedVector{1};
% matL1 = zeros(100);
% k=1;
% for i=1:100
%     for j=1:100
%         matL1(i,j) = matL(k,6);
%         k=k+1;
%     end
% end

SVMTrain = {};
SVMTest = {};
disp(size(matL));
options.MaxIter = 1000000;
for i=1:sizeDir
    SVMTrain{i} = svmtrain(matL',inputLabel(i,:)', 'Options', options); 
    SVMTest{i} = svmclassify(SVMTrain{i},matL1');
end
testLabel = [SVMTest{1},SVMTest{2},SVMTest{3},SVMTest{4},SVMTest{5}];
index = testOutLabel' == testLabel;

for i=1:sizeDir
    sizeI = size(index(:,i));
    countZ=0;countO=0;
    for j=1:sizeI
        if index(j,i) == 0
            countZ=countZ+1;
        else
            countO=countO+1;
        end
    end
    countErr = countO/(countZ+countO);
    disp(countErr);
end
%net = nff();