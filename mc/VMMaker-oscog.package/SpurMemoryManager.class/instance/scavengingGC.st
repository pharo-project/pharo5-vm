generation scavenging
scavengingGC
	"Run the scavenger."

	self assert: remapBufferCount = 0.
	self assert: self totalFreeListBytes = totalFreeOldSpace.
	"coInterpreter printCallStackFP: coInterpreter framePointer"

	self runLeakCheckerForFullGC: false.
	coInterpreter preGCAction: GCModeIncr.
	needGCFlag := false.

	gcStartUsecs := coInterpreter ioUTCMicrosecondsNow.

	scavengeInProgress := true.
	pastSpaceStart := scavenger scavenge.
	self assert: (self
					oop: pastSpaceStart
					isGreaterThanOrEqualTo: scavenger pastSpace start
					andLessThanOrEqualTo: scavenger pastSpace limit).
	freeStart := scavenger eden start.
	self initSpaceForAllocationCheck: scavenger eden.
	scavengeInProgress := false.

	statScavenges := statScavenges + 1.
	statGCEndUsecs := coInterpreter ioUTCMicrosecondsNow.
	statSGCDeltaUsecs := statGCEndUsecs - gcStartUsecs.
	statScavengeGCUsecs := statScavengeGCUsecs + statSGCDeltaUsecs.

	coInterpreter postGCAction.
	self runLeakCheckerForFullGC: false.

	self assert: self totalFreeListBytes = totalFreeOldSpace