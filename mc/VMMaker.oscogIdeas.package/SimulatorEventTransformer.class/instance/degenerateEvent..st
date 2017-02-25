event transformation
degenerateEvent: aMorphicEvent
	"tty. Bert had mentioned a distinction between events and polling events and that Morphic could handle both.
	I don't know what he is talking about."
	aMorphicEvent isMouse ifTrue:
		[^self degenerateMouseEvent: aMorphicEvent].
	aMorphicEvent isKeyboard ifTrue:
		[^self degenerateKeyboardEvent: aMorphicEvent].
"	type = EventTypeDragDropFiles ifTrue: [evt := self generateDropFilesEvent: evtBuf].
	type = EventTypeWindow	ifTrue:[evt := self generateWindowEvent: evtBuf]."

	^nil