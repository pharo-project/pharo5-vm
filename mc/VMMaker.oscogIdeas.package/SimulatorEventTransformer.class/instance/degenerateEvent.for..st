event transformation
degenerateEvent: aMorphicEvent for: client
	"Handle ''degenerating'' events for aClient.  This interface gets the client
	 to queue the event via queueForwardedEvent:, and may generate more
	 than one event for the input event (i.e. a fake mouse move before a
	 button down), in addition to filtering-out excessive mouse moves."
	aMorphicEvent isMouse ifTrue:
		[^self degenerateMouseEvent: aMorphicEvent for: client].
	aMorphicEvent isKeyboard ifTrue:
		[^self degenerateKeyboardEvent: aMorphicEvent for: client].
	^self degenerateUnknownEvent: aMorphicEvent for: client