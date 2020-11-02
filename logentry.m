function logentry(txt)
% function for writing out stderr log messages

    [ST,I] = dbstack;
    logtime = clock;
    
    STname = ST(end).name;
    if contains(STname, '@(')
        STname = ST(end-1).name;
    end
    
    logtimetext = [ '(' num2str(logtime(1),  '%04i') '.' ...
                   num2str(logtime(2),        '%02i') '.' ...
                   num2str(logtime(3),        '%02i') ', ' ...
                   num2str(logtime(4),        '%02i') ':' ...
                   num2str(logtime(5),        '%02i') ':' ...
                   num2str(floor(logtime(6)), '%02i') ') '];
     headertext = [logtimetext STname ': '];
     
     fprintf('%s%s\n', headertext, txt);
     
     return;    
