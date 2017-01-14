control primitives
filterPerformOf: selector to: receiver
	"This is to allow simulator to filter start-up items to avoid as-yet unsimulatable plugins."
	performFilters ifNil: [^false].
	(performFilters at: (self shortPrint: receiver) ifAbsent: []) ifNotNil:
		[:messages|
		^messages includes: (self stringOf: selector)].
	^false