load('train_test.mat')
train_Y = train_Y(:,1);
test_Y = test_Y(:,1);
sensitivity = zeros(1,20);
sensi = zeros(1,25);
for k = 1:1:25
    for j=1:1:20
        B = TreeBagger(k,train_X,train_Y, 'Method', 'classification');
        y = predict(B,test_X);
        tp=0;
        tn=0;
        fp=0;
        fn=0;
        res = zeros(size(test_Y,1),1);
            for i=1:1:size(test_Y,1)
                res(i)=str2double(y{i});
            end
        for i=1:1:size(test_Y,1)
            if res(i)==1 && test_Y(i)==1
                tp=tp+1;
            elseif res(i)==1 && test_Y(i)==0
                fp=fp+1;
            elseif res(i)==0 && test_Y(i)==1
                fn=fn+1;
            elseif res(i)==0 && test_Y(i)==0
                tn=tn+1;
            end
        end
        sensitivity(j) = tp/(tp+fn);
    end
    sen = mean(sensitivity);
    sensi(k)=sen; 
end
x = (1:1:25);
plot(x,sensi, 'r*-', 'linewidth', 2);
xlabel("number of trees")
ylabel("sensitivity")