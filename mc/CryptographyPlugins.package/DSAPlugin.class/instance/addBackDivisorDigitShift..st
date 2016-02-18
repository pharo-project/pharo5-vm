private
addBackDivisorDigitShift: digitShift
	"Add back the divisor shifted left by the given number of digits. This is done only when the estimate of quotient digit was one larger than the correct value."

	| carry rIndex sum |
	carry := 0.
	rIndex := digitShift + 1.
	1 to: divisorDigitCount do: [:i |
		sum := (dsaRemainder at: rIndex) + (dsaDivisor at: i) + carry.
		dsaRemainder at: rIndex put: (sum bitAnd: 16rFF).
		carry := sum bitShift: -8.
		rIndex := rIndex + 1].

	"do final carry"
	sum := (dsaRemainder at: rIndex) + carry.
	dsaRemainder at: rIndex put: (sum bitAnd: 16rFF).

	"Note: There should be a final carry that cancels out the excess borrow."
	"Assert: (sum bitShift: -8) ~= 1 ifTrue: [self halt: 'no carry!']."
