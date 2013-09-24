indexing primitive support
subscript: array with: index format: fmt
	"Note: This method assumes that the index is within bounds!"

	<inline: true>
	<asmLabel: false> "If labelled icc duplicates when inlining stObject:at:"
	fmt <= objectMemory lastPointerFormat ifTrue:
		[^objectMemory fetchPointer: index - 1 ofObject: array].
	fmt >= objectMemory firstByteFormat ifTrue:
		[^objectMemory integerObjectOf:
			(objectMemory fetchByte: index - 1 ofObject: array)].
	"long-word type objects"
	^self positive32BitIntegerFor:
			(objectMemory fetchLong32: index - 1 ofObject: array)