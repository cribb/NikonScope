function state = scope_get_lamp_state(obj1)
% SCOPE_GET_LAMP_STATE determines if the lamp is on (state = 1) or off 
% (state = 0)

% Flush data in input buffer
flushinput(obj1)

% Set the 'recieved' variable to false 
recieved = false;

% Reads the input
while ~recieved    
    data = query(obj1, 'rLSR', '%s\n' ,'%s');
    if strcmp(data(1:4),'aLSR')
        state = str2double(data(5:end));
        recieved = true;
    else
        flushinput(obj1)
        disp('Resending command...')
    end
end