utilities
hasUnrenamableCCode
	"Answer true if the receiver uses inlined C or complex C declarations,
	 which are not currently renamed properly by the the inliner."

	declarations keysAndValuesDo:
		[:name :value|
		((value endsWith: name)
		 or: [value == #implicit]) ifFalse: 
			[^true]].

	parseTree nodesDo:
		[:node|
		(node isSend
		 and: [node isNonNullCCode]) ifTrue:
			[^true]].
	^false