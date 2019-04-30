import keras
from keras.models import Sequential
from keras.utils import to_categorical
from keras.layers import Activation
from keras.optimizers import SGD
from keras.layers import Dense
import numpy as np
import tensorflow as tf
import matplotlib.pyplot as plt
import scipy.io
import time


# f = scipy.io.loadmat('data.mat')
# VT = f['F_VT'].T
# SVT = f['F_SVT'].T
# N = VT.shape[0]
# X = np.concatenate((VT, SVT), axis=0)
# Y1 = np.concatenate((np.ones((N, 1)), np.zeros((N, 1))), axis=0)
# Y2 = np.concatenate((np.zeros((N, 1)), np.ones((N, 1))), axis=0)
# Y = np.concatenate((Y1, Y2), axis=1)
# trainData = np.array(X)
# trainLabels = np.array(Y)

f = scipy.io.loadmat('train_test.mat')
trainData = np.array(f['train_X'])
trainLabels = np.array(f['train_Y'])
trainLabels = np.array(trainLabels[:, 0])
#
testData = np.array(f['test_X'])
testLabels = np.array(f['test_Y'])
testLabels = np.array(testLabels[:, 0])


model = Sequential()
model.add(Dense(10, input_dim= 12, init="normal", activation="relu"))
model.add(Dense(10, activation='relu', kernel_initializer="uniform"))
#model.add(Dense(10, activation='relu', kernel_initializer="uniform"))
model.add(Dense(1, activation='sigmoid'))

print("[INFO] compiling model...")
sgd = SGD(lr=0.01)
model.compile(loss="binary_crossentropy", optimizer=sgd, metrics=["accuracy"])
start_time = time.time()
model.fit(trainData, trainLabels, epochs=3000, batch_size=128, shuffle= 1, verbose=1)
end_time = time.time()
print('Train time')
print("--- %s seconds ---" % (end_time - start_time))
perp = (end_time - start_time)/trainData.shape[0]
print("--- %s seconds/patient ---" % perp)

# dump the network architecture and weights to file
print("[INFO] dumping architecture and weights to file...")
model.save("model")


# X_test = np.random.rand(100)*10
# X_test = np.sort(X_test)
# X_test = np.reshape(X_test, (100, 1))
# Y_test = model.predict_classes(X_test)
# plt.plot(Y_test)
print("[INFO] evaluating on testing set...")
start_time = time.time()
(loss, accuracy) = model.evaluate(testData, testLabels, batch_size=128, verbose=1)
end_time = time.time()
print('Test time')
print("--- %s seconds ---" % (end_time - start_time))
perp = (end_time - start_time)/testData.shape[0]
print("--- %s seconds/patient ---" % perp)
print("[INFO] loss={:.4f}, accuracy: {:.4f}%".format(loss, accuracy * 100))


TP = 0
FP = 0
TN = 0
FN = 0

testPred = model.predict_classes(testData)
for i in range(len(testLabels)):
    if testPred[i] == testLabels[i] == 1:
       TP += 1
    if testPred[i] == 1 and testLabels[i] == 0:
       FP += 1
    if testPred[i] == testLabels[i] == 0:
       TN += 1
    if testPred[i] == 0 and testLabels[i] == 1:
       FN += 1


TPR = TP/(TP+FN)
TNR = TN/(TN+FP)

sensitivity = TPR
specificity = TNR
presicion = TP/(TP+FP)
ff = 2*TPR*presicion/(TPR+presicion)


