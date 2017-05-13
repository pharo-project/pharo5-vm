object memory support
postGCAction: gcModeArg
	"Signal the gc semaphore, and inform the display subsystem if the display bitmap has moved."

	self signalSemaphoreWithIndex: gcSemaphoreIndex.
	objectMemory hasSpurMemoryManagerAPI ifFalse:
		[| displayObj bitsOop bitsNow |
		 displayObj := objectMemory splObj: TheDisplay.
		 ((objectMemory isPointers: displayObj)
		  and: [(objectMemory lengthOf: displayObj) >= 4
		  and: [objectMemory isWordsOrBytes: (bitsOop := objectMemory fetchPointer: 0 ofObject: displayObj)]]) ifTrue:
			[bitsNow := self cCode: [objectMemory firstIndexableField: bitsOop]
							inSmalltalk: [(objectMemory firstIndexableField: bitsOop) asInteger].
			 displayBits ~= bitsNow ifTrue:
				[displayBits := bitsNow.
				 self ioNoteDisplayChanged: displayBits width: displayWidth height: displayHeight depth: displayDepth]]]