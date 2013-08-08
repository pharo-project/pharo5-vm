translation
requiredMethodNames
	"self requiredMethodNames"
	^self exportAPISelectors
		addAll: self tableFunctions;
		yourself