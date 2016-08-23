trampolines
ceContext: maybeContext instVar: slotIndex
	<api>
	| result |
	(objectMemory isContextNonImm: maybeContext)
		ifTrue:
			[instructionPointer := self popStack.
			 result := self externalInstVar: slotIndex ofContext: maybeContext.
			 self push: instructionPointer]
		ifFalse: [result := objectMemory fetchPointer: slotIndex ofObject: maybeContext].
	^result