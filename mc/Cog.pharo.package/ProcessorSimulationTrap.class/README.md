A ProcessorSimulationTrap is an Error raised by CogProcessorAliens which allow the VMSimulator to fix the problem and resume execution.
I know where the problem occured (pc) and which instruction is next (nextpc), which field of the processor need be read/written and what type of memory access was the source of error.

I am created in #handleExecutionPrimitiveFailureIn:minimumAddress:readOnlyBelow: and associated methods. 
In the IA32 case, the type is managed by the OpcodeExecutionMap, using the first byte of the last instruction as index. 
In the ARM case, we need rely on a case statement, since no byte (sequence) is able to directly tell which type I am of.