load('train_test.mat')
train_Y = train_Y(:,1);
test_Y = test_Y(:,1);
B = TreeBagger(1,train_X,train_Y, 'Method', 'classification');
view(B.Trees{1},'Mode','graph')
