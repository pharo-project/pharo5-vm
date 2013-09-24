debug support
cloneSimulation
	| savedDisplayView savedDisplayForm savedQuitBlock savedTranscript |
	savedDisplayView := displayView. displayView := nil.
	savedDisplayForm := displayForm. displayForm = nil.
	savedQuitBlock := quitBlock. quitBlock := nil.
	savedTranscript := transcript. transcript := nil.

	[| clone window |
	 clone := self veryDeepCopy.
	 window := clone openAsMorph.
	 window setLabel: 'Clone of ', (savedDisplayView containingWindow label allButFirst: 'Simulation of ' size)]
		ensure:
			[displayView := savedDisplayView.
			 displayForm = savedDisplayForm.
			 quitBlock := savedQuitBlock.
			 transcript := savedTranscript]