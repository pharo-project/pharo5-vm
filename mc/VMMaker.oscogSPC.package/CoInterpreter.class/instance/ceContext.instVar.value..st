trampolines
ceContext: maybeMarriedContext instVar: slotIndex value: anOop
	<api>
	"genStorePop:MaybeContextReceiverVariable: filters out unmarried contexts
	 but not arbitrary objects in subclasses.  It answers maybeMarriedContext so
	 that the StackToRegisterMappingCogit can keep ReceiverResultReg live."
	((objectMemory isContextNonImm: maybeMarriedContext) 
	 and: [self isMarriedOrWidowedContext: maybeMarriedContext])
		ifTrue:
			[instructionPointer := self popStack.
			 self externalInstVar: slotIndex ofContext: maybeMarriedContext put: anOop.
			 self push: instructionPointer]
		ifFalse:
			[objectMemory storePointer: slotIndex ofObject: maybeMarriedContext withValue: anOop].
	^maybeMarriedContext