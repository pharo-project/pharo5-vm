helper
recordResults: timer for: aSelector
	| result name |
	name := suite benchmarkNameForSelector: aSelector.
	
	result := SMarkResult new.
	result total: timer totalTime.
	result benchmarkName: name.
	result suite: suite.
	result criteria: timers.
	
	(results at: name ifAbsentPut: OrderedCollection new) add: result.