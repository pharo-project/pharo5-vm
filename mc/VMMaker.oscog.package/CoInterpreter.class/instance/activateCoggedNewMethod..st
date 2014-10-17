message sending
activateCoggedNewMethod: inInterpreter
	"Activate newMethod when newMethod has been cogged, i.e. create a machine-code frame and (re)enter machine-code."
	| methodHeader cogMethod rcvr numTemps errorCode switched |
	<var: #cogMethod type: #'CogMethod *'>

	methodHeader := self rawHeaderOf: newMethod.
	self assert: (self isCogMethodReference: methodHeader).

	cogMethod := self cCoerceSimple: methodHeader to: #'CogMethod *'.
	methodHeader := cogMethod methodHeader.
	rcvr := self stackValue: cogMethod cmNumArgs. "could new rcvr be set at point of send?"
	self push: instructionPointer.
	cogMethod stackCheckOffset = 0 ifTrue:
		["frameless method; nothing to activate..."
		 cogit numRegArgs > 0 ifTrue: "dont use and: so as to get Slang to inline cogit numRegArgs > 0"
			[cogMethod cmNumArgs <= cogit numRegArgs ifTrue:
				[self callRegisterArgCogMethod: cogMethod at: cogit noCheckEntryOffset receiver: rcvr]].
		 self push: cogMethod asInteger + cogit noCheckEntryOffset.
		 self push: rcvr.
		 cogit ceCallCogCodePopReceiverReg.
		 self error: 'should not be reached'].
	self push: framePointer.
	framePointer := stackPointer.
	self push: cogMethod asInteger.
	self push: objectMemory nilObject. "FxThisContext field"
	self push: rcvr.

	"clear remaining temps to nil"
	numTemps := self temporaryCountOfMethodHeader: methodHeader.
	cogMethod cmNumArgs + 1 to: numTemps do:
		[:i | self push: objectMemory nilObject].

	(self methodHeaderHasPrimitive: methodHeader) ifTrue:
		[| initialPC |
		 "Store the error code if the method starts with a long store temp.  No instructionPointer skip because we're heading for machine code."
		 initialPC := (self initialPCForHeader: methodHeader method: newMethod) + (self sizeOfCallPrimitiveBytecode: methodHeader).
		 primFailCode ~= 0 ifTrue:
			[(objectMemory byteAt: initialPC) = (self longStoreBytecodeForHeader: methodHeader) ifTrue:
				[errorCode := self getErrorObjectFromPrimFailCode.
				 self stackTopPut: errorCode "nil if primFailCode == 1, or primFailCode"].
			 primFailCode := 0]].

	"Now check for stack overflow or an event (interrupt, must scavenge, etc)."
	stackPointer >= stackLimit ifTrue:
		[self assert: cogMethod stackCheckOffset > cogit noCheckEntryOffset.
		 self push: cogMethod asInteger + cogMethod stackCheckOffset.
		 self push: rcvr.
		 cogit ceEnterCogCodePopReceiverReg.
		 self error: 'should not be reached'].
	instructionPointer := cogMethod asInteger + cogMethod stackCheckOffset.
	switched := self handleStackOverflowOrEventAllowContextSwitch: (self canContextSwitchIfActivating: newMethod header: methodHeader).
	self returnToExecutive: inInterpreter postContextSwitch: switched