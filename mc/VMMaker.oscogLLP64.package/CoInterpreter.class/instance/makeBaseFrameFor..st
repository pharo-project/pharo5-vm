frame access
makeBaseFrameFor: aContext "<Integer>"
	"Marry aContext with the base frame of a new stack page.  Build the base
	 frame to reflect the context's state.  Answer the new page.  Override to
	 hold the caller context in a different place,  In the StackInterpreter we use
	 the caller saved ip, but in the Cog VM caller saved ip is the ceBaseReturn:
	 trampoline.  Simply hold the caller context in the first word of the stack."
	<returnTypeC: #'StackPage *'>
	| page pointer theMethod theIP numArgs stackPtrIndex maybeClosure rcvr |
	<inline: false>
	<var: #page type: #'StackPage *'>
	<var: #pointer type: #'char *'>
	<var: #cogMethod type: #'CogMethod *'>
	"theIP must be typed as signed because it is assigned ceCannotResumePC and so maybe implicitly typed as unsigned."
	<var: #theIP type: #sqInt>
	self assert: (objectMemory isContext: aContext).
	self assert: (self isSingleContext: aContext).
	self assert: (objectMemory goodContextSize: aContext).
	theIP := objectMemory fetchPointer: InstructionPointerIndex ofObject: aContext.
	self assert: HasBeenReturnedFromMCPC < 0.
	theIP := (objectMemory isIntegerObject: theIP)
				ifTrue: [objectMemory integerValueOf: theIP]
				ifFalse: [HasBeenReturnedFromMCPC].
	theMethod := objectMemory followObjField: MethodIndex ofObject: aContext.
	page := stackPages newStackPage.
	"first word on stack is caller context of base frame"
	stackPages
		longAt: (pointer := page baseAddress)
		put: (objectMemory followObjField: SenderIndex ofObject: aContext).
	"second word is the context itself; needed for cannotReturn processing; see ceBaseReturn:."
	stackPages
		longAt: (pointer := pointer - objectMemory wordSize)
		put: aContext.
	rcvr := objectMemory followField: ReceiverIndex ofObject: aContext.
	"If the frame is a closure activation then the closure should be on the stack in
	 the pushed receiver position (closures receive the value[:value:] messages).
	 Otherwise it should be the receiver proper."
	maybeClosure := objectMemory fetchPointer: ClosureIndex ofObject: aContext.
	maybeClosure ~= objectMemory nilObject
		ifTrue:
			[(objectMemory isForwarded: maybeClosure) ifTrue:
				[maybeClosure := objectMemory fixFollowedField: ClosureIndex ofObject: aContext withInitialValue: maybeClosure].
			 numArgs := self argumentCountOfClosure: maybeClosure.
			 stackPages
				longAt: (pointer := pointer - objectMemory wordSize)
				put: maybeClosure]
		ifFalse:
			[| header |
			 header := objectMemory methodHeaderOf: theMethod.
			 numArgs := self argumentCountOfMethodHeader: header.
			 "If this is a synthetic context its IP could be pointing at the CallPrimitive opcode.  If so, skip it."
			 ((self methodHeaderHasPrimitive: header)
			  and: [theIP = (1 + (objectMemory lastPointerOfMethodHeader: header))]) ifTrue:
				[theIP := theIP + (self sizeOfCallPrimitiveBytecode: header)].
			 stackPages
				longAt: (pointer := pointer - objectMemory wordSize)
				put: rcvr].
	"Put the arguments on the stack"
	1 to: numArgs do:
		[:i|
		stackPages
			longAt: (pointer := pointer - objectMemory wordSize)
			put: (objectMemory fetchPointer: ReceiverIndex + i ofObject: aContext)].
	"saved caller ip is base return trampoline"
	stackPages
		longAt: (pointer := pointer - objectMemory wordSize)
		put: cogit ceBaseFrameReturnPC.
	"base frame's saved fp is null"
	stackPages
		longAt: (pointer := pointer - objectMemory wordSize)
		put: 0.
	"N.B.  Don't set the baseFP, which marks the page as in use, until after
	 ensureMethodIsCogged: and/or instructionPointer:forContext:frame:. These
	 can cause a compiled code compaction which, if marked as in use, will
	 examine this partially initialized page and crash."
	page headFP: pointer.
	"Create either a machine code frame or an interpreter frame based on the pc.  If the pc is -ve
	 it is a machine code pc and so we produce a machine code frame.  If +ve an interpreter frame.
	 N.B. Do *not* change this to try and map from a bytecode pc to a machine code frame under
	 any circumstances.  See ensureContextIsExecutionSafeAfterAssignToStackPointer:"
	theIP < 0
		ifTrue:
			[| cogMethod |
			 "Since we would have to generate a machine-code method to be able to map
			  the native pc anyway we should create a native method and native frame."
			 cogMethod := self ensureMethodIsCogged: theMethod.
			 theMethod := cogMethod asInteger.
			 maybeClosure ~= objectMemory nilObject
				ifTrue:
					[(self isVanillaBlockClosure: maybeClosure)
						ifTrue:
							["If the pc is the special HasBeenReturnedFromMCPC pc set the pc
							  appropriately so that the frame stays in the cannotReturn: state."
							 theIP = HasBeenReturnedFromMCPC
								ifTrue:
									[theMethod := (cogit findMethodForStartBcpc: (self startPCOfClosure: maybeClosure)
														inHomeMethod: (self cCoerceSimple: theMethod
																			to: #'CogMethod *')) asInteger.
									 theMethod = 0 ifTrue:
										[self error: 'cannot find machine code block matching closure''s startpc'].
									 theIP := cogit ceCannotResumePC]
								ifFalse:
									[self assert: (theIP signedBitShift: -16) < -1. "See contextInstructionPointer:frame:"
									 theMethod := theMethod - ((theIP signedBitShift: -16) * cogit blockAlignment).
									 theIP := theMethod - theIP signedIntFromShort]]
						ifFalse:
							[self assert: (theIP signedBitShift: -16) >= -1.
							 "If the pc is the special HasBeenReturnedFromMCPC pc set the pc
							  appropriately so that the frame stays in the cannotReturn: state."
							 theIP := theIP = HasBeenReturnedFromMCPC
										ifTrue: [cogit ceCannotResumePC]
										ifFalse: [theMethod asInteger - theIP]].
					 stackPages
						longAt: (pointer := pointer - objectMemory wordSize)
						put: theMethod + MFMethodFlagHasContextFlag + MFMethodFlagIsBlockFlag]
				ifFalse:
					[self assert: (theIP signedBitShift: -16) >= -1.
					 "If the pc is the special HasBeenReturnedFromMCPC pc set the pc
					  appropriately so that the frame stays in the cannotReturn: state."
					 theIP := theIP = HasBeenReturnedFromMCPC
								ifTrue: [cogit ceCannotResumePC]
								ifFalse: [theMethod asInteger - theIP].
					 stackPages
						longAt: (pointer := pointer - objectMemory wordSize)
						put: theMethod + MFMethodFlagHasContextFlag].
			 stackPages
				longAt: (pointer := pointer - objectMemory wordSize)
				put: aContext]
		ifFalse:
			[stackPages
				longAt: (pointer := pointer - objectMemory wordSize)
				put: theMethod.
			stackPages
				longAt: (pointer := pointer - objectMemory wordSize)
				put: aContext.
			stackPages
				longAt: (pointer := pointer - objectMemory wordSize)
				put: (self encodeFrameFieldHasContext: true isBlock: maybeClosure ~= objectMemory nilObject numArgs: numArgs).
			stackPages
				longAt: (pointer := pointer - objectMemory wordSize)
				put: 0. "FoxIFSavedIP"
			theIP := self iframeInstructionPointerForIndex: theIP method: theMethod].
	page baseFP: page headFP.
	self assert: (self frameHasContext: page baseFP).
	self assert: (self frameNumArgs: page baseFP) == numArgs.
	stackPages
		longAt: (pointer := pointer - objectMemory wordSize)
		put: rcvr.
	stackPtrIndex := self quickFetchInteger: StackPointerIndex ofObject: aContext.
	self assert: ReceiverIndex + stackPtrIndex < (objectMemory lengthOf: aContext).
	numArgs + 1 to: stackPtrIndex do:
		[:i|
		stackPages
			longAt: (pointer := pointer - objectMemory wordSize)
			put: (objectMemory fetchPointer: ReceiverIndex + i ofObject: aContext)].
	"top of stack is the instruction pointer"
	stackPages longAt: (pointer := pointer - objectMemory wordSize) put: theIP.
	page headSP: pointer.
	self assert: (self context: aContext hasValidInversePCMappingOf: theIP in: page baseFP).

	"Mark context as married by setting its sender to the frame pointer plus SmallInteger
	 tags and the InstructionPointer to the saved fp (which ensures correct alignment
	 w.r.t. the frame when we check for validity) plus SmallInteger tags."
	objectMemory storePointerUnchecked: SenderIndex
		ofObject: aContext
		withValue: (self withSmallIntegerTags: page baseFP).
	objectMemory storePointerUnchecked: InstructionPointerIndex
		ofObject: aContext
		withValue: (self withSmallIntegerTags: 0).
	self assert: (objectMemory isIntegerObject: (objectMemory fetchPointer: SenderIndex ofObject: aContext)).
	self assert: (self frameOfMarriedContext: aContext) = page baseFP.
	self assert: (self validStackPageBaseFrame: page).
	^page