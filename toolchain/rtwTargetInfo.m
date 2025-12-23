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
% @Copyright: (C) 1989-2024 Lauterbach GmbH, licensed for use with TRACE32(R) only
% --------------------------------------------------------------------------------
% $Id: rtwTargetInfo.m 8277 2024-10-28 09:04:56Z csax $

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
    config(2).TargetHWDeviceType = {'ARM Compatible->ARM Cortex', 'ARM Compatible->ARM Cortex-R'};
    config(2).Platform  = {computer('arch')};

    config(3) = coder.make.ToolchainInfoRegistry;
    config(3).Name = 'TRACE32 XIL GCC arm-none-eabi Cortex-M | gmake makefile';
    config(3).FileName = fullfile(fileparts(mfilename('fullpath')), 't32xil_tc_gcc_arm_none_eabi_cortex_m.mat');
    config(3).TargetHWDeviceType = {'ARM Compatible->ARM Cortex', 'ARM Compatible->ARM Cortex-M'};
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

    config(6) = coder.make.ToolchainInfoRegistry;
    config(6).Name = 'TRACE32 XIL Renesas RL78 Compiler CC-RL | gmake makefile';
    config(6).FileName = fullfile(fileparts(mfilename('fullpath')), 't32xil_tc_renesas_rl78_ccrl.mat');
    config(6).TargetHWDeviceType = {'Renesas->RL78'};
    config(6).Platform  = {computer('arch')};

    config(7) = coder.make.ToolchainInfoRegistry;
    config(7).Name = 'TRACE32 XIL Diab Compiler Power Architecture | gmake makefile';
    config(7).FileName = fullfile(fileparts(mfilename('fullpath')), 't32xil_tc_ppc_diab.mat');
    config(7).TargetHWDeviceType = {'Freescale->MPC86xx'};
    config(7).Platform  = {computer('arch')};

    % To register more custom toolchains:
    % 1) Copy and paste the five preceding 'config' lines.
    % 2) Increment the index of config().
    % 3) Replace the values between angle brackets.
    % 4) Remove the angle brackets.
end
