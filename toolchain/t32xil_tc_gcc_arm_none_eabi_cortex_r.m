% --------------------------------------------------------------------------------
% @Title: ToolchainInfo object for GCC arm-none-eabi Cortex-R
% @Description: 
%   Creates a generic ToolchainInfo object for TRAC32 XIL with GCC arm-none-eabi
%   for Cortex-R targets. A toolchain object describes the basic information of
%   the toolchain.
%   
% @Keywords: PIL Processor-in-the-Loop Simulink MATLAB model-based
% @Author: CSA
% @Copyright: (C) 1989-2018 Lauterbach GmbH, licensed for use with TRACE32(R) only
% --------------------------------------------------------------------------------
% $Id: t32xil_tc_gcc_arm_none_eabi_cortex_r.m 3029 2018-09-11 15:27:37Z csax $


%% Creates a generic ToolchainInfo object for TRACE32 XIL
function toolchain = t32xil_tc_gcc_arm_none_eabi_cortex_r
toolchain = coder.make.ToolchainInfo('SupportedLanguages', 'Asm/C', 'BuildArtifact', 'gmake makefile');
toolchain.Name = 'TRACE32 XIL GCC arm-none-eabi Cortex-R | gmake makefile';
toolchain.Platform  = computer('arch');
toolchain.SupportedVersion = '5.4.1';

toolchain.addAttribute('TransformPathsWithSpaces', 0);  % Escape paths containing spaces if enabled
toolchain.addAttribute('RequiresCommandFile', 0);  % Handle long archiver/linker calls on Windows systems if enabled
toolchain.addAttribute('SupportsUNCPaths', 0);  % Support UNC paths on Windows if enabled 
toolchain.addAttribute('SupportsDoubleQuotes', false);  % Wrap path in double quotes if enabled 
toolchain.addAttribute('RequiresBatchFile', true);  % Creates a batch file that execute the generated makefile if enabled


%% Run the required setup scripts for this toolchain
% toolchain.ShellSetup{1} = '';


%% Set macros that are exported to the created makefile
toolchain.addMacro('T32XIL_PATH', 'C:/T32/demo/env/matlabsimulink/t32xil/');
toolchain.addMacro('TARGET_HEADER', '$(T32XIL_PATH)targets/arm/');
toolchain.addMacro('LIB_FILES', '-lgcc -lc -lm');

toolchain.addMacro('AS_OPTS', '-g -c -Wall -march=armv7-r -marm -mlittle-endian -Wa,--gdwarf2 -xassembler-with-cpp');
toolchain.addMacro('CC_OPTS', '-g -c -Wall -march=armv7-r -marm -mlittle-endian -fshort-enums');
toolchain.addMacro('LD_OPTS', '-Wall -march=armv7-r -marm -mlittle-endian -Wl,--nmagic -nodefaultlibs -nostartfiles');
toolchain.addMacro('AR_OPTS', '');
% tc.addIntrinsicMacros({'<macro>', ...'});


%% Customize the assembler
assembler = toolchain.getBuildTool('Assembler');

assembler.setName('GNU AS');
assembler.setCommand('arm-none-eabi-gcc');
assembler.setPath('C:/Compiler/GNU_Tools_ARM_Embedded/5.4_2016q3/bin');

assembler.setDirective('PreprocessorDefine', '-D');
assembler.setDirective('Debug', '-g');
assembler.setDirective('OutputFlag', '-o');

assembler.setFileExtension('Source', '.s');
assembler.setFileExtension('Object', '.o');

assembler.setCommandPattern('|>TOOL<| |>TOOL_OPTIONS<| |>OUTPUT_FLAG<| |>OUTPUT<|');


%% Customize the C compiler
compiler = toolchain.getBuildTool('C Compiler');

compiler.setName('GNU GCC');
compiler.setCommand('arm-none-eabi-gcc');
compiler.setPath('C:/Compiler/GNU_Tools_ARM_Embedded/5.4_2016q3/bin');

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
compiler.IncludePaths = {'$(TARGET_HEADER)'};
compiler.Libraries = {'-Wl,--start-group $(LIB_FILES) -Wl,--end-group' };


%% Customize the linker
linker = toolchain.getBuildTool('Linker');

linker.setName('GNU LD');
linker.setCommand('arm-none-eabi-gcc');
linker.setPath('C:/Compiler/GNU_Tools_ARM_Embedded/5.4_2016q3/bin');

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

archiver.setName('GNU AR');
archiver.setCommand('arm-none-eabi-ar');
archiver.setPath('C:/Compiler/GNU_Tools_ARM_Embedded/5.4_2016q3/bin');

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
config.setOption('Linker', linker_opts);
config.setOption('Archiver', archiver_opts);

config = toolchain.getBuildConfiguration('Faster Runs');
config.setOption('Assembler', horzcat(assembler_opts, fast_run_opts));
config.setOption('C Compiler', horzcat(compiler_opts, fast_run_opts));
config.setOption('Linker', linker_opts);
config.setOption('Archiver',archiver_opts);

config = toolchain.getBuildConfiguration('Debug');
config.setOption('Assembler', horzcat(assembler_opts, debug_build_opts));
config.setOption('C Compiler', horzcat(compiler_opts, debug_build_opts));
config.setOption('Linker', horzcat(linker_opts));
config.setOption('Archiver', horzcat(archiver_opts));

toolchain.setBuildConfigurationOption('all', 'Make Tool', '-f $(MAKEFILE)');

