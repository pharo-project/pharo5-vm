initialization
initializeWithByteSize: byteSize "<Integer>" for: anInterpreter "<CoInterpreter>" "^<Array of: <Integer>"
	"Initialize the stackPages memory for simulation. Answer the base address of the memory."
	self subclassResponsibility