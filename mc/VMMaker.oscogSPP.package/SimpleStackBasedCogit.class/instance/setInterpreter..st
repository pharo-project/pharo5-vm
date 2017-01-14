initialization
setInterpreter: aCoInterpreter
	"Initialization of the code generator in the simulator.
	 These objects already exist in the generated C VM
	 or are used only in the simulation."
	<doNotGenerate>
	super setInterpreter: aCoInterpreter.
	primitiveGeneratorTable := self class primitiveTable.
	externalPrimJumpOffsets := CArrayAccessor on: (Array new: MaxNumArgs + 1).
	externalPrimCallOffsets := CArrayAccessor on: (Array new: MaxNumArgs + 1).
	externalSetPrimOffsets := CArrayAccessor on: (Array new: MaxNumArgs + 1)