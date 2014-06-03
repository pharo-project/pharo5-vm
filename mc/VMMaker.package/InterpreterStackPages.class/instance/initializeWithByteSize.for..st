initialization
initializeWithByteSize: byteSize "<Integer>" for: anInterpreter "<StackInterpreter>" "^<Array of: <Integer>"
	"Initialize the stackPages memory for simulation."
	<doNotGenerate>
	interpreter := anInterpreter.
	^stackMemory := Array new: byteSize / BytesPerWord withAll: 0