primitive support
retryPrimitiveOnFailure
	"In Spur two cases of primitive failure are handled specially.  A primitive may fail due to validation
	 encountering a forwarder. On failure, check the accessorDepth for the primitive and if non-negative
	 scan the args to the depth, following any forwarders.  Retry the primitive if any are found.  Hence
	 lazily and transparently following forwarders on primtiive failure.  Additionally a prmitive might fail
	 due to an allocation failing.  Retry if external primitives have failed with PrimErrNoMemory after running
	 first the scavenger and then on a subsequent failure, the global mark-sweep collector.  Hence lazily
	 and transparently GC on memory exhaustion."
	<option: #SpurObjectMemory>
	<inline: false>
	| gcDone followDone canRetry retry retried |
	gcDone := 0.
	followDone := canRetry := retried := false.
	[retry := false.
	 primFailCode = PrimErrNoMemory
		ifTrue:
			[(gcDone := gcDone + 1) = 1 ifTrue:
				[canRetry := self isExternalPrimitiveCall: newMethod].
			 canRetry ifTrue:
				 [gcDone = 1 ifTrue:
					[objectMemory scavengingGC].
				 gcDone = 2 ifTrue:
					[objectMemory fullGC].
				 retry := gcDone <= 2]]
		 ifFalse:
			[followDone ifFalse:
				[followDone := true.
				 retry := self checkForAndFollowForwardedPrimitiveState]].
	 retry] whileTrue:
		[self assert: primFailCode ~= 0.
		 retried := true.
		 self initPrimCall.
		 self cCode: [] inSmalltalk:
			[self maybeMapPrimitiveFunctionPointerBackToSomethingEvaluable].
		 self dispatchFunctionPointer: primitiveFunctionPointer].
	^retried