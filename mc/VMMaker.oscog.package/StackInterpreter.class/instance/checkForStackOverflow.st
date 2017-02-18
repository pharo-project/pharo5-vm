message sending
checkForStackOverflow
	"Check for stack overflow, moving frames to another stack if so.  Since event checking
	 piggy-backs off the stackLimit by setting it to all ones, the check for overflow must be
	 against the real stack limit to find out if overflow has actually occurred."
	<inline: true>
	self externalWriteBackHeadFramePointers.
	stackPointer < stackPage realStackLimit ifTrue:
		[self handleStackOverflow]