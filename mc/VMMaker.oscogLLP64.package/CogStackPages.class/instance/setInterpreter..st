initialization
setInterpreter: anInterpreter
	"Initialize the stackPages memory for simulation.  To keep access monitoring
	 in one place we defer to the coInterpreter for accessing memory."
	<doNotGenerate>
	coInterpreter := anInterpreter.
	objectMemory := coInterpreter objectMemory