function s_new = preprocess( s, fs )
fs_old = 1000;
% resample
[P,Q] = rat(fs/fs_old);
s_new = resample(s,P,Q);

fcutlow=0.4;   %low cut frequency in Hz
fcuthigh=40;   %high cut frequency in Hz
[b,a]=butter(4,[fcutlow,fcuthigh]/(fs/2),'bandpass');

s_filt =filter(b, a, s_new);
end

