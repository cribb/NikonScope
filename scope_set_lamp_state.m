function scope_set_lamp_state(obj1, state)
% SCOPE_SET_LAMP_STATE sets the lamp to on (state = 1) or off (state = 0)

% ON = 1; OFF = 0;

% Flush data in input buffer
flushinput(obj1)

% Increase the timeout to avoid flooding the buffer
set(obj1, 'Timeout', 100.0);

% Set the 'recieved' variable to false 
received = false;

% Reads the input
while ~received    
    command = strcat('cLMS', num2str(state));
    data = query(obj1, command, '%s\n' ,'%s');
    if strcmp(data,'oLMS') && (scope_get_lamp_state(obj1) == state)
        logentry('Lamp state has been set.')
        received = true;
    else
        flushinput(obj1)
        logentry('Resending command...')
    end
end