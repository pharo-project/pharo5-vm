translation
filteredInstVarNames
	"Eliminate the obvious simulation-only inst vars"
	^self allInstVarNames reject:
		[:n|
		Cogit isNonArgumentImplicitReceiverVariableName: n]