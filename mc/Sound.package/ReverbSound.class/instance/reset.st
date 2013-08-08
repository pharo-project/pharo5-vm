sound generation
reset

	super reset.
	sound reset.
	1 to: bufferSize do: [:i |
		leftBuffer at: i put: 0.
		rightBuffer at: i put: 0].
