function saveRealChopped()
load('C:\Users\alena\Dropbox\4 Penn, Spring 2019\CIS 520, ML\Project\EGM_real.mat');

data_vt= chopData(data_vt);
data_svt= chopData(data_svt);

save('EGM_real_chopped.mat','data_vt','data_svt');
end

function DATA = chopData(data)
DATA=cell(0);
for s_ind = 1:size(data, 2)
    sV = data{s_ind}.V;
    sA = data{s_ind}.A;
    
    SV = chopSignal(sV);
    SA = chopSignal(sA);
    
    I_ind = size(DATA, 2);
    for ii = 1:size(SV, 2)
        DATA{1, I_ind+ii}.V = SV(:, ii);
        DATA{1, I_ind+ii}.A = SA(:, ii);
    end
end
end

function S = chopSignal(s)
S = [];
fs = 1000;
sig_len = 8; % seconds 
shift_len = 2; % seconds

ind_start = 1;
ind_end = fs*sig_len;
%
counter = 1;
while ind_end <= length(s)
    S(:, counter) = s(ind_start:ind_end);
    
    shift = shift_len*fs;
    ind_start = ind_start + shift;
    ind_end = ind_end + shift;
    counter = counter+1;
end
end
