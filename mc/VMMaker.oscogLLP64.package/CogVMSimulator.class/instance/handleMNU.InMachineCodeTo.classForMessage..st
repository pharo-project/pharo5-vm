message sending
handleMNU: selectorIndex InMachineCodeTo: rcvr classForMessage: classForMessage
	selectorIndex = SelectorCannotInterpret ifTrue:
		[self halt].
	^super handleMNU: selectorIndex InMachineCodeTo: rcvr classForMessage: classForMessage