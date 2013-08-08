combination rules
partitionedAdd: word1 to: word2 nBits: nBits nPartitions: nParts
	"Add word1 to word2 as nParts partitions of nBits each.
	This is useful for packed pixels, or packed colors"
	| mask sum result maskedWord1 |
	"In C, most arithmetic operations answer the same bit pattern regardless of the operands being signed or unsigned ints
	(this is due to the way 2's complement numbers work). However, comparisions might fail. Add the proper declaration of
	words as unsigned int in those cases where comparisions are done (jmv)"
	<var: #word1 type: 'unsigned int'>
	<var: #word2 type: 'unsigned int'>
	<var: #mask type: 'unsigned int'>
	<var: #sum type: 'unsigned int'>
	<var: #result type: 'unsigned int'>
	<var: #maskedWord1 type: 'unsigned int'>
	mask := maskTable at: nBits.  "partition mask starts at the right"
	result := 0.
	1 to: nParts do:
		[:i |
		maskedWord1 := word1 bitAnd: mask.
		sum := maskedWord1 + (word2 bitAnd: mask).
		(sum <= mask "result must not carry out of partition"
				and: [ sum >= maskedWord1 ])	"This is needed because in C, integer arithmetic overflows silently! (jmv)"
			ifTrue: [result := result bitOr: sum]
			ifFalse: [result := result bitOr: mask].
		mask := mask << nBits  "slide left to next partition"].
	^ result
