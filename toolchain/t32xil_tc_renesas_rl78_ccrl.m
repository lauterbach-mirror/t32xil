% --------------------------------------------------------------------------------
% @Title: ToolchainInfo object for Renesas RL78 Compiler CC-RL
% @Description:
%   Creates a generic ToolchainInfo object for TRACE32 XIL with Renesas RL78
%   Compiler CC-RL. A toolchain object describes the basic information of the
%   toolchain.
%
% @Keywords: PIL Processor-in-the-Loop Simulink MATLAB model-based
% @Author: CSA
% @Copyright: (C) 1989-2022 Lauterbach GmbH, licensed for use with TRACE32(R) only
% --------------------------------------------------------------------------------
% $Id: t32xil_tc_renesas_rl78_ccrl.m 6381 2022-07-08 09:14:46Z csax $


%% Creates a generic ToolchainInfo object for TRACE32 XIL
function toolchain = t32xil_tc_renesas_rl78_ccrl

toolchain = coder.make.ToolchainInfo('SupportedLanguages', 'Asm/C', 'BuildArtifact', 'gmake makefile');
toolchain.Name = 'TRACE32 XIL Renesas RL78 Compiler CC-RL | gmake makefile';
toolchain.Platform  = computer('arch');
toolchain.SupportedVersion = '1.11.00';


toolchain.addAttribute('TransformPathsWithSpaces', true);  % Escape paths containing spaces if enabled
toolchain.addAttribute('RequiresCommandFile', false);  % Handle long archiver/linker calls on Windows systems if enabled
toolchain.addAttribute('SupportsUNCPaths', false);  % Support UNC paths on Windows if enabled
toolchain.addAttribute('SupportsDoubleQuotes', false);  % Wrap path in double quotes if enabled
toolchain.addAttribute('RequiresBatchFile', true);  % Creates a batch file that execute the generated makefile if enabled
toolchain.addAttribute('LinkerLibraryPrefix', '-lnkopt=-LIBrary=')  % Append prefix to static library arguments


%% Run the required setup scripts for this toolchain
% toolchain.ShellSetup{1} = '';


%% Set macros that are exported to the created makefile
toolchain.addMacro('CPU', 'S3');
toolchain.addMacro('DEVFILE', '"C:\Program Files (x86)\Renesas Electronics\CS+\CC\Device\RL78\Devicefile\DR5F104ML.DVF"');
toolchain.addMacro('LIBS', '');

toolchain.addMacro('AS_OPTS', '$(CC_OPTS)');
toolchain.addMacro('CC_OPTS', '-c -g -g_line -cpu=$(CPU) -dev=$(DEVFILE)');
toolchain.addMacro('AR_OPTS', '-FOrm=library -DEVICE=$(DEVFILE)');

