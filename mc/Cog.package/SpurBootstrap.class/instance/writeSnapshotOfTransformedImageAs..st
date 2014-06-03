testing
writeSnapshotOfTransformedImageAs: imageFileName
	"The bootstrapped image typically contains a few big free chunks and one huge free chunk.
	 Test snapshot writing and loading by turning the largest non-huge chunks into segment bridges
	 and saving."
	| penultimate ultimate heap sizes counts barriers sim |
	heap := TransformedImage veryDeepCopy.
	sim := StackInterpreterSimulator onObjectMemory: heap.
	sim bootstrapping: true.
	heap coInterpreter: sim.
	sim initializeInterpreter: 0;
		setImageHeaderFlagsFrom: ImageHeaderFlags;
		setDisplayForm: (Form extent: ImageScreenSize >> 16 @ (ImageScreenSize bitAnd: 16rFFFF)).
	heap allOldSpaceEntitiesDo: [:e| penultimate := ultimate. ultimate := e].
	self assert: (heap isFreeObject: penultimate).
	self assert: (heap isSegmentBridge: ultimate).
	sizes := Bag new.
	heap allObjectsInFreeTree: (heap freeLists at: 0) do:
		[:f|
		sizes add: (heap bytesInObject: f)].
	counts := sizes sortedCounts.
	self assert: counts last key = 1. "1 huge chunk"
	counts size > 1
		ifTrue:
			[self assert: ((counts at: counts size - 1) key > 2
						and: [(counts at: counts size - 1) value > 1024]).
			barriers := (1 to: (counts at: counts size - 1) key) collect:
							[:ign| heap allocateOldSpaceChunkOfExactlyBytes: (counts at: counts size - 1) value].
			barriers := barriers, {heap allocateOldSpaceChunkOfExactlyBytes: (heap bytesInObject: penultimate)}]
		ifFalse:
			[barriers := {heap allocateOldSpaceChunkOfExactlyBytes: (heap bytesInObject: penultimate)}].
	heap setEndOfMemory: barriers last.
	heap allOldSpaceEntitiesDo: [:e| penultimate := ultimate. ultimate := e].
	self assert: (heap addressAfter: ultimate) = barriers last.
	heap checkFreeSpace.
	heap runLeakCheckerForFullGC: true.
	heap segmentManager initializeFromFreeChunks: (barriers sort collect: [:b| heap objectStartingAt: b]).
	heap checkFreeSpace.
	heap runLeakCheckerForFullGC: true.
	sim bereaveAllMarriedContextsForSnapshotFlushingExternalPrimitivesIf: true.
	sim imageName: imageFileName.
	sim writeImageFileIO