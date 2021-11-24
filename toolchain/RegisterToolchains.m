% --------------------------------------------------------------------------------
% @Title: Create and register custom toolchains for TRACE32 XIL
% @Description:
%   This script creates and registers ToolchainInfo object for all custom
%   toolchains located in the folder "toolchain". m-files containing custom
%   toolchains need to start with "t32xil_tc".
%
% @Keywords: PIL Processor-in-the-Loop Simulink MATLAB model-based
% @Author: CSA
% @Copyright: (C) 1989-2019 Lauterbach GmbH, licensed for use with TRACE32(R) only
% --------------------------------------------------------------------------------
% $Id: RegisterToolchains.m 5576 2021-09-09 12:08:40Z csax $

function RegisterToolchains(~)
    % Get custom toolchains
    listing = dir('.');
    toolchains = cell(size(listing, 1), 1);
    for ii = 1:size(listing, 1)
        if listing(ii).isdir
           continue
        end

        [~, name, extension] = fileparts(listing(ii).name);
        if ~(strncmp(name, 't32xil_tc', 9) && strcmp(extension, '.m'))
           continue
        end
        toolchains{ii} = listing(ii).name;
    end
    toolchains = toolchains( ...
        cellfun(@(x) ~isempty(x), toolchains, 'UniformOutput', true) ...
    );

    % Create and register all custom toolchains
    for ii = 1:size(toolchains, 1)
        [~, name, ~] = fileparts(toolchains{ii});
        handle = str2func(name);
        tc = handle();
        save([name, '.mat'], 'tc');
    end
    RTW.TargetRegistry.getInstance('reset');
end
