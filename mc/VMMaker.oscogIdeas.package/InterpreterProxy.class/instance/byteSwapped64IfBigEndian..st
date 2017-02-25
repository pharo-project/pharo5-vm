other
byteSwapped64IfBigEndian: anInteger
	"Note: for simulation only.
	This message is not generated in C but replaced with a macro"
	<doNotGenerate>
	self vmEndianness = 1 ifTrue: [^anInteger byteSwap64].
	^anInteger