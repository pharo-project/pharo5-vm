A BytecodeAssembler is something that converts an AssemblerMethod into a CompiledMethod.

Instance Variables
	code:		<AssemblerMethod>
	encoder:	<BytecodeEncoder>
	sizes:		<SequenceableCollection>

code
	- the input assembly method

encoder
	- the encoder that generates instructions

sizes
	- the size of each corresponding bytecode in code's instructions