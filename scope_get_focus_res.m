function res = scope_get_focus_res(obj1)
% SCOPE_GET_FOCUS_RES returns the focus resolution of an object as coarse (res =
% 0), medium (res = 1), or fine (res = 2).

% Fine is accurate within 10 units of the target focus position
% Medium is accurate within 20 units of the target focus position
% Coarse is accurate within 30 units of the target focus position

% Flush data in input buffer
flushinput(obj1)

% Set the 'recieved' variable to false 
recieved = false;

% Reads the input
while ~recieved    
    data = query(obj1, 'rSJR', '%s\n' ,'%s');
    disp(data);
    if strcmp(data(1:4),'aSJR')
        res = str2double(data(5:end));
        recieved = true;
    else
        flushinput(obj1)
        disp('Resending command...')
    end
end