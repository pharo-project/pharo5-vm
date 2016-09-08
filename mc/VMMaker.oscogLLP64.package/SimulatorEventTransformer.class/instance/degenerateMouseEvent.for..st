event transformation
degenerateMouseEvent: aMorphicEvent for: aClient
	"Convert the mouse event into low-level events for the VM simulator (aClient).  Filter-out mouse moves,
	 and generate a fake mouse move before each button press.
	 See HandMorph>>generateMouseEvent"
	| translated |
	translated := aMorphicEvent position - aClient displayView bounds origin.
	modifiers := aMorphicEvent buttons >> 3. "Sad, but modifiers come in on mouse move events..."

	aMorphicEvent type == #mouseMove
		ifTrue: "filter-out mouse moves unless buttons are pressed, so simulation doesn't get window leave events when we leave its window"
			[buttons = 0 ifTrue: [^nil]]
		ifFalse:"If the buttons are going down, make sure to add a mouse move event to the current position before the buttons are pressed."
			[((buttons bitAnd: 7) = 0 and: [(aMorphicEvent buttons bitAnd: 7) ~= 0]) ifTrue:
				[aClient queueForwardedEvent:
							{	1.
								aMorphicEvent timeStamp.
								translated x.
								translated y.
								0.
								buttons >> 3.     "Thanks dtl"
								0.
								self windowIndex }].
				 buttons := aMorphicEvent buttons].
	aClient queueForwardedEvent:
			{	1.
				aMorphicEvent timeStamp.
				translated x.
				translated y.
				buttons bitAnd: 7.  "thanks Ron T."
				buttons >> 3.     "Thanks dtl"
				0.
				self windowIndex }