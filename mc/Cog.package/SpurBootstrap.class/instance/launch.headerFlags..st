testing
launch: heap headerFlags: headerFlags
	| sim |
	sim := StackInterpreterSimulator onObjectMemory: heap.
	heap coInterpreter: sim.
	sim
		initializeInterpreter: 0;
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
		setCheckForLeaks: 15;
		runLeakCheckerForFullGC: true.

	sim halt; run