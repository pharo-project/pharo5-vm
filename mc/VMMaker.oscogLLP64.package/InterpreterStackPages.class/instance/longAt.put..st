memory access
longAt: byteAddress put: a32BitValue
	<doNotGenerate>
	"Note: Adjusted for Smalltalk's 1-based array indexing."
	self assert: a32BitValue isInteger.
	self assert: (byteAddress bitAnd: objectMemory wordSize - 1) == 0.
	^stackMemory at: byteAddress // objectMemory wordSize + indexOffset put: a32BitValue