link_cmds = fullfile(fileparts(mfilename('fullpath')), '..', 'targets', 'rl78', 'opts.clnk');
toolchain.addMacro('LD_OPTS', ['-g -g_line -cpu=$(CPU) -subcommand="C:\T32\demo\env\matlabsimulink\t32xil\toolchain\..\targets\rl78\opts.cbld" -lnkopt=-FOrm=absolute -lnkopt=-DEVICE=$(DEVFILE) -lnkopt=-subcommand="' link_cmds '" -lnkopt=-list="out.map"']);
% tc.addIntrinsicMacros({'<macro>', ...'});


%% Customize the assembler
assembler = toolchain.getBuildTool('Assembler');

assembler.setName('CC-RL ccrl');
assembler.setCommand('"C:\Program Files (x86)\Renesas Electronics\CS+\CC\CC-RL\V1.11.00\bin\ccrl"');

assembler.setDirective('PreprocessorDefine', '-D');
assembler.setDirective('Debug', '-g -g_line');
assembler.setDirective('OutputFlag', '-o');

assembler.setFileExtension('Source', '.asm');
assembler.setFileExtension('Object', '.obj');

assembler.setCommandPattern('|>TOOL<| |>TOOL_OPTIONS<| |>OUTPUT_FLAG<| |>OUTPUT<|');


%% Customize the C compiler
compiler = toolchain.getBuildTool('C Compiler');

assembler.setName('CC-RL ccrl');
compiler.setCommand('"C:\Program Files (x86)\Renesas Electronics\CS+\CC\CC-RL\V1.11.00\bin\ccrl"');

compiler.setDirective('IncludeSearchPath', '-I');
compiler.setDirective('PreprocessorDefine', '-D');
compiler.setDirective('PreprocessFile', '-P');
compiler.setDirective('CompileFlag', '-c');
compiler.setDirective('Debug', '-g -g_line');
compiler.setDirective('OutputFlag', '-o');

compiler.setFileExtension('Source', '.c');
compiler.setFileExtension('Header', '.h');
compiler.setFileExtension('Object', '.obj');

compiler.setCommandPattern('|>TOOL<| |>TOOL_OPTIONS<| |>OUTPUT_FLAG<| |>OUTPUT<|');

compiler.Sources = {''};
compiler.IncludePaths = {'$(TARGET_DIR)'};


%% Customize the linker
linker = toolchain.getBuildTool('Linker');

linker.setName('CC-RL ccrl');
linker.setCommand('"C:\Program Files (x86)\Renesas Electronics\CS+\CC\CC-RL\V1.11.00\bin\ccrl"');

linker.setDirective('OutputFlag', '-lnkopt=-OUtput=');
linker.setDirective('Debug', '-DEBug');

linker.setFileExtension('Executable', '.abs');
linker.setFileExtension('Shared Library', '.dll');

linker.setCommandPattern('|>TOOL<| |>TOOL_OPTIONS<| |>OUTPUT_FLAG<||>OUTPUT<|');


%% Customize the archiver
archiver = toolchain.getBuildTool('Archiver');

archiver.setName('CC-RL rlink');
archiver.setCommand('"C:\Program Files (x86)\Renesas Electronics\CS+\CC\CC-RL\V1.11.00\bin\rlink"');

archiver.setDirective('OutputFlag', '-OUtput=');

archiver.setFileExtension('Static Library', '.lib');

archiver.setCommandPattern('|>TOOL<| |>TOOL_OPTIONS<| |>OUTPUT_FLAG<||>OUTPUT<|');


%% Customize the builder application
toolchain.setBuilderApplication(toolchain.Platform);


%% Customize the build process
fast_build_opts = {'-Onothing'};
fast_run_opts = {'-Osize'};
debug_build_opts = {'-Onothing'};
assembler_opts = '$(AS_OPTS)';
compiler_opts = '$(CC_OPTS)';
linker_opts = {'$(LD_OPTS)'};
archiver_opts = {'$(AR_OPTS)'};

config = toolchain.getBuildConfiguration('Faster Builds');
config.setOption('Assembler', horzcat(assembler_opts, fast_build_opts));
config.setOption('C Compiler', horzcat(compiler_opts, fast_build_opts));
config.setOption('Linker', horzcat(linker_opts, '-lnkopt=-OPtimize=SAFe'));
config.setOption('Archiver', archiver_opts);

config = toolchain.getBuildConfiguration('Faster Runs');
config.setOption('Assembler', horzcat(assembler_opts, fast_run_opts));
config.setOption('C Compiler', horzcat(compiler_opts, fast_run_opts));
config.setOption('Linker', horzcat(linker_opts, '-lnkopt=-OPtimize=Branch'));
config.setOption('Archiver',archiver_opts);

config = toolchain.getBuildConfiguration('Debug');
config.setOption('Assembler', horzcat(assembler_opts, debug_build_opts));
config.setOption('C Compiler', horzcat(compiler_opts, debug_build_opts));
config.setOption('Linker', horzcat(linker_opts, '-lnkopt=-NOOPtimize'));
config.setOption('Archiver', horzcat(archiver_opts));

toolchain.setBuildConfigurationOption('all', 'Make Tool', '-f $(MAKEFILE)');

