process primitive support
forProcessPrimitiveReturnToExecutivePostContextSwitch: inInterpreter
	"Do a returnToExecutive: inInterpreter postContextSwitch: true for a process primtive
	 being sure to sample the profile clock before making the switch."
	<inline: true>
	"If we are profiling, take accurate primitive measures"
	nextProfileTick > 0 ifTrue:
		[self checkProfileTick: newMethod].
	^self returnToExecutive: inInterpreter postContextSwitch: true