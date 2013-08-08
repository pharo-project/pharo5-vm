initialization
initialize
	super initialize.
	sounds := SharedQueue new.
	done := false.
	startTime := Time millisecondClockValue