initialization
setInterpreter: aCoInterpreter
	"Initialization of the code generator in the simulator.
	 These objects already exist in the generated C VM
	 or are used only in the simulation."
	<doNotGenerate>
	super setInterpreter: aCoInterpreter.
	externalPrimJumpOffsets := CArrayAccessor on: (Array new: MaxNumArgs + 1).
	externalPrimCallOffsets := CArrayAccessor on: (Array new: MaxNumArgs + 1)