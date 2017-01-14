frame access
instVar: offset ofContext: aContext
	"Fetch an instance variable from a maybe married context.
	 If the context is still married compute the value of the
	 relevant inst var from the spouse frame's state."
	| spouseFP |
	<var: #spouseFP type: #'char *'>
	<inline: true>
	self assert: offset < MethodIndex.
	self assert: (objectMemory isContext: aContext).
	(self isMarriedOrWidowedContext: aContext) ifFalse:
		[^objectMemory fetchPointer: offset ofObject: aContext].

	self writeBackHeadFramePointers.
	(self isWidowedContext: aContext) ifTrue:
		[^objectMemory fetchPointer: offset ofObject: aContext].

	spouseFP := self frameOfMarriedContext: aContext.
	offset = SenderIndex ifTrue:
		[^self ensureCallerContext: spouseFP].
	offset = StackPointerIndex ifTrue:
		[self assert: ReceiverIndex + (self stackPointerIndexForFrame: spouseFP) < (objectMemory lengthOf: aContext).
		^objectMemory integerObjectOf: (self stackPointerIndexForFrame: spouseFP)].
	offset = InstructionPointerIndex ifTrue:
		[^self instructionPointerForFrame: spouseFP currentFP: localFP currentIP: (self oopForPointer: localIP)].
	self error: 'bad index'.
	^0