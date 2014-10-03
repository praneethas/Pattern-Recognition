% clear all
% close all
% clc

function [] = ReducedVector()



load('TestData.mat');
load('TrainData.mat');
load('savePath.mat');


ReducedVector = strcat(mypathSaveVar,'ReducedVector.mat');

reduced = score(1:3000,:);
reducedTest = scoreTest(1:3000,:);

save(ReducedVector, 'reduced', 'reducedTest');


