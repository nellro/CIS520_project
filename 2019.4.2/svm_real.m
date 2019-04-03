load('fft_data_real_kmax.mat');

svt_num = size(kmax_svt_V, 1);
vt_num = size(kmax_vt_V, 1);

% kernel = 0: rbf; kernel = 1: polynomial
kernel = 1;

randomize = 1;


train_svt = 21;
train_vt = 48;
test_svt = svt_num - train_svt;
test_vt = vt_num - train_vt;


if randomize == 0
    train_X = [[kmax_svt_V(1: train_svt, :), kmax_svt_A(1: train_svt, :)];
        [kmax_vt_V(1: train_vt, :), kmax_vt_A(1: train_vt, :)]];
    test_X = [[kmax_svt_V(1: test_svt, :), kmax_svt_A(1: test_svt, :)];
        [kmax_vt_V(1: test_vt, :), kmax_vt_A(1: test_vt, :)]];
else
    i_svt_train = randperm(svt_num, train_svt);
    i_vt_train = randperm(vt_num, train_vt);
    i_svt_test = setdiff(1: 1: svt_num, i_svt_train);
    i_vt_test = setdiff(1: 1: vt_num, i_vt_train);
    train_X = [[kmax_svt_V(i_svt_train, :), kmax_svt_A(i_svt_train, :)];
        [kmax_vt_V(i_vt_train, :), kmax_vt_A(i_vt_train, :)]];
    test_X = [[kmax_svt_V(i_svt_test, :), kmax_svt_A(i_svt_test, :)];
        [kmax_vt_V(i_vt_test, :), kmax_vt_A(i_vt_test, :)]];
end

train_Y = [zeros(train_svt, 1); ones(train_vt, 1)];
test_Y = [zeros(test_svt, 1); ones(test_vt, 1)];



tic;

if kernel == 0
    cl = fitcsvm(train_X, train_Y(:, 1),'KernelFunction', 'rbf', 'Standardize', true);
else
    cl = fitcsvm(train_X, train_Y(:, 1),'KernelFunction', 'polynomial', 'Standardize', true);
end

train_time = toc;

[pre_label, scores, cost] = predict(cl,test_X);

test_time = toc;

err = sum(pre_label ~= test_Y) / (test_svt + test_vt);
disp(['error = ', num2str(err)]);
disp(['training time = ', num2str(train_time)]);
disp(['test time = ', num2str(test_time)]);
