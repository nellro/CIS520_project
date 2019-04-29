load('EGM_database');

num = length(data_svt);
tdata_svt = cell(1, num);
tdata_vt = cell(1, num);

for i = 1:num
    tdata_svt{i}.tV = data_svt{i}.tV;
    tdata_svt{i}.tA = data_svt{i}.tA;
    
    tdata_vt{i}.tV = data_vt{i}.tV;
    tdata_vt{i}.tA = data_vt{i}.tA;
end

save('tdata.mat', 'tdata_svt', 'tdata_vt');