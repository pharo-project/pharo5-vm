decoding
colorComponentBlocks: blocks from: oop
	| arrayOop max blockOop |
	<var: #blocks type: 'int **'>
	(interpreterProxy isPointers: oop) ifFalse:[^false].
	(interpreterProxy slotSizeOf: oop) < MinComponentSize ifTrue:[^false].

	arrayOop := interpreterProxy fetchPointer: MCUBlockIndex ofObject: oop.
	(interpreterProxy isPointers: arrayOop) ifFalse:[^false].
	max := interpreterProxy slotSizeOf: arrayOop.
	max > MaxMCUBlocks ifTrue:[^false].
	0 to: max-1 do:[:i|
		blockOop := interpreterProxy fetchPointer: i ofObject: arrayOop.
		(interpreterProxy isWords: blockOop) ifFalse:[^false].
		(interpreterProxy slotSizeOf: blockOop) = DCTSize2 ifFalse:[^false].
		blocks at: i put: (interpreterProxy firstIndexableField: blockOop).
	].
	^interpreterProxy failed not