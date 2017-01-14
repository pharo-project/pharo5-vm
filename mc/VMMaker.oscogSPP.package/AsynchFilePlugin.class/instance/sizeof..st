simulation
sizeof: objectSymbolOrClass
	<doNotGenerate>
	objectSymbolOrClass isInteger ifTrue:
		[^interpreterProxy wordSize].
	objectSymbolOrClass == #AsyncFile ifTrue:
		[^interpreterProxy wordSize * 2].
	^super sizeof: objectSymbolOrClass