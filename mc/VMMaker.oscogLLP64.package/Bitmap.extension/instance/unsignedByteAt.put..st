*VMMaker-JITSimulation
unsignedByteAt: byteAddress put: byte
	"Compatibility with the ByteArray and Alien methods of the same name."
	| longWord shift lowBits longAddr |
	(byte < 0 or:[byte > 255]) ifTrue:[^self errorImproperStore].
	lowBits := byteAddress - 1 bitAnd: 3.
	longWord := self at: (longAddr := (byteAddress - 1 - lowBits) // 4 + 1).
	shift := (3 - lowBits) * 8.
	longWord := longWord - (longWord bitAnd: (16rFF bitShift: shift)) 
		+ (byte bitShift: shift).
	self at: longAddr put: longWord.
	^ byte