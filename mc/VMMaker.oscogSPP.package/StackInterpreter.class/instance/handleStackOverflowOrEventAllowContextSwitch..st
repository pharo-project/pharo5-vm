message sending
handleStackOverflowOrEventAllowContextSwitch: mayContextSwitch
	"The stackPointer is below the stackLimit.  This is either because of a
	 stack overflow or the setting of stackLimit to indicate a possible interrupt.
	 Check for interrupts and stackOverflow and deal with each appropriately.
	 Answer if a context switch occurred."
	| switched |
	<inline: false>
	"If the stackLimit differs from the realStackLimit then the stackLimit
	 has been set to indicate an event or interrupt that needs servicing."
	stackLimit = stackPage realStackLimit
		ifTrue:
			[self externalWriteBackHeadFramePointers.
			 switched := false]
		ifFalse: [switched := self checkForEventsMayContextSwitch: mayContextSwitch].

	self checkForStackOverflow.
	^switched