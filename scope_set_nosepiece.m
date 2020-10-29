function scope_set_nosepiece(obj1, path)
% SCOPE_SET_OP_PATH sets the objective turret to 'path', which is an integer location
%

% Flush data in input buffer
flushinput(obj1)

% Increase the timeout to avoid flooding the buffer
set(obj1, 'Timeout', 200.0);

% Set the 'recieved' variable to false 
recieved = false;

% Reads the input
while ~recieved    
    command = strcat('cRDM', num2str(path));
    data = query(obj1, command, '%s\n' ,'%s');
%     fprintf(' %s, ', data);
    if contains(data,'nRDM') && (scope_get_nosepiece(obj1) == path)
        disp('Turret objective has been set')
        recieved = true;
    else
        flushinput(obj1)
%         disp('Resending command...')
    end
end