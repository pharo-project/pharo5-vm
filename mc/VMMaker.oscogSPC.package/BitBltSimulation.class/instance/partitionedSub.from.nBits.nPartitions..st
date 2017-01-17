combination rules
partitionedSub: word1 from: word2 nBits: nBits nPartitions: nParts
	"Subtract word1 from word2 as nParts partitions of nBits each.
	This is useful for packed pixels, or packed colors"
	| mask result p1 p2 |
	"In C, most arithmetic operations answer the same bit pattern regardless of the operands being signed or unsigned ints
	(this is due to the way 2's complement numbers work). However, comparisions might fail. Add the proper declaration of
	words as unsigned int in those cases where comparisions are done (jmv)"
	<returnTypeC: 'unsigned int'>
	<var: #word1 type: 'unsigned int'>
	<var: #word2 type: 'unsigned int'>
	<var: #p1 type: 'unsigned int'>
	<var: #p2 type: 'unsigned int'>
	<var: #mask type: 'unsigned int'>
	<var: #result type: 'unsigned int'>
	mask := maskTable at: nBits.  "partition mask starts at the right"
	result := 0.
	1 to: nParts do:
		[:i |
		p1 := word1 bitAnd: mask.
		p2 := word2 bitAnd: mask.
		p1 < p2  "result is really abs value of thedifference"
			ifTrue: [result := result bitOr: p2 - p1]
			ifFalse: [result := result bitOr: p1 - p2].
		mask := mask << nBits  "slide left to next partition"].
	^ result
