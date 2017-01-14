object memory support
followSemaphoreIn: anArray at: index
	"Only follow the reference to the semaphore.  synchronousSignal
	 checks the chain to the suspendedContext."
	 
	| obj |
	obj := objectMemory fetchPointer: index ofObject: anArray.
	(objectMemory isForwarded: obj) ifTrue:
		[obj := objectMemory followForwarded: obj.
		 objectMemory storePointer: index ofObject: anArray withValue: obj]