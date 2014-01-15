trampolines
ceContext: maybeContext instVar: slotIndex
	<api>
	| result |
	(objectMemory isContextNonInt: maybeContext)
		ifTrue:
			[instructionPointer := self popStack.
			 result := self externalInstVar: slotIndex ofContext: maybeContext.
			 self push: instructionPointer]
		ifFalse: [result := objectMemory fetchPointer: slotIndex ofObject: maybeContext].
	^result