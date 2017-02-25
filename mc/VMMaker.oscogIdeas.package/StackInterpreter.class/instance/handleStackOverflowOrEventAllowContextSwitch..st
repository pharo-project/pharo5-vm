message sending
handleStackOverflowOrEventAllowContextSwitch: mayContextSwitch
	"The stackPointer is below the stackLimit.  This is either because of a
	 stack overflow or the setting of stackLimit to indicate a possible interrupt.
	 Check for stackOverflow and  interrupts anddeal with each appropriately.
	 Answer if a context switch occurred."
	<inline: false>
	self checkForStackOverflow.
	"If the stackLimit differs from the realStackLimit then the stackLimit
	 has been set to indicate an event or interrupt that needs servicing."
	stackLimit = stackPage realStackLimit ifTrue:
		[^false].
	^self checkForEventsMayContextSwitch: mayContextSwitch