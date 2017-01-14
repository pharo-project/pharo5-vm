process primitives
primitiveSuspend
	"Primitive. Suspend the receiver, aProcess such that it can be executed again
	by sending #resume. If the given process is not currently running, take it off
	its corresponding list. The primitive returns the list the receiver was previously on."
	| process myList |
	process := self stackTop.
	process = self activeProcess ifTrue:
		[self pop: 1 thenPush: objectMemory nilObject.
		 ^self transferTo: self wakeHighestPriority].
	myList := objectMemory fetchPointer: MyListIndex ofObject: process.
	"XXXX Fixme. We should really check whether myList is a kind of LinkedList or not
	but we can't easily so just do a quick check for nil which is the most common case."
	myList = objectMemory nilObject ifTrue:
		[^self primitiveFailFor: PrimErrBadReceiver].
	"Alas in Spur we need a read barrier"
	(objectMemory isForwarded: myList) ifTrue:
		[myList := objectMemory followForwarded: myList.
		 objectMemory storePointer: MyListIndex ofObject: process withValue: myList].
	self removeProcess: process fromList: myList.
	self successful ifTrue:
		[objectMemory storePointer: MyListIndex ofObject: process withValue: objectMemory nilObject.
		 self pop: 1 thenPush: myList]