C core
cDigitRshift: shiftCount from: pFrom len: fromLen to: pTo len: toLen 
	| digit bitShift carry digitShift leftShift limit start |
	<var: #pTo type: #'unsigned char *'>
	<var: #pFrom type: #'unsigned char *'>
	<var: #carry type: #'unsigned int'>
	<var: #digit type: #'unsigned int'>
	digitShift := shiftCount // 8.
	bitShift := shiftCount \\ 8.
	bitShift = 0 ifTrue: ["Fast version for byte-aligned shifts"
		"C indexed!"
		^self
			cDigitReplace: pTo
			from: 0
			to: toLen - 1
			with: pFrom
			startingAt: digitShift].
		
	"This implementation use at most 16 bits of x"
	leftShift := 8 - bitShift.
	carry := (pFrom at: digitShift) >> bitShift.
	start := digitShift + 1.
	limit := fromLen - 1.
	start to: limit do: 
		[:j | 
		digit := pFrom at: j.
		pTo at: j - start put: ((carry bitOr: digit << leftShift) bitAnd: 16rFF).
		carry := digit >> bitShift].
	carry = 0 ifFalse: [pTo at: toLen - 1 put: carry].
	^0