% --------------------------------------------------------------------------------
% @Title: Customize build process of T32XIL
% @Description: 
%   Set custom user hooks that are activated during the build process of 
%   T32XIL. Please refer to the section
%   "Customize Build Process withsl_customization.m" for a detailed
%   description of the configuration options.
%   
% @Keywords: PIL Processor-in-the-Loop Simulink MATLAB model-based
% @Author: CSA
% @Copyright: (C) 1989-2017 Lauterbach GmbH, licensed for use with TRACE32(R) only
% --------------------------------------------------------------------------------

function t32xil_make_rtw_before_make_user_hook(modelName, dependencyObject)
%% Set user hooks for build process

toolchain = get_param(modelName, 'Toolchain');
if strcmp(toolchain, 'TRACE32 XIL GCC arm-none-eabi Cortex-R | gmake makefile')
    base = fullfile(fileparts(mfilename('fullpath')), '..', 'targets', 'cortex-r');    
    addSourcePaths(dependencyObject, fullfile(base));
    
    addSourceFiles(dependencyObject, 'crt0.s');

    addLinkFlags(dependencyObject, ['-T ' fullfile(base, 'link.lds')]);
elseif strcmp(toolchain, 'TRACE32 XIL GCC arm-none-eabi Cortex-M | gmake makefile')
    base = fullfile(fileparts(mfilename('fullpath')), '..', 'targets', 'cortex-m');    
    addSourcePaths(dependencyObject, fullfile(base));
    
    addSourceFiles(dependencyObject, 'crt0.s');

    addLinkFlags(dependencyObject, ['-T ' fullfile(base, 'link.lds')]);    
end

end
