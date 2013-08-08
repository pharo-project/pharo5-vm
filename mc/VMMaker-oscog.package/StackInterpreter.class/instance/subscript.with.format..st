indexing primitive support
subscript: array with: index format: fmt
	"Note: This method assumes that the index is within bounds!"

	<inline: true>
	<asmLabel: false> "If labelled icc duplicates when inlining stObject:at:"
	fmt <= 4 ifTrue: [  "pointer type objects"
		^ objectMemory fetchPointer: index - 1 ofObject: array].
	fmt < 8 ifTrue: [  "long-word type objects"
		^ self positive32BitIntegerFor:
			(objectMemory fetchLong32: index - 1 ofObject: array)
	] ifFalse: [  "byte-type objects"
		^ objectMemory integerObjectOf:
			(objectMemory fetchByte: index - 1 ofObject: array)
	].