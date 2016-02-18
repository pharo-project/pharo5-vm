utilities
shouldGenerateMethod: aTMethod
	^(self isBuiltinSelector: aTMethod selector)
		ifTrue: [requiredSelectors includes: aTMethod selector]
		ifFalse: [true]