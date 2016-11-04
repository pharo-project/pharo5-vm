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

	simStack := CArrayAccessor on: ((1 to: self class simStackSlots) collect: [:i| self simStackEntryClass new cogit: self]).
	simNativeStack := CArrayAccessor on: ((1 to: self class simStackSlots) collect: [:i| self simStackNativeEntryClass new cogit: self]).
	simSelf := self simStackEntryClass new cogit: self.
	optStatus := CogSSOptStatus new.

	debugFixupBreaks := self class initializationOptions at: #debugFixupBreaks ifAbsent: [Set new].

	numPushNilsFunction := self class numPushNilsFunction.
	pushNilSizeFunction := self class pushNilSizeFunction