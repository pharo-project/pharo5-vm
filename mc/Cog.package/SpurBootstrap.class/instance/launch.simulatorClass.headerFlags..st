testing
launch: heap simulatorClass: simulatorClass headerFlags: headerFlags
	| sim methodCacheSize |
	sim := simulatorClass onObjectMemory: heap.
	heap coInterpreter: sim.
	(sim class allInstVarNames includes: 'cogCodeSize')
		ifTrue:
			[sim initializeInterpreter: 0.
			 methodCacheSize := sim methodCache size * heap wordSize.
			 sim instVarNamed: 'heapBase' put: heap startOfMemory;
				instVarNamed: 'numStackPages' put: 8;
				instVarNamed: 'cogCodeSize' put: 1024*1024;
				moveMethodCacheToMemoryAt: sim cogCodeSize + sim computeStackZoneSize;
				movePrimTraceLogToMemoryAt: sim cogCodeSize + sim computeStackZoneSize + methodCacheSize;
				"sendTrace: 1+ 2 + 8 + 16;"
			 	initializeCodeGenerator]
		ifFalse:
			[sim initializeInterpreter: 0].
	heap
		initializeNewSpaceVariables;
		bootstrapping: false;
		assimilateNewSegment: (heap segmentManager segments at: 0).
	sim
		setImageHeaderFlagsFrom: headerFlags;
		imageName: ImageName;
		flushExternalPrimitives;
		openAsMorph;
		transcript: Transcript. "deep copy copies this"
	"sim
		instVarNamed: 'printSends' put: true;
		instVarNamed: 'printReturns' put: true;
		instVarNamed: 'methodDictLinearSearchLimit' put: SmallInteger maxVal." "for now"
	heap
		setCheckForLeaks: 0;
		runLeakCheckerForFullGC.

	sim halt; run