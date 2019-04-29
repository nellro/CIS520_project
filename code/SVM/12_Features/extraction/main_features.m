close all
clear all
load('EGM_database');
fs = 300;
part = 10000+(1:10000);

N = length(data_vt);

F_VT = zeros(12, N);
for iter = 1:N
    s = data_vt{iter}.V;
    s = s(part);
    s = preprocess( s, fs );
    F_VT(1:6, iter)  = getF(s, fs);
    %
    s = data_vt{iter}.A;
    s = s(part);
    s = preprocess( s, fs );
    F_VT(7:12, iter) = getF(s, fs);
    
    if mod(iter, 100)==0
        fprintf('Iteration VT %i\n', iter);
    end
end
M(:, 1) = mean(F_VT, 2);
STD(:, 1) = sqrt(var(F_VT, 0, 2));

F_SVT = zeros(12, N);
for iter = 1:N
    s = data_svt{iter}.V;
    s = s(part);
    s = preprocess( s, fs );
    F_SVT(1:6, iter)  = getF(s, fs);
    
    s = data_svt{iter}.A;
    s = s(part);
    s = preprocess( s, fs );
    F_SVT(7:12, iter) = getF(s, fs);
    
    if mod(iter, 100)==0
        fprintf('Iteration SVT %i\n', iter);
    end
end
M(:, 2) = mean(F_SVT, 2);
STD(:, 2) = sqrt(var(F_SVT, 0, 2));


save data.mat F_VT F_SVT