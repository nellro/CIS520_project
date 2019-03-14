function params = egm_params()
params.annotations   = {...
    'AF';                % SVT
    'AF-PVC';            % SVT
    'AF-VF';             %  VT
    'AF-VT';             %  VT
    'AF-ashman';         % ---
    'Aft';               % SVT
    'Aft-VT';            %  VT
    'NSVT';              % SVT
    'PAC';               % SVT
    'PAC-VF';            %  VT
    'PVC';               % ---
    'SVT';               % SVT
    'SVT-Wenkebach';     % SVT
    'SVT-Wenkebach-PVC'; % SVT
    'SickSinus';         % ---
    'VF';                %  VT
    'VT';             	 %  VT
    'VT-PAC';            %  VT
    'VT-retrograde'      %  VT
    }; 

%--------------------------------------------------------------------------
% 0 = 'SVT', 1 = 'VT', 2 = '---'
params.vt = [0; 0; 1; 1; 2; 0; 1; 0; 0; 1; 2; 0; 0; 0; 2; 1; 1; 1; 1]; 
%--------------------------------------------------------------------------
params.label.svt   = 0;
params.label.vt    = 1;
params.label.extra = 2;

params.IDX_vt  = find(params.vt == params.label.vt)';
params.IDX_svt = find(params.vt == params.label.svt)';
end

