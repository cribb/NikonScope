function obj1 = scope_open
% SCOPE_OPEN creates a new microscope object

% Find a serial port object.
obj1 = instrfind('Type', 'serial', ...
                 'Port', 'COM2', ...
                 'Tag', '' );

% Create the serial port object if it does not exist
% otherwise use the object that was found.
% Note: Change from 'COM2' if connected to different port!
if isempty(obj1)
    obj1 = serial('COM2', 'BaudRate', 9600, ...
                          'DataBits', 8, ...
                          'Parity', 'none', ...
                          'StopBits', 1); 
else
    fclose(obj1);
    obj1 = obj1(1);
end

% Connect to instrument object, obj1.
fopen(obj1);

% Configure instrument object, obj1 -> set terminator
set(obj1, 'Terminator', {'CR/LF','CR'});

% Increase the timeout to avoid flooding the buffer
set(obj1, 'Timeout', 100.0);