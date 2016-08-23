indexing primitive support
subscript: array with: index storing: oopToStore format: fmt 
	"Note: This method assumes that the index is within bounds!"
	| signedValueToStore unsignedValueToStore |
	<inline: true>
	fmt <= objectMemory lastPointerFormat ifTrue:
		[objectMemory storePointer: index - 1 ofObject: array withValue: oopToStore.
		 ^self].
	fmt >= objectMemory firstByteFormat ifTrue:
		[(objectMemory isIntegerObject: oopToStore) ifFalse:
			[primFailCode := PrimErrBadArgument.
			 ^self].
		 signedValueToStore := objectMemory integerValueOf: oopToStore.
		 (signedValueToStore >= 0 and: [signedValueToStore <= 255]) ifFalse:
			[primFailCode := PrimErrBadArgument.
			 ^self].
		 objectMemory storeByte: index - 1 ofObject: array withValue: signedValueToStore.
		 ^self].
	(objectMemory hasSpurMemoryManagerAPI
	 and: [fmt >= objectMemory firstShortFormat]) ifTrue:
		[(objectMemory isIntegerObject: oopToStore) ifFalse:
			[primFailCode := PrimErrBadArgument.
			 ^self].
		 signedValueToStore := objectMemory integerValueOf: oopToStore.
		 (signedValueToStore >= 0 and: [signedValueToStore <= 65535]) ifFalse:
			[primFailCode := PrimErrBadArgument.
			 ^self].
		 objectMemory storeShort16: index - 1 ofObject: array withValue: signedValueToStore.
		 ^self].
	"double-word type objects; for now assume no 64-bit indexable objects"
	unsignedValueToStore := self positive32BitValueOf: oopToStore.
	self successful ifTrue:
		[objectMemory storeLong32: index - 1 ofObject: array withValue: unsignedValueToStore]