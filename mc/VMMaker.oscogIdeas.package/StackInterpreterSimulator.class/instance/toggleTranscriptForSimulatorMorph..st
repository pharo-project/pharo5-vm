UI
toggleTranscriptForSimulatorMorph: aTranscriptStreamOrTranscript
	"tty think this through when not so tired"
	self flag: 'tty'.
	transcript ifNil: [transcript := Transcript. ^self].
	displayView ifNil: [^self changed: #flash].
	transcript := transcript = Transcript
					ifTrue: [aTranscriptStreamOrTranscript]
					ifFalse: [Transcript]