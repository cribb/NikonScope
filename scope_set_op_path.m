function scope_set_op_path(scope, path)
% SCOPE_SET_OP_PATH sets the optical path (camera) for the NikonScope
%
% scope_set_op_path(scope, path)
%
% Inputs
%   scope: handle to microscope object
% 
% Outputs
%   path: Path number/ID to the desired camera/eyepiece
%


% Flush data in input buffer
flushinput(scope)

% Increase the timeout to avoid flooding the buffer
set(scope, 'Timeout', 100.0);

% Set the 'received' variable to false 
received = false;

% Reads the input
while ~received    
    command = strcat('cPDM', num2str(path));
    data = query(scope, command, '%s\n' ,'%s');
%     fprintf('Sent command: %s, Received state: %s \n. ', command, data);
    if strcmp(data,'oPDM') && (scope_get_op_path(scope) == path)
        disp('Optical path has been set')
        received = true;
    else
        flushinput(scope)
        disp('Resending command...')
    end
end