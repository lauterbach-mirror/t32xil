% --------------------------------------------------------------------------------
% @Title: Register custom toolchains for TRACE32 XIL
% @Description: 
%   Custom toolchains can be registered after creation of a ToolchainInfo
%   object. To register an m-file with name "rtwTargetInfo" has to be on
%   the MATLAB path. Use the command
%       which -all rtwTargetInfo
%   to verify that the file has been detected correctly.
%   Use the command
%       RTW.TargetRegistry.getInstance('reset')
%   to register the the custom toolchain.
%   
% @Keywords: PIL Processor-in-the-Loop Simulink MATLAB model-based
% @Author: CSA
% @Copyright: (C) 1989-2019 Lauterbach GmbH, licensed for use with TRACE32(R) only
% --------------------------------------------------------------------------------
% $Id: rtwTargetInfo.m 5825 2021-11-19 08:35:56Z csax $

%% Callback to detect the custom toolchains
function rtwTargetInfo(tr)
    tr.registerTargetInfo(@loc_createToolchain);
end

%% Specify properties for custom toolchains
function config = loc_createToolchain
    config(1) = coder.make.ToolchainInfoRegistry;
    config(1).Name = 'TRACE32 XIL v1.0 | gmake makefile';
    config(1).FileName = fullfile(fileparts(mfilename('fullpath')), 't32xil_tc.mat');
    config(1).TargetHWDeviceType = {'*'};
    config(1).Platform  = {computer('arch')};

    config(2) = coder.make.ToolchainInfoRegistry;
    config(2).Name = 'TRACE32 XIL GCC arm-none-eabi Cortex-R | gmake makefile';
    config(2).FileName = fullfile(fileparts(mfilename('fullpath')), 't32xil_tc_gcc_arm_none_eabi_cortex_r.mat');
    config(2).TargetHWDeviceType = {'ARM Compatible->ARM Cortex'};
    config(2).Platform  = {computer('arch')};

    config(3) = coder.make.ToolchainInfoRegistry;
    config(3).Name = 'TRACE32 XIL GCC arm-none-eabi Cortex-M | gmake makefile';
    config(3).FileName = fullfile(fileparts(mfilename('fullpath')), 't32xil_tc_gcc_arm_none_eabi_cortex_m.mat');
    config(3).TargetHWDeviceType = {'ARM Compatible->ARM Cortex'};
    config(3).Platform  = {computer('arch')};

    config(4) = coder.make.ToolchainInfoRegistry;
    config(4).Name = 'TRACE32 XIL TASKING VX-toolset for TriCore | gmake makefile';
    config(4).FileName = fullfile(fileparts(mfilename('fullpath')), 't32xil_tc_tasking_ctc.mat');
    config(4).TargetHWDeviceType = {'Infineon->TriCore'};
    config(4).Platform  = {computer('arch')};

    config(5) = coder.make.ToolchainInfoRegistry;
    config(5).Name = 'TRACE32 XIL HighTec TriCore Development Platform | gmake makefile';
    config(5).FileName = fullfile(fileparts(mfilename('fullpath')), 't32xil_tc_hightec_tricore_gcc.mat');
    config(5).TargetHWDeviceType = {'Infineon->TriCore'};
    config(5).Platform  = {computer('arch')};

    % To register more custom toolchains:
    % 1) Copy and paste the five preceding 'config' lines.
    % 2) Increment the index of config().
    % 3) Replace the values between angle brackets.
    % 4) Remove the angle brackets.
end
