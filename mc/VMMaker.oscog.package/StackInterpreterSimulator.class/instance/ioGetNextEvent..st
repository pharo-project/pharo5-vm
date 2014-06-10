I/O primitives
ioGetNextEvent: evtBuf
	| evt  |
	"StackInterpreterSimulatorMorphicModel browse"
	eventQueue isNil ifTrue: 
		[^self primitiveFail].
	eventQueue isEmpty
		ifFalse:
			[	evt :=  eventQueue next.
			      1 to: (evt size) do: [:i | ((evt at: i) isNil) ifFalse: [evtBuf at: (i - 1) put: (evt at: i)]]].
	 self success: true.
