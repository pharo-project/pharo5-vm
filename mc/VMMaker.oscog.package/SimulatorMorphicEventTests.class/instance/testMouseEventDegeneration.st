test event
testMouseEventDegeneration
	|aMorphicEvent evtBuf type|
	"see class comment in EventSensor browse"
	aMorphicEvent := HandMorph new generateMouseEvent: {1 . 0. 0. 0. 0. 0. 0. 0}.
	evtBuf := SimulatorEventTransformer default degenerateEvent: aMorphicEvent. 
	type := evtBuf at:1.
	self assert:(type = EventTypeMouse).
