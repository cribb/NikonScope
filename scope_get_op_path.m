function path = scope_get_op_path(obj1)
% SCOPE_GET_OP_PATH gets the optical path position of the device as an
% integer

% Flush data in input buffer
flushinput(obj1)

% Set the 'recieved' variable to false 
recieved = false;

% Reads the input
while ~recieved    
    data = query(obj1, 'rPAR', '%s\n' ,'%s');
    if strcmp(data(1:4),'aPAR')
        path = str2double(data(5:end));
        recieved = true;
    else
        flushinput(obj1)
        disp('Resending command...')
    end
end