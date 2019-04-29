load('max_10_freq.mat');

num = length(max_svt_A);
train_n = num * 5 / 6;
test_n = num / 6;

% whether to randomly distribute train and test data
randomize = 1;


feature = size(max_vt_A, 2) + size(max_vt_V, 2);



if randomize == 0
    train_data = zeros(2 * train_n, feature);
    train_class = [ones(train_n, 1); -1 * ones(train_n, 1)];
    train_data(1:train_n, :) = [max_svt_V(1:train_n, :), max_svt_A(1:train_n, :)];
    train_data(train_n + 1:end, :) = [max_vt_V(1:train_n, :), max_vt_A(1:train_n, :)];
    test_data = zeros(2 * test_n, feature);
    test_class = [ones(test_n, 1); -1 * ones(test_n, 1)];
    test_data(1:test_n, :) = [max_svt_V(train_n + 1:end, :), max_svt_A(train_n + 1:end, :)];
    test_data(test_n + 1:end, :) = [max_vt_V(train_n + 1:end, :), max_vt_A(train_n + 1:end, :)];
else
    [train_data, train_class, test_data, test_class] = random_distribute(max_svt_V, max_svt_A, max_vt_V, max_vt_A, feature, num);
end



tic;
cl = fitcsvm(train_data, train_class, 'KernelFunction', 'polynomial', 'Standardize', true);
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
