helper
resultsFor: aCriterion from: aListOfResults
	^aListOfResults collect: [:result | (result criteria at: aCriterion) totalTime]
	