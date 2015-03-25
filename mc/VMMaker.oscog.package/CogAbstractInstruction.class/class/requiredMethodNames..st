translation
requiredMethodNames: options
	^self selectors reject:
		[:s|
		(self isAccessor: s)
		or: [((self compiledMethodAt: s) pragmaAt: #doNotGenerate) notNil
		or: [((self compiledMethodAt: s) pragmaAt: #inline:) notNil
			and: [((self compiledMethodAt: s) pragmaAt: #inline:) arguments first == true]]]]