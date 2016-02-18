frame access
makeBaseFrameFor: aContext "<Integer>"
	"Marry aContext with the base frame of a new stack page.  Build the base
	 frame to reflect the context's state.  Answer the new page."
	<returnTypeC: #'StackPage *'>
	| page pointer theMethod theIP numArgs stackPtrIndex maybeClosure rcvr |
	<inline: false>
	<var: #page type: #'StackPage *'>
	<var: #pointer type: #'char *'>
	self assert: (objectMemory isContext: aContext).
	self assert: (self isSingleContext: aContext).
	self assert: (objectMemory goodContextSize: aContext).
	page := stackPages newStackPage.
	pointer := page baseAddress.
	theIP := objectMemory fetchPointer: InstructionPointerIndex ofObject: aContext.
	theMethod := objectMemory followObjField: MethodIndex ofObject: aContext.
	(objectMemory isIntegerObject: theIP) ifFalse:
		[self error: 'context is not resumable'].
	theIP := objectMemory integerValueOf: theIP.
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
			 stackPages longAt: pointer put: maybeClosure]
		ifFalse:
			[| header |
			 header := objectMemory methodHeaderOf: theMethod.
			 numArgs := self argumentCountOfMethodHeader: header.
			 "If this is a synthetic context its IP could be pointing at the CallPrimitive opcode.  If so, skip it."
			 ((self methodHeaderHasPrimitive: header)
			  and: [theIP = (1 + (objectMemory lastPointerOfMethodHeader: header))]) ifTrue:
				[theIP := theIP + (self sizeOfCallPrimitiveBytecode: header)].
			 stackPages longAt: pointer put: rcvr].
	"Put the arguments on the stack"
	1 to: numArgs do:
		[:i|
		stackPages
			longAt: (pointer := pointer - objectMemory wordSize)
			put: (objectMemory fetchPointer: ReceiverIndex + i ofObject: aContext)].
	"saved caller ip is sender context in base frame"
	stackPages
		longAt: (pointer := pointer - objectMemory wordSize)
		put: (objectMemory followObjField: SenderIndex ofObject: aContext).
	"base frame's saved fp is null"
	stackPages
		longAt: (pointer := pointer - objectMemory wordSize)
		put: 0.
	page baseFP: pointer; headFP: pointer.
	stackPages
		longAt: (pointer := pointer - objectMemory wordSize)
		put: theMethod.
	stackPages
		longAt: (pointer := pointer - objectMemory wordSize)
		put: (self encodeFrameFieldHasContext: true isBlock: maybeClosure ~= objectMemory nilObject numArgs: numArgs).
	self assert: (self frameHasContext: page baseFP).
	self assert: (self frameNumArgs: page baseFP) == numArgs.
	stackPages
		longAt: (pointer := pointer - objectMemory wordSize)
		put: aContext.
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
	theIP := self iframeInstructionPointerForIndex: theIP method: theMethod.
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