indexing primitive support
subscript: array with: index format: fmt
	"Note: This method assumes that the index is within bounds!"

	<inline: true>
	fmt <= objectMemory lastPointerFormat ifTrue:
		[^objectMemory fetchPointer: index - 1 ofObject: array].
	fmt >= objectMemory firstByteFormat ifTrue:
		[^objectMemory integerObjectOf:
			(objectMemory fetchByte: index - 1 ofObject: array)].
	(objectMemory hasSpurMemoryManagerAPI
	 and: [fmt >= objectMemory firstShortFormat]) ifTrue:
		[^objectMemory integerObjectOf:
			(objectMemory fetchShort16: index - 1 ofObject: array)].
	"double-word type objects; for now assume no 64-bit indexable objects"
	^self positive32BitIntegerFor:
			(objectMemory fetchLong32: index - 1 ofObject: array)