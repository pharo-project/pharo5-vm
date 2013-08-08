C core
cBytesLshift: shiftCount from: pFrom len: lenFrom to: pTo len: lenTo 
	"C indexed!"
	| byteShift bitShift carry limit digit lastIx |
	<returnTypeC: 'int'>
	<var: #pTo type: 'unsigned char * '>
	<var: #pFrom type: 'unsigned char * '>
	byteShift := shiftCount // 8.
	bitShift := shiftCount \\ 8.
	bitShift = 0 ifTrue: ["Fast version for byte-aligned shifts"
		"C indexed!"
		^ self
			cBytesReplace: pTo
			from: byteShift
			to: lenTo - 1
			with: pFrom
			startingAt: 0].
		
	"This implementation use at most 15 bits of carry.
	bitAnd: 255 is only for simulator, useless in C"
	carry := 0.
	limit := byteShift - 1.
	0 to: limit do: [:i | pTo at: i put: 0].
	limit := lenTo - byteShift - 2.
	self sqAssert: limit < lenFrom.
	0 to: limit do: 
		[:i | 
		digit := pFrom at: i.
		carry := (carry >> 8) bitOr: (digit << bitShift).
		pTo at: i + byteShift put: (carry bitAnd: 255)].
	lastIx := limit + 1.
	lastIx > (lenFrom - 1)
		ifTrue: [digit := 0]
		ifFalse: [digit := pFrom at: lastIx].
	carry := (carry >> 8) bitOr: (digit << bitShift).
	pTo at: lastIx + byteShift put: (carry "bitAnd: 255").
	carry := carry >> 8.
	self sqAssert: carry = 0