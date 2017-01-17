debug support
cloneSimulation
	| savedDisplayView savedDisplayForm savedQuitBlock savedTranscript |
	savedDisplayView := displayView. displayView := nil.
	savedDisplayForm := displayForm. displayForm = nil.
	savedQuitBlock := quitBlock. quitBlock := nil.
	savedTranscript := transcript. transcript := nil.

	^[| theClone |
	 Smalltalk garbageCollect.
	 theClone := self veryDeepCopy.
	 theClone parent: self; transcript: Transcript.
	 theClone objectMemory parent: objectMemory.
	 theClone]
		ensure:
			[displayView := savedDisplayView.
			 displayForm = savedDisplayForm.
			 quitBlock := savedQuitBlock.
			 transcript := savedTranscript]