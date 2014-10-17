helper
benchmarkNameForSelector: selector
	"Extracts the actual name of the benchmark from the selector"
	(selector beginsWith: #bench) ifTrue: [ ^ selector copyFrom: 6 to: selector size].
	^ selector asSymbol
	