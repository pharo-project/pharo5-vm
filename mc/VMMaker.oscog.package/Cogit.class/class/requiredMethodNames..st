translation
requiredMethodNames: options
	"self requiredMethodNames"
	^(self exportAPISelectors: options)
		addAll: self tableFunctions;
		yourself