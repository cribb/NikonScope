function scope_set_focus_res(obj1, res)
% SCOPE_SET_FOCUS_RES sets the focus resolution to coarse (res =
% 0), medium (res = 1), or fine (res = 2)

% Fine is accurate within 10 units of the target focus position
% Medium is accurate within 20 units of the target focus position
% Coarse is accurate within 30 units of the target focus position

% Flush data in input buffer
flushinput(obj1)

% Increase the timeout to avoid flooding the buffer
set(obj1, 'Timeout', 100.0);

% Set the 'recieved' variable to false 
recieved = false;

% Reads the input
while ~recieved    
    command = strcat('cSJS', num2str(res));
    data = query(obj1, command, '%s\n' ,'%s');
    if strcmp(data,'oSJS') && (scope_get_focus_stepsize(obj1) == res)
        disp('Focus Step Size has been set')
        recieved = true;
    else
        flushinput(obj1)
        disp('Resending command...')
    end
end