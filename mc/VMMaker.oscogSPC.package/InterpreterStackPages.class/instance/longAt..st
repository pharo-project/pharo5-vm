memory access
longAt: byteAddress
	<doNotGenerate>
	"Note: Adjusted for Smalltalk's 1-based array indexing."
	self assert: (byteAddress bitAnd: objectMemory wordSize - 1) == 0.
	^stackMemory at: byteAddress // objectMemory wordSize + indexOffset