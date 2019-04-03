load('EGM_real.mat');


% this represent freq = 1 - 200
max_freq = 200;


svt_num = size(data_svt, 2);
vt_num = size(data_vt, 2);

fft_data_svt = cell(1, svt_num);
fft_data_vt = cell(1,vt_num);


for i = 1: svt_num
    svt_V = data_svt{i}.V;
    L = size(svt_V, 1);
    fts = fft(svt_V) / L;
    % Fv = linspace(0, 1, fix(L/2)+1);
    Iv = 1: fix(L / 2) + 1;
    amp_svt_V = abs(fts(Iv)) * 2;
    pha_svt_V = angle(fts(Iv));
    fft_data_svt{i}.V_amp = amp_svt_V;
    fft_data_svt{i}.V_pha = pha_svt_V;
    
    
    svt_A = data_svt{i}.A;
    L = size(svt_A, 1);
    fts = fft(svt_A) / L;
    Iv = 1: fix(L / 2) + 1;
    amp_svt_A = abs(fts(Iv)) * 2;
    pha_svt_A = angle(fts(Iv));
    fft_data_svt{i}.A_amp = amp_svt_A;
    fft_data_svt{i}.A_pha = pha_svt_A;
end



for i = 1: vt_num
    vt_V = data_vt{i}.V;
    L = size(vt_V, 1);
    fts = fft(vt_V) / L;
    Iv = 1: fix(L / 2) + 1;
    amp_vt_V = abs(fts(Iv)) * 2;
    pha_vt_V = angle(fts(Iv));
    fft_data_vt{i}.V_amp = amp_vt_V;
    fft_data_vt{i}.V_pha = pha_vt_V;
    
    vt_A = data_vt{i}.A;
    L = size(vt_A, 1);
    fts = fft(vt_A) / L;
    Iv = 1: fix(L / 2) + 1;
    amp_vt_A = abs(fts(Iv)) * 2;
    pha_vt_A = angle(fts(Iv));
    fft_data_vt{i}.A_amp = amp_vt_A;
    fft_data_vt{i}.A_pha = pha_vt_A;
end


save('fft_data_real.mat', 'fft_data_svt', 'fft_data_vt');




% for i = 1: 960
%     svt_V = data_svt{i}.V;
%     Y_svt_V = fft(svt_V);
%     P2 = abs(Y_svt_V / L);
%     P1 = P2(2 : max_freq + 1);
%     % P1(2 : end) = 2 * P1(2 : end);
%     fft_data_svt{i}.V = 2 * P1;
%     
%     svt_A = data_svt{i}.A;
%     Y_svt_A = fft(svt_A);
%     P2 = abs(Y_svt_A / L);
%     P1 = P2(1 : max_freq);
%     % P1(2 : end) = 2 * P1(2 : end);
%     fft_data_svt{i}.A = 2 * P1;
%     
%     vt_V = data_vt{i}.V;
%     Y_vt_V = fft(vt_V);
%     P2 = abs(Y_vt_V / L);
%     P1 = P2(1 : max_freq);
%     % P1(2 : end) = 2 * P1(2 : end);
%     fft_data_vt{i}.V = 2 * P1;
%     
%     vt_A = data_vt{i}.A;
%     Y_vt_A = fft(vt_A);
%     P2 = abs(Y_vt_A / L);
%     P1 = P2(1 : max_freq);
%     % P1(2 : end) = 2 * P1(2 : end);
%     fft_data_vt{i}.A = 2 * P1;
% end



% figure;
% f = Fs * (0 : (max_freq - 1)) / L;
% plot(f, fft_data_svt{10}.A);
% title('Single-Sided Amplitude Spectrum of a A(t) of svt')
% xlabel('f (Hz)');
% ylabel('|P1(f)|');



% L = size(data_svt{1}.A, 1);
% Fs = 3000;
% x = 1:1:L;
% V0 = data_svt{100}.A;
% 
% Y = fft(V0);
% P2 = abs(Y / L);
% P1 = P2(1 : L / 2 + 1);
% P1(2 : end - 1) = 2 * P1(2 : end - 1);
% 
% Lc = 3000;
% Yc = fft(V0, Lc);
% Pc2 = abs(Yc / Lc);
% Pc1 = Pc2(1 : Lc / 2 + 1);
% Pc1(2 : end - 1) = 2 * Pc1(2 : end - 1);
% 
% figure;
% f = Fs * (0 : (L / 2)) / L;
% plot(f, P1) 
% title('Single-Sided Amplitude Spectrum of a A(t) of svt')
% xlabel('f (Hz)')
% ylabel('|P1(f)|')
% 
% figure;
% f = Fs * (0 : (Lc / 2)) / Lc;
% plot(f, Pc1) 
% title('Single-Sided Amplitude Spectrum of a A(t) of svt chuck')
% xlabel('f (Hz)')
% ylabel('|P1(f)|')