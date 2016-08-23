frame access
instVar: offset ofContext: aContext
	"Fetch an instance avriable from a maybe married context.
	 If the context is still married compute the value of the
	 relevant inst var from the spouse frame's state.

	 If the context is single but has a negative instruction pointer
	 recognise that the instruction pointer is actually into machine
	 code and convert it to the corresponding bytecode pc."
	| value spouseFP |
	<var: #spouseFP type: #'char *'>
	<inline: true>
	self assert: offset < MethodIndex.
	self assert: (objectMemory isContext: aContext).
	self writeBackHeadFramePointers.
	(self isMarriedOrWidowedContext: aContext) ifFalse:
		[value := objectMemory fetchPointer: offset ofObject: aContext.
		 (offset = InstructionPointerIndex
		  and: [(objectMemory isIntegerObject: value)
		  and: [value signedIntFromLong < 0]]) ifTrue:
			[value := self internalMustMapMachineCodePC: (objectMemory integerValueOf: value)
						context: aContext].
		 ^value].

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