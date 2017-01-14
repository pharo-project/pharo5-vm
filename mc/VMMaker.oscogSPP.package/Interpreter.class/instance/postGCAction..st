object memory support
postGCAction: gcModeArg
	"Mark the active and home contexts as roots if old. This 
	allows the interpreter to use storePointerUnchecked to 
	store into them."

	compilerInitialized
		ifTrue: [self compilerPostGC]
		ifFalse: [(self oop: activeContext isLessThan: youngStart)
				ifTrue: [self beRootIfOld: activeContext].
			(self oop: theHomeContext isLessThan: youngStart)
				ifTrue: [self beRootIfOld: theHomeContext]].
	(self sizeOfFree: freeBlock) > shrinkThreshold
		ifTrue: ["Attempt to shrink memory after successfully 
			reclaiming lots of memory"
			self shrinkObjectMemory: (self sizeOfFree: freeBlock) - growHeadroom].
	
	self signalSemaphoreWithIndex: gcSemaphoreIndex.
