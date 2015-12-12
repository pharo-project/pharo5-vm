disassembly
relativeBaseForDisassemblyInto: aBlock
	<doNotGenerate>
	disassemblingMethod ifNotNil:
		[aBlock value: disassemblingMethod asInteger value: '.']