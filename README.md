# CIS520_project
 

#### 1. Get required patients data for training/testing the models:
- [features get here, 93KB](https://www.dropbox.com/s/kwrfj2151296q6m/train_test.mat?dl=0 "train_test.mat")
- [full patient data, 1GB](https://www.dropbox.com/s/qdo3opy1tvmghpl/EGM_database.mat?dl=0 "EGM_database.mat")(optional, only for SVM code)

#### 2. Instructions to run the code for each algorithm

### Method 1: DNN 

### Method 2: Decision Tree

### Method 3: k-NN
- For the original kNN run the main file `kNNmain.m` (the function file is `KNN_.m`)
- For the modified kNN run the `ModifiedkNNmain.m` (its function file is `KNN_modified.m`)

### Method 4: SVM
For all SVM model, default setting is use polynomial kernel with degree q in {2, 3, 4}, and training/test data are randomly distributed. 
Change variable `randomize` to 0 to turn off data set random distribution. Change fitcsvm function’s input to change kernel.

1. Naïve

   Raw data: `EGM_database.mat`
   
   Steps to run the code:
   
   a. `make_tdata.m`
   
   b. `svm.m`
  
2. 12 Features

   Raw data: `train_test.mat`
   
   Run:
   a. `svm_12_features.m` (train_test.mat is calculated from EGM_database.mat by main_features.m)
 
