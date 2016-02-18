translation
requiredMethodNames: options
	^self selectors reject:
		[:s| | m |
		(self isAccessor: s)
		or: [((m := self compiledMethodAt: s) isQuick and: [m pragmas isEmpty])
		or: [(m pragmaAt: #doNotGenerate) notNil
		or: [(m pragmaAt: #inline:) notNil and: [(m pragmaAt: #inline:) arguments first == true]]]]]