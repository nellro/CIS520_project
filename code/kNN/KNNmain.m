clear all
close all
 load('EGM_real');

load('train_test (1)');

k=3;

trainErr=[];
testErr=[];

for k=[1,2,3,4,5,6,7,8,9,10,11]
    
    i=9;
    j=9;
 [predicted_labels,~] = KNN_(k,train_X(800-80*i:800+80*i,:),train_Y(800-80*i:800+80*i,1),test_X);

err1 = classification_error(predicted_labels, test_Y(:,1));

testErr=[testErr,err1];

[predicted_labels,~] = KNN_(k,train_X(800-80*j:800+80*j,:),train_Y(800-80*j:800+80*j,1),train_X(800-80*j:800+80*j,:));

err2 = classification_error(predicted_labels, train_Y(800-80*j:800+80*j,1));
trainErr=[trainErr,err2];

end
Xk=[1,2,3,4,5,6,7,8,9,10,11];
plot(Xk,testErr,'r*-', 'linewidth', 2); %x1 state
hold on
plot(Xk,trainErr,'b*-', 'linewidth', 2); % x2 state
hold on 

