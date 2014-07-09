accessing
problemSize: aValue
	"Do some conversion to make it easier for the benchmarks"
	(aValue isString and: [aValue isAllDigits]) ifTrue: [
		problemSize := Number readFrom: aValue.
		^ self.
	].

	problemSize := aValue