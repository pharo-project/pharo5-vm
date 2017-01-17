frame access
isStillMarriedContext: aContext
	"Answer if aContext is married or widowed and still married.
	 If a context is widowed then turn it into a single dead context."
	^(self isMarriedOrWidowedContext: aContext)
	    and: [(self isWidowedContext: aContext) not]