translation
requiredMethodNames: options
	^self selectors reject:
		[:s|
		(self isAccessor: s)
		or: [((self compiledMethodAt: s) pragmaAt: #doNotGenerate) notNil]]