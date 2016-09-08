message sending
justActivateNewMethod
	| methodHeader activateCogMethod cogMethod numArgs numTemps rcvr errorCode initialIP |
	<var: #cogMethod type: #'CogMethod *'>
	<var: #initialIP type: #usqInt>
	<inline: true>
	methodHeader := self rawHeaderOf: newMethod.
	(activateCogMethod := self isCogMethodReference: methodHeader) ifTrue:
		[cogMethod := self cCoerceSimple: methodHeader to: #'CogMethod *'.
		 methodHeader := cogMethod methodHeader].
	numTemps := self temporaryCountOfMethodHeader: methodHeader.
	numArgs := self argumentCountOfMethodHeader: methodHeader.

	rcvr := self stackValue: numArgs. "could new rcvr be set at point of send?"
	self assert: (objectMemory isOopForwarded: rcvr) not.

	(activateCogMethod
	and: [instructionPointer asUnsignedInteger >= objectMemory startOfMemory]) ifTrue:
		[self iframeSavedIP: framePointer put: instructionPointer.
		 instructionPointer := cogit ceReturnToInterpreterPC].
	self push: instructionPointer.
	self push: framePointer.
	framePointer := stackPointer.
	initialIP := self initialPCForHeader: methodHeader method: newMethod.
	activateCogMethod
		ifTrue:
			[self push: cogMethod asUnsignedInteger.
			 self push: objectMemory nilObject. "FoxThisContext field"
			 instructionPointer := cogMethod asUnsignedInteger + cogMethod stackCheckOffset]
		ifFalse:
			[self push: newMethod.
			 self setMethod: newMethod methodHeader: methodHeader.
			 self push: objectMemory nilObject. "FoxThisContext field"
			 self push: (self encodeFrameFieldHasContext: false isBlock: false numArgs: numArgs).
			 self push: 0. "FoxIFSavedIP"
			 instructionPointer := initialIP - 1].
	self push: rcvr.

	"clear remaining temps to nil"
	numArgs+1 to: numTemps do:
		[:i | self push: objectMemory nilObject].

	(self methodHeaderHasPrimitive: methodHeader) ifTrue:
		["Skip the CallPrimitive bytecode, if it's there, and store the error code if the method starts
		  with a long store temp.  Strictly no need to skip the store because it's effectively a noop."
		 initialIP := initialIP + (self sizeOfCallPrimitiveBytecode: methodHeader).
		activateCogMethod ifFalse:
			[instructionPointer := initialIP].
		 primFailCode ~= 0 ifTrue:
			[(objectMemory byteAt: initialIP + 1)
			  = (self longStoreBytecodeForHeader: methodHeader) ifTrue:
				[errorCode := self getErrorObjectFromPrimFailCode.
				 self stackTopPut: errorCode "nil if primFailCode == 1, or primFailCode"].
			 primFailCode := 0]].

	^methodHeader