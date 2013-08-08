initialization
initialize

	super initialize.
	rand := Random new.
	lowLimit := 0.994.
	highLimit := 1.006.
	delta := 0.0002.
	currValue := 1.0.
	scale := 1.0.
