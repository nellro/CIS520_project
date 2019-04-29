load('fft_data.mat');

l = size(fft_data_svt, 2);
k = 10;
feature = size(fft_data_svt{1}.V, 1);
fft_V = zeros(2 * l, feature);
fft_A = zeros(2 * l, feature);

for i = 1:l
    fft_V(i, :) = fft_data_svt{i}.V;
    fft_V(i + l, :) = fft_data_vt{i}.V;
    fft_A(i, :) = fft_data_svt{i}.A;
    fft_A(i + l, :) = fft_data_vt{i}.A;
end

[coeff_V, score_V, latent_V] = pca(fft_V, 'NumComponents', k);
[coeff_A, score_A, latent_A] = pca(fft_A, 'NumComponents', k);

svt_V = score_V(1: l, :);
vt_V = score_V(l + 1: end, :);
svt_A = score_A(1: l, :);
vt_A = score_A(l + 1: end, :);

save('pca_fft.mat', 'svt_A', 'svt_V', 'vt_A', 'vt_A');
% save('pca_fft.mat', 'coeff_V', 'score_V', 'latent_V', 'coeff_A', 'score_A', 'latent_A');