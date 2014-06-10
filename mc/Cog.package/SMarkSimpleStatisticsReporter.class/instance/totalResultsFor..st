helper
totalResultsFor: aListOfResults
	^aListOfResults collect: [:timer | timer total]
	