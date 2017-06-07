private - handle conversion
sizeof: objectSymbolOrClass
	<doNotGenerate>
	objectSymbolOrClass == #HANDLE ifTrue:
		[^interpreterProxy wordSize].
	^super sizeof: objectSymbolOrClass