event transformation
degenerateKeyboardEvent: aMorphicEvent
	"see HandMorph>>generateKeyboardEvent and EventSensor class comment"
	^{	2.
		aMorphicEvent timeStamp.
		aMorphicEvent keyValue.		"<--this is wrong. See Sensor FirstEvt: for what needs to happen. hooo boy"
		aMorphicEvent type caseOf: {
					[#keyDown]	->	[EventKeyDown].
					[#keyUp]		->	[EventKeyUp].
					[#keystroke]	->	[EventKeyChar] }.
		aMorphicEvent buttons bitAnd: 7.
		aMorphicEvent keyValue.
		0.
		0 }