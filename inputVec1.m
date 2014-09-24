function [reconstructMatrix, meand] = inputVec1(B)

cd(B);
files = dir( fullfile(B,'*.jpg') );
sizeTrain = size(files);
dum = [];

for p=1:sizeTrain
    f = imread(files(p).name);
    if ndims(f)>2
        f = rgb2gray(f);
    end
    %dum = [f(:)];
    [h,w] = size(f);
    k=1;
    %fprintf('Creating feature vector for %d\n',p);
    for i=1:h
        for j=1:w
            dum(k,p)=f(i,j);
            k=k+1;
        end
    end
end

meand = mean(dum,2);
[rowd,cold] = size(dum);

fprintf('Creating centered vector\n');
for i=1:rowd
    dum(i,:) = dum(i,:) - meand(i);
end
        
%bxsfun(@minus,dum,mean(dum,2));
%dum = dum-mean(dum,2);
[sizefr,sizefc] = size(dum);
N = min(sizefr,sizefc);
fprintf('Calculating PCA\n');
[COEFF] = pcaCal(dum);

disp(size(COEFF));
if nargin>1
  newDim=d;
else
  [rowEig,colEig] = size(COEFF);
  newDim=int8(0.7*colEig);
end

newdum = dum(:,1:newDim);

fprintf('Reduced data\n');
% if sizefr<sizefc
%     newMatrix = dum*COEFF;
% else
%     newMatrix = dum'*COEFF;
% end
newMatrix = newdum'*COEFF;

% Projection Data
projectMatrix = COEFF*newMatrix';

reconstructMatrix = projectMatrix;
%reconstructMatrix = projectMatrix;
% Reconstruct Data
% reconstructMatrix = projectMatrix*newMatrix;

% for i=1:rowd
%     reconstructMatrix(i,:) = reconstructMatrix(i,:) + meand(i);
% end
%v = u(:,1:newDim);
%bxsfun(@minus,v,mean(v,2));