event transformation
degenerateEvent: aMorphicEvent
	"tty. Bert had mentioned a distinction between events and polling events and that Morphic could handle both.
	I don't know what he is talking about."	
	| evt type |
	self flag:'tty'.

	evt := nil.	
	type := aMorphicEvent type.
"	Transcript show:type;cr."
	(('mouse' charactersExactlyMatching: type asString) > 4)  "mous"
		ifTrue: [^self degenerateMouseEvent: aMorphicEvent].
	(('key' charactersExactlyMatching: type asString) > 2)  "key"
		ifTrue: [^self degenerateKeyboardEvent: aMorphicEvent].
"	type = EventTypeDragDropFiles ifTrue: [evt := self generateDropFilesEvent: evtBuf].
	type = EventTypeWindow	ifTrue:[evt := self generateWindowEvent: evtBuf]."

	^ #(0 0 0 0 0 0 0 0).