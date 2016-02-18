initialization
initializeWithByteSize: byteSize "<Integer>" for: anInterpreter "<CoInterpreter>" "^<Array of: <Integer>"
	"Initialize the stackPages memory for simulation.  To keep access monitoring
	 in one place we defer to the coInterpreter for accessing memory.  Answer the
	 base address of th ememory."
	<doNotGenerate>
	coInterpreter := anInterpreter.
	objectMemory := coInterpreter objectMemory.
	^anInterpreter stackZoneBase