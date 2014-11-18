initialization
setInterpreter: anInterpreter
	"Initialize the stackPages memory for simulation."
	<doNotGenerate>
	interpreter := anInterpreter.
	objectMemory := interpreter objectMemory