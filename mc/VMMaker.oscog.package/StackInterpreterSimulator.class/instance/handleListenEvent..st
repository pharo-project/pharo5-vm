I/O primitives support
handleListenEvent: aMorphicEvent
	"openAsMorph regsitered me for listen events via HandMorph>>addEventListener.
	Transform the listen event and add it to my event queue."
	| evtBuf xtranslated ytranslated |
	evtBuf := SimulatorEventTransformer default degenerateEvent: aMorphicEvent.
	(evtBuf first = SimulatorEventTransformer eventTypeMouse
	 and: [displayView bounds containsPoint: aMorphicEvent position]) ifTrue:
		[xtranslated := (evtBuf at:3) - displayView bounds left - 2. "<--heh"
		 ytranslated := (evtBuf at:4) - displayView bounds top.
		 evtBuf at: 3 put: xtranslated.
		 evtBuf at: 4 put: ytranslated].
	self queueForwardedEvent: evtBuf