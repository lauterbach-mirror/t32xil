interface = struct('in1', 'input1', 'in2', 'input2', 'in3', 'input3',...
                   'out1', [], 'out2', []);
stack = struct;
stack.name = 'System Stack';
stack.startAddress = '807fe00';
stack.endAddress =   '8080000';
stack.growthDirection = 'DOWN';
stack.pattern = 'a5';
stack.maxUsageInBytes = '';
stack.maxUsageInPercent = '';