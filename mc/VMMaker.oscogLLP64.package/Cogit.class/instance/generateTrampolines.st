initialization
generateTrampolines
	"Generate the run-time entries and exits at the base of the native code zone and update the base.
	 Read the class-side method trampolines for documentation on the various trampolines"
	| methodZoneStart |
	methodZoneStart := methodZoneBase.
	methodLabel address: methodZoneStart.
	self allocateOpcodes: 80 bytecodes: 0.
	hasYoungReferent := false.
	objectRepresentation maybeGenerateSelectorIndexDereferenceRoutine.
	self generateSendTrampolines.
	self generateMissAbortTrampolines.
	objectRepresentation generateObjectRepresentationTrampolines.
	self generateRunTimeTrampolines.
	NewspeakVM ifTrue: [self generateNewspeakRuntime].
	SistaVM ifTrue: [self generateSistaRuntime].
	self generateEnilopmarts.
	self generateTracingTrampolines.

	"finish up"
	self recordGeneratedRunTime: 'methodZoneBase' address: methodZoneBase.
	processor flushICacheFrom: methodZoneStart asUnsignedInteger to: methodZoneBase asUnsignedInteger