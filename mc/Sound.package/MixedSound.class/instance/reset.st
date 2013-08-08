sound generation
reset

	super reset.
	sounds do: [:snd | snd reset].
	soundDone := (Array new: sounds size) atAllPut: false.
