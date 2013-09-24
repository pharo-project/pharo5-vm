memory access
longAt: byteAddress
	"Note: Adjusted for Smalltalk's 1-based array indexing."
	self assert: (byteAddress >= minStackAddress and: [byteAddress < maxStackAddress]).
	^objectMemory longAt: byteAddress