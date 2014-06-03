instance creation
on: aStackInterpreterSimulator title: aString transcript: aTranscriptStream
	| simmodel |
	simmodel := self new.
	simmodel 
		vm: aStackInterpreterSimulator;
		title: aString;
		transcript: aTranscriptStream.
	^simmodel.	