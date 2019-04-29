load('EGM_database');

L = size(data_svt{1}.A, 1);
% this represent freq = 0-1000
max_freq = 1000;

fft_data_svt = cell(1, 960);
fft_data_vt = cell(1,960);


for i = 1: 960
    svt_V = data_svt{i}.V;
    Y_svt_V = fft(svt_V);
    P2 = abs(Y_svt_V / L);
    P1 = P2(2 : max_freq + 1);
    fft_data_svt{i}.V = 2 * P1;
    
    svt_A = data_svt{i}.A;
    Y_svt_A = fft(svt_A);
    P2 = abs(Y_svt_A / L);
    P1 = P2(1 : max_freq);
    fft_data_svt{i}.A = 2 * P1;
    
    vt_V = data_vt{i}.V;
    Y_vt_V = fft(vt_V);
    P2 = abs(Y_vt_V / L);
    P1 = P2(1 : max_freq);
    fft_data_vt{i}.V = 2 * P1;
    
    vt_A = data_vt{i}.A;
    Y_vt_A = fft(vt_A);
    P2 = abs(Y_vt_A / L);
    P1 = P2(1 : max_freq);
    fft_data_vt{i}.A = 2 * P1;
end

save(['fft_data_', num2str(max_freq), '.mat'], 'fft_data_svt', 'fft_data_vt');