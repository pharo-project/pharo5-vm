initialization
initialize
	pastSpace := SpurNewSpaceSpace new.
	futureSpace := SpurNewSpaceSpace new.
	eden := SpurNewSpaceSpace new.
	rememberedSetSize := 0.
	tenureThreshold := 0.
	statSurvivorCount := statTenures := 0