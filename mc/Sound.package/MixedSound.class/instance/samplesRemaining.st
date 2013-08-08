sound generation
samplesRemaining

	| remaining r |
	remaining := 0.
	1 to: sounds size do: [:i |
		r := (sounds at: i) samplesRemaining.
		r > remaining ifTrue: [remaining := r]].

	^ remaining
