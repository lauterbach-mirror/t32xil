% --------------------------------------------------------------------------------
% @Title: ToolchainInfo object for Diab Compiler DCC
% @Description:
%   Creates a generic ToolchainInfo object for TRACE32 XIL with Wind River Diab
%   Compiler DCC. A toolchain object describes the basic information of the
%   toolchain.
%
% @Keywords: PIL Processor-in-the-Loop Simulink MATLAB model-based
% @Author: CSA
% @Copyright: (C) 1989-2024 Lauterbach GmbH, licensed for use with TRACE32(R) only
% --------------------------------------------------------------------------------
% $Id: t32xil_tc_ppc_diab.m 8277 2024-10-28 09:04:56Z csax $


%% Creates a generic ToolchainInfo object for TRACE32 XIL
function toolchain = t32xil_tc_ppc_diab

toolchain = coder.make.ToolchainInfo('SupportedLanguages', 'Asm/C', 'BuildArtifact', 'gmake makefile');
toolchain.Name = 'TRACE32 XIL Diab Compiler Power Architecture | gmake makefile';
toolchain.Platform  = computer('arch');
toolchain.SupportedVersion = '5.8.0.0';


toolchain.addAttribute('TransformPathsWithSpaces', true);  % Escape paths containing spaces if enabled
toolchain.addAttribute('RequiresCommandFile', false);  % Handle long archiver/linker calls on Windows systems if enabled
toolchain.addAttribute('SupportsUNCPaths', false);  % Support UNC paths on Windows if enabled
toolchain.addAttribute('SupportsDoubleQuotes', false);  % Wrap path in double quotes if enabled
toolchain.addAttribute('RequiresBatchFile', true);  % Creates a batch file that execute the generated makefile if enabled
toolchain.addAttribute('LinkerLibraryPrefix', '')  % Append prefix to static library arguments


%% Run the required setup scripts for this toolchain
% toolchain.ShellSetup{1} = '';


%% Set macros that are exported to the created makefile
toolchain.addMacro('CPU', '-tPPC8610EH:simple');
toolchain.addMacro('LIBS', '-lc -lm');

toolchain.addMacro('AS_OPTS', '$(CPU) -g');
toolchain.addMacro('CC_OPTS', '$(CPU) -g -c -Xsmall-const=8192 -Xsmall-data=8192');
toolchain.addMacro('AR_OPTS', '');

toolchain.addMacro('LD_OPTS', '$(CPU) -Xelf -e _start');
% tc.addIntrinsicMacros({'<macro>', ...'});


%% Customize the assembler
assembler = toolchain.getBuildTool('Assembler');

assembler.setName('Diab DAS');
assembler.setCommand('C:/diab/5.8.0.0-2/WIN32/bin/das');

assembler.setDirective('PreprocessorDefine', '-D');
assembler.setDirective('Debug', '-g');
assembler.setDirective('OutputFlag', '-o');

assembler.setFileExtension('Source', '.s');
assembler.setFileExtension('Object', '.o');

assembler.setCommandPattern('|>TOOL<| |>TOOL_OPTIONS<| |>OUTPUT_FLAG<| |>OUTPUT<|');


%% Customize the C compiler
compiler = toolchain.getBuildTool('C Compiler');

assembler.setName('Diab DCC');
compiler.setCommand('C:/diab/5.8.0.0-2/WIN32/bin/dcc');

compiler.setDirective('IncludeSearchPath', '-I');
compiler.setDirective('PreprocessorDefine', '-D');
compiler.setDirective('PreprocessFile', '-P');
compiler.setDirective('CompileFlag', '-c');
compiler.setDirective('Debug', '-g');
compiler.setDirective('OutputFlag', '-o');

compiler.setFileExtension('Source', '.c');
compiler.setFileExtension('Header', '.h');
compiler.setFileExtension('Object', '.o');

compiler.setCommandPattern('|>TOOL<| |>TOOL_OPTIONS<| |>OUTPUT_FLAG<| |>OUTPUT<|');

compiler.Sources = {''};
compiler.IncludePaths = {'$(TARGET_DIR)'};
compiler.Libraries = {''};


%% Customize the linker
linker = toolchain.getBuildTool('Linker');

linker.setName('Diab DLD');
linker.setCommand('C:/diab/5.8.0.0-2/WIN32/bin/dld');

linker.setDirective('Library', '-l');
linker.setDirective('LibrarySearchPath', '-L');
linker.setDirective('OutputFlag', '-o');

linker.setFileExtension('Executable', '.elf');
linker.setFileExtension('Shared Library', '.dll');

linker.setCommandPattern('|>TOOL<| |>TOOL_OPTIONS<| |>OUTPUT_FLAG<| |>OUTPUT<|');


%% Customize the archiver
archiver = toolchain.getBuildTool('Archiver');

archiver.setName('Diab DAR');
archiver.setCommand('C:/diab/5.8.0.0-2/WIN32/bin/dar');

archiver.setDirective('OutputFlag', '-r');

archiver.setFileExtension('Static Library', '.a');

archiver.setCommandPattern('|>TOOL<| |>TOOL_OPTIONS<| |>OUTPUT_FLAG<| |>OUTPUT<|');


%% Customize the builder application
toolchain.setBuilderApplication(toolchain.Platform);


%% Customize the build process
fast_build_opts = {'-O'};
fast_run_opts = {'-Xsize-opt'};
debug_build_opts = {''};
assembler_opts = '$(AS_OPTS)';
compiler_opts = '$(CC_OPTS)';
linker_opts = {'$(LD_OPTS)'};
archiver_opts = {'$(AR_OPTS)'};

config = toolchain.getBuildConfiguration('Faster Builds');
config.setOption('Assembler', assembler_opts);
config.setOption('C Compiler', horzcat(compiler_opts, fast_build_opts));
config.setOption('Linker', linker_opts);
config.setOption('Archiver', archiver_opts);

config = toolchain.getBuildConfiguration('Faster Runs');
config.setOption('Assembler', assembler_opts);
config.setOption('C Compiler', horzcat(compiler_opts, fast_run_opts));
config.setOption('Linker', linker_opts);
config.setOption('Archiver',archiver_opts);

config = toolchain.getBuildConfiguration('Debug');
config.setOption('Assembler', assembler_opts);
config.setOption('C Compiler', horzcat(compiler_opts, debug_build_opts));
config.setOption('Linker', linker_opts);
config.setOption('Archiver', horzcat(archiver_opts));

toolchain.setBuildConfigurationOption('all', 'Make Tool', '-f $(MAKEFILE)');

