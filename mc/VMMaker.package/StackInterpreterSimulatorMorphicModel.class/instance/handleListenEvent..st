event-forwarding
handleListenEvent: aMorphicEvent
"The StackInterpreterSimulatorImageMorph  regsitered me (a StackInterpreterSimulatorMorphicModel ) with HandMorph>>addEventListener
HandMorph then broadcasts events to all registered listeners at this method. See HandMorph>>sendListenPrimitiveEvent
"
	|evtBuf xtranslated ytranslated|
	morph
		ifNotNil:[
			evtBuf := (StackInterpreterSimulatorEventTransformer default) degenerateEvent: aMorphicEvent. 
			((evtBuf at: 1) = EventTypeMouse) & (morph bounds containsPoint: aMorphicEvent position)
				ifTrue:[
						xtranslated :=  (evtBuf at:3) - (morph bounds left) - 2 .  "<--heh"  
						ytranslated :=  (evtBuf at:4) - (morph bounds top). 
						evtBuf at: 3 put: xtranslated.
						evtBuf at: 4 put: ytranslated.
						vm queueForwardedEvent: evtBuf]]



