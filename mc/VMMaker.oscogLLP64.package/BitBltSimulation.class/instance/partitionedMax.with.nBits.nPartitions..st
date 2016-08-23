combination rules
partitionedMax: word1 with: word2 nBits: nBits nPartitions: nParts
	"Max word1 to word2 as nParts partitions of nBits each"
	| mask result |
	"In C, most arithmetic operations answer the same bit pattern regardless of the operands being signed or unsigned ints
	(this is due to the way 2's complement numbers work). However, comparisions might fail. Add the proper declaration of
	words as unsigned int in those cases where comparisions are done (jmv)"
	<returnTypeC: 'unsigned int'>
	<var: #word1 type: 'unsigned int'>
	<var: #word2 type: 'unsigned int'>
	<var: #mask type: 'unsigned int'>
	<var: #result type: 'unsigned int'>
	mask := maskTable at: nBits.  "partition mask starts at the right"
	result := 0.
	1 to: nParts do:
		[:i |
		result := result bitOr: ((word2 bitAnd: mask) max: (word1 bitAnd: mask)).
		mask := mask << nBits  "slide left to next partition"].
	^ result
