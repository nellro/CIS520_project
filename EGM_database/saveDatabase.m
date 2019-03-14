% DO NOT RUN THIS FILE
clear all
close all
loadFolder = 'E:\DATABASE_synthetic\DATABASE_synthetic';
params = egm_params();

i_iter = 1:3;
i_ind  = 1:size(params.annotations, 1);
i_case = 1:40;

counter_vt  = 1;
counter_svt = 1;
for egm_iter = i_iter
    for egm_case = i_case
        for egm_ind = params.IDX_vt
            data_vt{counter_vt} = getSignal(loadFolder, egm_iter, egm_case, egm_ind); 
            counter_vt = counter_vt+1;
        end
        for egm_ind = params.IDX_svt
            data_svt{counter_svt} = getSignal(loadFolder, egm_iter, egm_case, egm_ind);
            counter_svt = counter_svt+1;
        end
    end
end

save('EGM_database.mat','data_vt','data_svt');




