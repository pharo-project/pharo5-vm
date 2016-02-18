saving
snapshot
	Spur32BitMMLESimulator adoptInstance: heap.
	interpreter imageName: 'munged-', (FileDirectory default localNameFor: interpreter imageName).
	[heap parent: heap; setCheckForLeaks: 15; garbageCollectForSnapshot]
		on: Halt
		do: [:ex|
			"suppress halts from the usual suspects (development time halts)"
			(#(fullGC globalGarbageCollect) includes: ex signalerContext sender selector)
				ifTrue: [ex resume]
				ifFalse: [ex pass]].
	interpreter
		setDisplayForm: nil; "gets it to use savedWindowSize"
		writeImageFileIO.
	Transcript cr; show: 'Done!'