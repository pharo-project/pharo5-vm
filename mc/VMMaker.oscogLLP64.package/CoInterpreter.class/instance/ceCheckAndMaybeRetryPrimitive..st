primitive support
ceCheckAndMaybeRetryPrimitive: primIndex
	"Log failure and then retry if there's an accessorDepth or failure due to no memory."
	<api>
	<option: #SpurObjectMemory>
	| retried |
	cogit recordPrimTrace ifTrue:
		[self fastLogPrim: TracePrimitiveFailure].
	retried := self retryPrimitiveOnFailure.
	(retried and: [cogit recordPrimTrace]) ifTrue:
		[self fastLogPrim: TracePrimitiveRetry]