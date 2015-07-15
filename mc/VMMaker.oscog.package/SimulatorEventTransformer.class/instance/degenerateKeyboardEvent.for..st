event transformation
degenerateKeyboardEvent: aMorphicEvent for: aClient
	"Convert the keyboard event into a low-level event for the VM simulator (aClient).
	 See HandMorph>>generateKeyboardEvent and EventSensor class comment"
	aClient queueForwardedEvent:
		{	2.
			aMorphicEvent timeStamp.
			aMorphicEvent keyValue.		"<--this is wrong. See Sensor FirstEvt: for what needs to happen. hooo boy"
			aMorphicEvent type caseOf: {
						[#keyDown]	->	[EventKeyDown].
						[#keyUp]		->	[EventKeyUp].
						[#keystroke]	->	[EventKeyChar] }.
			modifiers.
			aMorphicEvent keyValue.
			0.
			self windowIndex }