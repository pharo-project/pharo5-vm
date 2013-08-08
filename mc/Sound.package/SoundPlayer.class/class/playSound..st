playing
playSound: aSound
	"Reset and start playing the given sound from its beginning."

	aSound reset.
	aSound samplesRemaining = 0 ifTrue:[^self].
	self resumePlaying: aSound.
