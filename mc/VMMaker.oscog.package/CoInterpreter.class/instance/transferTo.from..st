process primitive support
transferTo: newProc from: sourceCode
	"Record a process to be awoken on the next interpreter cycle.
	 Reimplement to record the source of the switch for debugging,
	 and to cope with possible code compaction in makeBaseFrameFor:."
	| activeContext sched oldProc |
	<inline: false>
	self recordContextSwitchFrom: self activeProcess in: sourceCode.
	statProcessSwitch := statProcessSwitch + 1.
	self push: instructionPointer.
	self externalWriteBackHeadFramePointers.
	self assertValidExecutionPointe: instructionPointer r: framePointer s: stackPointer.
	"ensureMethodIsCogged: in makeBaseFrameFor: in
	 externalSetStackPageAndPointersForSuspendedContextOfProcess:
	 below may do a code compaction. Nil instructionPointer to avoid it getting pushed twice."
	instructionPointer := 0.
	sched := self schedulerPointer.
	oldProc := objectMemory fetchPointer: ActiveProcessIndex ofObject: sched.
	activeContext := self ensureFrameIsMarried: framePointer SP: stackPointer + BytesPerWord.
	objectMemory storePointer: SuspendedContextIndex ofObject: oldProc withValue: activeContext.
	objectMemory storePointer: ActiveProcessIndex ofObject: sched withValue: newProc.
	objectMemory storePointerUnchecked: MyListIndex ofObject: newProc withValue: objectMemory nilObject.
	self externalSetStackPageAndPointersForSuspendedContextOfProcess: newProc