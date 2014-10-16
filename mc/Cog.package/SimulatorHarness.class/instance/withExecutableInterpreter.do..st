bootstrap methods
withExecutableInterpreter: sim do: aBlock
	"With the oldInterpreter ready to execute code, evaluate aBlock,
	 then return the interpreter (and the heap) to the ``just snapshotted'' state."
	| savedpc savedfp initialContext finalContext |
	sim
		initStackPages;
		loadInitialContext;
		internalizeIPandSP.
	savedpc := sim localIP.
	savedfp := sim localFP.
	"sim printHeadFrame."
	aBlock value.
	"sim printHeadFrame."
	sim
		internalPush: sim localIP;
		externalizeIPandSP.
	"now undo the execution state"
	self assert: sim localFP = savedfp.
	initialContext := sim frameContext: savedfp.
	finalContext := sim voidVMStateForSnapshotFlushingExternalPrimitivesIf: false.
	self assert: initialContext = finalContext.
	self assert: sim localIP = savedpc.
	sim objectMemory
		storePointer: SuspendedContextIndex
		ofObject: sim activeProcess
		withValue: finalContext