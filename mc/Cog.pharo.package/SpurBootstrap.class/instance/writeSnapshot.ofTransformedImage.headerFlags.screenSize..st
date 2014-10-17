testing
writeSnapshot: imageFileName ofTransformedImage: spurHeap headerFlags: headerFlags screenSize: screenSizeInteger
	"The bootstrapped image typically contains a few big free chunks and one huge free chunk.
	 Test snapshot writing and loading by turning the largest non-huge chunks into segment bridges
	 and saving."
	| penultimate ultimate sizes counts barriers sim |
	sim := StackInterpreterSimulator onObjectMemory: spurHeap.
	sim bootstrapping: true.
	spurHeap
		coInterpreter: sim;
		setEndOfMemory: spurHeap endOfMemory + spurHeap bridgeSize. "hack; initializeInterpreter: cuts it back by bridgeSize"
	sim initializeInterpreter: 0;
		setImageHeaderFlagsFrom: headerFlags;
		setDisplayForm: (Form extent: screenSizeInteger >> 16 @ (screenSizeInteger bitAnd: 16rFFFF)).
	spurHeap allOldSpaceEntitiesDo: [:e| penultimate := ultimate. ultimate := e].
	(spurHeap isFreeObject: penultimate) ifTrue: "old, pre-pigCompact segmented save"
		[self assert: (spurHeap isSegmentBridge: ultimate).
		 sizes := Bag new.
		 spurHeap allObjectsInFreeTree: (spurHeap freeLists at: 0) do:
			[:f|
			sizes add: (spurHeap bytesInObject: f)].
		 counts := sizes sortedCounts.
		 self assert: counts last key = 1. "1 huge chunk"
		 counts size > 1
			ifTrue:
				[self assert: ((counts at: counts size - 1) key > 2
							and: [(counts at: counts size - 1) value > 1024]).
				barriers := (1 to: (counts at: counts size - 1) key) collect:
								[:ign| spurHeap allocateOldSpaceChunkOfExactlyBytes: (counts at: counts size - 1) value].
				barriers := barriers, {spurHeap allocateOldSpaceChunkOfExactlyBytes: (spurHeap bytesInObject: penultimate)}]
			ifFalse:
				[barriers := {spurHeap allocateOldSpaceChunkOfExactlyBytes: (spurHeap bytesInObject: penultimate)}].
		 barriers last ifNotNil:
			[:end|
			spurHeap setEndOfMemory: end.
			spurHeap allOldSpaceEntitiesDo: [:e| penultimate := ultimate. ultimate := e].
			self assert: (spurHeap addressAfter: ultimate) = end]].
	spurHeap checkFreeSpace.
	spurHeap runLeakCheckerForFullGC: true.
	barriers ifNotNil: "old, pre-pigCompact segmented save"
		[spurHeap segmentManager initializeFromFreeChunks: (barriers sort collect: [:b| spurHeap objectStartingAt: b])].
	spurHeap checkFreeSpace.
	spurHeap runLeakCheckerForFullGC: true.
	sim bereaveAllMarriedContextsForSnapshotFlushingExternalPrimitivesIf: true.
	sim imageName: imageFileName.
	sim writeImageFileIO