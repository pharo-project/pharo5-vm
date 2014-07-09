object memory support
traceProfileState
	objectMemory hasSpurMemoryManagerAPI ifTrue:
		[self followForwardingPointersInProfileState].
	objectMemory markAndTrace: profileProcess.
	objectMemory markAndTrace: profileMethod.
	objectMemory markAndTrace: profileSemaphore.

	"The longRunningPrimitiveCheckMethod (LRPCM) is sampled in an interrupt.  Be very careful with it.
	  If longRunningPrimitiveCheckSequenceNumber (LRPCSN) = statCheckForEvents then LRPCM has
	  been recenty sampled, but it must be newMethod and we don't need to trace it twice.  If LRPCSN
	  ~= statCheckForEvents then LRPCM must be some extant object and needs to be traced."
	self sqLowLevelMFence.
	(longRunningPrimitiveCheckMethod ~= nil
	 and: [longRunningPrimitiveCheckSequenceNumber ~= statCheckForEvents]) ifTrue:
		[(objectMemory isForwarded: longRunningPrimitiveCheckMethod) ifTrue:
			[longRunningPrimitiveCheckMethod := objectMemory followForwarded: longRunningPrimitiveCheckMethod].
	objectMemory markAndTrace: longRunningPrimitiveCheckMethod].
	longRunningPrimitiveCheckSemaphore ~= nil ifTrue:
		[(objectMemory isForwarded: longRunningPrimitiveCheckSemaphore) ifTrue:
			[longRunningPrimitiveCheckSemaphore := objectMemory followForwarded: longRunningPrimitiveCheckSemaphore].
		 objectMemory markAndTrace: longRunningPrimitiveCheckSemaphore]