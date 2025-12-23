% --------------------------------------------------------------------------------
% @Title: TRACE32 Integration for Simulink
% @Copyright: (C) 1989-2024 Lauterbach GmbH, licensed for use with TRACE32(R) only
% --------------------------------------------------------------------------------
% $Id: trace32_target_make.m 8277 2024-10-28 09:04:56Z csax $

function trace32_target_make(varargin)

    set_param(bdroot, 'SimulationCommand', 'update'); % do not catch (otherwise other Simulink messages are suppressed)
    save_system(bdroot);
    if (strcmp(get_param(bdroot, 'GenCodeOnly'), 'off'))
        make_rtw(varargin{:});
    end

end
