function path = scope_get_op_path(scope)
% SCOPE_GET_OP_PATH gets the optical path position of the device as an integer
%
% path = scope_get_op_path(scope)
%
% Inputs
%   scope: handle to microscope object
%
% Outputs
%   path: Number/ID that corresponds to current optical path (camera)
%

% Flush data in input buffer
flushinput(scope)

% Set the 'received' variable to false 
received = false;

% Reads the input
while ~received    
    data = query(scope, 'rPAR', '%s\n' ,'%s');
    if strcmp(data(1:4),'aPAR')
        path = str2double(data(5:end));
        received = true;
    else
        flushinput(scope)
        disp('Resending command...')
    end
end