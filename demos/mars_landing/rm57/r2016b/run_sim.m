function run_sim
    delete(timerfind);

    open_system('mars_landing');

    dlg = msgbox('Quit demo mode');
    set(dlg, 'Deletefcn', @DeleteTimer);

    t = timer('TimerFcn', @(x,y) set_param('mars_landing', 'SimulationCommand', 'start'), ...
              'StopFcn', @(x,y) set_param('mars_landing', 'SimulationCommand', 'stop'), ...
              'StartDelay', 5, 'ExecutionMode', 'fixedDelay', 'Period', 60);
    t.start();

    function DeleteTimer(src, event)
        stop(t);
        delete(t);
    end
end

