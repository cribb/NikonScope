function FilterNumber = scope_get_filterblock(scope)
% SCOPE_GET_FILTERBLOCK gets the filter block position of the NikonScope
%
% FilterNumber= scope_get_filterblock(scope)
%
% Inputs
%   scope: handle to microscope object
%
% Outputs
%   FilterNumber: filter block position of the NikonScope
%

% Flush data in input buffer
flushinput(scope)

% Set the 'received' variable to false 
received = false;

% Reads the input
while ~received    
    data = query(scope, 'rHAR', '%s\n' ,'%s');
    if strcmp(data(1:4),'aHAR')
        FilterNumber = str2double(data(5:end));
        received = true;
    else
        flushinput(scope)
        disp('Resending command...')
    end
end