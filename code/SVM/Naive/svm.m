load('tdata.mat');

num = length(tdata_svt);
train_n = num * 5 / 6;
test_n = num / 6;

randomize = 1;

svt_tV_size = zeros(num, 1);
svt_tA_size = zeros(num, 1);
vt_tV_size = zeros(num, 1);
vt_tA_size = zeros(num, 1);

for i = 1:num
    svt_tV_size(i) = size(tdata_svt{i}.tV, 2);
    svt_tA_size(i) = size(tdata_svt{i}.tA, 2);
    vt_tV_size(i) = size(tdata_vt{i}.tV, 2);
    vt_tA_size(i) = size(tdata_vt{i}.tA, 2);
end

% use first min_number of data point
min_tV = min([svt_tV_size; vt_tV_size]);
min_tA = min([svt_tA_size; vt_tA_size]);



rand_index_1 = randperm(num);
rand_index_2 = randperm(num);


% Class: svt = 1, vt = -1
train_data = zeros(2 * train_n, min_tV + min_tA);
train_class = [ones(train_n, 1); -1 * ones(train_n, 1)];

if randomize == 0
    for i = 1: train_n
        train_data(i, :) = [tdata_svt{i}.tV(1: min_tV), tdata_svt{i}.tA(1: min_tA)];
        train_data(i + train_n, :) = [tdata_vt{i}.tV(1: min_tV), tdata_vt{i}.tA(1: min_tA)];
    end
else
    for i = 1: train_n
        train_data(i, :) = [tdata_svt{rand_index_1(i)}.tV(1: min_tV), tdata_svt{rand_index_1(i)}.tA(1: min_tA)];
        train_data(i + train_n, :) = [tdata_vt{rand_index_2(i)}.tV(1: min_tV), tdata_vt{rand_index_2(i)}.tA(1: min_tA)];
    end
end


test_data = zeros(2 * test_n, min_tV + min_tA);
test_class = [ones(test_n, 1); -1 * ones(test_n, 1)];

if randomize == 0
    for i = 1: test_n
        test_data(i, :) = [tdata_svt{i + train_n}.tV(1: min_tV), tdata_svt{i + train_n}.tA(1: min_tA)];
        test_data(i + test_n, :) = [tdata_vt{i + train_n}.tV(1: min_tV), tdata_vt{i + train_n}.tA(1: min_tA)];
    end
else
    for i = 1: test_n
        test_data(i, :) = [tdata_svt{rand_index_1(i + train_n)}.tV(1: min_tV), tdata_svt{rand_index_1(i + train_n)}.tA(1: min_tA)];
        test_data(i + test_n, :) = [tdata_vt{rand_index_2(i + train_n)}.tV(1: min_tV), tdata_vt{rand_index_2(i + train_n)}.tA(1: min_tA)];
    end
end

tic;
cl = fitcsvm(train_data,train_class,'KernelFunction', 'polynomial', 'Standardize', true);
train_time = toc;
tic;
[pre_class, scores, cost] = predict(cl,test_data);
test_time = toc;

[pre_class_train, scores_train, cost_train] = predict(cl,train_data);
err_train = sum(pre_class_train ~= train_class) / (length(pre_class_train));

err = sum(pre_class ~= test_class) / (length(pre_class));

pre_positive = pre_class == ones(length(pre_class), 1);
test_positive = test_class == ones(length(test_class), 1);
TP = mean(pre_positive == test_positive);
TN = mean((1 - pre_positive) == (1 - test_positive));
FP = mean(pre_positive == (1 - test_positive));
FN = mean((1 - pre_positive) == test_positive);

disp(['train error = ', num2str(err_train)]);
disp(['test error = ', num2str(err)]);

disp(['true positive = ', num2str(TP)]);
disp(['true negative = ', num2str(TN)]);
disp(['false positive = ', num2str(FP)]);
disp(['false negative = ', num2str(FN)]);

disp(['training time = ', num2str(train_time)]);
disp(['test time = ', num2str(test_time)]);