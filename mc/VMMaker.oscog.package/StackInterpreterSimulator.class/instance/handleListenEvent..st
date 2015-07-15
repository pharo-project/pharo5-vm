I/O primitives support
handleListenEvent: aMorphicEvent
	"openAsMorph[NoTranscript] regsitered me for listen events via HandMorph>>addEventListener.
	Transform the listen event and add it to my event queue."
	((aMorphicEvent isMouse or: [aMorphicEvent isKeyboard])
	 and: [displayView bounds containsPoint: aMorphicEvent position]) ifTrue:
		[eventTransformer degenerateEvent: aMorphicEvent for: self]