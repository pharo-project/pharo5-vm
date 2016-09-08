*VMMaker-JITSimulation
unsignedLongAt: byteIndex put: aValue
	"Compatiblity with the ByteArray & Alien methods of the same name."
	| lowBits mask wordIndex |
	wordIndex := byteIndex - 1 // 4 + 1.
	(lowBits := byteIndex - 1 bitAnd: 3) = 0 ifTrue:
		[^self at: wordIndex put: aValue].
	mask := 16rFFFFFFFF bitShift: lowBits * -8.
	self at: wordIndex put: (((self at: wordIndex) bitAnd: mask bitInvert) bitXor: ((aValue bitShift: lowBits * -8) bitAnd: mask)).
	self at: wordIndex + 1 put: (((self at: wordIndex + 1) bitAnd: mask) bitXor: (16rFFFFFFFF bitAnd: ((aValue bitShift: (4 - lowBits * 8)) bitAnd: mask bitInvert))).
	^aValue