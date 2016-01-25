gc - scavenging
scavengingGCTenuringIf: tenuringCriterion
	"Run the scavenger."
	<inline: false>
	self assert: remapBufferCount = 0.
	(self asserta: scavenger eden limit - freeStart > coInterpreter interpreterAllocationReserveBytes) ifFalse:
		[coInterpreter tab;
			printNum: scavenger eden limit - freeStart; space;
			printNum: coInterpreter interpreterAllocationReserveBytes; space;
			printNum: coInterpreter interpreterAllocationReserveBytes - (scavenger eden limit - freeStart); cr].
	self checkMemoryMap.
	self checkFreeSpace: GCModeNewSpace.
	self runLeakCheckerFor: GCModeNewSpace.

	coInterpreter
		preGCAction: GCModeNewSpace;
		"would prefer this to be in mapInterpreterOops, but
		 compatibility with ObjectMemory dictates it goes here."
		flushMethodCacheFrom: newSpaceStart to: newSpaceLimit.
	needGCFlag := false.

	gcStartUsecs := coInterpreter ioUTCMicrosecondsNow.

	self doScavenge: tenuringCriterion.

	statScavenges := statScavenges + 1.
	statGCEndUsecs := coInterpreter ioUTCMicrosecondsNow.
	statSGCDeltaUsecs := statGCEndUsecs - gcStartUsecs.
	statScavengeGCUsecs := statScavengeGCUsecs + statSGCDeltaUsecs.
	statRootTableCount := scavenger rememberedSetSize.

	coInterpreter postGCAction: GCModeNewSpace.

	self runLeakCheckerFor: GCModeNewSpace.
	self checkFreeSpace: GCModeNewSpace