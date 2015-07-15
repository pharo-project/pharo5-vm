event transformation
degenerateMouseEvent: aMorphicEvent
	"see HandMorph>>generateMouseEvent"

	modifiers := aMorphicEvent buttons >> 3. "Sad, but modifiers come in on mouse move events..."
	aMorphicEvent type == #mouseMove
		ifTrue: [buttons = 0 ifTrue: [^nil]] "filter-out mouse moves unless buttons are pressed, so simulation doersn't get window leave events when we leave its window"
		ifFalse: [buttons := aMorphicEvent buttons].
	^{	1.
		aMorphicEvent timeStamp.
		aMorphicEvent position x.
		aMorphicEvent position y.
		buttons bitAnd: 7.  "thanks Ron T."
		buttons >> 3.     "Thanks dtl"
		0.
		0 }