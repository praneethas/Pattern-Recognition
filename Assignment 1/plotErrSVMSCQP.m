clear
close all
clc

%load('ErrorSVMLinear.mat');
%load('ErrorSVMMLP.mat');
%load('ErrorSVMPolynomial.mat');
%load('ErrorSVMQuadratic.mat');
%load('ErrorSVMRBF.mat');

load('ErrorSave2.mat');

x = 1:5;
title('% Correctness of SVM for each Method');
xlabel('Soft max constraint') % x-axis label
ylabel('Percentage(%) Correctness') % y-axis label
plot(x,Error2(1,:), x,Error2(2,:), x,Error2(3,:),x,Error2(4,:),x,Error2(5,:));
legend('1','2','3','4','5','Location','southeast');

%plot(x,Error(1,:), x,Error(2,:), x,Error(3,:));
%legend('Linear Kernel','MLP Kernel','RBF Kernel','Location','southeast');

% RBF Kernel the best
