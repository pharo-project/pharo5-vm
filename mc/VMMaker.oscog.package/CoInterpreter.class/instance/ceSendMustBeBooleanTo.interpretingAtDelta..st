trampolines
ceSendMustBeBooleanTo: aNonBooleanObject interpretingAtDelta: jumpSize
	"For RegisterAllocatingCogit we want the address following a conditional branch not to be reachable, so we
	 don't have to generate code to reload registers.  Instead simply convert to an interpreter frame,
	 backup the pc to the branch, reenter the interpreter and hence retry the mustBeBoolean send therein."
	<api>
	| cogMethod methodObj methodHeader startBcpc |
	<var: 'cogMethod' type: #'CogBlockMethod *'>
	<var: 'p' type: #'char *'>
	self assert: (objectMemory addressCouldBeOop: aNonBooleanObject).
	cogMethod := self mframeCogMethod: framePointer.
	((self mframeIsBlockActivation: framePointer)
	 and: [cogMethod cmIsFullBlock not])
		ifTrue:
			[methodHeader := (self cCoerceSimple: cogMethod cmHomeMethod to: #'CogMethod *') methodHeader.
			 methodObj := (self cCoerceSimple: cogMethod cmHomeMethod to: #'CogMethod *') methodObject.
			 startBcpc := cogMethod startpc]
		ifFalse:
			[methodHeader := (self cCoerceSimple: cogMethod to: #'CogMethod *') methodHeader.
			 methodObj := (self cCoerceSimple: cogMethod to: #'CogMethod *') methodObject.
			 startBcpc := self startPCOfMethod: methodObj].

	"Map the machine code instructionPointer to the interpreter instructionPointer of the branch."
	instructionPointer := self popStack.
	instructionPointer := cogit bytecodePCFor: instructionPointer startBcpc: startBcpc in: cogMethod.
	instructionPointer := methodObj + objectMemory baseHeaderSize + instructionPointer - jumpSize - 1. "pre-decrement"

	"Make space for the two extra fields in an interpreter frame"
	stackPointer to: framePointer + FoxMFReceiver by: objectMemory wordSize do:
		[:p| | oop |
		 oop := objectMemory longAt: p.
		 objectMemory
			longAt: p - objectMemory wordSize - objectMemory wordSize
			put: (objectMemory longAt: p)].
	stackPointer := stackPointer - objectMemory wordSize - objectMemory wordSize.
	self push: aNonBooleanObject.
	"Fill in the fields"
	objectMemory
		longAt: framePointer + FoxIFrameFlags
			put: (self
					encodeFrameFieldHasContext: (self mframeHasContext: framePointer)
					isBlock: (self mframeIsBlockActivation: framePointer)
					numArgs: cogMethod cmNumArgs);
		longAt: framePointer + FoxIFSavedIP
			put: 0;
		longAt: framePointer + FoxMethod
			put: methodObj.

	"and now reenter the interpreter..."
	self setMethod: methodObj methodHeader: methodHeader.
	self siglong: reenterInterpreter jmp: ReturnToInterpreter.