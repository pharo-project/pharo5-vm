message sending
activateNewMethod
	| methodHeader numArgs numTemps rcvr errorCode inInterpreter switched |

	methodHeader := objectMemory methodHeaderOf: newMethod.
	numTemps := self temporaryCountOfMethodHeader: methodHeader.
	numArgs := self argumentCountOfMethodHeader: methodHeader.

	rcvr := self stackValue: numArgs. "could new rcvr be set at point of send?"
	self assert: (objectMemory isOopForwarded: rcvr) not.

	"Because this is an uncogged method we need to continue via the interpreter.
	 We could have been reached either from the interpreter, in which case we
	 should simply return, or from a machine code frame or from a compiled
	 primitive.  In these latter two cases we must longjmp back to the interpreter.
	 The instructionPointer tells us which path we took.
	 If the sender was an interpreter frame but called through a (failing) primitive
	 then make sure we restore the saved instruction pointer and avoid pushing
	 ceReturnToInterpreterPC which is only valid between an interpreter caller
	 frame and a machine code callee frame."
	(inInterpreter := instructionPointer >= objectMemory startOfMemory) ifFalse:
		[instructionPointer = cogit ceReturnToInterpreterPC ifTrue:
			[instructionPointer := self iframeSavedIP: framePointer]].
	self push: instructionPointer.
	self push: framePointer.
	framePointer := stackPointer.
	self push: newMethod.
	self setMethod: newMethod methodHeader: methodHeader.
	self push: objectMemory nilObject. "FxThisContext field"
	self push: (self encodeFrameFieldHasContext: false isBlock: false numArgs: numArgs).
	self push: 0. "FoxIFSavedIP"
	self push: rcvr.

	"clear remaining temps to nil"
	numArgs+1 to: numTemps do:
		[:i | self push: objectMemory nilObject].

	instructionPointer := (self initialPCForHeader: methodHeader method: newMethod) - 1.

	(self methodHeaderHasPrimitive: methodHeader) ifTrue:
		["Skip the CallPrimitive bytecode, if it's there, and store the error code if the method starts
		  with a long store temp.  Strictly no need to skip the store because it's effectively a noop."
		 instructionPointer := instructionPointer + (self sizeOfCallPrimitiveBytecode: methodHeader).
		 primFailCode ~= 0 ifTrue:
			[(objectMemory byteAt: instructionPointer + 1)
			  = (self longStoreBytecodeForHeader: methodHeader) ifTrue:
				[errorCode := self getErrorObjectFromPrimFailCode.
				 self stackTopPut: errorCode "nil if primFailCode == 1, or primFailCode"].
			 primFailCode := 0]].

	"Now check for stack overflow or an event (interrupt, must scavenge, etc)."
	switched := true.
	stackPointer < stackLimit ifTrue:
		[switched := self handleStackOverflowOrEventAllowContextSwitch:
							(self canContextSwitchIfActivating: newMethod header: methodHeader)].
	self returnToExecutive: inInterpreter postContextSwitch: switched