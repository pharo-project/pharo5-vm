accessing
compiledMethod
	^definingClass
		compiledMethodAt: selector
		ifAbsent: [definingClass compiledMethodAt: properties selector]