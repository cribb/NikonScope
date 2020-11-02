function outs = scope_autofocus(scope, lohifocus, stepsize, exptime)
% BA_TESTAUTOFOCUS 
%

if nargin < 1 || isempty(scope)
    logentry('No scope object. Connecting to scope now...');
    try
        scope = scope_open;
        pause(3);
    catch
        error('No connection established. Is scope running?');
    end

end

if nargin < 2 || isempty(lohifocus)
    error('Need [low,high] locations for focus. Try [20000 40000].');
end

if nargin < 3 || isempty(stepsize)
    error('Need distance between frames. Try 500.');
end

if nargin < 4 || isempty(exptime)
    exptime = 8; % [ms]
end

% Camera Setup
imaqmex('feature', '-previewFullBitDepth', true);
%vid = videoinput('pointgrey', 1, 'F7_Mono8_648x488_Mode0');
vid = videoinput('pointgrey', 2,'F7_Raw16_1024x768_Mode2');
vid.ReturnedColorspace = 'grayscale';
% triggerconfig(vid, 'manual');
% vid.FramesPerTrigger = NFrames;

% Following code found in apps -> image acquisition
% More info here: http://www.mathworks.com/help/imaq/basic-image-acquisition-procedure.html
src = getselectedsource(vid); 
src.ExposureMode = 'off'; 
src.FrameRateMode = 'off';
src.ShutterMode = 'manual';
src.Gain = 10;
src.Gamma = 1.15;
src.Brightness = 5.8594;
src.Shutter = exptime;

vidRes = vid.VideoResolution;


imageRes = fliplr(vidRes);

focusTF = true;

f = figure;%('Visible', 'off');
hImage = imshow(uint16(zeros(imageRes)));
hImage.UserData{1} = focusTF;

axis image
% setappdata(hImage, 'UpdatePreviewWindowFcn', @ur_livehist)
setappdata(hImage, 'UpdatePreviewWindowFcn', @ur_liveview)
p = preview(vid, hImage);
set(p, 'CDataMapping', 'scaled');


% ----------------
% Controlling the Hardware and running the experiment
%
focus_locations = [ min(lohifocus) : stepsize : max(lohifocus) ];
N = numel(focus_locations);

% (1) Move stage to beginning position.
startingFocus = scope_get_focus(scope);
logentry(['Microscope is currently at ' num2str(startingFocus)]);


pause(2);
logentry('Starting collection...');

im = cell(N, 1);
arrived_locs = zeros(N,1);
focus_score = zeros(N,1);

for k = 1:N
    this_focus = focus_locations(k);
    
    figure(f); 
    drawnow;

    logentry(['Moving scope to step' num2str(k) ' located at ' num2str(this_focus) '. ']);
    scope_set_focus(scope, this_focus);    
    arrived_locs(k,1) = scope_get_focus(scope);
    logentry(['Focus location: ' num2str(arrived_locs(k,1))]);
    
    im{k,1} = p.CData;
    outfile = ['focus', num2str(k, '%03i'), '.png'];
%     imwrite(im{k,1}, outfile);
%     logentry(['Frame grabbed to ' outfile '.']);
    
    focus_score(k,1) = fmeasure(im{k,1}, 'GDER');
end

close(f);

outs = table(im, arrived_locs, focus_score);
logentry('Done!');

return


% function for writing out stderr log messages
function logentry(txt)
    logtime = clock;
    logtimetext = [ '(' num2str(logtime(1),  '%04i') '.' ...
                   num2str(logtime(2),        '%02i') '.' ...
                   num2str(logtime(3),        '%02i') ', ' ...
                   num2str(logtime(4),        '%02i') ':' ...
                   num2str(logtime(5),        '%02i') ':' ...
                   num2str(floor(logtime(6)), '%02i') ') '];
     headertext = [logtimetext 'ba_testautofocus: '];
     
     fprintf('%s%s\n', headertext, txt);
     
     return