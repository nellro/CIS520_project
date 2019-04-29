load('train_test.mat')
train_Y = train_Y(:,1);
test_Y = test_Y(:,1);
B = TreeBagger(25,train_X,train_Y, 'Method', 'classification','OOBPredictorImportance','On');
figure
plot(oobError(B),'g*-', 'linewidth', 2)
xlabel('number of trees')
ylabel('Out-of-Bag Classification Error')
