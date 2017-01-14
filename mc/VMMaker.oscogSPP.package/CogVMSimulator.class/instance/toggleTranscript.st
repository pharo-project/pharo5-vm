UI
toggleTranscript
	| transcriptPane |
	transcript ifNil: [transcript := Transcript. ^self].
	displayView ifNil: [^self changed: #flash].
	transcriptPane := (displayView outermostMorphThat: [:m| m isSystemWindow])
							submorphThat: [:m| m model isStream]
							ifNone: [^self changed: #flash].
	transcript := transcript = Transcript
					ifTrue: [transcriptPane model]
					ifFalse: [Transcript]