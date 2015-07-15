test event
testNullEventDegeneration
	|aMorphicEvent evtBuf type|
	"Test a bad morphic event returns a null event"	"see class comment in EventSensor browse"
	aMorphicEvent := UserInputEvent new.
	evtBuf := SimulatorEventTransformer default degenerateEvent: aMorphicEvent. 
	type := evtBuf at:1.
	self assert:(type = EventTypeNone).

