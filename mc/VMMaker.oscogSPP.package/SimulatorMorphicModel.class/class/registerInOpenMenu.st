class initialization
registerInOpenMenu
	(TheWorldMenu respondsTo: #registerOpenCommand:) ifTrue: [
		TheWorldMenu unregisterOpenCommand: 'StackInterpreter Simulator'.
		TheWorldMenu registerOpenCommand: {'StackInterpreter Simulator'. {self. #open}}].
		