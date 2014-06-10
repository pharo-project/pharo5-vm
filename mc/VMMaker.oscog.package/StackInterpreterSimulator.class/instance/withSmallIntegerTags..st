frame access
withSmallIntegerTags: value
	"The simulator works with strictly positive bit patterns"
	^value < 0
		ifTrue: [(value bitAnd: 16rFFFFFFFF) + 1]
		ifFalse: [value + 1]