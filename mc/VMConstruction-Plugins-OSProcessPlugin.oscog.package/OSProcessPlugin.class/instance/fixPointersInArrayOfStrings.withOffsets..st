private
fixPointersInArrayOfStrings: flattenedStrings withOffsets: offsets
	"The image constructs a flattened string of all the argument and/or environment strings.
	 There is room at the beginning for the null-terminated array of pointers to strings.
	 The rest of the string contains the null-terminated strings."
	"Use the address offsets in offsetArray to fix up the pointers in cStringArray.
	The result is a C array of pointers to char, used for argv and env vectors."

	<returnTypeC: #'char **'>
	| count offsetArray ptr sz idx |
	<var: 'offsetArray' type: #'sqInt *'>
	<var: 'ptr' type: #'char **'>
	<var: 'sz' type: #usqInt>
	count := interpreterProxy stSizeOf: offsets.
	offsetArray := interpreterProxy firstIndexableField: offsets.
	sz := (interpreterProxy byteSizeOf: flattenedStrings) asUnsignedInteger.
	count * (self sizeof: #'char *') >= sz ifTrue:
		[interpreterProxy primitiveFailFor: PrimErrBadArgument.
		 ^0].
	ptr := self cCoerce: (interpreterProxy arrayValueOf: flattenedStrings) to: #'char **'.
	idx := 0.
	[idx < count] whileTrue:
		[| val |
		 val := interpreterProxy integerValueOf: (offsetArray at: idx).
		 val asUnsignedInteger >= sz ifTrue:
			[interpreterProxy primitiveFailFor: PrimErrBadArgument.
			 ^0].
		 ptr at: idx put: (self cCoerce: ptr to: #'char *') + val.
		 idx := idx + 1].
	(ptr at: idx) ~= 0 ifTrue:
		[interpreterProxy primitiveFailFor: PrimErrBadArgument].
	^interpreterProxy failed
		ifTrue: [0]
		ifFalse: [ptr]