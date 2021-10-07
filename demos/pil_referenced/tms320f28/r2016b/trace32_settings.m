% --------------------------------------------------------------------------------
% @Title: Settings for TRACE32 XIL
% @Description: 
%  Defines settings for the TRACE32 XIL target connectivity configuration.
%  To adapt the settings for a new model, copy the file to the model
%  directory and modify its contents.
%   
% @Keywords: PIL Processor-in-the-Loop Simulink MATLAB model-based
% @Author: MBU, CSA
% @Copyright: (C) 1989-2018 Lauterbach GmbH, licensed for use with TRACE32(R) only
% --------------------------------------------------------------------------------
% $Id: trace32_settings.m 1326 2016-09-07 15:27:40Z csax $

function  cfg = trace32_settings()
	% Specify configuration settings for T32XIL
	cfg = struct;

    %% ### Start: User adaptable values ###
    % T32_x: If given without full path, the current path of this file is
    %           searched for these files
    % Target_Binary_Extension: e.g. .elf, .coff, .ecoff, .xcoff, .out, ...
    % Timeout_x: Timeouts in seconds
    cfg.T32_Executable          = 't32m2000.exe';
    cfg.T32_Startupscript       = 'trace32_tms320f28_startup.cmm';
    cfg.T32_Config              = '';  % If empty, the simulinktemplate.config.t32 in the matlabsimulink diectory will be taken; Otherwise give full path.
    cfg.Target_Binary_Extension = '.elf';
    cfg.Timeout_Init            = 10;
    cfg.Timeout_Transfer        = 10;
    cfg.Hardware_Timer          = '';  % Specify timer object for code execution profiling. If empty, execution profiling is disabled.
    cfg.Stack_Profiler          = '';  % Specify data for stack profiling. If empty, stack profiling is disabled.
	cfg.PracticeHooks           = SetPracticeCallbacks();
    % ### End: User adaptable values ###
end


function hooks = SetPracticeCallbacks()
	% Specify PRACTICE scripts that are executed if a specific event is
	% detected:
    %   hooks.PreInit  = {'<full_script_path>', '<name_of_struct>'};
	%
	% Example:
    %   % 1. Create a container on the workspace:
    %     %    Convention: - Arguments passed to the callback are fields
    %                        with a string value
    %     %                - Arguments returned from the callback are empty
	%     interface = struct('in1', 'input1', 'in2', 'input2', 'in3',...
	%                        'input3', 'out1', [], 'out2', []);

    %
    %   % 2. Define callback in  settings file:
	%     %% ### Start: User adaptable values ###
	%     hooks.PreInit  = {'callback', 'interface'};
	%     hooks.PostTerm = {'', ''};
    %     %% ### End: User adaptable values ###
    %
    %   % 3. Create PRACTICE script
    %     PRIVATE &in1
    %     PRIVATE &in2
    %     PRIVATE &in3
    %     
    %     ; --------------------------------------------------------------------------------
    %     ; Parse argument string
    %     ; --------------------------------------------------------------------------------
    %     PARAMETERS &parameters  // Input/output parameters
    %     &in1=STRing.SCANAndExtract("&parameters","IN1=","")
    %     &in2=STRing.SCANAndExtract("&parameters","IN2=","")
    %     &in3=STRing.SCANAndExtract("&parameters","IN3=","")
    %     
    %
    %     ; --------------------------------------------------------------------------------
    %     ; Start callback implementation
    %     ; --------------------------------------------------------------------------------
    %     
    %     ; --------------------------------------------------------------------------------
    %     ; EnEnd callback implementation
    %     ; --------------------------------------------------------------------------------
    %
    %
    %     ; --------------------------------------------------------------------------------
    %     ; Return argument string
    %     ; --------------------------------------------------------------------------------
    %     PRINT " OUT1=output1  OUT2=output2 "
    %     
    %     ENDDO
    %
	hooks = struct;

	%% ### Start: User adaptable values ###
	hooks.PreInit  = {'', ''};  % Triggered once immediately before the simulation is started
	hooks.PostTerm = {'callback', 'interface'};  % Triggered once after the simulation has terminated	
    % ### End: User adaptable values ###
end
