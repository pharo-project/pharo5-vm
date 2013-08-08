private
fixPointersInArrayOfStrings: flattenedArrayOfStrings withOffsets: offsetArray count: count
	"Use the address offsets in offsetArray to fix up the pointers in cStringArray.
	The result is a C array of pointers to char, used for argv and env vectors."

	| ptr idx |
	<var: 'flattenedArrayOfStrings' declareC: 'char *flattenedArrayOfStrings'>
	<var: 'offsetArray' declareC: 'sqInt *offsetArray'>
	<var: 'ptr' declareC: 'char **ptr'>
	ptr := self cCoerce: flattenedArrayOfStrings to: 'char **'.
	idx := 0.
	[idx < count]
		whileTrue:
			[ptr
				at: idx
				put: (flattenedArrayOfStrings + (interpreterProxy integerValueOf: (offsetArray at: idx))).
			idx := idx + 1]