stack bytecodes
pushLiteralVariable: literalIndex
	objectMemory hasSpurMemoryManagerAPI
		ifTrue:
			[| litVar |
			 "push/store/popLiteralVariable all fetch a literal, and either read or write the literal's value field.
			  The fetch of the literal needs an explicit check (otherwise we would have to scan all literals in
			  all methods in the stack zone, and the entire method on return, and global variables are relatively
			  rare; in my work image 8.7% of literals are globals)."
			 litVar := self literal: literalIndex.
			 (objectMemory isForwarded: litVar) ifTrue:
				[litVar := self unfollow: litVar atIndex: literalIndex].
			 self internalPush:
				(objectMemory fetchPointer: ValueIndex ofObject: litVar)]
		ifFalse:
			[self internalPush:
				(objectMemory fetchPointer: ValueIndex ofObject: (self literal: literalIndex))]