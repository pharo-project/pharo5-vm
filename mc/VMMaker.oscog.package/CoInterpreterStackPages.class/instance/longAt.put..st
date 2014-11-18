memory access
longAt: byteAddress put: a32BitValue
	<doNotGenerate>
	self assert: (byteAddress >= minStackAddress and: [byteAddress < maxStackAddress]).
	^objectMemory longAt: byteAddress put: a32BitValue