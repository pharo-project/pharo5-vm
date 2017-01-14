directory primitives
primitiveDirectoryDelimitor
	| ascii |
	<export: true>
	ascii := self asciiDirectoryDelimiter.
	interpreterProxy minorVersion >= 13
		ifTrue:
			[interpreterProxy
				pop: 1
				thenPush: (interpreterProxy characterObjectOf: ascii)]
		ifFalse:
			[(ascii >= 0 and: [ascii <= 255])
				ifTrue:
					[interpreterProxy
						pop: 1
						thenPush: (interpreterProxy
										fetchPointer: ascii
										ofObject: interpreterProxy characterTable)]
				ifFalse:
					[interpreterProxy primitiveFail]]