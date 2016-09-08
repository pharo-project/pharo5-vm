instance initialization
address: theAddress simulator: aCoInterpreterSimulator zoneBase: base zoneLimit: limit
	address := theAddress.
	stackPages := aCoInterpreterSimulator stackPages.
	memory := aCoInterpreterSimulator memory.
	zoneBase := base.
	zoneLimit := limit