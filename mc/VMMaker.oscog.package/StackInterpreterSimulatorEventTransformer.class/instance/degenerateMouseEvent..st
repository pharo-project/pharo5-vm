event transformation
degenerateMouseEvent: aMorphicEvent
	"see HandMorph>>generateMouseEvent"

	(aMorphicEvent type) = #mouseMove
		ifTrue:[^self degenerateMouseMoveEvent: aMorphicEvent].	

	((aMorphicEvent type) = #mouseUp) |  ((aMorphicEvent type) = #mouseDown)
		ifTrue:[^self degenerateMouseButtonEvent: aMorphicEvent].	
"	(aMorphicEvent type) = #mouseDrag
		ifTrue:[evt := self degenerateMouseDragEvent: aMorphicEvent].	
"
	^{0 . 0. 0. 0. 0. 0. 0. 0}.