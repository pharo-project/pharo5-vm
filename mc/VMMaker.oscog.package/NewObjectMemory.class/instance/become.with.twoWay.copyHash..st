become
become: array1 with: array2 twoWay: twoWayFlag copyHash: copyHashFlag
	"All references to each object in array1 are swapped with all references to the corresponding object in array2. That is, all pointers to one object are replaced with with pointers to the other. The arguments must be arrays of the same length. 
	Returns PrimNoErr if the primitive succeeds."
	"Implementation: Uses forwarding blocks to update references as done in compaction."
	| start |
	self runLeakCheckerFor: GCModeBecome.
	(self isArray: array1) ifFalse:
		[^PrimErrBadReceiver].
	((self isArray: array2)
	 and: [(self lastPointerOf: array1) = (self lastPointerOf: array2)]) ifFalse:
		[^PrimErrBadArgument].
	(twoWayFlag or: [copyHashFlag])
		ifTrue: [(self containOnlyOops: array1 and: array2) ifFalse: [^PrimErrInappropriate]]
		ifFalse: [(self containOnlyOops: array1) ifFalse: [^PrimErrInappropriate]].

	(self prepareForwardingTableForBecoming: array1 with: array2 twoWay: twoWayFlag) ifFalse:
		[^PrimErrNoMemory]. "fail; not enough space for forwarding table"

	(self allYoung: array1 and: array2)
		ifTrue: [start := youngStart"sweep only the young objects plus the roots"]
		ifFalse: [start := self startOfMemory"sweep all objects"].
	coInterpreter preBecomeAction.
	self mapPointersInObjectsFrom: start to: freeStart.
	twoWayFlag
		ifTrue: [self restoreHeadersAfterBecoming: array1 with: array2]
		ifFalse: [self restoreHeadersAfterForwardBecome: copyHashFlag].
	coInterpreter postBecomeAction: 0.

	self initializeMemoryFirstFree: freeStart. "re-initialize memory used for forwarding table"
	self runLeakCheckerFor: GCModeBecome.

	^PrimNoErr "success"