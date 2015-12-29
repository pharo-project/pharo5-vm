stack bytecodes
storeLiteralVariable: literalIndex withValue: anObject
	| litVar |
	litVar := self literal: literalIndex.
	"push/store/popLiteralVariable all fetch a literal, and either read or write the literal's value field.
	 The fetch of the literal needs an explicit check (otherwise we would have to scan all literals in
	 all methods in the stack zone, and the entire method on return, and global variables are relatively
	 rare; in my work image 8.7% of literals are globals)."

	(objectMemory isForwarded: litVar) ifTrue:
		[litVar := objectMemory followForwarded: litVar].
	^objectMemory storePointerImmutabilityCheck: ValueIndex ofObject: litVar withValue: anObject