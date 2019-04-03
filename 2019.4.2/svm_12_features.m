load('train_test.mat');

train_n = size(train_X, 1);
test_n = size(test_X, 1);

% kernel = 0: rbf; kernel = 1: polynomial
kernel = 1;



% randomize = 1;
% 
% svt_tV_size = zeros(960, 1);
% svt_tA_size = zeros(960, 1);
% vt_tV_size = zeros(960, 1);
% vt_tA_size = zeros(960, 1);
% 
% for i = 1:960
%     svt_tV_size(i) = size(tdata_svt{i}.tV, 2);
%     svt_tA_size(i) = size(tdata_svt{i}.tA, 2);
%     vt_tV_size(i) = size(tdata_vt{i}.tV, 2);
%     vt_tA_size(i) = size(tdata_vt{i}.tA, 2);
% end
% 
% % use first min_number of data point
% min_tV = min([svt_tV_size; vt_tV_size]);
% min_tA = min([svt_tA_size; vt_tA_size]);
% 
% rand_index_1 = randperm(960);
% rand_index_2 = randperm(960);
% 
% % Class: svt = 1, vt = -1
% train_data = zeros(2 * train_n, min_tV + min_tA);
% train_class = [ones(train_n, 1); -1 * ones(train_n, 1)];
% 
% if randomize == 0
%     for i = 1: train_n
%         train_data(i, :) = [tdata_svt{i}.tV(1: min_tV), tdata_svt{i}.tA(1: min_tA)];
%         train_data(i + train_n, :) = [tdata_vt{i}.tV(1: min_tV), tdata_vt{i}.tA(1: min_tA)];
%     end
% else
%     for i = 1: train_n
%         train_data(i, :) = [tdata_svt{rand_index_1(i)}.tV(1: min_tV), tdata_svt{rand_index_1(i)}.tA(1: min_tA)];
%         train_data(i + train_n, :) = [tdata_vt{rand_index_2(i)}.tV(1: min_tV), tdata_vt{rand_index_2(i)}.tA(1: min_tA)];
%     end
% end
% 
% test_data = zeros(2 * test_n, min_tV + min_tA);
% test_class = [ones(test_n, 1); -1 * ones(test_n, 1)];
% 
% if randomize == 0
%     for i = 1: test_n
%         test_data(i, :) = [tdata_svt{i + train_n}.tV(1: min_tV), tdata_svt{i + train_n}.tA(1: min_tA)];
%         test_data(i + test_n, :) = [tdata_vt{i + train_n}.tV(1: min_tV), tdata_vt{i + train_n}.tA(1: min_tA)];
%     end
% else
%     for i = 1: test_n
%         test_data(i, :) = [tdata_svt{rand_index_1(i + train_n)}.tV(1: min_tV), tdata_svt{rand_index_1(i + train_n)}.tA(1: min_tA)];
%         test_data(i + test_n, :) = [tdata_vt{rand_index_2(i + train_n)}.tV(1: min_tV), tdata_vt{rand_index_2(i + train_n)}.tA(1: min_tA)];
%     end
% end


tic;

if kernel == 0
    cl = fitcsvm(train_X, train_Y(:, 1),'KernelFunction', 'rbf', 'Standardize', true);
else
    cl = fitcsvm(train_X, train_Y(:, 1),'KernelFunction', 'polynomial', 'Standardize', true);
end

train_time = toc;

[pre_label, scores, cost] = predict(cl,test_X);

test_time = toc;

err = sum(pre_label ~= test_Y(:, 1)) / (2 * test_n);
disp(['error = ', num2str(err)]);
disp(['training time = ', num2str(train_time)]);
disp(['test time = ', num2str(test_time)]);
