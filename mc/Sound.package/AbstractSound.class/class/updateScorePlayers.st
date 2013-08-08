sound library-file in/out
updateScorePlayers
	| soundsBeingEdited |
	"Force all ScorePlayers to update their instrument list from the sound library. This may done after loading, unloading, or replacing a sound to make all ScorePlayers feel the change."

	ScorePlayer allSubInstancesDo: [:p | p pause].
	SoundPlayer shutDown.
	Smalltalk at: #EnvelopeEditorMorph ifPresent: [ :class |
		soundsBeingEdited := class allSubInstances
			collect: [:ed | ed soundBeingEdited ] ].
	Smalltalk at: #ScorePlayerMorph ifPresent: [ :class |
		class allSubInstancesDo:
			[:p | p updateInstrumentsFromLibraryExcept: soundsBeingEdited ] ]