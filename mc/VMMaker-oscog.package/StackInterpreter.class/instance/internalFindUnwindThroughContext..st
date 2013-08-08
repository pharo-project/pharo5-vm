return bytecodes
internalFindUnwindThroughContext: homeContext
	"Search for either an unwind-protect (activation of method with primitive 198)
	 or homeContext along the sender chain, which ever is found first.  If homeContext
	 is not found answer nilObj, indicating cannotReturn:.  If homeContext is found
	 answer 0.  If homeContext is itself an unwind-protect answer the context, not 0."
	self externalizeIPandSP.
	^self findUnwindThroughContext: homeContext