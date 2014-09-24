function [u] = pcaCal(vec)


[row,col] = size(vec);
if row<col
    dumS = vec*vec';
else
    dumS = vec'*vec;
end

N = min(row,col);
dumS = dumS/N;
[eigvS,eigdS] = eig(dumS);
[row1,col1] = size(eigdS);
u = [];
% for i=1:row1
%     %disp(N);disp(eigdS(i,i));
%     r = (1/sqrt(N*abs(eigdS(i,i))));
%     if row<col
%         u(:,i) = r*vec'*eigvS(:,i);
%     else
%         u(:,i) = r*vec*eigvS(:,i);
%     end
% end
for i=1:row1
    if row<col
        u(:,i) = vec'*eigvS(:,i);
    else
        u(:,i) = vec*eigvS(:,i);
    end
end
u = u/norm(u);