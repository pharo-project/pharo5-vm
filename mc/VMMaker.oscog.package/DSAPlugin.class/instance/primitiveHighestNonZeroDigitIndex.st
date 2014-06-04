primitives-integers
primitiveHighestNonZeroDigitIndex
	"Called with one LargePositiveInteger argument. Answer the index of the top-most non-zero digit."

	| arg bigIntPtr i |
	<export: true>
	<var: #bigIntPtr type: 'unsigned char *'>

	arg := interpreterProxy stackObjectValue: 0.
	interpreterProxy success:
		(interpreterProxy fetchClassOf: arg) = interpreterProxy classLargePositiveInteger.
	interpreterProxy failed ifTrue: [^ nil].

	bigIntPtr := interpreterProxy firstIndexableField: arg.
	i := interpreterProxy stSizeOf: arg.
	[(i > 0) and: [(bigIntPtr at: (i := i - 1)) = 0]]
		whileTrue: ["scan down from end to first non-zero digit"].

	interpreterProxy pop: 1.
	interpreterProxy pushInteger: i + 1.
