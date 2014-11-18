initialization
initializeWithByteSize: byteSize "<Integer>" for: anInterpreter "<StackInterpreter>" "^<Array of: <Integer>"
	"Initialize the stackPages memory for simulation."
	<doNotGenerate>
	interpreter := anInterpreter.
	objectMemory := anInterpreter objectMemory.
	^stackMemory := Array new: byteSize / objectMemory wordSize withAll: 0