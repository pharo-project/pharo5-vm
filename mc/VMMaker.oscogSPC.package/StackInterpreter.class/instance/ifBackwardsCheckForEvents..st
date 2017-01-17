jump bytecodes
ifBackwardsCheckForEvents: offset
	"Backward jump means we're in a loop; check for possible interrupts."
	<inline: true>
	(offset < 0
	 and: [localSP < stackLimit]) ifTrue:
		[self externalizeIPandSP.
		 self checkForEventsMayContextSwitch: true.
		 self browserPluginReturnIfNeeded.
		 self internalizeIPandSP]