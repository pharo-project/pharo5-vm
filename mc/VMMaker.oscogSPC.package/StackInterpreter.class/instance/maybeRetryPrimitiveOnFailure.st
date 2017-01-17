primitive support
maybeRetryPrimitiveOnFailure
	"In Spur two cases of pirmitive failure are handled specially.  A primitive may fail due to validation
	 encountering a forwarder. On failure, check the accessorDepth for the primitive and if non-negative
	 scan the args to the depth, following any forwarders.  Retry the primitive if any are found.  Hence
	 lazily and transparently following forwarders on primtiive failue.  Additionally a prmitive might fail
	 due to an allocation failing.  Retry if primitives have failed with PrimErrNoMemory after running
	 first the scavenger and then on a subsequent failure, the global mark-sweep collector.  Hence lazily
	 and transparently GC on memory exhaustion."
	<inline: true>
	(objectMemory hasSpurMemoryManagerAPI and: [self failed]) ifTrue:
		[self retryPrimitiveOnFailure]