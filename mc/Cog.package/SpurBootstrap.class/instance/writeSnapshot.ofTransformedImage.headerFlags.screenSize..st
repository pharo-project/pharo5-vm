testing
writeSnapshot: imageFileName ofTransformedImage: spurHeap headerFlags: headerFlags screenSize: screenSizeInteger
	"The bootstrapped image typically contains a few big free chunks and one huge free chunk.
	 Test snapshot writing and loading by turning the largest non-huge chunks into segment bridges
	 and saving."
	| penultimate ultimate sim |
	sim := StackInterpreterSimulator onObjectMemory: spurHeap.
	sim bootstrapping: true.
	spurHeap
		coInterpreter: sim;
		setEndOfMemory: spurHeap endOfMemory + spurHeap bridgeSize. "hack; initializeInterpreter: cuts it back by bridgeSize"
	sim initializeInterpreter: 0;
		setImageHeaderFlagsFrom: headerFlags;
		setSavedWindowSize: screenSizeInteger;
		setDisplayForm: nil.
	spurHeap allOldSpaceEntitiesDo: [:e| penultimate := ultimate. ultimate := e].
	"Check that we've left behind the old, pre-pigCompact segmented save"
	self assert: (spurHeap isFreeObject: penultimate) not.
	spurHeap checkFreeSpace.
	spurHeap runLeakCheckerForFullGC.
	sim bereaveAllMarriedContextsForSnapshotFlushingExternalPrimitivesIf: true.
	sim imageName: imageFileName.
	sim writeImageFileIO.
	Transcript cr; show: 'Done!'