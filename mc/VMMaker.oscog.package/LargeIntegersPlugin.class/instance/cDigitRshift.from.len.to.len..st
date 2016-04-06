C core
cDigitRshift: shiftCount from: pFrom len: lenFrom to: pTo len: lenTo 
	| carry digit digitShift bitShift leftShift limit start |
	<var: #pTo type: #'unsigned int *'>
	<var: #pFrom type: #'unsigned int *'>
	<var: #carry type: #'unsigned int'>
	<var: #digit type: #'unsigned int'>
	digitShift := shiftCount // 32.
	bitShift := shiftCount \\ 32.
	bitShift = 0 ifTrue: ["Fast version for digit-aligned shifts"
		"C indexed!"
		^self
			cDigitReplace: pTo
			from: 0
			to: lenTo - 1
			with: pFrom
			startingAt: digitShift].
		
	"This implementation use at most 31 bits of carry.
	bitAnd: 16rFFFFFFFF is only for simulator, useless in C"
	leftShift := 32 - bitShift.
	carry := (self cDigitOf: pFrom at: digitShift) >> bitShift.
	start := digitShift + 1.
	limit := lenFrom - 1.
	start to: limit do: 
		[:j | 
		digit := self cDigitOf: pFrom at: j.
		self cDigitOf: pTo at: j - start put: ((carry bitOr: digit << leftShift) bitAnd: 16rFFFFFFFF).
		carry := digit >> bitShift].
	carry = 0 ifFalse: [self cDigitOf: pTo at: lenTo - 1 put: carry].
	^0