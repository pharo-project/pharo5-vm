*VMMaker-JITSimulation
longAt: byteIndex put: aValue
	"Default bigEndian access"
	| lowBits wordIndex value mask |
	wordIndex := byteIndex - 1 // 4 + 1.
	aValue < 0
		ifTrue:
			[aValue < -2147483648 ifTrue:
				[^self errorImproperStore].
			 value := 16rFFFFFFFF bitAnd: aValue]
		ifFalse:
			[16r7FFFFFFF < aValue ifTrue:
				[^self errorImproperStore].
			value := aValue].
	(lowBits := byteIndex - 1 bitAnd: 3) = 0 ifTrue:
		[self at: wordIndex put: value.
		 ^aValue].
	mask := 16rFFFFFFFF bitShift: lowBits * -8.
	self at: wordIndex put: (((self at: wordIndex) bitAnd: mask bitInvert) bitXor: ((value bitShift: lowBits * -8) bitAnd: mask)).
	self at: wordIndex + 1 put: (((self at: wordIndex + 1) bitAnd: mask) bitXor: (16rFFFFFFFF bitAnd: ((value bitShift: (4 - lowBits * 8)) bitAnd: mask bitInvert))).
	^aValue