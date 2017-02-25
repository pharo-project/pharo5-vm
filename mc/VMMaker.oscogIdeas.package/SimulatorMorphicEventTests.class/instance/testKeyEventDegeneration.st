test event
testKeyEventDegeneration
	|aMorphicEvent evtBuf type|
	aMorphicEvent := HandMorph new generateKeyboardEvent: {2 . 0. 0. 0. 0. 0. 0. 0}.
	evtBuf := SimulatorEventTransformer default degenerateEvent: aMorphicEvent. 
	type := evtBuf at:1.
	self assert:(type = EventTypeKeyboard).
