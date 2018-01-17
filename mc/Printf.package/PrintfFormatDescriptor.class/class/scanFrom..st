instance creation
scanFrom: stream
	| desc |
	desc := self new.
	[Flags includesKey: stream peek]
		whileTrue: [desc := desc perform: (Flags at: stream next)].
	stream peek isDigit ifTrue: [desc width: (Integer readFrom: stream)].
	stream peek == $. ifTrue: [stream next. desc precision: (Integer readFrom: stream)].
	stream peek == $l ifTrue: [stream next].
	desc := desc operator: stream next.
	^ desc