clear
close all
clc

%load('ErrorSVMLinear.mat');
%load('ErrorSVMMLP.mat');
%load('ErrorSVMPolynomial.mat');
%load('ErrorSVMQuadratic.mat');
%load('ErrorSVMRBF.mat');

load('ErrorSave1.mat');

x = 1:5;
title('% Correctness of SVM for each Method');
xlabel('Classes') % x-axis label
ylabel('Percentage(%) Correctness') % y-axis label
plot(x,Error1(1,:), x,Error1(2,:), x,Error1(3,:), x,Error1(4,:), x,Error1(5,:));
legend('Linear Kernel','MLP Kernel','RBF Kernel','Quadratic Kernel','Polynomial Kernel','Location','southeast');

%plot(x,Error(1,:), x,Error(2,:), x,Error(3,:));
%legend('Linear Kernel','MLP Kernel','RBF Kernel','Location','southeast');

% RBF Kernel the best
