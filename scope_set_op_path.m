function scope_set_op_path(obj1, path)
% SCOPE_SET_OP_PATH gets the optical path position of the device. The
% variable 'path' is an integer.

% Flush data in input buffer
flushinput(obj1)

% Increase the timeout to avoid flooding the buffer
set(obj1, 'Timeout', 100.0);

% Set the 'recieved' variable to false 
recieved = false;

% Reads the input
while ~recieved    
    command = strcat('cPDM', num2str(path));
    data = query(obj1, command, '%s\n' ,'%s');
    if strcmp(data,'oPDM') && (scope_get_op_path(obj1) == path)
        disp('Optical path has been set')
        recieved = true;
    else
        flushinput(obj1)
        disp('Resending command...')
    end
end