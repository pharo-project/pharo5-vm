event transformation
degenerateMouseButtonEvent: aMorphicEvent
	| evt |
	"see HandMorph>>generateMouseEvent"
	evt := {1 . 0 . 0 . 0 . 0. 0 . 0 . 0}.
	
	evt at:2 put: aMorphicEvent timeStamp.
	evt at:3 put: aMorphicEvent position x.
	evt at:4 put: aMorphicEvent position y.
	evt at:5 put: (aMorphicEvent buttons bitAnd: 7).  "thanks Ron T."
	evt at:6 put: (aMorphicEvent buttons >> 3).     "Thanks dtl"
	^evt


