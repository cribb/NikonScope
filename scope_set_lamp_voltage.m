function scope_set_lamp_voltage(obj1, voltage)
% SCOPE_SET_LAMP_VOLTAGE sets the lamp voltage to the indicated value.
% Voltage MUST be in the range [3,12]. In general, the set voltage is 
% accurate to .5V or less for the range [3,5], .3V or less for the 
% range [5,7], and negiglible error for [7,12]

% Flush data in input buffer
flushinput(obj1)

% Set the tolerance value to which the final voltage should be within
tol = 0.5;

% Set the 'recieved' variable to false 
recieved = false;

% Makes sure that the voltage called for is within bounds
if (voltage > 12) || (voltage < 3)
    error('Voltage value not within bounds of device')
end

% Reads the input
while ~recieved    
    command = strcat('cLMC', num2str(voltage));
    data = query(obj1, command, '%s\n' ,'%s');
    
    if strcmp(data,'oLMC')
        if abs(scope_get_lamp_voltage(obj1) - voltage) <= tol
            disp('Lamp voltage has been set')
            recieved = true;
        end
    else
        flushinput(obj1)
        disp('Resending command...')
    end
end