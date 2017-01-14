*VMMaker-JITSimulation
long64At: byteIndex put: aValue
	| lowBits mask wordIndex |
	(lowBits := byteIndex - 1 \\ 4) = 0 ifTrue:
		[self "N.B. Do the access that can fail first, before altering the receiver"
			longAt: byteIndex put: (aValue bitShift: -32);
			unsignedLongAt: byteIndex + 4 put: (aValue bitAnd: 16rffffffff).
		^aValue].
	"There will always be three accesses; two partial words and a full word in the middle"
	wordIndex := byteIndex - 1 // 4 + 1.
	aValue < 0
		ifTrue:
			[(aValue bitShift: -32) < -2147483648 ifTrue:
				[^self errorImproperStore]]
		ifFalse:
			[16r7FFFFFFF < (aValue bitShift: -32) ifTrue:
				[^self errorImproperStore]].
	mask := 16rFFFFFFFF bitShift: 4 - lowBits * -8.
	self at: wordIndex + 2 put: (((self at: wordIndex + 2) bitAnd: mask) bitXor: ((aValue bitShift: lowBits * 8) bitAnd: mask bitInvert32)).
	self at: wordIndex + 1 put: ((aValue bitShift: lowBits * -8) bitAnd: 16rFFFFFFFF).
	self at: wordIndex put: (((self at: wordIndex) bitAnd: mask bitInvert32) bitXor: ((aValue bitShift: 4 - lowBits + 4 * -8) bitAnd: mask)).
	"(wordIndex to: wordIndex + 2) collect: [:i| (self at: i) hex]"
	^aValue