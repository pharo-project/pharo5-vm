as yet unclassified
compressWith: codecClass atRate: aSamplingRate

	(codecName == codecClass name asSymbol and: [samplingRate = aSamplingRate]) ifTrue: [^self].
	^self asSound compressWith: codecClass atRate: aSamplingRate