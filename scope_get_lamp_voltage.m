function voltage = scope_get_lamp_voltage(obj1)
% SCOPE_GET_LAMP_VOLTAGE returns the voltage of the lamp

% Flush data in input buffer
flushinput(obj1)

% Set the 'recieved' variable to false 
recieved = false;

% Reads the input
while ~recieved    
    data = query(obj1, 'rLVR', '%s\n' ,'%s');
    if strcmp(data(1:4),'aLVR')
        voltage = str2double(data(5:end));
        recieved = true;
    else
        flushinput(obj1)
        disp('Resending command...')
    end
end