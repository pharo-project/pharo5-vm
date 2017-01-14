simulation support
log: aBlockOrString
	logging ifTrue:
		[aBlockOrString isBlock
			ifTrue: [aBlockOrString value]
			ifFalse: [interpreterProxy coInterpreter print: aBlockOrString; cr; flush]]