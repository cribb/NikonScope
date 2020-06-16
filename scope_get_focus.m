function focus = scope_get_focus(obj1)
% SCOPE_GET_FOCUS returns the focus value of the microscope

% Flush data in input buffer
flushinput(obj1)

% Set the 'recieved' variable to false 
recieved = false;
% fprintf('\n');
% Reads the input
while ~recieved    
    data = query(obj1, 'rSPR', '%s\n' ,'%s');
%     fprintf(' %s, ', data);
    if strcmp(data(1:4),'aSPR')
        focus = str2double(data(5:end));
        recieved = true;
    else
        flushinput(obj1)
%         disp('Resending command...')
    end
end
fprintf('\n\n');
