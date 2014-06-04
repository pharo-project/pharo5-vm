testing
isExcludedClass: aMethodReference

	classes notNil
		and: [classes
				detect: [:cls | cls name = aMethodReference classSymbol]
				ifNone: [^ true]].
	^ false