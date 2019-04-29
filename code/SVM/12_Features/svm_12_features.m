load('train_test.mat');

train_n = size(train_X, 1);
test_n = size(test_X, 1);


tic;
cl = fitcsvm(train_X, train_Y(:, 1),'KernelFunction', 'polynomial', 'Standardize', true);
train_time = toc;

[pre_label, scores, cost] = predict(cl,test_X);

test_time = toc;

[pre_label_train, scores_train, cost_train] = predict(cl,train_X);
err_train = sum(pre_label_train ~= train_Y(:, 1)) / (length(pre_label_train));

err = sum(pre_label ~= test_Y(:, 1)) / (length(pre_label));
pre_positive = pre_label == ones(length(pre_label), 1);
test_positive = test_Y(:, 1) == ones(length(pre_label), 1);
TP = mean(pre_positive == test_positive);
TN = mean((1 - pre_positive) == (1 - test_positive));
FP = mean(pre_positive == (1 - test_positive));
FN = mean((1 - pre_positive) == test_positive);

disp(['test error = ', num2str(err)]);
disp(['train error = ', num2str(err)]);

disp(['true positive = ', num2str(TP)]);
disp(['true negative = ', num2str(TN)]);
disp(['false positive = ', num2str(FP)]);
disp(['false negative = ', num2str(FN)]);

disp(['training time = ', num2str(train_time)]);
disp(['test time = ', num2str(test_time)]);
