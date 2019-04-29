# CIS520_project
 
 ## Fatal or Non-fatal: Comparative Study of Classification Algorithms for Cardiac Arrhythmias Discrimination
 
 In this project we compared classification methods for 
electrogram (EGM) arrhythmia discrimination. We consider two 
arrhythmia types: ventricular tachycardia (VT) and supraventricular 
tachycardia (SVT). Therefore, we viewed this problem as a
binary classification task to discriminate whether a patient has VT 
(fatal tachycardia) or SVT (non-fatal tachycardia).

The set of methods we considered, implemented and
analysed include Deep Neural Network (DNN), Support Vector Machine 
(SVM), k-Nearest Neighbours (k-nn) and Decision Tree.

### 1. Get required patients data for training/testing the models:
- [features get here, 93KB](https://www.dropbox.com/s/kwrfj2151296q6m/train_test.mat?dl=0 "train_test.mat")
- [full patient data, 1GB](https://www.dropbox.com/s/qdo3opy1tvmghpl/EGM_database.mat?dl=0 "EGM_database.mat")(optional, only for SVM code)

### 2. Instructions to run the code for each algorithm:

#### Method 1: DNN 

#### Method 2: Decision Tree

#### Method 3: k-NN
- For the original kNN run the main file `kNNmain.m` (the function file is `KNN_.m`)
- For the modified kNN run the `ModifiedkNNmain.m` (its function file is `KNN_modified.m`)

#### Method 4: SVM
For all SVM model, default setting is use polynomial kernel with degree q in {2, 3, 4}, and training/test data are randomly distributed. 
Change variable `randomize` to 0 to turn off data set random distribution. Change fitcsvm function’s input to change kernel.

1. Naïve

   Raw data: `EGM_database.mat`
   
   Steps to run the code:
   - `make_tdata.m`;
   - `svm.m`
  
2. 12 Features

   Raw data: `train_test.mat`
   
   Run:
   - `svm_12_features.m` (train_test.mat is calculated from EGM_database.mat by main_features.m)
   
3. FFT k_max
   
   Raw data: `EGM_database.mat`
   
   Steps to run the code:
   - `fft_data.m`
   - `max_k_freq.m`
   - `svm_fft.m`
   
   1. FFT filters all frequencies higher than 1000Hz. To change this setting you need to change variable  `max_freq` in `fft_data.m`, and it will change the name of the mat file it saves, so also change what you load at the beginning of `max_k_freq.m`
   
   2.	`max_k_freq.m` takes 10 frequencies with highest energy. To change this setting, you need to change variable `k` in `max_k_freq.m` and the load file name in `svm_fft.m` accordingly.
   
   
4. FFT PCA
   
   Raw data: `EGM_database.mat`
   
   Steps to run the code:
   
   - `fft_data.m`
   - `pca_fft_data.m`
   - `svm_pca_fft.m`
   1. FFT part’s setting is similar as in FFT k_max.

   

 
