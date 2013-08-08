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
	<var: #thePage type: #'StackPage *'>
	<var: #theFPAbove type: #'char *'>
	<inline: true>
	self assert: offset < MethodIndex.
	self assert: (objectMemory isContext: aContext).
	self writeBackHeadFramePointers.
	(self isMarriedOrWidowedContext: aContext) ifFalse:
		[value := objectMemory fetchPointer: offset ofObject: aContext.
		 (offset = InstructionPointerIndex
		  and: ["self halt: value hex." (objectMemory isIntegerObject: value)
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
		[| theIP thePage theFPAbove |
		 spouseFP = localFP
			ifTrue: [theIP := self oopForPointer: localIP]
			ifFalse:
				[thePage := stackPages stackPageFor: spouseFP.
				 theFPAbove := self findFrameAbove: spouseFP inPage: thePage.
				 theIP := theFPAbove == 0
							ifTrue: [stackPages longAt: thePage headSP]
							ifFalse:[self oopForPointer: (self frameCallerSavedIP: theFPAbove)]].
		 value := self contextInstructionPointer: theIP frame: spouseFP.
		 value signedIntFromLong < 0 ifTrue:
			[value := self internalMustMapMachineCodePC: (objectMemory integerValueOf: value)
							context: aContext].
		 ^value].
	self error: 'bad index'.
	^0