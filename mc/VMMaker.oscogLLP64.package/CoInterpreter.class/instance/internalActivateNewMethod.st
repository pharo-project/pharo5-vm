message sending
internalActivateNewMethod
	| methodHeader numTemps rcvr errorCode switched |
	<inline: true>

	methodHeader := self rawHeaderOf: newMethod.
	self assert: (self isCogMethodReference: methodHeader) not.
	numTemps := self temporaryCountOfMethodHeader: methodHeader.
	self assert: argumentCount = (self argumentCountOfMethodHeader: methodHeader).
	rcvr := self internalStackValue: argumentCount. "could new rcvr be set at point of send?"
	self assert: (objectMemory isOopForwarded: rcvr) not.

	self internalPush: localIP.
	self internalPush: localFP.
	localFP := localSP.
	self internalPush: newMethod.
	self setMethod: newMethod methodHeader: methodHeader.
	self internalPush: objectMemory nilObject. "FxThisContext field"
	self internalPush: (self
						encodeFrameFieldHasContext: false
						isBlock: false
						numArgs: (self argumentCountOfMethodHeader: methodHeader)).
	self internalPush: 0. "FoxIFSavedIP"
	self internalPush: rcvr.

	"Initialize temps..."
	argumentCount + 1 to: numTemps do:
		[:i | self internalPush: objectMemory nilObject].

	"-1 to account for pre-increment in fetchNextBytecode"
	localIP := self pointerForOop: (self initialPCForHeader: methodHeader method: newMethod) - 1.

	(self methodHeaderHasPrimitive: methodHeader) ifTrue:
		["Skip the CallPrimitive bytecode, if it's there, and store the error code if the method starts
		  with a long store temp.  Strictly no need to skip the store because it's effectively a noop."
		 localIP := localIP + (self sizeOfCallPrimitiveBytecode: methodHeader).
		 primFailCode ~= 0 ifTrue:
			[(objectMemory byteAt: localIP + 1)
			  = (self longStoreBytecodeForHeader: methodHeader) ifTrue:
				[errorCode := self getErrorObjectFromPrimFailCode.
				 self internalStackTopPut: errorCode "nil if primFailCode == 1, or primFailCode"].
			 primFailCode := 0]].

	self assert: (self frameNumArgs: localFP) == argumentCount.
	self assert: (self frameIsBlockActivation: localFP) not.
	self assert: (self frameHasContext: localFP) not.

	"Now check for stack overflow or an event (interrupt, must scavenge, etc)."
	localSP < stackLimit ifTrue:
		[self externalizeIPandSP.
		 switched := self handleStackOverflowOrEventAllowContextSwitch:
						(self canContextSwitchIfActivating: newMethod header: methodHeader).
		 self returnToExecutive: true postContextSwitch: switched.
		 self internalizeIPandSP]