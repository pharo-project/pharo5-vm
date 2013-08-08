processing-voice
addAmplitudeDiplophonia
	"Add diplophonia (bicyclic voice). Change voicing amplitude."
	<returnTypeC: 'void'>
	periodCount \\ 2 = 0
		ifFalse: [x1 := x1 * (1.0 - (frame at: Diplophonia)).
				"x1 must be <= 0"
				x1 > 0 ifTrue: [x1 := 0]]