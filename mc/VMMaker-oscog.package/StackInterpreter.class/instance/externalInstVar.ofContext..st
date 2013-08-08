frame access
externalInstVar: offset ofContext: aContext
	"Fetch an instance variable from a maybe married context.
	 If the context is still married compute the value of the
	 relevant inst var from the spouse frame's state."
	| spouseFP |
	<var: #spouseFP type: #'char *'>
	<var: #thePage type: #'StackPage *'>
	<var: #theFPAbove type: #'char *'>

	self assert: (objectMemory isContext: aContext).
	"method, closureOrNil & receiver need no special handling; only
	 sender, pc & stackp have to be computed for married contexts."
	(offset < MethodIndex 
	 and: [self isMarriedOrWidowedContext: aContext]) ifFalse:
		[^objectMemory fetchPointer: offset ofObject: aContext].

	self externalWriteBackHeadFramePointers.
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
		 spouseFP = framePointer
			ifTrue: [theIP := self oopForPointer: instructionPointer]
			ifFalse:
				[thePage := stackPages stackPageFor: spouseFP.
				 theFPAbove := self findFrameAbove: spouseFP inPage: thePage.
				 theIP := theFPAbove == 0
							ifTrue: [stackPages longAt: thePage headSP]
							ifFalse:[self oopForPointer: (self frameCallerSavedIP: theFPAbove)]].
		 ^self contextInstructionPointer: theIP frame: spouseFP].
	self error: 'bad index'.
	^0