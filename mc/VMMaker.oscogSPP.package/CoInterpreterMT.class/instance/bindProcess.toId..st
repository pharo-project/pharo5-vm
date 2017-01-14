process primitive support
bindProcess: aProcess toId: newId
	"Change a Process's thread binding and answer 0, otherwise answer a suitable error code.
	 Cases:
		process is unbound & unaffined
			id 0 nothing to do
			id non-zero ensure thread and bind
		process is affined (temporarily bound to a thread for the duration of a surrender of ownership)
			id = affined index nothing to do
			id = 0 nothing to do
			id ~= 0 && id ~= affined index fail
		process is bound (permanently bound to a thread)
			id = bound index nothing to do
			id ~= bound index set bound index"
	| threadId ownerIndex newThreadIndex |
	processHasThreadId ifFalse:
		[^PrimErrUnsupported].

	threadId := self threadIdFieldOf: aProcess.
	newThreadIndex := self ownerIndexOfThreadId: newId.
	ownerIndex := self ownerIndexOfThreadId: threadId.

	(self isAffinedThreadId: threadId) ifTrue:
		[(ownerIndex = newId
		  or: [newId = 0]) ifTrue:
			[^0].
		^PrimErrInappropriate].

	newThreadIndex > 0 ifTrue:
		[(self startThreadForThreadIndex: newThreadIndex) ifFalse:
			[^PrimErrLimitExceeded]].

	self setOwnerIndexOfProcess: aProcess to: newId bind: true.
	^0