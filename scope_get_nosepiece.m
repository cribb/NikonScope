function LensNumber = scope_get_nosepiece(scope)
% SCOPE_GET_FOCUS returns the focus value of the microscope
%
% LensNumber = scope_get_nosepiece(scope)
% 
% Inputs
%   scope: handle to microscope object
%
% Outputs
%   LensNumber: number/ID location for current microscope objective 
%


% Flush data in input buffer
flushinput(scope)

% Set the 'received' variable to false 
received = false;

% Reads the input
while ~received    
    data = query(scope, 'rRAR', '%s\n' ,'%s');
%     fprintf(' %s, ', data);
    if strcmp(data(1:4),'aRAR')
        LensNumber = str2double(data(5:end));
        received = true;
    else
        flushinput(scope)
%         disp('Resending command...')
    end
end
fprintf('\n\n');
