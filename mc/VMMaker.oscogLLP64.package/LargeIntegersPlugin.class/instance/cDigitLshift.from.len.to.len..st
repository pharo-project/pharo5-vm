C core
cDigitLshift: shiftCount from: pFrom len: lenFrom to: pTo len: lenTo 
	"C indexed!"
	| digitShift bitShift carry limit digit rshift |
	<var: #pTo type: #'unsigned int *'>
	<var: #pFrom type: #'unsigned int *'>
	<var: #carry type: #'unsigned int'>
	<var: #digit type: #'unsigned int'>
	digitShift := shiftCount // 32.
	bitShift := shiftCount \\ 32.
	
	limit := digitShift - 1.
	"Note: 0 is endian neutral, use direct access"
	0 to: limit do: [:i | pTo at: i put: 0].
	
	bitShift = 0 ifTrue: ["Fast version for digit-aligned shifts"
		"C indexed!"
		^ self
			cDigitReplace: pTo
			from: digitShift
			to: lenTo - 1
			with: pFrom
			startingAt: 0].
		
	"This implementation use at most 31 bits of carry.
	bitAnd: 16rFFFFFFFF is only for simulator, useless in C"
	rshift := 32 - bitShift.
	carry := 0.
	limit := lenFrom - 1.
	0 to: limit do: 
		[:i | 
		digit := self cDigitOf: pFrom at: i.
		self cDigitOf: pTo at: i + digitShift put: ((carry bitOr: digit << bitShift) bitAnd: 16rFFFFFFFF).
		carry := digit >> rshift].
	carry = 0 ifFalse: [self cDigitOf: pTo at: lenTo - 1 put: carry].
	^0