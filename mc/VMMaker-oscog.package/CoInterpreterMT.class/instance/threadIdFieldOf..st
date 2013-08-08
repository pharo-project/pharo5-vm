process primitive support
threadIdFieldOf: aProcess
	^processHasThreadId
		ifTrue: [objectMemory fetchPointer: ThreadIdIndex ofObject: aProcess]
		ifFalse: [objectMemory nilObject]