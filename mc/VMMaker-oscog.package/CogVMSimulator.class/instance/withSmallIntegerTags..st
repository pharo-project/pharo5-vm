frame access
withSmallIntegerTags: aValueOrSurrogate
	"The simulator works with strictly positive bit patterns"
	| value |
	value := aValueOrSurrogate asInteger.
	^value < 0
		ifTrue: [(value bitAnd: 16rFFFFFFFF) + 1]
		ifFalse: [value + 1]