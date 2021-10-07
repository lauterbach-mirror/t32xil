% --------------------------------------------------------------------------------
% @Title: Register boards for TRACE32 DebugIO
% @Description:
%   Custom boards that use the TRACE32 DebugIO interface can be registered here.
%   To register a new board extend the list below.
%
% @Keywords: PIL Processor-in-the-Loop Simulink MATLAB model-based
% @Author: CSA
% @Copyright: (C) 1989-2021 Lauterbach GmbH, licensed for use with TRACE32(R) only
% --------------------------------------------------------------------------------
% $Id: t32boards.m 5574 2021-09-09 12:07:17Z csax $


function boards = t32boards()
    boards = {};

    boards{1} = struct( ...
        'Name', 'TRACE32 DebugIO for Arm', ...         % Create the board description
        'Processor', 'ARM Compatible-ARM Cortex' ...   % Associate the board with a processor
    );

    boards{2} = struct( ...
        'Name', 'TRACE32 DebugIO for TriCore', ...     % Create the board description
        'Processor', 'Infineon-TriCore' ...            % Associate the board with a processor
    );

end

