% function [] = performSVM(projectVector, inputLabel, projectVectorTest, testLabel)

function [] = performSVMAllQP()

%disp(size(projectVector));
%disp(size(projectVectorTest));
%disp(size(inputLabel));
%disp(size(testLabel));
clear 
clc
close all

load('TestData.mat');
load('TrainData.mat');
load('savePath.mat');
load('ReducedVector.mat');

projectVector = reduced;
projectVectorTest = reducedTest;
%inputLabel = inputLabel;
%testLabel = testLabel;
sizeDir = 5;
SVMTrain = {};
SVMTest = {};
options.MaxIter = 2000000;

SVMFunc = {'linear','mlp','rbf','quadratic','polynomial'};
ErrorSVMLinear1 = zeros(1,sizeDir);
ErrorSVMQuadratic1 = zeros(1,sizeDir);
ErrorSVMPolynomial1 = zeros(1,sizeDir);
ErrorSVMRBF1 = zeros(1,sizeDir);
ErrorSVMMLP1 = zeros(1,sizeDir);
Error1 = [ErrorSVMLinear1;ErrorSVMMLP1;ErrorSVMRBF1;ErrorSVMQuadratic1;ErrorSVMPolynomial1];
ErrorSave = {'ErrorSVMLinear1','ErrorSVMMLP1','ErrorSVMRBF1','ErrorSVMQuadratic1','ErrorSVMPolynomial1'};
ErrorSaveFile = {};
pathSave = 'C:/Users/Praneeth A S/Documents/MATLAB/Assignment New 2/';
sizeSVM = size(SVMFunc,2);
ErrorFile = strcat(mypathSaveVar,'ErrorSave1.mat');

for j=1:sizeSVM
    ErrorSaveFile{j} = strcat(mypathSaveVar,ErrorSave{j},'.mat');
end

for j=1:sizeSVM
    fprintf('Calculating for %s\n',ErrorSave{j});
    for i=1:sizeDir
        fprintf('Training Data set %d\n',i);
        %inputLabelIn = inputLabel(i,:);
        %SVMTrain{i} = svmtrain(projectVector,inputLabel, 'Options', options,'kernelfunction',Linear,'boxconstraint',[1 2 3 4 5]);
        SVMTrain{i} = svmtrain(projectVector,inputLabel(i,:), 'Options', options,'kernel_function',SVMFunc{j});
        fprintf('Testing Data set %d\n',i);
        %disp(SVMTrain{i});
        %disp(size(projectVectorTest));
        %disp(size(projectVector));
        SVMTest{i} = svmclassify(SVMTrain{i},projectVectorTest');
    end
    
    testOutLabel = [SVMTest{1},SVMTest{2},SVMTest{3},SVMTest{4},SVMTest{5}];
    index = testOutLabel == testLabel';
    av=0;
    for k=1:sizeDir
        sizeI = size(index(:,k));
        countZ=0;countO=0;
        for l=1:sizeI
            if index(l,k) == 0
                countZ=countZ+1;
            else
                countO=countO+1;
            end
        end
        countErr = countO/(countZ+countO);
        %disp(countErr);
        av = av+countErr;
        Error1(j,k) = countErr;
    end
    av=av/5;
    disp(av);
    disp(ErrorSave{j});
    %saveError{j} = Error(j,:);
    
end

save(ErrorFile, 'Error1');

