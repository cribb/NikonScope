function status=scope_close(S)
% SCOPE_CLOSE closes the connection to the microscope
    fclose(S);
    delete(S);
    clear S;
    status=0;
end