event transformation
degenerateKeyboardEvent: aMorphicEvent
	| evt |
	"see HandMorph>>generateKeyboardEvent and EventSensor class comment"
	evt := {2 . 0 . 0 . 0 . 0. 0 . 0 . 0}.
	
	evt at:2 put: aMorphicEvent timeStamp.
	evt at:3 put: aMorphicEvent keyValue.    "<--this is wrong. See Sensor FirstEvt: for what needs to happen. hooo boy"
	evt at:4 put: aMorphicEvent position y.
	evt at:5 put: (aMorphicEvent buttons bitAnd: 7).  "thanks Ron T."
	evt at:6 put: (aMorphicEvent buttons >> 3).     "Thanks dtl"
	^evt


