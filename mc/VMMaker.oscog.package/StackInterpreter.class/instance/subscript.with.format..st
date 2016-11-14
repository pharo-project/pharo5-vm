indexing primitive support
subscript: array with: index format: fmt
	"Note: This method assumes that the index is within bounds!"

	<inline: true>
	fmt <= objectMemory lastPointerFormat ifTrue:
		[^objectMemory fetchPointer: index - 1 ofObject: array].
	fmt >= objectMemory firstByteFormat ifTrue:
		[^objectMemory integerObjectOf:
			(objectMemory fetchByte: index - 1 ofObject: array)].
	objectMemory hasSpurMemoryManagerAPI ifTrue:
		[fmt >= objectMemory firstShortFormat ifTrue:
			[^objectMemory integerObjectOf:
				(objectMemory fetchUnsignedShort16: index - 1 ofObject: array)].
		 fmt = objectMemory sixtyFourBitIndexableFormat ifTrue:
			[^self positive64BitIntegerFor:
				(objectMemory fetchLong64: index - 1 ofObject: array)]].
	"32bit-word type objects; for now assume no 64-bit indexable objects"
	^self positive32BitIntegerFor:
			(objectMemory fetchLong32: index - 1 ofObject: array)