header format
classFormatForInstanceFormat: aFormat
	"Clear any odd bits from the format so that it matches its class's format"
	aFormat < self firstLongFormat ifTrue:
		[^aFormat].
	aFormat >= self firstByteFormat ifTrue:
		[^aFormat bitAnd: -8].
	^aFormat >= self firstShortFormat
		ifTrue: [aFormat bitAnd: -4]
		ifFalse: [aFormat bitAnd: -2]