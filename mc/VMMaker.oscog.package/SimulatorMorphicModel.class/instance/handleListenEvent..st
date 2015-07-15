event-forwarding
handleListenEvent: aMorphicEvent
"The SimulatorImageMorph  regsitered me (a SimulatorMorphicModel ) with HandMorph>>addEventListener
HandMorph then broadcasts events to all registered listeners at this method. See HandMorph>>sendListenPrimitiveEvent
"
	| evtBuf xtranslated ytranslated |
	morph ifNotNil:
		[evtBuf := SimulatorEventTransformer default degenerateEvent: aMorphicEvent. 
		 ((evtBuf at: 1) = EventTypeMouse and: [morph bounds containsPoint: aMorphicEvent position]) ifTrue:
			[xtranslated :=  (evtBuf at:3) - (morph bounds left) - 2 .  "<--heh"  
			ytranslated :=  (evtBuf at:4) - (morph bounds top). 
			evtBuf at: 3 put: xtranslated.
			evtBuf at: 4 put: ytranslated.
			vm queueForwardedEvent: evtBuf]]