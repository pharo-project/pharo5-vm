combination rules
partitionedAND: word1 to: word2 nBits: nBits nPartitions: nParts
	"AND word1 to word2 as nParts partitions of nBits each.
	Any field of word1 not all-ones is treated as all-zeroes.
	Used for erasing, eg, brush shapes prior to ORing in a color"
	| mask result |
	mask := maskTable at: nBits.  "partition mask starts at the right"
	result := 0.
	1 to: nParts do:
		[:i |
		(word1 bitAnd: mask) = mask
			ifTrue: [result := result bitOr: (word2 bitAnd: mask)].
		mask := mask << nBits  "slide left to next partition"].
	^ result
