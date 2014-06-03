initialization
stackPagesClass
	<doNotGenerate>
	^VMBIGENDIAN
		ifTrue: [InterpreterStackPagesMSB]
		ifFalse: [InterpreterStackPagesLSB]