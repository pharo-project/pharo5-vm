*VMMaker-JITSimulation
unsignedByteAt: byteAddress
	"Compatibility with the ByteArray and Alien methods of the same name."
	| lowBits |
	lowBits := byteAddress - 1 bitAnd: 3.
	^((self at: byteAddress - 1 - lowBits // 4 + 1)
		bitShift: (lowBits - 3) * 8)
		bitAnd: 16rFF