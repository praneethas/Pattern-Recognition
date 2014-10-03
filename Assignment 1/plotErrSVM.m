clear
close all
clc

%load('ErrorSVMLinear.mat');
%load('ErrorSVMMLP.mat');
%load('ErrorSVMPolynomial.mat');
%load('ErrorSVMQuadratic.mat');
%load('ErrorSVMRBF.mat');

load('ErrorSave.mat');

x = 1:5;
title('% Correctness of SVM for each Method');
xlabel('Classes') % x-axis label
ylabel('Percentage(%) Correctness') % y-axis label
%plot(x,ErrorSVMLinear, x,ErrorSVMMLP, x,ErrorSVMQuadratic, x,ErrorSVMRBF);
%legend('Linear Kernel','MLP Kernel','Quadratic Kernel','RBF Kernel','Location','southeast');

plot(x,Error(1,:), x,Error(2,:), x,Error(3,:));
legend('Linear Kernel','MLP Kernel','RBF Kernel','Location','southeast');

% RBF Kernel the best
