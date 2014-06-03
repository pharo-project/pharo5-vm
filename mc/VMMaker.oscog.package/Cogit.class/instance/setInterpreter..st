initialization
setInterpreter: aCoInterpreter
	"Initialization of the code generator in the simulator.
	 These objects already exist in the generated C VM
	 or are used only in the simulation."
	<doNotGenerate>
	coInterpreter := aCoInterpreter.
	objectMemory := aCoInterpreter objectMemory.
	threadManager := aCoInterpreter threadManager. "N.B. may be nil"
	methodZone := CogMethodZone new.
	objectRepresentation := objectMemory objectRepresentationClass
								forCogit: self methodZone: methodZone.
	methodZone setInterpreter: aCoInterpreter
				objectRepresentation: objectRepresentation
				cogit: self.
	generatorTable := self class generatorTable.
	primitiveGeneratorTable := self class primitiveTable.
	processor := ProcessorClass new.
	simulatedAddresses := Dictionary new.
	simulatedTrampolines := Dictionary new.
	simulatedVariableGetters := Dictionary new.
	simulatedVariableSetters := Dictionary new.
	traceStores := 0.
	traceFlags := 8. "record prim trace on by default (see Cogit class>>decareCVarsIn:)"
	debugPrimCallStackOffset := 0.
	singleStep := printRegisters := printInstructions := clickConfirm := false.
	breakBlock ifNil: [self breakPC: breakPC].
	(backEnd := processor abstractInstructionCompilerClass new) cogit: self.
	(methodLabel := processor abstractInstructionCompilerClass new) cogit: self.
	sendTrampolines := CArrayAccessor on: (Array new: NumSendTrampolines).
	superSendTrampolines := CArrayAccessor on: (Array new: NumSendTrampolines).
	NewspeakVM ifTrue:
		[dynamicSuperSendTrampolines := CArrayAccessor on: (Array new: NumSendTrampolines)].
	"debug metadata"
	objectReferencesInRuntime := CArrayAccessor on: (Array new: NumObjRefsInRuntime).
	runtimeObjectRefIndex := 0.
	"debug metadata"
	trampolineAddresses := CArrayAccessor on: (Array new: NumTrampolines * 2).
	trampolineTableIndex := 0.

	compilationTrace ifNil: [compilationTrace := 0].
	extA := extB := 0