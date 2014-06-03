C core
cCoreBytesRshiftCount: count n: n f: f bytes: b from: pFrom len: fromLen to: pTo len: toLen 
	| x digit |
	<var: #pTo type: 'unsigned char * '>
	<var: #pFrom type: 'unsigned char * '>
	self sqAssert: b < fromLen.
	n = 0 ifTrue: ["Fast version for byte-aligned shifts"
		"C indexed!"
		^self
			cBytesReplace: pTo
			from: 0
			to: toLen - 1
			with: pFrom
			startingAt: b].
		
	"This implementation use at most 16 bits of x"
	x := (pFrom at: b) << f.
	self sqAssert: count - 1 < fromLen.
	b + 1 to: count - 1 do: 
		[:j | 
		digit := pFrom at: j.
		x := (x >> 8) bitOr: (digit << f).
		pTo at: j - b - 1 put: (x bitAnd: 255)].
	count = fromLen
				ifTrue: [digit := 0]
				ifFalse: [digit := pFrom at: count].
	x := (x >> 8) bitOr: (digit << f).
	pTo at: count - b - 1 put: (x "bitAnd: 255")