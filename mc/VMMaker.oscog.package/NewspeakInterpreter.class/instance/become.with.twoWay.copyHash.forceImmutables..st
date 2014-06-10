become
become: array1 with: array2 twoWay: twoWayFlag copyHash: copyHashFlag forceImmutables: immutablesOk 
	"All references to each object in array1 are swapped with all references to the corresponding object in array2. That is, all pointers to one object are replaced with with pointers to the other. The arguments must be arrays of the same length. 
	Returns true if the primitive succeeds."
	"Implementation: Uses forwarding blocks to update references as done in compaction."
	| start |
	(self isArray: array1) ifFalse:
		[^PrimErrBadReceiver].
	((self isArray: array2)
	 and: [(self lastPointerOf: array1) = (self lastPointerOf: array2)]) ifFalse:
		[^PrimErrBadArgument].
	(self containOnlyOops: array1 and: array2) ifFalse:
		[PrimErrInappropriate].
	"This code fails the primitive if it should fail for immutables and objects
	 that are being becommed are immutable. This is debateable.  Instead we
	 could have it that we fail only if the referents are immutable."
	immutablesOk ifFalse:
		[(self containOnlyMutableOops: array1 and: array2) ifFalse:
			[^PrimErrNoModification]].

	(self prepareForwardingTableForBecoming: array1 with: array2 twoWay: twoWayFlag) ifFalse:
		[^PrimErrNoMemory]. "fail; not enough space for forwarding table"

	(self allYoung: array1 and: array2)
		ifTrue: [start := youngStart"sweep only the young objects plus the roots"]
		ifFalse: [start := self startOfMemory"sweep all objects"].
	immutablesOk ifFalse:
		["Search for any references to a forwarded object in an immutable.
		 Fail if any exist."
		 (self existImmutableReferencesToForwardedInRangeFrom: start to: endOfMemory) ifTrue:
			[twoWayFlag
				ifTrue: [self restoreHeadersAfterBecoming: array1 with: array2]
				ifFalse: [self restoreHeadersAfterForwardBecome: copyHashFlag].
			 ^PrimErrNoModification]].
	self mapPointersInObjectsFrom: start to: endOfMemory.
	twoWayFlag
		ifTrue: [self restoreHeadersAfterBecoming: array1 with: array2]
		ifFalse: [self restoreHeadersAfterForwardBecome: copyHashFlag].

	self initializeMemoryFirstFree: freeBlock. "re-initialize memory used for forwarding table"
	
	self forceInterruptCheck. "pretty much guaranteed to take a long time, so check for timers etc ASAP"

	^PrimNoErr "success"