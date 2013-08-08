private - SQFile access
sizeof: objectSymbolOrClass
	<doNotGenerate>
	"In the simulator file handles are just integer indices into openFiles and so need only be BytesPerWord big."
	^objectSymbolOrClass == #SQFile
		ifTrue: [BytesPerWord]
		ifFalse: [super sizeof: objectSymbolOrClass]