initialization
stackPagesClass
	<doNotGenerate>
	^VMBIGENDIAN
		ifTrue: [CoInterpreterStackPagesMSB]
		ifFalse: [CoInterpreterStackPagesLSB]