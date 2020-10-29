function LampState = scope_get_lamp_state(scope)
% SCOPE_GET_LAMP_STATE returns if the lamp is on (state = 1) or off (state = 0)
% 
% state = scope_get_lamp_state(scope)
% 
% Inputs
%   scope: handles to scope object
%
% Outputs
%   LampState: returns "0" if OFF and "1" if ON
%

% Flush data in input buffer
flushinput(scope)

% Set the 'received' variable to false 
received = false;

% Reads the input
while ~received    
    data = query(scope, 'rLSR', '%s\n' ,'%s');
    if strcmp(data(1:4),'aLSR')
        LampState = str2double(data(5:end));
        received = true;
    else
        flushinput(scope)
        disp('Resending command...')
    end
end