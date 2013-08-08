initialization
setInterpreter: aCoInterpreter
	"Initialization of the code generator in the simulator.
	 These objects already exist in the generated C VM
	 or are used only in the simulation."
	<doNotGenerate>
	super setInterpreter: aCoInterpreter.

	methodAbortTrampolines := CArrayAccessor on: (Array new: self numRegArgs + 2).
	picAbortTrampolines := CArrayAccessor on: (Array new: self numRegArgs + 2).
	picMissTrampolines := CArrayAccessor on: (Array new: self numRegArgs + 2).

	simStack := CArrayAccessor on: ((1 to: 256) collect: [:i| CogSimStackEntry new cogit: self]).
	simSelf := CogSimStackEntry new cogit: self.
	optStatus := CogSSOptStatus new.

	debugFixupBreaks := Set new.
	debugBytecodePointers := Set new.

	isPushNilFunction := self class isPushNilFunction.
	pushNilSizeFunction := self class pushNilSizeFunction.