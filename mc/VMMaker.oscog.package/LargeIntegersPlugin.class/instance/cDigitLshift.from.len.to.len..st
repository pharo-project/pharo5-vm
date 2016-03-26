C core
cDigitLshift: shiftCount from: pFrom len: lenFrom to: pTo len: lenTo 
	"C indexed!"
	| digitShift bitShift carry limit digit rshift |
	<var: #pTo type: #'unsigned char *'>
	<var: #pFrom type: #'unsigned char *'>
	<var: #carry type: #'unsigned int'>
	<var: #digit type: #'unsigned int'>
	digitShift := shiftCount // 8.
	bitShift := shiftCount \\ 8.
	
	limit := digitShift - 1.
	0 to: limit do: [:i | pTo at: i put: 0].
	
	bitShift = 0 ifTrue: ["Fast version for digit-aligned shifts"
		"C indexed!"
		^ self
			cDigitReplace: pTo
			from: digitShift
			to: lenTo - 1
			with: pFrom
			startingAt: 0].
		
	"This implementation use at most 15 bits of carry.
	bitAnd: 16rFF is only for simulator, useless in C"
	rshift := 8 - bitShift.
	carry := 0.
	limit := lenFrom - 1.
	0 to: limit do: 
		[:i | 
		digit := pFrom at: i.
		pTo at: i + digitShift put: ((carry bitOr: digit << bitShift) bitAnd: 16rFF).
		carry := digit >> rshift].
	carry = 0 ifFalse: [pTo at: lenTo - 1 put: carry].
	^0
