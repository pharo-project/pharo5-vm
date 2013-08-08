sound generation
reset

	super reset.
	sounds do: [:snd | snd reset].
	sounds size > 0 ifTrue: [currentIndex := 1].
