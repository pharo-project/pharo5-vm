An AssemblerEncoderInterface is an abstract superclass for the interfaces between a BytecodeAssembler and a BytecodeEncoder.  These interfaces convert the assembly messages (see CompiledMethod>>abstractBytecodeMessages and InstructionStream interpretNextInstructionFor: et al) to the sizing and emitting messages implemented by BytecodeEncoder's subclasses.

Instance Variables
	assembler:		<BytecodeAssembler>
	encoder:		<BytecodeEncoder>