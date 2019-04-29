load('train_test.mat')
train_Y = train_Y(:,1);
test_Y = test_Y(:,1);
time = zeros(1,25);
for k = 1:1:25
    tic
    B = TreeBagger(k,train_X,train_Y, 'Method', 'classification');
    toc
    time(k) = toc;
end
x = (1:1:25);
plot(x,time,'b*-', 'linewidth', 2);
xlabel("number of trees")
ylabel("training time(s)")