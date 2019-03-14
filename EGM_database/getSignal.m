function patient = getSignal( folderName, egm_iter, egm_case, egm_ind)

params = egm_params();
egm_type = params.annotations{egm_ind};
egm_name = strcat('EGM-', num2str(egm_iter), '-', num2str(egm_case), '-', num2str(egm_ind));
egm_path = strcat(folderName, '\', egm_name);

load(egm_path);
%clearvars -except egm flagPlot egm_type flagSave;

%% SENSING: detect V and A events
sA=EGM.ASigRaw;
sV=EGM.VSigRaw;
        
tV=EGM.RVin;
tA=EGM.RAin;
% avoid oversensing
% sometimes the signal contains two consecutive peaks, where the
% second one should be ignored. the following code does it:
for i = 1:length(tV)-1
  if tV(i) == 1, tV(i+1) = 0; end
  if tA(i) == 1, tA(i+1) = 0; end
end          
tV = find(tV == 1);
tA = find(tA == 1);

%%
start = 10000;
sV = sV((start+1):end);
sA = sA((start+1):end);
tV = tV(tV > start)-start;
tA = tA(tA > start)-start;

patient.tV = tV;
patient.tA = tA;
patient.V = sV;
patient.A = sA;
end

