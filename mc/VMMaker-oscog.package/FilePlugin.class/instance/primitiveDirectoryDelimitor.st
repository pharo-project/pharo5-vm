directory primitives
primitiveDirectoryDelimitor
	| ascii |
	<export: true>
	ascii := self asciiDirectoryDelimiter.
	((ascii >= 0) and: [ascii <= 255]) ifFalse:
		[^interpreterProxy primitiveFail].
	interpreterProxy
		pop: 1
		thenPush: (interpreterProxy fetchPointer: ascii ofObject: (interpreterProxy characterTable))