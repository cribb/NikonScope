function scope_set_focus(scope, pos)
% SCOPE_SET_FOCUS sets the focus of the microscope
%
% scope_set_focus(scope, pos)
%
% Inputs
%   scope: handles to microscope object
%   pos: desired focus position (arb units)
%

% Flush data in input buffer
flushinput(scope)

% Set the tolerance value to which the final position should be within
tol = 50;

% Set the 'received' variable to false 
received = false;
tic;

% build the command
command = strcat('cSMV', num2str(pos));

% Reads the input
while ~received    
%     fprintf('FOO');
    data = query(scope, command, '%s\n' ,'%s');
%     fprintf('BAR');
%     fprintf(' %s, ', data);
    if strcmp(data,'oSMV')
        if abs(scope_get_focus(scope) - pos) <= tol
            logentry('Focus has been set.')
            received = true;
        end
    else
        flushinput(scope)
%         disp('Resending command...')
    end
end

elapsed_time = toc;
logentry(['Elapsed time focusing: ' num2str(elapsed_time), ' [s].']);





