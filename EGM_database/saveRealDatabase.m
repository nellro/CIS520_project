%%
function saveRealDatabase()
    clear all
    close all
    %%
    load('patients.mat');
    plist=pr.keys;
    fprintf('\n====================\nList of patients:\n');
    for pnumber=1:length(plist)
        fprintf(strcat(plist{pnumber}, 32, '\n')); 
    end


    counter_vt = 1;
    counter_svt = 1;
    %
    for pnumber=1:length(plist)
        pname=plist{pnumber};
        patient = pr(pname); 

        signals_list=patient.keys;
    %     fprintf(strcat('\n====================\nList of signals for a patient', ...
    %         32, num2str(pname), ':\n'));
    %     for i=1:length(signals_list)
    %         fprintf(strcat(signals_list{i}, 32, '\n')); 
    %     end
        for type_num = 1:length(signals_list)
            signal_type = signals_list{type_num};
            if isequal('VTs', signal_type) || isequal('SVTs', signal_type) || isequal('NSR', signal_type)
                egms = patient(signal_type); 
                for record_num = 1:length(egms)
                    egm = egms(record_num); % may be more than one EGM of given type
                    %
                    if isequal('VTs', signal_type)
                        data_vt{counter_vt} = getSignals(egm);   
                        counter_vt = counter_vt+1;
                    elseif isequal('SVTs', signal_type) || isequal('NSR', signal_type)
                        data_svt{counter_svt} = getSignals(egm);   
                        counter_svt = counter_svt+1;
                    end                       
                end
            end
        end
    end
    save('EGM_real.mat','data_vt','data_svt');
end


function patient = getSignals(egm)
    sA=egm.ASigRaw;
    sV=egm.VSigRaw;
    sVFilt = egm.VSigFilt;
    sAFilt = egm.ASigFilt;
    tV=egm.RVin;
    tA=egm.RAin;
    % avoid oversensing
    % sometimes the signal contains two consecutive peaks, where the
    % second one should be ignored. the following code does it:
    for i = 1:length(tV)-1
      if tV(i) == 1, tV(i+1) = 0; end
      if tA(i) == 1, tA(i+1) = 0; end
    end          
    tV = find(tV == 1);
    tA = find(tA == 1);

    patient.tV = tV;
    patient.tA = tA;
    patient.V = sV;
    patient.A = sA;
    
    patient.AFilt = sAFilt;
    patient.VFilt = sVFilt; 
end