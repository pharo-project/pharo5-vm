combination rules
partitionedMul: word1 with: word2 nBits: nBits nPartitions: nParts
	"Multiply word1 with word2 as nParts partitions of nBits each.
	This is useful for packed pixels, or packed colors.
	Bug in loop version when non-white background"

	| sMask product result dMask |
	"In C, integer multiplication might answer a wrong value if the unsigned values are declared as signed.
	This problem does not affect this method, because the most significant bit (i.e. the sign bit) will
	always be zero (jmv)"
	<returnTypeC: 'unsigned int'>
	<var: #word1 type: 'unsigned int'>
	<var: #word2 type: 'unsigned int'>
	<var: #sMask type: 'unsigned int'>
	<var: #dMask type: 'unsigned int'>
	<var: #result type: 'unsigned int'>
	<var: #product type: 'unsigned int'>
	sMask := maskTable at: nBits.  "partition mask starts at the right"
	dMask :=  sMask << nBits.
	result := (((word1 bitAnd: sMask)+1) * ((word2 bitAnd: sMask)+1) - 1 
				bitAnd: dMask) >> nBits.	"optimized first step"
	nParts = 1
		ifTrue: [ ^result ].
	product := (((word1>>nBits bitAnd: sMask)+1) * ((word2>>nBits bitAnd: sMask)+1) - 1 bitAnd: dMask).
	result := result bitOr: product.
	nParts = 2
		ifTrue: [ ^result ].
	product := (((word1>>(2*nBits) bitAnd: sMask)+1) * ((word2>>(2*nBits) bitAnd: sMask)+1) - 1 bitAnd: dMask).
	result := result bitOr: product << nBits.
	nParts = 3
		ifTrue: [ ^result ].
	product := (((word1>>(3*nBits) bitAnd: sMask)+1) * ((word2>>(3*nBits) bitAnd: sMask)+1) - 1 bitAnd: dMask).
	result := result bitOr: product << (2*nBits).
	^ result

"	| sMask product result dMask |
	sMask := maskTable at: nBits.  'partition mask starts at the right'
	dMask :=  sMask << nBits.
	result := (((word1 bitAnd: sMask)+1) * ((word2 bitAnd: sMask)+1) - 1 
				bitAnd: dMask) >> nBits.	'optimized first step'
	nBits to: nBits * (nParts-1) by: nBits do: [:ofs |
		product := (((word1>>ofs bitAnd: sMask)+1) * ((word2>>ofs bitAnd: sMask)+1) - 1 bitAnd: dMask).
		result := result bitOr: (product bitAnd: dMask) << (ofs-nBits)].
	^ result"