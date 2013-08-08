*sound-piano rolls
justDroppedIntoPianoRoll: pianoRoll event: evt
	
	| ambientEvent startTimeInScore |
	startTimeInScore := pianoRoll timeForX: self left.

	ambientEvent := AmbientEvent new 
		morph: self;
		time: startTimeInScore.

	pianoRoll score addAmbientEvent: ambientEvent.

	"self endTime > pianoRoll scorePlayer durationInTicks ifTrue:
		[pianoRoll scorePlayer updateDuration]"
