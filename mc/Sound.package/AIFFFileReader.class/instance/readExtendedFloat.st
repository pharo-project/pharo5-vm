private
readExtendedFloat
	"Read and answer an Apple extended-precision 80-bit floating point number from the input stream."
	"Details: I could not find the specification for this format, so constants were determined empirically based on assumption of 1-bit sign, 15-bit exponent, 64-bit mantissa. This format does not seem to have an implicit one before the mantissa as some float formats do."

	| signAndExp mantissa sign exp |
	signAndExp := in nextNumber: 2.
	mantissa := in nextNumber: 8.  "scaled by (2 raisedTo: -64) below"
	(signAndExp bitAnd: 16r8000) = 0
		ifTrue: [sign := 1.0]
		ifFalse: [sign := -1.0].
	exp := (signAndExp bitAnd: 16r7FFF) - 16r4000 + 2.  "not sure why +2 is needed..."
	^ (sign * mantissa asFloat * (2.0 raisedTo: exp - 64)) roundTo: 0.00000001
