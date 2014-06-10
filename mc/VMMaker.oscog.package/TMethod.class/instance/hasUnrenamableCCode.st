utilities
hasUnrenamableCCode
	"Answer true if the receiver uses inlined C which
	 is not currently renamed properly by the the inliner."

	^parseTree anySatisfy:
		[:node| node isNonNullCCode]