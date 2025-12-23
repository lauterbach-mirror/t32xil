% --------------------------------------------------------------------------------
% @Title: Customize build process of T32XIL
% @Description:
%   Set custom user hooks that are activated during the build process of
%   T32XIL. Please refer to the section
%   "Customize Build Process with sl_customization.m" for a detailed
%   description of the configuration options.
%
% @Keywords: PIL Processor-in-the-Loop Simulink MATLAB model-based
% @Author: CSA
% @Copyright: (C) 1989-2024 Lauterbach GmbH, licensed for use with TRACE32(R) only
% --------------------------------------------------------------------------------

function t32xil_make_rtw_before_make_user_hook(modelName, dependencyObject)
%% Set user hooks for build process

toolchain = get_param(modelName, 'Toolchain');
if strcmp(toolchain, 'TRACE32 XIL GCC arm-none-eabi Cortex-R | gmake makefile')
    base = fullfile(fileparts(mfilename('fullpath')), '..', 'targets', 'cortex-r');
    addSourcePaths(dependencyObject, fullfile(base));

    addSourceFiles(dependencyObject, 'crt0.s');
    addSourceFiles(dependencyObject, 'syscalls.c');

    addLinkFlags(dependencyObject, ['-T "' fullfile(base, 'link.lds') '"']);
elseif strcmp(toolchain, 'TRACE32 XIL GCC arm-none-eabi Cortex-M | gmake makefile')
    base = fullfile(fileparts(mfilename('fullpath')), '..', 'targets', 'cortex-m');
    addSourcePaths(dependencyObject, fullfile(base));

    addSourceFiles(dependencyObject, 'crt0.s');
    addSourceFiles(dependencyObject, 'syscalls.c');

    addLinkFlags(dependencyObject, ['-T "' fullfile(base, 'link.lds') '"']);
elseif strcmp(toolchain, 'TRACE32 XIL Renesas RL78 Compiler CC-RL | gmake makefile')
    base = fullfile('C:', 'Program Files (x86)', 'Renesas Electronics', 'CS+', 'CC', 'SampleProjects', 'RL78', 'RL78_G13_Tutorial_Basic_Operation_CC');
elseif strcmp(toolchain, 'TRACE32 XIL Diab Compiler Power Architecture | gmake makefile')
    base = fullfile(fileparts(mfilename('fullpath')), '..', 'targets', 'mpc8610');
    addSourcePaths(dependencyObject, fullfile(base));

    addSourceFiles(dependencyObject, 'crt0.s');

    addLinkFlags(dependencyObject, [' "' fullfile(base, 'ppc.dld') '" -lc -lm']);
end

end
