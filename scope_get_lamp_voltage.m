function voltage = scope_get_lamp_voltage(scope)
% SCOPE_GET_LAMP_VOLTAGE returns the voltage of the lamp
%
% voltage = scope_get_lamp_voltage(scope)
%
% Inputs
%   scope: handle to microscope object
%
% Outputs 
%   voltage: current voltage of the brightfield lamp
%


% Flush data in input buffer
flushinput(scope)

% Set the 'received' variable to false 
received = false;

% Reads the input
while ~received    
    data = query(scope, 'rLVR', '%s\n' ,'%s');
    if strcmp(data(1:4),'aLVR')
        voltage = str2double(data(5:end));
        received = true;
    else
        flushinput(scope)
        disp('Resending command...')
    end
end