%        TRACE32 Integration for Simulink
%    Copyright (c) 2012-2015 Lauterbach GmbH
%              All rights reserved

function trace32_target_make(varargin)

    set_param(bdroot, 'SimulationCommand', 'update'); %do not catch (otherwise other Simulink messages are suppressed)
    save_system(bdroot);
    if (strcmp(get_param(bdroot, 'GenCodeOnly'), 'off'))
        make_rtw(varargin{:});
    end

end
