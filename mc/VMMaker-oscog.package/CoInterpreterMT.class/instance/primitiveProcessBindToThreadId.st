process primitives
primitiveProcessBindToThreadId
	"Attempt to bind the receiver to the thread with the id of the argument or nil, where the receiver is a Process.
	 If successful the VM will ensure that there are at least id many threads active."
	| aProcess id ec |
	<export: true>
	self cCode: [] inSmalltalk: [cogThreadManager isNil ifTrue: [^self primitiveFail]].
	id := self stackTop.
	aProcess := self stackValue: 1.
	((id = objectMemory nilObject or: [(objectMemory isIntegerObject: id)
										and: [(objectMemory integerValueOf: id) >= 0]])
	and: [(objectMemory isPointers: aProcess)
	and: [(objectMemory slotSizeOf: aProcess) >= (ThreadIdIndex + 1)]]) ifFalse:
		[^self primitiveFailFor: PrimErrBadArgument].
	id := id = objectMemory nilObject ifTrue: [0] ifFalse: [objectMemory integerValueOf: id].
	id >= cogThreadManager maxNumThreads ifTrue:
		[^self primitiveFailFor: PrimErrLimitExceeded].
	(ec := self bindProcess: aProcess toId: id) ~= 0 ifTrue:
		[^self primitiveFailFor: ec].
	(aProcess = self activeProcess
	and: [(activeProcessAffined := id ~= 0)
	and: [id ~= cogThreadManager getVMOwner]]) ifTrue:
		[(self quickFetchInteger: PriorityIndex ofObject: aProcess) < maxWaitingPriority ifTrue:
			[maxWaitingPriority = self quickFetchInteger: PriorityIndex ofObject: aProcess].
		 checkThreadActivation := true.
		 self forceInterruptCheck].
	self pop: argumentCount