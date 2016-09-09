accessing
reinitialize
	<inline: true>
	targetInstruction := 0.
	simStackPtr := 0.
	self cppIf: LowcodeVM ifTrue: [
		simNativeStackPtr := 0.
	]