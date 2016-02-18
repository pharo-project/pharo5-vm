frame access
externalInstVar: offset ofContext: aContext
	"Fetch an instance variable from a maybe married context.
	 If the context is still married compute the value of the
	 relevant inst var from the spouse frame's state.

	 If the context is single but has a negative instruction pointer
	 recognise that the instruction pointer is actually into machine
	 code and convert it to the corresponding bytecode pc."
	<inline: false>
	| value |

	self assert: (objectMemory isContext: aContext).
	"method, closureOrNil & receiver need no special handling; only
	 sender, pc & stackp have to be computed for married contexts."
	((self isReadMediatedContextInstVarIndex: offset)
	 and: [self isMarriedOrWidowedContext: aContext]) ifFalse:
		[value := objectMemory fetchPointer: offset ofObject: aContext.
		 ^(offset = InstructionPointerIndex
		    and: [(objectMemory isIntegerObject: value)
		    and: [value signedIntFromLong < 0]])
			ifTrue: [self externalWriteBackHeadFramePointers.
					self mustMapMachineCodePC: (objectMemory integerValueOf: value)
						context: aContext]
			ifFalse: [value]].

	self externalWriteBackHeadFramePointers.
	^(self isStillMarriedContext: aContext)
		ifTrue: [self fetchPointer: offset ofMarriedContext: aContext]
		ifFalse: [objectMemory fetchPointer: offset ofObject: aContext]