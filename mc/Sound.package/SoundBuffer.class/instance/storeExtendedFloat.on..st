utilities
storeExtendedFloat: aNumber on: aBinaryStream
	"Store an Apple extended-precision 80-bit floating point number on the given stream."
	"Details: I could not find the specification for this format, so constants were determined empirically based on assumption of 1-bit sign, 15-bit exponent, 64-bit mantissa. This format does not seem to have an implicit one before the mantissa as some float formats do."

	| n isNeg exp mantissa |
	n := aNumber asFloat.
	isNeg := false.
	n < 0.0 ifTrue: [
		n := 0.0 - n.
		isNeg := true].
	exp := (n log: 2.0) ceiling.
	mantissa := (n * (2 raisedTo: 64 - exp)) truncated.
	exp := exp + 16r4000 - 2.  "not sure why the -2 is needed..."
	isNeg ifTrue: [exp := exp bitOr: 16r8000].  "set sign bit"
	aBinaryStream nextPut: ((exp bitShift: -8) bitAnd: 16rFF).
	aBinaryStream nextPut: (exp bitAnd: 16rFF).
	8 to: 1 by: -1 do: [:i | aBinaryStream nextPut: (mantissa digitAt: i)].