frame access
internalMustMapMachineCodePC: theIP context: aOnceMarriedContext
	"Must externalize before calling mustMapMachineCodePC:context:
	 because it may cause a code compaction."
	| result |
	self externalizeIPandSP.
	result := self mustMapMachineCodePC: theIP context: aOnceMarriedContext.
	self internalizeIPandSP.
	^result