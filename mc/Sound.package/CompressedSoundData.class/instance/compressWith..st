as yet unclassified
compressWith: codecClass

	codecName == codecClass name asSymbol ifTrue: [^self].
	^self asSound compressWith: codecClass