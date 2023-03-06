function scope_set_lamp_voltage(scope, voltage)
% SCOPE_SET_LAMP_VOLTAGE sets the lamp to the desired voltage.
%
% scope_set_lamp_voltage(scope, voltage)
% 
% Inputs
%    scope: handles to microscope object
%    voltage: Voltage to lamp in [V], which MUST be in the range [3,12]. 
%             In general, the set voltage is accurate to .5V or less for 
%             the range [3,5], .3V or less for the range [5,7], and 
%             negiglible error for [7,12]
% 

% Flush data in input buffer
flushinput(scope)

% Set the tolerance value to which the final voltage should be within
tol = 0.5;

% Set the 'received' variable to false 
received = false;

% Makes sure that the voltage called for is within bounds
if (voltage > 12) || (voltage < 2)
    error('Voltage value not within bounds of device')
end

% Reads the input
while ~received    
    command = strcat('cLMC', num2str(voltage));
    data = query(scope, command, '%s\n' ,'%s');
    
    if strcmp(data,'oLMC')
        if abs(scope_get_lamp_voltage(scope) - voltage) <= tol
            disp('Lamp voltage has been set')
            received = true;
        end
    else
        flushinput(scope)
        disp('Resending command...')
    end
end