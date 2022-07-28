% --------------------------------------------------------------------------------
% @Title: ToolchainInfo object for HighTec TriCore Development Platform
% @Description: 
%   Creates a generic ToolchainInfo object for TRACE32 XIL with HighTec TriCore
%   Development Platform v4.9.4.0. A toolchain object describes the basic
%   information of the toolchain.
%   
% @Keywords: PIL Processor-in-the-Loop Simulink MATLAB model-based
% @Author: CSA
% @Copyright: (C) 1989-2019 Lauterbach GmbH, licensed for use with TRACE32(R) only
% --------------------------------------------------------------------------------
% $Id: t32xil_tc_hightec_tricore_gcc.m 6172 2022-04-08 07:00:14Z csax $


%% Creates a generic ToolchainInfo object for TRACE32 XIL
function toolchain = t32xil_tc_hightec_tricore_gcc
toolchain = coder.make.ToolchainInfo('SupportedLanguages', 'Asm/C', 'BuildArtifact', 'gmake makefile');
toolchain.Name = 'TRACE32 XIL HighTec TriCore Development Platform | gmake makefile';
toolchain.Platform  = computer('arch');
toolchain.SupportedVersion = 'v4.9.4.0';


toolchain.addAttribute('TransformPathsWithSpaces', true);  % Escape paths containing spaces if enabled
toolchain.addAttribute('RequiresCommandFile', false);  % Handle long archiver/linker calls on Windows systems if enabled
toolchain.addAttribute('SupportsUNCPaths', false);  % Support UNC paths on Windows if enabled 
toolchain.addAttribute('SupportsDoubleQuotes', false);  % Wrap path in double quotes if enabled 
toolchain.addAttribute('RequiresBatchFile', true);  % Creates a batch file that execute the generated makefile if enabled


%% Run the required setup scripts for this toolchain
% toolchain.ShellSetup{1} = '';


%% Set macros that are exported to the created makefile
toolchain.addMacro('CPU', 'tc29xx');

toolchain.addMacro('AS_OPTS', '');
toolchain.addMacro('CC_OPTS', '-c -g -mcpu=$(CPU)');
toolchain.addMacro('LD_OPTS', '-mcpu=$(CPU)');
toolchain.addMacro('AR_OPTS', '');
% tc.addIntrinsicMacros({'<macro>', ...'});


%% Customize the assembler
assembler = toolchain.getBuildTool('Assembler');

assembler.setName('HighTec tricore-gcc');
assembler.setCommand('tricore-gcc');
assembler.setPath('C:/Compiler/HIGHTEC/toolchains/tricore/V4.9.4.0/bin');

assembler.setDirective('PreprocessorDefine', '-D');
assembler.setDirective('Debug', '-g');
assembler.setDirective('OutputFlag', '-o');

assembler.setFileExtension('Source', '.s');
assembler.setFileExtension('Object', '.o');

assembler.setCommandPattern('|>TOOL<| |>TOOL_OPTIONS<| |>OUTPUT_FLAG<| |>OUTPUT<|');


%% Customize the C compiler
compiler = toolchain.getBuildTool('C Compiler');

assembler.setName('HighTec tricore-gcc');
compiler.setCommand('tricore-gcc');
compiler.setPath('C:/Compiler/HIGHTEC/toolchains/tricore/V4.9.4.0/bin');

compiler.setDirective('IncludeSearchPath', '-I');
compiler.setDirective('PreprocessorDefine', '-D');
compiler.setDirective('PreprocessFile', '-E');
compiler.setDirective('CompileFlag', '-c');
compiler.setDirective('Debug', '-g');
compiler.setDirective('OutputFlag', '-o');

compiler.setFileExtension('Source', '.c');
compiler.setFileExtension('Header', '.h');
compiler.setFileExtension('Object', '.o');

compiler.setCommandPattern('|>TOOL<| |>TOOL_OPTIONS<| |>OUTPUT_FLAG<| |>OUTPUT<|');

compiler.Sources = {''};
compiler.IncludePaths = {'$(TARGET_DIR)'};
compiler.Libraries = {'$(LIBS)'};


%% Customize the linker
linker = toolchain.getBuildTool('Linker');

linker.setName('HighTec tricore-gcc');
linker.setCommand('tricore-gcc');
linker.setPath('C:/Compiler/HIGHTEC/toolchains/tricore/V4.9.4.0/bin');

linker.setDirective('Library', '-l');
linker.setDirective('LibrarySearchPath', '-L');
linker.setDirective('OutputFlag', '-o');
linker.setDirective('Debug', '');

linker.setFileExtension('Executable', '.elf');
linker.setFileExtension('Shared Library', '.dll');

linker.InputFileExtensions = {'Object'};
linker.DerivedFileExtensions = {'Static Library'};

linker.setCommandPattern('|>TOOL<| |>TOOL_OPTIONS<| |>OUTPUT_FLAG<| |>OUTPUT<|');


%% Customize the archiver
archiver = toolchain.getBuildTool('Archiver');

archiver.setName('HighTec tricore-ar');
archiver.setCommand('tricore-ar');
archiver.setPath('C:/Compiler/HIGHTEC/toolchains/tricore/V4.9.4.0/bin');

archiver.setDirective('OutputFlag', '-r');

archiver.InputFileExtensions = {'Source'};

archiver.setFileExtension('Static Library', '.a');

archiver.setCommandPattern('|>TOOL<| |>TOOL_OPTIONS<| |>OUTPUT_FLAG<| |>OUTPUT<|');


%% Customize the builder application
toolchain.setBuilderApplication(toolchain.Platform);


%% Customize the build process
fast_build_opts = {'-O0'};
fast_run_opts = {'-O2'};
debug_build_opts = {'-Og'};
assembler_opts = '$(AS_OPTS)';
compiler_opts = '$(CC_OPTS)';
linker_opts = {'$(LD_OPTS)'};
archiver_opts = {'$(AR_OPTS)'};

config = toolchain.getBuildConfiguration('Faster Builds');
config.setOption('Assembler', horzcat(assembler_opts, fast_build_opts));
config.setOption('C Compiler', horzcat(compiler_opts, fast_build_opts));
config.setOption('Linker', horzcat(linker_opts, fast_build_opts));
config.setOption('Archiver', archiver_opts);

config = toolchain.getBuildConfiguration('Faster Runs');
config.setOption('Assembler', horzcat(assembler_opts, fast_run_opts));
config.setOption('C Compiler', horzcat(compiler_opts, fast_run_opts));
config.setOption('Linker', horzcat(linker_opts, fast_run_opts));
config.setOption('Archiver',archiver_opts);

config = toolchain.getBuildConfiguration('Debug');
config.setOption('Assembler', horzcat(assembler_opts, debug_build_opts));
config.setOption('C Compiler', horzcat(compiler_opts, debug_build_opts));
config.setOption('Linker', horzcat(linker_opts, debug_build_opts));
config.setOption('Archiver', horzcat(archiver_opts));

toolchain.setBuildConfigurationOption('all', 'Make Tool', '-f $(MAKEFILE)');

