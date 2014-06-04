class initialization
unregisterFromOpenMenu
	 (TheWorldMenu respondsTo: #registerOpenCommand:)
		ifTrue: [TheWorldMenu unregisterOpenCommand: 'StackInterpreter Simulator'].
