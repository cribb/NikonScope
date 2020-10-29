function scope_set_filterblock(scope, FilterNumber)
% SCOPE_SET_FILTERBLOCK sets the filterblock of the NikonScope
%
% scope_set_filterblock(scope, FilterNumber)
%
% Inputs
%   scope: handle to microscope object
%   FilterNumber: Location/ID number for desired filterblock
%

% Flush data in input buffer
flushinput(scope)

% Increase the timeout to avoid flooding the buffer
set(scope, 'Timeout', 100.0);

% Set the 'received' variable to false 
received = false;

% Reads the input
while ~received    
    command = strcat('cHDM1', num2str(FilterNumber));
    data = query(scope, command, '%s\n' ,'%s');
%     fprintf('Sent command: %s, Received state: %s. \n', command, data);
    if strcmp(data,'oHDM') && (scope_get_filterblock(scope) == FilterNumber)
        disp('Filter block has been set')
        received = true;
    else
        flushinput(scope)
        disp('Resending command...')
    end
end