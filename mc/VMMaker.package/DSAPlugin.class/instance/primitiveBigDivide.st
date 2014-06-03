primitives-integers
primitiveBigDivide
	"Called with three LargePositiveInteger arguments, rem, div, quo. Divide div into rem and store the quotient into quo, leaving the remainder in rem."
	"Assume: quo starts out filled with zeros."

	| rem div quo |
	<export: true>
	quo := interpreterProxy stackObjectValue: 0.
	div := interpreterProxy stackObjectValue: 1.
	rem := interpreterProxy stackObjectValue: 2.

	interpreterProxy success:
		(interpreterProxy fetchClassOf: rem) = interpreterProxy classLargePositiveInteger.
	interpreterProxy success:
		(interpreterProxy fetchClassOf: div) = interpreterProxy classLargePositiveInteger.
	interpreterProxy success:
		(interpreterProxy fetchClassOf: quo) = interpreterProxy classLargePositiveInteger.
	interpreterProxy failed ifTrue:[^ nil].

	dsaRemainder := interpreterProxy firstIndexableField: rem.
	dsaDivisor := interpreterProxy firstIndexableField: div.
	dsaQuotient := interpreterProxy firstIndexableField: quo.

	divisorDigitCount := interpreterProxy stSizeOf: div.
	remainderDigitCount := interpreterProxy stSizeOf: rem.

	"adjust pointers for base-1 indexing"
	dsaRemainder := dsaRemainder - 1.
	dsaDivisor := dsaDivisor - 1.
	dsaQuotient := dsaQuotient - 1.

	self bigDivideLoop.
	interpreterProxy pop: 3.
