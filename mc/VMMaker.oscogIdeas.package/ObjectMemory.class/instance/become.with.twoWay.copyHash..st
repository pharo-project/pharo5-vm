become
become: array1 with: array2 twoWay: twoWayFlag copyHash: copyHashFlag 
	"All references to each object in array1 are swapped with all references to the corresponding
	 object in array2. That is, all pointers to one object are replaced with with pointers to the other.
	 The arguments must be arrays of the same length.  Ansswer if the operation succeeds."

	"Implementation: Uses forwarding blocks to update references as done in compaction."
	(self isArray: array1) ifFalse: [^false].
	(self isArray: array2) ifFalse: [^false].
	(self lastPointerOf: array1) = (self lastPointerOf: array2) ifFalse: [^false].
	(twoWayFlag or: [copyHashFlag])
		ifTrue: [(self containOnlyOops: array1 and: array2) ifFalse: [^false]]
		ifFalse: [(self containOnlyOops: array1) ifFalse: [^false]].

	(self prepareForwardingTableForBecoming: array1 with: array2 twoWay: twoWayFlag) ifFalse:
		[^false]. "fail; not enough space for forwarding table"

	(self allYoung: array1 and: array2)
		ifTrue: ["sweep only the young objects plus the roots"
			self mapPointersInObjectsFrom: youngStart to: endOfMemory]
		ifFalse: ["sweep all objects"
			self mapPointersInObjectsFrom: self startOfMemory to: endOfMemory].
	twoWayFlag
		ifTrue: [self restoreHeadersAfterBecoming: array1 with: array2]
		ifFalse: [self restoreHeadersAfterForwardBecome: copyHashFlag].

	self initializeMemoryFirstFree: freeBlock. "re-initialize memory used for forwarding table"
	
	self forceInterruptCheck. "pretty much guaranteed to take a long time, so check for timers etc ASAP"

	^true "success"