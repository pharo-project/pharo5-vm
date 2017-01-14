primitive support
checkForAndFollowForwardedPrimitiveState
	"Override to log"
	<option: #SpurObjectMemory>
	| found |
	cogit recordPrimTrace ifTrue:
		[self fastLogPrim: TracePrimitiveFailure].
	found := super checkForAndFollowForwardedPrimitiveState.
	(found and: [cogit recordPrimTrace]) ifTrue:
		[self fastLogPrim: TracePrimitiveRetry].
	^found