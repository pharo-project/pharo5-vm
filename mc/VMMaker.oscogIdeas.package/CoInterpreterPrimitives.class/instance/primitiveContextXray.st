indexing primitives
primitiveContextXray
	"Lift the veil from a context and answer an integer describing its interior state.
	 Used for e.g. VM tests so they can verify they're testing what they think they're testing.
	 0 implies a vanilla heap context.
	 Bit 0 = is or was married to a frame
	 Bit 1 = is still married to a frame
	 Bit 2 = frame is executing machine code
	 Bit 3 = has machine code pc (as opposed to nil or a bytecode pc)
	 Bit 4 = method is currently compiled to machine code"
	| context pc flags theFP theMethod |
	<var: #theFP type: #'char *'>
	context := self stackTop.
	pc := objectMemory fetchPointer: InstructionPointerIndex ofObject: context.
	(self isMarriedOrWidowedContext: context)
		ifTrue:
			[(self checkIsStillMarriedContext: context currentFP: framePointer)
				ifTrue: [theFP := self frameOfMarriedContext: context.
						(self isMachineCodeFrame: theFP)
							ifTrue: [flags := 7]
							ifFalse: [flags := 3]]
				ifFalse: [flags := 1]]
		ifFalse:
			[flags := 0].
	((objectMemory isIntegerObject: pc)
	 and: [(objectMemory integerValueOf: pc) < 0]) ifTrue:
		[flags := flags bitOr: 8].
	theMethod := objectMemory fetchPointer: MethodIndex ofObject: context.
	(self maybeMethodHasCogMethod: theMethod) ifTrue:
		[flags := flags bitOr: 16].
	self pop: 1 thenPush: (objectMemory integerObjectOf: flags)