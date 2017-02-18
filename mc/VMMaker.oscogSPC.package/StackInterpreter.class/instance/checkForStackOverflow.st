message sending
checkForStackOverflow
	"Check for stack overflow, moving frames to another stack if so."
	<inline: true>
	"After checkForInterrupts another event check may have been forced, setting both
	 stackLimit and stackPage stackLimit to all ones.  So here we must check against
	 the real stackLimit, not the effective stackLimit."
	stackPointer < stackPage realStackLimit ifTrue:
		[self handleStackOverflow]