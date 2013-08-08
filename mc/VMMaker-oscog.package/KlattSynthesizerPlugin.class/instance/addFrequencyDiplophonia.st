processing-voice
addFrequencyDiplophonia
	"Add diplophonia (bicyclic voice). Change F0."
	<returnTypeC: 'void'>
	periodCount \\ 2 = 0
		ifTrue: [pitch := pitch + ((frame at: Diplophonia) * (frame at: F0) * (1.0 - (frame at: Ro)))]
		ifFalse: [pitch := pitch - ((frame at: Diplophonia) * (frame at: F0) * (1.0 - (frame at: Ro)))]