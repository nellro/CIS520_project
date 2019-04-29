load('fft_data_1000.mat');

k = 10;
n = size(fft_data_svt, 2);

max_svt_V = zeros(n, k);
max_svt_A = zeros(n, k);
max_vt_V = zeros(n, k);
max_vt_A = zeros(n, k);

for i = 1:n
    max_svt_V(i, :) = maxk(fft_data_svt{i}.V, k);
    max_svt_A(i, :) = maxk(fft_data_svt{i}.A, k);
    max_vt_V(i, :) = maxk(fft_data_vt{i}.V, k);
    max_vt_A(i, :) = maxk(fft_data_vt{i}.A, k);
end

save(['max_', num2str(k), '_freq'], 'max_svt_V', 'max_svt_A', 'max_vt_V', 'max_vt_A');