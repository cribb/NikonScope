function focus = scope_get_focus(scope)
% SCOPE_GET_FOCUS returns the focus value of the microscope
%
% focus = scope_get_focus(scope)
%
% Inputs
%   scope: handle to microscope object
%
% Outputs
%   focus: location of objective in z (arb units)
%

% Flush data in input buffer
flushinput(scope)

% Set the 'received' variable to false 
received = false;
% fprintf('\n');
% Reads the input
while ~received    
    data = query(scope, 'rSPR', '%s\n' ,'%s');
%     fprintf(' %s, ', data);
    if strcmp(data(1:4),'aSPR')
        focus = str2double(data(5:end));
        received = true;
    else
        flushinput(scope)
%         disp('Resending command...')
    end
end
fprintf('\n\n');
