accessing
reinitialize
	<inline: true>
	targetInstruction := 0.
	simStackPtr := 0.
	LowcodeVM ifTrue: [
		simNativeStackPtr := 0.
	]