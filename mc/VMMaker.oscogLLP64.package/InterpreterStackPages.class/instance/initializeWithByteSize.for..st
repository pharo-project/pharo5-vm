initialization
initializeWithByteSize: byteSize "<Integer>" for: anInterpreter "<StackInterpreter>" "^<Array of: <Integer>"
	"Initialize the stackPages memory for simulation. Answer the base address of the memory."
	<doNotGenerate>
	coInterpreter := anInterpreter.
	objectMemory := anInterpreter objectMemory.
	^stackMemory := Array new: byteSize / objectMemory wordSize withAll: 0