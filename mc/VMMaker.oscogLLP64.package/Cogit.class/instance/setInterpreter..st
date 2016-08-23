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
	processor := ProcessorClass new.
	simulatedAddresses := Dictionary new.
	simulatedTrampolines := Dictionary new.
	simulatedVariableGetters := Dictionary new.
	simulatedVariableSetters := Dictionary new.
	traceStores := 0.
	traceFlags := (self class initializationOptions at: #recordPrimTrace ifAbsent: [true])
					ifTrue: [8] "record prim trace on by default (see Cogit class>>decareCVarsIn:)"
					ifFalse: [0].
	debugPrimCallStackOffset := 0.
	singleStep := printRegisters := printInstructions := clickConfirm := false.
	backEnd := CogCompilerClass for: self.
	methodLabel := CogCompilerClass for: self.
	(literalsManager := backEnd class literalsManagerClass new) cogit: self.
	ordinarySendTrampolines := CArrayAccessor on: (Array new: NumSendTrampolines).
	superSendTrampolines := CArrayAccessor on: (Array new: NumSendTrampolines).
	BytecodeSetHasDirectedSuperSend ifTrue:
		[directedSuperSendTrampolines := CArrayAccessor on: (Array new: NumSendTrampolines)].
	NewspeakVM ifTrue:
		[selfSendTrampolines := CArrayAccessor on: (Array new: NumSendTrampolines).
		dynamicSuperSendTrampolines := CArrayAccessor on: (Array new: NumSendTrampolines).
		implicitReceiverSendTrampolines := CArrayAccessor on: (Array new: NumSendTrampolines).
		outerSendTrampolines := CArrayAccessor on: (Array new: NumSendTrampolines)].
	"debug metadata"
	objectReferencesInRuntime := CArrayAccessor on: (Array new: NumObjRefsInRuntime).
	runtimeObjectRefIndex := 0.
	"debug metadata"
	trampolineAddresses := CArrayAccessor on: (Array new: NumTrampolines * 2).
	trampolineTableIndex := 0.

	extA := extB := 0.

	compilationTrace ifNil: [compilationTrace := self class initializationOptions at: #compilationTrace ifAbsent: [0]].
	debugOpcodeIndices := self class initializationOptions at: #debugOpcodeIndices ifAbsent: [Set new].
	debugBytecodePointers := self class initializationOptions at: #debugBytecodePointers ifAbsent: [Set new]