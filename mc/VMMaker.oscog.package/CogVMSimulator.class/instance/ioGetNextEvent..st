I/O primitives
ioGetNextEvent: evtBuf
	| evt |
	"SimulatorMorphicModel browse"
	eventQueue ifNil:
		[^self primitiveFail].
	eventQueue isEmpty ifFalse:
		[evt :=  eventQueue next.
		 1 to: evt size do:
			[:i| (evt at: i) ifNotNil: [:val| evtBuf at: (i - 1) put: val]]]