load('fft_data_real.mat');

svt_num = size(fft_data_svt, 2);
vt_num = size(fft_data_vt, 2);

k = 5;

kmax_svt_V = zeros(svt_num, 3 * k);
kmax_svt_A = zeros(svt_num, 3 * k);
kmax_vt_V = zeros(vt_num, 3 * k);
kmax_vt_A = zeros(vt_num, 3 * k);

for i = 1: svt_num
    [amp, freq] = maxk(fft_data_svt{i}.V_amp, k);
    pha = fft_data_svt{i}.V_pha(freq);
    kmax_svt_V(i, :) = [freq; amp; pha]';
    
    [amp, freq] = maxk(fft_data_svt{i}.A_amp, k);
    pha = fft_data_svt{i}.A_pha(freq);
    kmax_svt_A(i, :) = [freq; amp; pha]';
end

for i = 1: vt_num
    [amp, freq] = maxk(fft_data_vt{i}.V_amp, k);
    pha = fft_data_vt{i}.V_pha(freq);
    kmax_vt_V(i, :) = [freq; amp; pha]';
    
    [amp, freq] = maxk(fft_data_vt{i}.A_amp, k);
    pha = fft_data_vt{i}.A_pha(freq);
    kmax_vt_A(i, :) = [freq; amp; pha]';
end

save('fft_data_real_kmax.mat', 'kmax_svt_V', 'kmax_svt_A', 'kmax_vt_V', 'kmax_vt_A');