compiled methods
safeMethodClassOf: methodPointer
	"Safe version of methodClassOf: that deals with malformed compiled methods,
	 etc, and does not fixup forwarding pointers.."
	| literal maybeClass |
	literal := self literal: (objectMemory literalCountOf: methodPointer) - 1 ofMethod: methodPointer.
	(objectMemory isOopForwarded: literal) ifTrue:
		[literal := objectMemory followForwarded: literal].
	((objectMemory isPointers: literal) and: [(objectMemory numSlotsOf: literal) > ValueIndex]) ifFalse:
		[^objectMemory nilObject].
	maybeClass := objectMemory fetchPointer: ValueIndex ofObject: literal.
	(objectMemory isOopForwarded: maybeClass) ifTrue:
		[maybeClass := objectMemory followForwarded: maybeClass].
	^maybeClass