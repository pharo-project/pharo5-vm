inflating
zipDecodeValueFrom: table size: tableSize
	"Decode the next value in the receiver using the given huffman table."
	| bits bitsNeeded tableIndex value index |
	<var: #table type:'unsigned int *'>
	bitsNeeded := (table at: 0) bitShift: -24.	"Initial bits needed"
	bitsNeeded > MaxBits ifTrue:[interpreterProxy primitiveFail. ^0].
	tableIndex := 2.							"First real table"
	[true] whileTrue:[
		bits := self zipNextBits: bitsNeeded.		"Get bits"
		index := tableIndex + bits - 1.
		index >= tableSize ifTrue:[interpreterProxy primitiveFail. ^0].
		value := table at: index.					"Lookup entry in table"
		(value bitAnd: 16r3F000000) = 0 ifTrue:[^value]. "Check if it is a leaf node"
		"Fetch sub table"
		tableIndex := value bitAnd: 16rFFFF.	"Table offset in low 16 bit"
		bitsNeeded := (value bitShift: -24) bitAnd: 255. "Additional bits in high 8 bit"
		bitsNeeded > MaxBits ifTrue:[interpreterProxy primitiveFail. ^0]].
	^0