sound generation
reset

	self internalizeModulationAndRatio.
	super reset.
	count := initialCount.
	scaledIndex := 0.
	scaledOffsetIndex := 0.
