accessing
reinitialize
	<inline: true>
	targetInstruction := simStackPtr := 0.
	LowcodeVM ifTrue:
		[simNativeStackPtr := simNativeStackSize := 0]