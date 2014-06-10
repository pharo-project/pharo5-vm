initialization
generateTrampolines
	"Generate the run-time entries and exits at the base of the native code zone and update the base.
	 Read the class-side method trampolines for documentation on the various trampolines"
	| methodZoneStart |
	methodZoneStart := methodZoneBase.
	self allocateOpcodes: 80 bytecodes: 0.
	initialPC := 0.
	endPC := numAbstractOpcodes - 1.
	hasYoungReferent := false.
	self generateSendTrampolines.
	self generateMissAbortTrampolines.
	objectRepresentation generateObjectRepresentationTrampolines.
	self generateRunTimeTrampolines.
	self cppIf: NewspeakVM ifTrue: 	[self generateNewspeakRuntime].
	self generateEnilopmarts.
	self generateTracingTrampolines.

	"finish up"
	self recordGeneratedRunTime: 'methodZoneBase' address: methodZoneBase.
	processor flushICacheFrom: methodZoneStart to: methodZoneBase.
	self cCode: ''
		inSmalltalk:
			[simulatedTrampolines keysAndValuesDo:
				[:addr :selector|
				simulatedTrampolines
					at: addr
					put: (MessageSend
							receiver: ((self respondsTo: selector)
										ifTrue: [self]
										ifFalse: [(coInterpreter respondsTo: selector)
													ifTrue: [coInterpreter]
													ifFalse: [(objectMemory respondsTo: selector)
														ifTrue: [objectMemory]
														ifFalse: [self notify: 'cannot find receiver for ', selector]]])
							selector: selector
							arguments: (1 to: selector numArgs) asArray)]]