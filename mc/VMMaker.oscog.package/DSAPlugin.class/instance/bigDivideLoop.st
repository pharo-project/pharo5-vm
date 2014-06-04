private
bigDivideLoop
	"This is the core of the divide algorithm. This loop steps through the digit positions of the quotient, each time estimating the right quotient digit, subtracting from the remainder the divisor times the quotient digit shifted left by the appropriate number of digits. When the loop terminates, all digits of the quotient have been filled in and the remainder contains a value less than the divisor. The tricky bit is estimating the next quotient digit. Knuth shows that the digit estimate computed here will never be less than it should be and cannot be more than one over what it should be. Furthermore, the case where the estimate is one too large is extremely rare. For example, in a typical test of 100000 random 60-bit division problems, the rare case only occured five times. See Knuth, volume 2 ('Semi-Numerical Algorithms') 2nd edition, pp. 257-260"

	| d1 d2 firstDigit firstTwoDigits thirdDigit q digitShift qTooBig |
	"extract the top two digits of the divisor"
	d1 := dsaDivisor at: divisorDigitCount.
	d2 := dsaDivisor at: divisorDigitCount - 1.

	remainderDigitCount to: divisorDigitCount + 1 by: -1 do: [:j |
		"extract the top several digits of remainder."
		firstDigit := dsaRemainder at: j.
		firstTwoDigits := (firstDigit bitShift: 8) + (dsaRemainder at: j - 1).
		thirdDigit := dsaRemainder at: j - 2.

		"estimate q, the next digit of the quotient"
		firstDigit = d1
			ifTrue: [q := 255]
			ifFalse: [q := firstTwoDigits // d1].

		"adjust the estimate of q if necessary"
		(d2 * q) > (((firstTwoDigits - (q * d1)) bitShift: 8) + thirdDigit) ifTrue: [	
			q := q - 1.
			(d2 * q) > (((firstTwoDigits - (q * d1)) bitShift: 8) + thirdDigit) ifTrue: [
				q := q - 1]].

		digitShift := j - divisorDigitCount - 1.
		q > 0 ifTrue: [
			qTooBig := self subtractDivisorMultipliedByDigit: q digitShift: digitShift.
			qTooBig ifTrue: [  "this case is extremely rare"
				self addBackDivisorDigitShift: digitShift.
				q := q - 1]].

		"record this digit of the quotient"
		dsaQuotient at: digitShift + 1 put: q].
