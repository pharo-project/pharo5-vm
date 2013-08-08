accessing
duration: seconds

	super duration: seconds.
	count := initialCount := (seconds * self samplingRate) rounded.
