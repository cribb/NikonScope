function scope_set_nosepiece(scope, LensNumber)
% SCOPE_SET_NOSEPIECE sets the imaging turret to a new objective lens
%
% scope_set_nosepiece(scope, LensNumber)
%
% Inputs
%   scope: handle to microscope object
%   LensNumber: number/ID location for desired microscope objective 
%

% Flush data in input buffer
flushinput(scope)

% Increase the timeout to avoid flooding the buffer
set(scope, 'Timeout', 200.0);

% Set the 'received' variable to false 
received = false;

% Reads the input
while ~received    
    command = strcat('cRDM1', num2str(LensNumber));
    data = query(scope, command, '%s\n' ,'%s');
%     fprintf(' %s, ', data);
    if contains(data,'oRDM') && (scope_get_nosepiece(scope) == LensNumber)
%         disp('Turret objective has been set')
        received = true;
    else
        flushinput(scope)
        disp('Resending command...')
    end
end