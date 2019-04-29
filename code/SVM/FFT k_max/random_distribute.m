function [train_data, train_class, test_data, test_class] = random_distribute(svt_V, svt_A, vt_V, vt_A, feature, num)
% randomly distribute train and test data

train_n = num * 5 / 6;
test_n = num / 6;
train_data = zeros(2 * train_n, feature);
train_class = [ones(train_n, 1); -1 * ones(train_n, 1)];
rand_index_1 = randperm(num);
rand_index_2 = randperm(num);

for i = 1: train_n
    train_data(i, :) = [svt_V(rand_index_1(i), :), svt_A(rand_index_1(i), :)];
    train_data(i + train_n, :) = [vt_V(rand_index_2(i), :), vt_A(rand_index_2(i), :)];
end

test_data = zeros(2 * test_n, feature);
test_class = [ones(test_n, 1); -1 * ones(test_n, 1)];
for i = 1: test_n
    test_data(i, :) = [svt_V(rand_index_1(i + train_n), :), svt_A(rand_index_1(i + train_n), :)];
    test_data(i + test_n, :) = [vt_V(rand_index_2(i + train_n), :), vt_A(rand_index_2(i + train_n), :)];
end

end