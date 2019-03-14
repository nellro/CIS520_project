clear all
close all
load('EGM_database');

%% DATABASE DESCRIPTION
% database has two sub-databases: 
%   - data_vt : ventricular tachycardia signals (960 signals total)
%   - data_svt: supraventricular tachycardia signals (960 signals total)
%
% each signal in vt and svt datasets:
%   - is 40,000 samples long
%   - has two channels: V channel (signal recorder in the ventricles) and
%                       A channel (signal recorded in the atria)
%   - tV: indices of all ventricular beats
%   - tA: indices of all atrial beats 


%% example of the patient with VT
patient_index = 43; % any number from 1 to 960.
patient = data_vt{patient_index}; % <-- VT patient

T = 5000; % show only the first 5 seconds
tA = patient.tA(patient.tA < T);
tV = patient.tV(patient.tV < T);

figure
subplot(211)
hold on
plot(patient.V(1:T));
plot(tV, patient.V(tV), 'r*');
title('Ventricular Channel');
legend('V signal', 'V beats');
% 
subplot(212)
hold on
plot(patient.A(1:T));
plot(tA, patient.A(tA), 'r*');
title('Atrial Channel');
legend('A signal', 'A beats');