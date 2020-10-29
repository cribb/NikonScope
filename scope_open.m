function scope = scope_open(ComPort)
% SCOPE_OPEN connects to the NikonScope and outputs a handle
%
% scope = scope_open(ComPort)
% 
% Inputs
%   ComPort: Serial communications port for Nikon Scope (try 'COM4')
%
% Outpus
%   scope: handle to microscope object
%


% Find a serial port object.
scope = instrfind('Type', 'serial', ...
                  'Port', ComPort, ...
                  'Tag', '' );

% Create the serial port object if it does not exist
% otherwise use the object that was found.
% Note: Change from 'COM2' if connected to different port!
if isempty(scope)
    scope = serial(ComPort, 'BaudRate', 9600, ...
                            'DataBits', 8, ...
                            'Parity', 'none', ...
                            'StopBits', 1); 
else
    fclose(scope);
    scope = scope(1);
end

% Connect to instrument object, obj1.
fopen(scope);

% Configure instrument object, obj1 -> set terminator
set(scope, 'Terminator', {'CR/LF','CR'});

% Increase the timeout to avoid flooding the buffer
set(scope, 'Timeout', 100.0);