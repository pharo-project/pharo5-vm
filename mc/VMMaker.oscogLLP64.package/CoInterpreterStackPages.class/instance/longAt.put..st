memory access
longAt: byteAddress put: a32Or64BitValue
	<doNotGenerate>
	self assert: (byteAddress >= minStackAddress and: [byteAddress < maxStackAddress]).
	^objectMemory longAt: byteAddress put: a32Or64BitValue